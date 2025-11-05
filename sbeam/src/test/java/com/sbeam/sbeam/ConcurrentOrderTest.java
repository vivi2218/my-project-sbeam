package com.sbeam.sbeam;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;
import java.util.*;
import java.util.concurrent.*;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * 高并发秒杀模拟测试（Lua + 幂等 + RabbitMQ）
 * 模拟 100 个用户同时下单同一游戏，验证不会超卖
 */
public class ConcurrentOrderTest {

    // ========= 配置区域 =========
    private static final String BASE_URL = "http://localhost:8080";  // 你的后端接口地址
    private static final int CONCURRENT_USERS = 10; // 并发数
    private static final int GAME_ID = 1;            // 测试的商品ID
    private static final ObjectMapper MAPPER = new ObjectMapper();
    private static final HttpClient CLIENT = HttpClient.newBuilder()
            .connectTimeout(Duration.ofSeconds(3))
            .build();
    // ==========================

    public static void main(String[] args) throws Exception {
        System.out.println("🚀 启动高并发测试，共 " + CONCURRENT_USERS + " 个并发线程...");
        long start = System.currentTimeMillis();

        ExecutorService pool = Executors.newFixedThreadPool(CONCURRENT_USERS);
        List<Future<TestResult>> futures = new ArrayList<>();

        AtomicInteger successCount = new AtomicInteger();
        AtomicInteger failCount = new AtomicInteger();
        AtomicInteger stockFailCount = new AtomicInteger();

        for (int i = 0; i < CONCURRENT_USERS; i++) {
            final int userId = 1+ i;
            futures.add(pool.submit(() -> runOnce(userId, GAME_ID)));
        }

        for (Future<TestResult> f : futures) {
            TestResult r = f.get();
            if (r.success) successCount.incrementAndGet();
            else {
                if (r.message.contains("库存不足")) stockFailCount.incrementAndGet();
                failCount.incrementAndGet();
            }
            System.out.println(r);
        }

        pool.shutdown();

        long end = System.currentTimeMillis();
        // 计算其他失败数量（非库存不足的失败）
        int otherFailCount = failCount.get() - stockFailCount.get();  // 先获取值再相减
        System.out.println("\n=========================");
        System.out.println("测试完成 ✅");
        System.out.println("并发用户数：" + CONCURRENT_USERS);
        System.out.println("成功下单：" + successCount);
        System.out.println("库存不足：" + stockFailCount);
        System.out.println("失败请求：" + otherFailCount);
        System.out.println("耗时：" + (end - start) + " ms");
        System.out.println("=========================\n");
    }

    /**
     * 单用户执行流程：获取token → 下单
     */
    private static TestResult runOnce(int userId, int gameId) {
        try {
            // 1️⃣ 获取token
            String tokenUrl = BASE_URL + "/idempotent/createToken?userId=" + userId;
            HttpRequest tokenReq = HttpRequest.newBuilder()
                    .uri(URI.create(tokenUrl))
                    .timeout(Duration.ofSeconds(5))
                    .GET()
                    .build();

            HttpResponse<String> tokenResp = CLIENT.send(tokenReq, HttpResponse.BodyHandlers.ofString());
            if (tokenResp.statusCode() != 200) {
                return new TestResult(false, userId, "获取token失败:" + tokenResp.statusCode());
            }

            JsonNode json = MAPPER.readTree(tokenResp.body());
            JsonNode data = json.get("data");
            if (data == null) {
                return new TestResult(false, userId, "token响应异常:" + tokenResp.body());
            }

            String formtoken = data.get("formtoken").asText();
            String formvalue = data.get("formvalue").asText();

            // 2️⃣ 创建订单
            Map<String, Object> orderPayload = new HashMap<>();
            orderPayload.put("gameId", gameId);
            orderPayload.put("price", 0.01);

            HttpRequest orderReq = HttpRequest.newBuilder()
                    .uri(URI.create(BASE_URL + "/myorder/create/"+ userId))
                    .timeout(Duration.ofSeconds(5))
                    .header("Content-Type", "application/json")
                    .header("formtoken", formtoken)
                    .header("formvalue", formvalue)
                    .POST(HttpRequest.BodyPublishers.ofString(MAPPER.writeValueAsString(orderPayload)))
                    .build();

            HttpResponse<String> orderResp = CLIENT.send(orderReq, HttpResponse.BodyHandlers.ofString());
            int status = orderResp.statusCode();
            String body = orderResp.body();

            boolean ok = (status >= 200 && status < 300) && body.contains("成功");
            return new TestResult(ok, userId, "[" + status + "] " + body);

        } catch (Exception e) {
            return new TestResult(false, userId, "异常:" + e.getMessage());
        }
    }

    /**
     * 单次请求结果
     */
    static class TestResult {
        boolean success;
        int userId;
        String message;

        public TestResult(boolean success, int userId, String message) {
            this.success = success;
            this.userId = userId;
            this.message = message;
        }

        @Override
        public String toString() {
            return (success ? "✅" : "❌") + " user=" + userId + " → " + message;
        }
    }
}


