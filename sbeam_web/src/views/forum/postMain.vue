<script setup lang="ts">
import { ref, onMounted } from 'vue';
import { useRoute } from 'vue-router';
import navigaton from '@/components/share/navigaton.vue';
import kobeImg from '@/assets/img/kobe.png';

const BACKEND = 'http://localhost:8080';

const route = useRoute();
const post = ref<any>(null);
const replies = ref<any[]>([]);
const newReply = ref('');
const liking = ref(false);

const loadPost = async () => {
    try {
        // 使用路径参数调用后端 MongoDB 接口：GET /mygo/{id}
        const idRaw = route.query.id || route.params.id || '1';
        const id = idRaw.toString();
        const res = await fetch(`${BACKEND}/mygo/${encodeURIComponent(id)}`);
        if (!res.ok) {
            // 若后端返回非 2xx，抛出以走到 catch 分支使用 fallback 数据
            throw new Error(`Failed to fetch post: ${res.status}`);
        }
        const data = await res.json();
        post.value = data || {
            postId: Number(id) || id,
            postTitle: '未找到帖子',
            postContent: '该帖子不存在或已被删除。',
            userId: null,
            communityId: null,
            createdAt: new Date().toISOString(),
            likeCount: 0,
        };

        // 改为从后端加载回复列表（若后端无数据会返回空数组）
        try {
            const rres = await fetch(`${BACKEND}/mygo/reply?postId=${post.value.postId}`);
            const rdata = await rres.json();
            if (Array.isArray(rdata) && rdata.length) {
                replies.value = rdata;
            } else {
                // fallback 示例
                replies.value = [
                    {
                        id: 1,
                        user: { id: post.value.userId || 101, name: post.value.userId ? `用户#${post.value.userId}` : '楼主' },
                        content: post.value.postContent,
                        time: post.value.createdAt,
                        likes: post.value.likeCount || 0,
                        floor: 1,
                    },
                    { id: 2, user: { id: 202, name: '网友A' }, content: '顶一个，写得不错！', time: '2025-10-10 09:20', likes: 12, floor: 2 },
                    { id: 3, user: { id: 303, name: '网友B' }, content: '补充一点自己的看法。', time: '2025-10-11 14:32', likes: 3, floor: 3 },
                ];
            }
        } catch (e) {
            console.warn('加载回复失败，使用示例回复', e);
            // ...existing sample replies...
        }
    } catch (e) {
        console.error('加载帖子失败', e);
    }
};

onMounted(loadPost);

const toggleLike = () => {
    liking.value = !liking.value;
    if (!post.value) return;
    post.value.likeCount = (post.value.likeCount || 0) + (liking.value ? 1 : -1);
};

const submitReply = async () => {
    if (!newReply.value.trim() || !post.value) return;

    // 从 localStorage 获取已登录用户（Login.vue 保存为 sbeam_user）
    let userId: any = null
    let userName: string = '游客'
    try {
        const u = localStorage.getItem('sbeam_user')
        if (u) {
            const parsed = JSON.parse(u)
            // 兼容性处理：后端可能返回 userId 或 id
            userId = parsed.userId ?? parsed.id ?? parsed.user?.id ?? null
            userName = parsed.userName ?? parsed.userName ?? parsed.name ?? userName
        }
    } catch (e) {
        console.warn('解析本地用户信息失败，使用游客', e)
    }

    // 构建符合 MogoPost/后端预期的回复对象
    const payload = {
        // parentPostId 表示回复所属的主帖 id
        parentPostId: post.value.postId,
        // 将回复内容放到 postContent 字段，与 MogoPost 对应
        postContent: newReply.value.trim(),
        // 继承社区 id，便于后端查询
        communityId: post.value.communityId ?? null,
        userId: userId ?? 'anonymous',
        // 便于前端/后端显示用户名（实体中没有 userName 字段，但后端可以接受）
        userName: userName,
        // 初始点赞数与状态
        likeCount: 0,
        createdAt: new Date().toISOString(),
        status: 'active',
    }

    try {
        const res = await fetch(`${BACKEND}/mygo/reply`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(payload),
        })
        if (!res.ok) throw new Error(`状态 ${res.status}`)
        const created = await res.json()

        // 后端可能返回新保存的 MogoPost（包含 postId、createdAt 等），兼容性处理：
        const newItem = {
            id: created?.postId ?? created?.id ?? Date.now(),
            user: { id: created?.userId ?? payload.userId, name: created?.userName ?? payload.userName },
            content: created?.postContent ?? payload.postContent,
            time: created?.createdAt ?? new Date().toLocaleString(),
            likes: created?.likeCount ?? payload.likeCount ?? 0,
            floor: created?.floor ?? (replies.value.length + 1),
        }

        replies.value.push(newItem)
        newReply.value = ''
    } catch (e) {
        console.error('提交回复失败', e)
        // 可加入用户可见提示，例如 toast 或 alert
    }
};
</script>

<template>
    <navigaton />

    <main class="tieba-wrap">
        <section class="left-col">
            <div class="post-card">
                <header class="post-head">
                    <h1 class="title">{{ post?.postTitle || '加载中...' }}</h1>
                    <div class="meta">
                        <img class="avatar" :src="kobeImg" alt="avatar" />
                        <div class="meta-info">
                            <span class="author">{{ post?.userId ? `用户#${post.userId}` : '匿名' }}</span>
                            <span class="sep">•</span>
                            <span class="community">社区：{{ post?.communityId ?? '-' }}</span>
                            <span class="sep">•</span>
                            <span class="time">{{ post?.createdAt ? new Date(post.createdAt).toLocaleString() : '-'
                                }}</span>
                        </div>
                        <div class="actions">
                            <button class="like" :class="{ on: liking }" @click="toggleLike">👍 {{ post?.likeCount ?? 0
                                }}</button>
                            <button class="reply">回复</button>
                        </div>
                    </div>
                </header>

                <article class="post-body" v-html="post?.postContent || ''"></article>

                <div class="post-tools">
                    <button class="tool">收藏</button>
                    <button class="tool">分享</button>
                    <button class="tool">投诉</button>
                </div>
            </div>

            <!-- 楼层列表 -->
            <div class="reply-list">
                <div v-for="r in replies" :key="r.id" class="reply-item">
                    <div class="floor">{{ r.floor }}楼</div>
                    <div class="reply-main">
                        <div class="reply-head">
                            <img class="avatar-sm" :src="kobeImg" alt="avatar" />
                            <div class="user-info">
                                <div class="name">{{ r.user.name }}</div>
                                <div class="time">{{ r.time }}</div>
                            </div>
                            <div class="reply-actions">
                                <button class="like small">👍 {{ r.likes }}</button>
                                <button class="reply small">回复</button>
                            </div>
                        </div>
                        <div class="reply-body">{{ r.content }}</div>
                    </div>
                </div>
            </div>

            <!-- 回复框 -->
            <div class="reply-box">
                <textarea v-model="newReply" placeholder="写下你的回复..." rows="4"></textarea>
                <div class="reply-controls">
                    <button class="btn-submit" @click="submitReply">发表</button>
                    <div class="hint">群里头不要发那些淫秽的东西，乱发黄色群主可能会坐牢，大家绿色聊天把，小心那天群主被铐起来</div>
                </div>
            </div>
        </section>

        <aside class="right-col">
            <div class="card">
                <h3>帖子信息</h3>
                <ul class="info-list">
                    <li>帖子ID：{{ post?.postId ?? '-' }}</li>
                    <li>社区：{{ post?.communityId ?? '-' }}</li>
                    <li>作者：{{ post?.userId ? `用户#${post.userId}` : '匿名' }}</li>
                    <li>创建时间：{{ post?.createdAt ? new Date(post.createdAt).toLocaleString() : '-' }}</li>
                    <li>点赞：{{ post?.likeCount ?? 0 }}</li>
                </ul>
            </div>

            <div class="card">
                <h3>关于社区</h3>
                <p>可在此显示社区简介、热门话题或管理操作按钮。</p>
                <button class="join">加入社区</button>
            </div>
        </aside>
    </main>
</template>

<style scoped>
.tieba-wrap {
    max-width: 1100px;
    margin: 20px auto;
    display: flex;
    gap: 20px;
    font-family: "Segoe UI", Arial, sans-serif;
    color: #333;
}

/* 左列：帖子和楼层 */
.left-col {
    flex: 1 1 720px;
}

/* 右列：侧边栏 */
.right-col {
    width: 300px;
    display: flex;
    flex-direction: column;
    gap: 16px;
}

.post-card {
    background: #fff;
    border-radius: 6px;
    padding: 16px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
    margin-bottom: 12px;
}

.post-head .title {
    font-size: 22px;
    margin: 0 0 12px;
    color: #222;
}

.meta {
    display: flex;
    align-items: center;
    gap: 12px;
}

.avatar {
    width: 56px;
    height: 56px;
    border-radius: 50%;
    object-fit: cover;
}

.meta-info {
    display: flex;
    gap: 8px;
    align-items: center;
    color: #666;
    font-size: 13px;
}

.meta-info .author {
    font-weight: 600;
    color: #333;
}

.actions {
    margin-left: auto;
    display: flex;
    gap: 8px;
}

.actions .like {
    background: #fff;
    border: 1px solid #e6e6e6;
    padding: 6px 10px;
    border-radius: 4px;
    cursor: pointer;
}

.actions .like.on {
    background: #ffefef;
    border-color: #ff8b8b;
}

.post-body {
    margin-top: 12px;
    padding: 12px;
    background: #fafafa;
    border-radius: 6px;
    line-height: 1.8;
    color: #333;
    white-space: pre-wrap;
}

/* 工具 */
.post-tools {
    margin-top: 10px;
    display: flex;
    gap: 8px;
}

.post-tools .tool {
    background: transparent;
    border: 1px solid #eee;
    padding: 6px 10px;
    border-radius: 4px;
    cursor: pointer;
}

/* 楼层列表 */
.reply-list {
    margin-top: 12px;
}

.reply-item {
    display: flex;
    gap: 12px;
    padding: 12px;
    border-bottom: 1px solid #f0f0f0;
    align-items: flex-start;
    background: linear-gradient(180deg, #fff, #fff);
}

.floor {
    width: 64px;
    text-align: center;
    font-weight: 700;
    color: #999;
}

.reply-main {
    flex: 1;
}

.reply-head {
    display: flex;
    align-items: center;
    gap: 12px;
}

.avatar-sm {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    object-fit: cover;
}

.user-info .name {
    font-weight: 600;
    color: #333;
}

.user-info .time {
    color: #999;
    font-size: 12px;
}

.reply-actions {
    margin-left: auto;
    display: flex;
    gap: 8px;
}

.reply-actions .small {
    padding: 4px 8px;
    border: 1px solid #eee;
    border-radius: 4px;
    background: #fff;
    cursor: pointer;
}

.reply-body {
    margin-top: 8px;
    white-space: pre-wrap;
}

/* 回复框 */
.reply-box {
    margin-top: 16px;
    background: #fff;
    padding: 12px;
    border-radius: 6px;
    box-shadow: 0 2px 6px rgba(0, 0, 0, 0.02);
}

.reply-box textarea {
    width: 100%;
    resize: vertical;
    padding: 8px;
    border: 1px solid #e6e6e6;
    border-radius: 4px;
    font-size: 14px;
    box-sizing: border-box;
}

.reply-controls {
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin-top: 8px;
}

.btn-submit {
    background: #ff7b7b;
    color: #fff;
    border: none;
    padding: 8px 14px;
    border-radius: 6px;
    cursor: pointer;
}

.hint {
    color: #999;
    font-size: 12px;
}

/* 侧边栏卡片 */
.card {
    background: #fff;
    padding: 12px;
    border-radius: 6px;
    box-shadow: 0 2px 6px rgba(0, 0, 0, 0.03);
}

.info-list {
    list-style: none;
    padding: 0;
    margin: 0;
    color: #555;
}

.info-list li {
    padding: 6px 0;
    border-bottom: 1px dashed #f0f0f0;
    font-size: 13px;
}

.join {
    margin-top: 8px;
    width: 100%;
    padding: 8px;
    border: none;
    background: #42b983;
    color: white;
    border-radius: 6px;
    cursor: pointer;
}

/* 响应式 */
@media (max-width: 900px) {
    .tieba-wrap {
        padding: 10px;
        flex-direction: column;
    }

    .right-col {
        width: 100%;
        order: 2;
    }

    .left-col {
        order: 1;
    }
}
</style>
