from flask import Flask, request, jsonify
import pymongo
import pymysql
import pandas as pd
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity
import jieba

# 创建Flask应用
app = Flask(__name__)

# 设置MongoDB连接
client = pymongo.MongoClient("mongodb://localhost:27017/")
db = client["sbeam"]  # 连接到数据库
post_collection = db["posts"]  # 连接到post集合

# 设置MySQL连接
mysql_conn = pymysql.connect(
    port=3308,
    host='localhost',
    user='root',
    password='root',
    database='sbeam'
)
cursor = mysql_conn.cursor()


# 提取MongoDB中帖子数据
def fetch_mongo_posts():
    posts = post_collection.find({}, {"communityName": 1, "content": 1})
    posts_data = []
    for post in posts:
        posts_data.append({
            "communityName": post["communityName"],
            "content": post["content"]
            # "likeCount": post["likeCount"]
        })
    return pd.DataFrame(posts_data)


# 提取MySQL中用户关注的游戏
def fetch_user_follow(user_id):
    query = f"SELECT game_id FROM user_follow WHERE user_id = {user_id} AND status = 0"
    cursor.execute(query)
    follow_data = cursor.fetchall()
    return pd.DataFrame(follow_data, columns=["game_id"])


# 提取MySQL中用户购买的游戏
def fetch_user_purchase(user_id):
    query = f"SELECT game_id FROM order_details WHERE user_id = {user_id} AND status = 0"
    cursor.execute(query)
    purchase_data = cursor.fetchall()
    return pd.DataFrame(purchase_data, columns=["game_id"])


# 提取MySQL中的游戏类型和描述等信息
def fetch_game_profile():
    query = "SELECT game_id, game_name, game_tag_name, game_description FROM game_profile"
    cursor.execute(query)
    game_data = cursor.fetchall()
    return pd.DataFrame(game_data, columns=["game_id", "game_name", "game_tag_name", "game_description"])


# 提取数据
posts_df = fetch_mongo_posts()
game_profile_df = fetch_game_profile()


# =====================================
# 文本处理与相似度计算

# 中文分词
def chinese_tokenizer(text):
    return list(jieba.cut(text))


# 创建TF-IDF向量化器
vectorizer = TfidfVectorizer(tokenizer=chinese_tokenizer)

# 合并帖子标题和内容
posts_df['combined'] = posts_df['communityName'] + " " + posts_df['content']

# 向量化
tfidf_matrix = vectorizer.fit_transform(posts_df['combined'])

# 计算余弦相似度
cosine_sim = cosine_similarity(tfidf_matrix, tfidf_matrix)


# =====================================
# 推荐函数：根据用户ID推荐帖子和游戏
def recommend_by_user(user_id, posts_df, game_profile_df, cosine_sim, top_n_posts=5, top_n_games=5):
    # 获取用户关注和购买的游戏
    user_follow_df = fetch_user_follow(user_id)
    user_purchase_df = fetch_user_purchase(user_id)

    # 获取关注和购买的游戏ID
    user_followed_games = user_follow_df['game_id'].values
    user_purchased_games = user_purchase_df['game_id'].values

    # 获取这些游戏的标签（类型）
    followed_game_tags = game_profile_df[game_profile_df['game_id'].isin(user_followed_games)]['game_tag_name'].values
    purchased_game_tags = game_profile_df[game_profile_df['game_id'].isin(user_purchased_games)]['game_tag_name'].values

    # 合并用户关注和购买的游戏类型
    all_game_tags = list(followed_game_tags) + list(purchased_game_tags)

    # 统计用户最常见的游戏类型
    most_common_game_tag = pd.Series(all_game_tags).mode()[0]  # 获取最常见的类型

    # 基于游戏类型推荐游戏
    related_games = game_profile_df[game_profile_df['game_tag_name'] == most_common_game_tag]
    recommended_game_ids = related_games['game_id'].values

    # 获取所有与这些游戏相关的帖子
    game_related_posts = posts_df[
        posts_df['communityName'].str.contains('|'.join([str(game) for game in recommended_game_ids]))]

    # 计算帖子之间的相似度，并排序
    if game_related_posts.empty:
        return "没有找到相关帖子"

    post_indices = game_related_posts.index
    similar_scores = cosine_sim[post_indices].flatten()

    # 获取相似度高的帖子
    similar_indices = similar_scores.argsort()[-top_n_posts:][::-1]
    recommended_posts = posts_df.iloc[similar_indices]

    # 返回推荐帖子与游戏
    return recommended_posts[['communityName']], recommended_game_ids


# 创建API路由
@app.route('/recommend', methods=['POST'])
def get_recommendation():
    try:
        data = request.get_json()

        # 从请求中获取用户ID
        user_id = data['user_id']

        # 获取推荐结果
        recommended_posts, recommended_games = recommend_by_user(user_id, posts_df, game_profile_df, cosine_sim)

        # 返回推荐结果
        return jsonify({
            "recommended_posts": recommended_posts.to_dict(orient='records'),
            "recommended_games": recommended_games.tolist()
        })

    except Exception as e:
        return jsonify({"error": str(e)}), 500


# 启动Flask应用
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)  # 在5000端口启动服务
