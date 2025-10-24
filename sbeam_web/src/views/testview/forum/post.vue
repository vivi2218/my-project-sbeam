<script setup lang="ts">
import { ref } from 'vue';

const BACKEND = 'http://localhost:8080';

const id = ref('');
const title = ref('');
const content = ref('');
const authorId = ref('');
const result = ref<any>(null);
const error = ref('');

const fetchPost = async () => {
    error.value = '';
    result.value = null;
    try {
        if (!id.value) {
            error.value = '请输入 id';
            return;
        }
        const res = await fetch(`${BACKEND}/mygo?id=${encodeURIComponent(id.value)}`);
        if (!res.ok) throw new Error(`状态 ${res.status}`);
        result.value = await res.json();
    } catch (e: unknown) {
        error.value = e.message || String(e);
    }
};

const submitPost = async () => {
    error.value = '';
    try {
        const payload = {
            // 尽量与后端 MogoPost 结构对齐，字段名根据实际后端实体调整
            id: id.value || undefined,
            title: title.value,
            content: content.value,
            userId: authorId.value ? Number(authorId.value) : undefined,
        };
        const res = await fetch(`${BACKEND}/mygo`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(payload),
        });
        if (!res.ok) throw new Error(`状态 ${res.status}`);
        const ok = await res.json();
        result.value = { created: ok, payload };
    } catch (e: any) {
        error.value = e.message || String(e);
    }
};
</script>

<template>
  <div style="padding:16px; max-width:720px; margin:auto;">
    <h3>测试：获取帖子 / 发帖（/mygo）</h3>

    <div style="margin-bottom:12px;">
      <label>帖子ID：<input v-model="id" /></label>
      <button @click="fetchPost" style="margin-left:8px;">获取帖子</button>
    </div>

    <div style="margin-bottom:12px;">
      <label>作者ID：<input v-model="authorId" /></label>
    </div>
    <div style="margin-bottom:12px;">
      <label>标题：<input v-model="title" style="width:100%" /></label>
    </div>
    <div style="margin-bottom:12px;">
      <label>内容：</label>
      <textarea v-model="content" rows="6" style="width:100%"></textarea>
    </div>
    <div style="margin-bottom:12px;">
      <button @click="submitPost">提交发帖 (POST /mygo)</button>
    </div>

    <div v-if="error" style="color:#c00;">错误：{{ error }}</div>

    <div v-if="result" style="margin-top:12px;">
      <h4>返回结果：</h4>
      <pre style="background:#f7f7f7; padding:8px;">{{ result }}</pre>
    </div>
  </div>
</template>
