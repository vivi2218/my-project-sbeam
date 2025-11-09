<script setup lang="ts">
import { ref, onMounted } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import axios from 'axios';
import kobeImg from '@/assets/img/kobe.png';

const BACKEND = 'http://localhost:8080';

const route = useRoute();
const router = useRouter();
const post = ref<any>(null);
const replies = ref<any[]>([]);
const newReply = ref('');
const liking = ref(false);
const isLoading = ref(true);
const errorMessage = ref('');
const isSubmitting = ref(false);

const loadPost = async () => {
    isLoading.value = true;
    errorMessage.value = '';

    try {
        // 使用路径参数调用后端 MongoDB 接口：GET /mygo/{id}
        const idRaw = route.query.id || route.params.id || '1';
        const id = idRaw.toString();
        const res = await axios.get(`${BACKEND}/mygo/${encodeURIComponent(id)}`);
        post.value = res.data;

        // 从后端加载回复列表，不使用任何虚拟数据
        const rres = await axios.get(`${BACKEND}/mygo/reply`, {
            params: { postId: post.value.postId }
        });

        // 处理回复数据，后端返回Result对象，数据在data字段中
        const replyData = Array.isArray(rres.data?.data) ? rres.data.data : [];
        replies.value = replyData.map((reply: any, index: number) => ({
            id: reply.postId || reply.id,
            user: {
                id: reply.userId || 'anonymous',
                name: reply.userName || `用户#${reply.userId || 'anonymous'}`
            },
            content: reply.postContent || reply.content || '',
            time: reply.createdAt ? new Date(reply.createdAt).toLocaleString() : new Date().toLocaleString(),
            likes: reply.likeCount || 0,
            floor: index + 1
        }));
    } catch (e) {
        console.error('加载帖子失败', e);
        errorMessage.value = '加载帖子失败，请稍后重试';
    } finally {
        isLoading.value = false;
    }
};

onMounted(loadPost);

const toggleLike = async () => {
    if (!post.value) return;

    try {
        // 调用后端点赞接口（暂时使用模拟方式，因为后端没有提供like接口）
        // 实际环境中需要后端实现此接口
        // await axios.post(`${BACKEND}/mygo/like`, {
        //     postId: post.value.postId,
        //     liked: !liking.value
        // });
        // 暂时只在前端更新状态","},{"old_str":

        liking.value = !liking.value;
        post.value.likeCount = (post.value.likeCount || 0) + (liking.value ? 1 : -1);
    } catch (e) {
        console.error('点赞失败', e);
        alert('点赞操作失败，请稍后重试');
    }
};

const submitReply = async () => {
    if (!newReply.value.trim() || !post.value || isSubmitting.value) return;

    isSubmitting.value = true;

    // 从 localStorage 获取已登录用户
    let userId: any = null;
    let userName: string = '游客';
    try {
        const u = localStorage.getItem('sbeam_user');
        if (u) {
            const parsed = JSON.parse(u);
            userId = parsed.userId ?? parsed.id ?? null;
            userName = parsed.userName ?? '游客';
        }
    } catch (e) {
        console.warn('解析本地用户信息失败，使用游客', e);
    }

    // 构建回复对象
    const payload = {
        parentPostId: post.value.postId,
        postContent: newReply.value.trim(),
        communityId: post.value.communityId ?? null,
        userId: userId ?? 'anonymous',
        userName: userName,
        likeCount: 0,
        createdAt: new Date().toISOString(),
        status: 'active'
    };

    try {
            // 使用正确的API路径：/mygo/{parentid}/reply
            const res = await axios.post(`${BACKEND}/mygo/${post.value.postId}/reply`, payload);
            const created = res.data?.data || res.data; // 处理Result对象格式

        // 添加新回复到列表
        replies.value.push({
            id: created?.postId ?? created?.id ?? Date.now(),
            user: {
                id: created?.userId ?? payload.userId,
                name: created?.userName ?? payload.userName
            },
            content: created?.postContent ?? payload.postContent,
            time: created?.createdAt ? new Date(created.createdAt).toLocaleString() : new Date().toLocaleString(),
            likes: created?.likeCount ?? 0,
            floor: replies.value.length + 1
        });

        newReply.value = '';
    } catch (e) {
        console.error('提交回复失败', e);
        alert('回复失败，请稍后重试');
    } finally {
        isSubmitting.value = false;
    }
};

// 返回社区详情页
const goBackToCommunity = () => {
    if (post.value && post.value.communityId) {
        router.push({
            path: '/community-detail',
            query: { id: post.value.communityId }
        });
    } else {
        router.push('/forum');
    }
};
</script>

<template>
    <navigaton />

    <main class="tieba-wrap">
        <!-- 加载状态 -->
        <div v-if="isLoading" class="loading">
            <p>加载中...</p>
        </div>

        <!-- 错误提示 -->
        <div v-else-if="errorMessage" class="error-message">
            {{ errorMessage }}
            <button @click="loadPost">重试</button>
        </div>

        <!-- 帖子内容 -->
        <div v-else>
            <section class="left-col">
                <!-- 返回按钮 -->
                <button class="back-button" @click="goBackToCommunity">← 返回社区</button>

                <div class="post-card">
                    <header class="post-head">
                        <h1 class="title">{{ post?.postTitle || '加载中...' }}</h1>
                        <div class="meta">
                            <img class="avatar" :src="kobeImg" alt="avatar" />
                            <div class="meta-info">
                                <span class="author">{{ post?.userName || (post?.userId ? `用户#${post.userId}` : '匿名') }}</span>
                                <span class="sep">•</span>
                                <span class="community">社区：{{ post?.communityName || (post?.communityId ? `社区#${post.communityId}` : '-') }}</span>
                                <span class="sep">•</span>
                                <span class="time">{{ post?.createdAt ? new Date(post.createdAt).toLocaleString() : '-'
                                    }}</span>
                            </div>
                            <div class="actions">
                                <button class="like" :class="{ on: liking }" @click="toggleLike" :disabled="liking">
                                    👍 {{ post?.likeCount ?? 0 }}
                                </button>
                                <button class="reply" @click="() => {}">回复</button>
                            </div>
                        </div>
                    </header>

                    <article class="post-body">{{ post?.postContent || '' }}</article>

                    <div class="post-tools">
                        <button class="tool">收藏</button>
                        <button class="tool">分享</button>
                        <button class="tool">投诉</button>
                    </div>
                </div>

                <!-- 楼层列表 -->
                <div class="reply-list">
                    <h2 class="section-title">评论 ({{ replies.length }})</h2>
                    <div v-if="replies.length === 0" class="no-replies">
                        暂无评论，快来发表第一条评论吧！
                    </div>
                    <div v-else>
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
                </div>

                <!-- 回复框 -->
                <div class="reply-box">
                    <textarea v-model="newReply" placeholder="写下你的回复..." rows="4"></textarea>
                    <div class="reply-controls">
                        <button
                            class="btn-submit"
                            @click="submitReply"
                            :disabled="isSubmitting || !newReply.trim()"
                        >
                            {{ isSubmitting ? '发表中...' : '发表' }}
                        </button>
                        <div class="hint">请遵守社区规范，文明发言</div>
                    </div>
                </div>
            </section>
        </div>
    </main>
</template>

<style scoped>
/* 页面整体布局 - 深色主题 */
.tieba-wrap {
    position: relative;
    top: 38px;
    max-width: 1200px;
    width: 100%;
    margin: 0 auto;
    padding: 20px;
    display: flex;
    gap: 20px;
    font-family: 'Microsoft YaHei', sans-serif;
    background-color: #121212;
    color: #e0e0e0;
    min-height: 100vh;
}

/* 加载和错误状态 */
.loading, .error-message {
    text-align: center;
    padding: 40px;
    color: #999;
}

.error-message button {
    margin-top: 10px;
    padding: 8px 16px;
    background: #2a2a2a;
    border: 1px solid #333;
    color: #e0e0e0;
    border-radius: 6px;
    cursor: pointer;
}

/* 返回按钮 */
.back-button {
    padding: 8px 16px;
    background: #2a2a2a;
    border: 1px solid #333;
    color: #e0e0e0;
    border-radius: 6px;
    cursor: pointer;
    margin-bottom: 20px;
    transition: all 0.3s ease;
}

.back-button:hover {
    background: #333;
    border-color: #444;
}

/* 左列：帖子和楼层 */
.left-col {
    flex: 1 1 720px;
    width:1100px
}

/* 右列：侧边栏 */
.right-col {
    width: 300px;
    display: flex;
    flex-direction: column;
    gap: 16px;
}

/* 帖子卡片 */
.post-card {
    background: #1e1e1e;
    border-radius: 10px;
    padding: 20px;
    border: 1px solid #333;
    margin-bottom: 20px;
    width: 100%;
}

.post-head .title {
    font-size: 24px;
    margin: 0 0 16px;
    color: #e0e0e0;
    font-weight: 600;
        width: 100%;

}

.meta {
    display: flex;
    align-items: center;
    gap: 16px;
    flex-wrap: wrap;
}

.avatar {
    width: 56px;
    height: 56px;
    border-radius: 50%;
    object-fit: cover;
    border: 1px solid #333;
}

.meta-info {
    display: flex;
    gap: 12px;
    align-items: center;
    color: #999;
    font-size: 14px;
    flex-wrap: wrap;
}

.meta-info .author {
    font-weight: 600;
    color: #e0e0e0;
}

.sep {
    color: #555;
}

.actions {
    margin-left: auto;
    display: flex;
    gap: 12px;
}

.actions .like {
    background: #2a2a2a;
    border: 1px solid #333;
    padding: 8px 14px;
    border-radius: 6px;
    cursor: pointer;
    color: #e0e0e0;
    transition: all 0.3s ease;
    width: 80px;
}

.actions .like:hover:not(:disabled) {
    background: #333;
    border-color: #444;
}

.actions .like.on {
    background: rgba(255, 77, 79, 0.2);
    border-color: #ff4d4f;
    color: #ff4d4f;
}

.actions .like:disabled {
    opacity: 0.6;
    cursor: not-allowed;
}

.actions .reply {
    background: #2a2a2a;
    border: 1px solid #333;
    padding: 8px 14px;
    border-radius: 6px;
    cursor: pointer;
    color: #e0e0e0;
    transition: all 0.3s ease;
}

.actions .reply:hover {
    background: #333;
    border-color: #444;
}

/* 帖子内容 */
.post-body {
    margin-top: 20px;
    padding: 20px;
    background: #252525;
    border-radius: 8px;
    line-height: 1.8;
    color: #ccc;
    white-space: pre-wrap;
    border: 1px solid #333;
    font-size: 15px;
}

/* 工具 */
.post-tools {
    margin-top: 16px;
    display: flex;
    gap: 12px;
}

.post-tools .tool {
    background: #2a2a2a;
    border: 1px solid #333;
    padding: 8px 14px;
    border-radius: 6px;
    cursor: pointer;
    color: #999;
    transition: all 0.3s ease;
    font-size: 14px;
}

.post-tools .tool:hover {
    background: #333;
    border-color: #444;
    color: #e0e0e0;
}

/* 楼层列表 */
.reply-list {
    margin-top: 20px;
    background: #1e1e1e;
    border-radius: 10px;
    padding: 20px;
    border: 1px solid #333;
}

.section-title {
    font-size: 20px;
    font-weight: 600;
    color: #e0e0e0;
    margin: 0 0 20px 0;
    border-bottom: 1px solid #333;
    padding-bottom: 10px;
}

.no-replies {
    text-align: center;
    padding: 60px;
    color: #777;
    font-style: italic;
    font-size: 16px;
}

.reply-item {
    display: flex;
    gap: 16px;
    padding: 20px 0;
    border-bottom: 1px solid #333;
    align-items: flex-start;
}

.reply-item:last-child {
    border-bottom: none;
}

.floor {
    width: 64px;
    text-align: center;
    font-weight: 700;
    color: #777;
    font-size: 14px;
}

.reply-main {
    flex: 1;
}

.reply-head {
    display: flex;
    align-items: center;
    gap: 12px;
    margin-bottom: 12px;
}

.avatar-sm {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    object-fit: cover;
    border: 1px solid #333;
}

.user-info .name {
    font-weight: 600;
    color: #e0e0e0;
    font-size: 14px;
}

.user-info .time {
    color: #777;
    font-size: 12px;
    margin-top: 2px;
}

.reply-actions {
    margin-left: auto;
    display: flex;
    gap: 8px;
}

.reply-actions .small {
    padding: 6px 10px;
    border: 1px solid #333;
    border-radius: 4px;
    background: #2a2a2a;
    color: #999;
    cursor: pointer;
    font-size: 13px;
    transition: all 0.3s ease;
}

.reply-actions .small:hover {
    background: #333;
    border-color: #444;
    color: #e0e0e0;
}

.reply-body {
    color: #ccc;
    line-height: 1.6;
    white-space: pre-wrap;
    font-size: 14px;
}

/* 回复框 */
.reply-box {
    margin-top: 20px;
    background: #1e1e1e;
    border-radius: 10px;
    padding: 20px;
    border: 1px solid #333;
}

.reply-box textarea {
    width: 100%;
    resize: vertical;
    min-height: 120px;
    padding: 12px;
    background: #252525;
    border: 1px solid #333;
    color: #e0e0e0;
    border-radius: 6px;
    font-size: 14px;
    font-family: inherit;
    box-sizing: border-box;
    transition: border-color 0.3s ease;
}

.reply-box textarea:focus {
    outline: none;
    border-color: #444;
}

.reply-controls {
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin-top: 12px;
}

.btn-submit {
    background: #009688;
    color: white;
    border: none;
    padding: 10px 20px;
    border-radius: 6px;
    cursor: pointer;
    font-size: 15px;
    font-weight: 600;
    transition: all 0.3s ease;
}

.btn-submit:hover:not(:disabled) {
    background: #00796b;
    transform: translateY(-1px);
}

.btn-submit:disabled {
    opacity: 0.6;
    cursor: not-allowed;
    transform: none;
}

.hint {
    color: #777;
    font-size: 13px;
}

/* 侧边栏卡片 */
.card {
    background: #1e1e1e;
    padding: 20px;
    border-radius: 8px;
    border: 1px solid #333;
}

.card h3 {
    font-size: 16px;
    font-weight: 600;
    color: #e0e0e0;
    margin: 0 0 16px 0;
    border-bottom: 1px solid #333;
    padding-bottom: 8px;
}

.info-list {
    list-style: none;
    padding: 0;
    margin: 0;
    color: #999;
}

.info-list li {
    padding: 8px 0;
    border-bottom: 1px dashed #333;
    font-size: 14px;
}

.info-list li:last-child {
    border-bottom: none;
}

.join, .report {
    margin-top: 12px;
    width: 100%;
    padding: 10px;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-size: 14px;
    font-weight: 600;
    transition: all 0.3s ease;
}

.join {
    background: #009688;
    color: white;
}

.join:hover {
    background: #00796b;
}

.report {
    margin-top: 8px;
    background: #2a2a2a;
    color: #e0e0e0;
    border: 1px solid #333;
}

.report:hover {
    background: #333;
    border-color: #444;
}

/* 响应式设计 */
@media (max-width: 900px) {
    .tieba-wrap {
        flex-direction: column;
        padding: 16px;
        height:1200vh;
    }

    .right-col {
        width: 100%;
        order: 2;
    }

    .left-col {
        order: 1;
    }

    .meta {
        flex-direction: column;
        align-items: flex-start;
        gap: 12px;
    }

    .actions {
        margin-left: 0;
        width: 100%;
    }

    .reply-item {
        flex-direction: column;
        gap: 12px;
    }

    .floor {
        width: auto;
        text-align: left;
    }

    .reply-controls {
        flex-direction: column;
        align-items: flex-start;
        gap: 8px;
    }
}
</style>
