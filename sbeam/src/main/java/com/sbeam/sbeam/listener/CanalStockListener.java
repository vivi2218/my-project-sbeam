package com.sbeam.sbeam.listener;

import com.alibaba.otter.canal.client.CanalConnector;
import com.alibaba.otter.canal.client.CanalConnectors;
import com.alibaba.otter.canal.protocol.CanalEntry;
import com.alibaba.otter.canal.protocol.Message;
import jakarta.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;

import java.net.InetSocketAddress;



@Component
public class CanalStockListener {
    @Autowired
    private RedisTemplate redisTemplate;
    @PostConstruct
    public void init() {
        new Thread(this::listen).start();
    }
    public void listen() {
        CanalConnector connector = CanalConnectors.newSingleConnector(
                new InetSocketAddress("127.0.0.1", 11111),
                "example",
                "",
                "" );
        connector.connect();
        connector.subscribe("sbeam\\.game");
        connector.rollback();
        System.out.println("✅ Canal 监听器已启动...");
        while (true)
        {
            try {
                Message message = connector.getWithoutAck(100);
                long batchId = message.getId();
                if (batchId == -1 || message.getEntries().isEmpty()) {
                    Thread.sleep(500); continue;
                }
                for (CanalEntry.Entry entry : message.getEntries()) {
                    if (entry.getEntryType() != CanalEntry.EntryType.ROWDATA)
                    {
                        continue;
                    }
                    CanalEntry.RowChange rowChange = CanalEntry.RowChange.parseFrom(entry.getStoreValue());
                    CanalEntry.EventType eventType = rowChange.getEventType();
                    String tableName = entry.getHeader().getTableName();
                    System.out.println("✅ 检测到表变化: " + tableName + ", 类型: " + eventType);
                    if ("game".equals(tableName) && eventType == CanalEntry.EventType.UPDATE) {
                        handleStock(rowChange);
                    }
                }
                connector.ack(batchId);
                } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    private void handleStock(CanalEntry.RowChange rowChange) {
        for (CanalEntry.RowData rowData : rowChange.getRowDatasList()) {
            int id = 0;
            int stock = 0;
            for (CanalEntry.Column col : rowData.getAfterColumnsList()) {
                if ("game_id".equals(col.getName())) {
                    id = Integer.parseInt(col.getValue());
                }
                if ("remain_stock".equals(col.getName())) {
                    stock = Integer.parseInt(col.getValue());
                }
            }
            System.out.println("✅ 库存变更：gameId=" + id + ", 新库存=" + stock);
        // 在这里同步 redis
         redisTemplate.opsForValue().set("game:stock:" + id, stock);
         }
    }
}
