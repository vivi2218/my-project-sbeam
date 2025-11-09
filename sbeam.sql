/*
 Navicat Premium Data Transfer

 Source Server         : liningning_mysql
 Source Server Type    : MySQL
 Source Server Version : 80029
 Source Host           : localhost:3308
 Source Schema         : sbeam

 Target Server Type    : MySQL
 Target Server Version : 80029
 File Encoding         : 65001

 Date: 08/11/2025 10:42:53
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for cart
-- ----------------------------
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart`  (
  `cart_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '购物车ID',
  `user_id` int(0) NOT NULL COMMENT '用户ID',
  `game_id` int(0) NOT NULL COMMENT '游戏ID',
  `game_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '游戏名称',
  `game_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '游戏加入购物车时的价格',
  `sales_id` int(0) NULL DEFAULT 0 COMMENT '折扣ID',
  `status` int(0) NULL DEFAULT 0 COMMENT '购物车状态，0表示正常，1表示异常',
  `version` int(0) NULL DEFAULT 1 COMMENT '版本控制',
  `created_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`cart_id`) USING BTREE,
  INDEX `fk_cart_user`(`user_id`) USING BTREE,
  INDEX `fk_cart_game`(`game_id`) USING BTREE,
  INDEX `fk_cart_sales`(`sales_id`) USING BTREE,
  CONSTRAINT `fk_cart_game` FOREIGN KEY (`game_id`) REFERENCES `game` (`game_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_cart_sales` FOREIGN KEY (`sales_id`) REFERENCES `sales` (`sales_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_cart_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 34 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cart
-- ----------------------------
INSERT INTO `cart` VALUES (1, 1, 1, 'Dragon Quest', 59.99, 1, 1, 1, '2021-01-01 10:00:00', '2025-11-06 21:07:54');
INSERT INTO `cart` VALUES (2, 1, 2, 'Call of Duty', 69.99, 2, 1, 1, '2021-02-01 11:00:00', '2025-11-06 21:07:58');
INSERT INTO `cart` VALUES (24, 2, 1, 'Dragon Quest', 59.99, 1, 1, 1, '2025-11-06 21:49:19', '2025-11-06 21:49:19');
INSERT INTO `cart` VALUES (25, 2, 2, 'Call of Duty', 69.99, 1, 1, 1, '2025-11-06 21:49:42', '2025-11-06 21:49:42');
INSERT INTO `cart` VALUES (26, 2, 4, 'FIFA 21', 49.99, 1, 1, 1, '2025-11-06 21:54:17', '2025-11-06 22:07:29');
INSERT INTO `cart` VALUES (27, 2, 4, 'FIFA 21', 49.99, 1, 1, 1, '2025-11-06 22:07:37', '2025-11-06 22:23:03');
INSERT INTO `cart` VALUES (28, 2, 5, 'Civilization VI', 39.99, 1, 1, 1, '2025-11-06 22:23:18', '2025-11-06 22:33:36');
INSERT INTO `cart` VALUES (29, 2, 1, 'Dragon Quest', 59.99, 1, 1, 1, '2025-11-06 22:23:27', '2025-11-06 22:33:38');
INSERT INTO `cart` VALUES (30, 2, 4, 'FIFA 21', 49.99, 1, 1, 1, '2025-11-06 22:33:47', '2025-11-06 22:35:46');
INSERT INTO `cart` VALUES (31, 2, 1, 'Dragon Quest', 59.99, 1, 1, 1, '2025-11-06 22:35:52', '2025-11-06 22:37:34');
INSERT INTO `cart` VALUES (32, 2, 4, 'FIFA 21', 49.99, 1, 1, 1, '2025-11-06 22:35:57', '2025-11-06 22:37:37');
INSERT INTO `cart` VALUES (33, 2, 4, 'FIFA 21', 49.99, 1, 1, 1, '2025-11-06 22:37:45', '2025-11-06 22:37:45');
INSERT INTO `cart` VALUES (34, 2, 1, 'Dragon Quest', 59.99, 1, 1, 1, '2025-11-06 22:45:59', '2025-11-06 22:45:59');
INSERT INTO `cart` VALUES (35, 1, 2, 'Call of Duty', 69.99, 1, 1, 1, '2025-11-07 18:51:20', '2025-11-07 18:51:20');
INSERT INTO `cart` VALUES (36, 1, 4, 'FIFA 21', 49.99, 1, 1, 1, '2025-11-07 18:51:28', '2025-11-07 18:51:28');
INSERT INTO `cart` VALUES (37, 1, 1, 'Dragon Quest', 59.99, 1, 1, 1, '2025-11-07 18:52:37', '2025-11-07 18:52:37');
INSERT INTO `cart` VALUES (38, 1, 5, 'Civilization VI', 39.99, 1, 1, 1, '2025-11-07 18:52:42', '2025-11-07 18:52:42');
INSERT INTO `cart` VALUES (39, 1, 1, 'Dragon Quest', 59.99, 1, 1, 1, '2025-11-07 18:55:45', '2025-11-07 18:55:45');
INSERT INTO `cart` VALUES (40, 1, 2, 'Call of Duty', 69.99, 1, 1, 1, '2025-11-07 18:55:53', '2025-11-07 18:55:53');
INSERT INTO `cart` VALUES (41, 1, 1, 'Dragon Quest', 59.99, 1, 1, 1, '2025-11-07 19:08:46', '2025-11-07 19:08:59');
INSERT INTO `cart` VALUES (42, 1, 2, 'Call of Duty', 69.99, 1, 1, 1, '2025-11-07 19:08:52', '2025-11-07 19:08:52');

-- ----------------------------
-- Table structure for cdkey_stock
-- ----------------------------
DROP TABLE IF EXISTS `cdkey_stock`;
CREATE TABLE `cdkey_stock`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `game_id` int(0) NOT NULL,
  `cdkey` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '激活码',
  `status` int(0) NULL DEFAULT 0 COMMENT '0未售出 1已售出 2作废',
  `order_id` int(0) NULL DEFAULT NULL,
  `user_id` int(0) NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_game_cdkey`(`game_id`, `cdkey`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 35 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'CDKey库存表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cdkey_stock
-- ----------------------------
INSERT INTO `cdkey_stock` VALUES (1, 1, '0df26604-ef25-430b-850b-8216a27ab5b0', 1, 25, 1, '2025-10-31 14:52:54', '2025-11-04 15:35:58');
INSERT INTO `cdkey_stock` VALUES (2, 1, 'bf43c31e-29d1-4000-944d-a3edb9db1426', 1, 37, 1, '2025-10-31 14:53:37', '2025-11-07 18:57:36');
INSERT INTO `cdkey_stock` VALUES (3, 1, '491bbf45-9815-4ebe-ae24-e31c4aacdd00', 1, 31, 1, '2025-10-31 14:53:38', '2025-11-06 19:26:13');
INSERT INTO `cdkey_stock` VALUES (4, 1, 'f5c32b45-1fb1-4bce-b147-bb181cf35bac', 0, NULL, NULL, '2025-10-31 14:53:39', '2025-10-31 14:53:39');
INSERT INTO `cdkey_stock` VALUES (5, 1, 'eca7e3cc-8de3-4cb6-afc1-647cd79953b5', 0, NULL, NULL, '2025-10-31 14:53:40', '2025-10-31 14:53:39');
INSERT INTO `cdkey_stock` VALUES (6, 1, '8d474f38-0796-45fd-a44c-910ea2e12790', 1, 34, 2, '2025-10-31 14:53:41', '2025-11-06 22:56:54');
INSERT INTO `cdkey_stock` VALUES (7, 2, 'dbdf38ee-6254-4b16-8919-c7d4945df519', 0, NULL, NULL, '2025-10-31 14:53:49', '2025-10-31 14:53:48');
INSERT INTO `cdkey_stock` VALUES (8, 2, '2276f284-2a74-4aea-a280-c5bf1508af84', 1, 31, 1, '2025-10-31 14:53:49', '2025-11-06 19:26:13');
INSERT INTO `cdkey_stock` VALUES (9, 2, 'd863eb5a-d664-4f50-b7a3-988f4ab57098', 0, NULL, NULL, '2025-10-31 14:53:50', '2025-10-31 14:53:50');
INSERT INTO `cdkey_stock` VALUES (10, 2, '9f0f8a44-b6f5-435d-b313-1f95ff270b96', 0, NULL, NULL, '2025-10-31 14:53:51', '2025-10-31 14:53:50');
INSERT INTO `cdkey_stock` VALUES (11, 2, 'beafaef9-dd5c-4e53-993c-4f38c325134f', 0, NULL, NULL, '2025-10-31 14:53:52', '2025-10-31 14:53:51');
INSERT INTO `cdkey_stock` VALUES (12, 2, '09de55f4-07ff-4e32-93e6-ddb9215c1fb6', 1, 25, 1, '2025-10-31 14:53:52', '2025-11-04 15:35:58');
INSERT INTO `cdkey_stock` VALUES (13, 1, 'f7711b43-a816-4843-bc8b-158bd88187c2', 0, NULL, NULL, '2025-11-06 21:40:03', '2025-11-06 21:40:03');
INSERT INTO `cdkey_stock` VALUES (14, 1, 'e6255e6f-1964-4033-98a4-f18a93d45e81', 0, NULL, NULL, '2025-11-06 21:40:09', '2025-11-06 21:40:08');
INSERT INTO `cdkey_stock` VALUES (15, 1, '1b97047b-3a71-4b3c-9098-4b1fab1269b2', 1, 33, 2, '2025-11-06 21:40:10', '2025-11-06 21:51:42');
INSERT INTO `cdkey_stock` VALUES (16, 1, 'dca6f138-f9e8-4aac-aece-41157b97a28a', 0, NULL, NULL, '2025-11-06 21:40:11', '2025-11-06 21:40:10');
INSERT INTO `cdkey_stock` VALUES (17, 2, 'cc06ef70-989c-41ca-8458-f4f92f52a983', 0, NULL, NULL, '2025-11-06 21:40:18', '2025-11-06 21:40:18');
INSERT INTO `cdkey_stock` VALUES (18, 2, '6d860013-3c12-42c8-bb99-a117abbfd72c', 1, 38, 1, '2025-11-06 21:40:19', '2025-11-07 19:12:25');
INSERT INTO `cdkey_stock` VALUES (19, 2, '26ef96f3-2623-4995-9660-3042b34f5987', 1, 37, 1, '2025-11-06 21:40:20', '2025-11-07 18:57:36');
INSERT INTO `cdkey_stock` VALUES (20, 2, '099d42d0-f524-46c8-a848-9a9a55820d4c', 1, 33, 2, '2025-11-06 21:40:21', '2025-11-06 21:51:42');
INSERT INTO `cdkey_stock` VALUES (21, 3, 'c9d61af3-6372-4a29-bb18-342d723f421a', 0, NULL, NULL, '2025-11-06 21:40:26', '2025-11-06 21:40:25');
INSERT INTO `cdkey_stock` VALUES (22, 3, 'e648b151-28f7-4b3f-8cb6-05730b30bfed', 0, NULL, NULL, '2025-11-06 21:40:27', '2025-11-06 21:40:26');
INSERT INTO `cdkey_stock` VALUES (23, 3, 'ce4762c6-dc0e-469e-a2fc-1613b07e795e', 0, NULL, NULL, '2025-11-06 21:40:28', '2025-11-06 21:40:27');
INSERT INTO `cdkey_stock` VALUES (24, 3, '6bf63739-0bc7-441b-91c5-d94d63d4b4b9', 0, NULL, NULL, '2025-11-06 21:40:29', '2025-11-06 21:40:28');
INSERT INTO `cdkey_stock` VALUES (25, 3, 'c602c764-20ed-415e-8d3d-940851bdd3f1', 0, NULL, NULL, '2025-11-06 21:41:09', '2025-11-06 21:41:09');
INSERT INTO `cdkey_stock` VALUES (26, 4, 'ca5a8c70-74c6-46b9-a8e2-60032092037c', 0, NULL, NULL, '2025-11-06 21:41:14', '2025-11-06 21:41:14');
INSERT INTO `cdkey_stock` VALUES (27, 4, 'be1ec027-f2de-48af-992b-aa5cf2ef3738', 0, NULL, NULL, '2025-11-06 21:41:15', '2025-11-06 21:41:15');
INSERT INTO `cdkey_stock` VALUES (28, 4, '1747a45d-079e-44b4-8655-6b478665472a', 1, 34, 2, '2025-11-06 21:41:16', '2025-11-06 22:56:54');
INSERT INTO `cdkey_stock` VALUES (29, 4, 'f5b9c438-872f-4464-900b-aabdcdf80f87', 0, NULL, NULL, '2025-11-06 21:41:17', '2025-11-06 21:41:17');
INSERT INTO `cdkey_stock` VALUES (30, 4, '8ed849c1-8d7f-4561-b7a7-1eb949ecb38a', 0, NULL, NULL, '2025-11-06 21:41:18', '2025-11-06 21:41:18');
INSERT INTO `cdkey_stock` VALUES (31, 5, 'a48c3ad3-5774-4ee1-b9e8-64390d02ddbe', 0, NULL, NULL, '2025-11-06 21:41:26', '2025-11-06 21:41:25');
INSERT INTO `cdkey_stock` VALUES (32, 5, '4c4d5e60-b73c-421a-8fe2-3d53859b1675', 0, NULL, NULL, '2025-11-06 21:41:26', '2025-11-06 21:41:26');
INSERT INTO `cdkey_stock` VALUES (33, 5, '49e28600-509e-4e6f-b47d-29a9f5b19bce', 0, NULL, NULL, '2025-11-06 21:41:27', '2025-11-06 21:41:27');
INSERT INTO `cdkey_stock` VALUES (34, 5, 'd0d15e40-4659-420d-896e-c852b8144190', 0, NULL, NULL, '2025-11-06 21:41:28', '2025-11-06 21:41:28');
INSERT INTO `cdkey_stock` VALUES (35, 5, '1f1fbc72-6d22-4b21-b45a-43c8cf02b973', 0, NULL, NULL, '2025-11-06 21:41:29', '2025-11-06 21:41:29');

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment`  (
  `comment_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '评论ID',
  `post_id` int(0) NULL DEFAULT NULL COMMENT '帖子 id',
  `user_id` int(0) NOT NULL COMMENT '用户ID',
  `game_id` int(0) NULL DEFAULT NULL COMMENT '游戏ID',
  `rating` decimal(2, 1) NULL DEFAULT NULL COMMENT '评分',
  `comment_text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '评论内容',
  `parent_comment_id` int(0) NULL DEFAULT NULL COMMENT '父评论ID',
  `status` int(0) NULL DEFAULT 0 COMMENT '状态，0表示正常，1表示异常',
  `version` int(0) NULL DEFAULT 1 COMMENT '版本控制',
  `created_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`comment_id`) USING BTREE,
  INDEX `fk_comment_user`(`user_id`) USING BTREE,
  INDEX `fk_comment_game`(`game_id`) USING BTREE,
  INDEX `fk_comment_post`(`post_id`) USING BTREE,
  CONSTRAINT `fk_comment_game` FOREIGN KEY (`game_id`) REFERENCES `game` (`game_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_comment_post` FOREIGN KEY (`post_id`) REFERENCES `post` (`post_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_comment_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES (1, NULL, 1, 1, 8.5, '游戏剧情很棒', NULL, 0, 1, '2021-01-01 10:00:00', '2021-01-01 10:00:00');
INSERT INTO `comment` VALUES (2, NULL, 2, 2, 9.0, '枪械手感很真实', NULL, 0, 1, '2021-02-01 11:00:00', '2021-02-01 11:00:00');
INSERT INTO `comment` VALUES (3, 1, 3, NULL, NULL, '新手攻略写得不错！', NULL, 0, 1, '2021-03-01 12:00:00', '2021-03-01 12:00:00');
INSERT INTO `comment` VALUES (4, NULL, 4, 4, 8.0, '足球动作很真实', NULL, 0, 1, '2021-04-01 13:00:00', '2021-04-01 13:00:00');
INSERT INTO `comment` VALUES (5, 2, 5, NULL, NULL, '我觉得突击步枪更好用', 3, 0, 1, '2021-05-01 14:00:00', '2021-05-01 14:00:00');
INSERT INTO `comment` VALUES (6, NULL, 6, 6, 7.0, '解谜环节有点难', NULL, 0, 1, '2021-06-01 15:00:00', '2021-06-01 15:00:00');
INSERT INTO `comment` VALUES (7, 7, 7, NULL, NULL, '漂移教学视频太棒了', NULL, 0, 1, '2021-07-01 16:00:00', '2021-07-01 16:00:00');
INSERT INTO `comment` VALUES (8, NULL, 8, 8, 6.5, '关卡有点重复', NULL, 0, 1, '2021-08-01 17:00:00', '2021-08-01 17:00:00');
INSERT INTO `comment` VALUES (9, 9, 9, NULL, NULL, '卡组推荐很实用，谢谢！', NULL, 0, 1, '2021-09-01 18:00:00', '2021-09-01 18:00:00');
INSERT INTO `comment` VALUES (10, NULL, 10, 10, 8.3, '城市建设很有趣', NULL, 0, 1, '2021-10-01 19:00:00', '2021-10-01 19:00:00');
INSERT INTO `comment` VALUES (11, 11, 11, NULL, NULL, 'Among Us的套路太有意思了', NULL, 0, 1, '2021-11-01 20:00:00', '2021-11-01 20:00:00');
INSERT INTO `comment` VALUES (12, NULL, 12, 12, 9.8, '沙盒自由度很高', NULL, 0, 1, '2021-12-01 21:00:00', '2021-12-01 21:00:00');
INSERT INTO `comment` VALUES (13, 13, 13, NULL, NULL, '生存技巧干货满满', NULL, 0, 1, '2022-01-01 22:00:00', '2022-01-01 22:00:00');
INSERT INTO `comment` VALUES (14, NULL, 14, 14, 7.6, '恐怖氛围拉满', NULL, 0, 1, '2022-02-01 23:00:00', '2022-02-01 23:00:00');
INSERT INTO `comment` VALUES (15, 15, 15, NULL, NULL, '魔兽怀旧服才是经典', NULL, 0, 1, '2022-03-01 09:00:00', '2022-03-01 09:00:00');
INSERT INTO `comment` VALUES (16, NULL, 16, 16, 9.0, 'VR体验沉浸感强', NULL, 0, 1, '2022-04-01 10:00:00', '2022-04-01 10:00:00');
INSERT INTO `comment` VALUES (17, 17, 17, NULL, NULL, '格斗连招很实用，学到了', NULL, 0, 1, '2022-05-01 11:00:00', '2022-05-01 11:00:00');
INSERT INTO `comment` VALUES (18, NULL, 18, 18, 7.2, '桌游氛围感好', NULL, 0, 1, '2022-06-01 12:00:00', '2022-06-01 12:00:00');
INSERT INTO `comment` VALUES (19, 19, 19, NULL, NULL, '黑魂真是难哭我了', NULL, 0, 1, '2022-07-01 13:00:00', '2022-07-01 13:00:00');
INSERT INTO `comment` VALUES (20, NULL, 20, 20, 8.9, '赛博朋克世界观超棒', NULL, 0, 1, '2022-08-01 14:00:00', '2022-08-01 14:00:00');

-- ----------------------------
-- Table structure for community
-- ----------------------------
DROP TABLE IF EXISTS `community`;
CREATE TABLE `community`  (
  `community_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '社区ID',
  `community_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '社区名称',
  `community_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '社区描述',
  `status` int(0) NULL DEFAULT 0 COMMENT '状态，0表示正常，1表示异常',
  `version` int(0) NULL DEFAULT 1 COMMENT '版本控制',
  `created_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`community_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of community
-- ----------------------------
INSERT INTO `community` VALUES (1, 'RPG Lovers', '专注角色扮演类游戏的玩家聚集地', 0, 1, '2020-01-10 14:00:00', '2021-01-15 18:20:00');
INSERT INTO `community` VALUES (2, 'FPS Club', '热爱第一人称射击游戏的玩家社区', 0, 1, '2019-06-20 10:10:00', '2020-07-11 12:00:00');
INSERT INTO `community` VALUES (3, 'MOBA Arena', '讨论MOBA竞技战术和赛事的地方', 0, 1, '2021-02-01 08:22:00', '2022-03-01 11:45:00');
INSERT INTO `community` VALUES (4, 'Sports Zone', '专注体育类游戏的爱好者社区', 0, 1, '2018-05-13 19:05:00', '2019-05-13 19:05:00');
INSERT INTO `community` VALUES (5, 'Strategy World', '策略类游戏爱好者的聚集地', 0, 1, '2020-07-01 15:33:00', '2021-07-15 17:50:00');
INSERT INTO `community` VALUES (6, 'Adventure Time', '冒险类游戏玩家社区', 0, 1, '2019-09-22 09:00:00', '2020-09-22 09:00:00');
INSERT INTO `community` VALUES (7, 'Racing Fans', '赛车类游戏爱好者聚集地', 0, 1, '2021-01-05 12:45:00', '2022-01-05 12:45:00');
INSERT INTO `community` VALUES (8, 'Puzzle Club', '益智解谜类游戏爱好者社区', 0, 1, '2018-03-18 18:20:00', '2019-04-01 09:10:00');
INSERT INTO `community` VALUES (9, 'Card Gamers', '卡牌游戏玩家聚集地', 0, 1, '2020-11-11 10:11:00', '2021-12-12 11:22:00');
INSERT INTO `community` VALUES (10, 'Simulation Life', '模拟经营类游戏爱好者的社区', 0, 1, '2019-02-02 16:00:00', '2020-02-02 16:00:00');
INSERT INTO `community` VALUES (11, 'Indie Games Hub', '独立游戏开发者与玩家的聚集地', 0, 1, '2020-08-08 08:08:00', '2021-08-08 08:08:00');
INSERT INTO `community` VALUES (12, 'Casual Corner', '休闲轻松类游戏玩家社区', 0, 1, '2018-12-12 12:12:00', '2019-12-12 12:12:00');
INSERT INTO `community` VALUES (13, 'Sandbox World', '沙盒开放世界游戏讨论区', 0, 1, '2021-06-06 18:30:00', '2022-06-06 18:30:00');
INSERT INTO `community` VALUES (14, 'Survival Camp', '生存类游戏玩家分享社区', 0, 1, '2019-01-15 09:45:00', '2020-01-15 09:45:00');
INSERT INTO `community` VALUES (15, 'Horror House', '恐怖游戏爱好者的聚集地', 0, 1, '2020-10-31 23:59:00', '2021-10-31 23:59:00');
INSERT INTO `community` VALUES (16, 'MMO Hub', 'MMORPG玩家交流中心', 0, 1, '2018-07-20 20:00:00', '2019-07-20 20:00:00');
INSERT INTO `community` VALUES (17, 'VR World', '虚拟现实游戏讨论区', 0, 1, '2021-09-09 09:09:00', '2022-09-09 09:09:00');
INSERT INTO `community` VALUES (18, 'Music Beats', '音乐节奏类游戏爱好者社区', 0, 1, '2019-11-22 20:20:00', '2020-11-22 20:20:00');
INSERT INTO `community` VALUES (19, 'Fighting Club', '格斗游戏爱好者聚集地', 0, 1, '2020-04-04 14:14:00', '2021-04-04 14:14:00');
INSERT INTO `community` VALUES (20, 'Board Games', '桌游类玩家讨论社区', 0, 1, '2018-02-28 11:00:00', '2019-02-28 11:00:00');

-- ----------------------------
-- Table structure for game
-- ----------------------------
DROP TABLE IF EXISTS `game`;
CREATE TABLE `game`  (
  `game_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '游戏ID',
  `game_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '游戏名称',
  `game_original_price` decimal(10, 2) NOT NULL COMMENT '游戏原始价格',
  `total_stock` int(0) NULL DEFAULT NULL COMMENT '总库存',
  `remain_stock` int(0) NULL DEFAULT NULL COMMENT '剩余库存',
  `release_date` date NULL DEFAULT NULL COMMENT '游戏发行日期',
  `status` int(0) NULL DEFAULT 0 COMMENT '游戏状态,0表示可获取,1表示下架',
  `main_image_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '主图片 URL',
  `version` int(0) NULL DEFAULT 1 COMMENT '版本控制',
  `created_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`game_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of game
-- ----------------------------
INSERT INTO `game` VALUES (1, 'Dragon Quest', 59.99, 10, 5, '2020-01-01', 0, 'dragonquest.jpg', 1, '2020-01-01 10:00:00', '2025-11-08 10:21:39');
INSERT INTO `game` VALUES (2, 'Call of Duty', 69.99, 10, 5, '2021-11-11', 0, 'cod.jpg', 1, '2021-11-11 15:00:00', '2025-11-07 19:12:24');
INSERT INTO `game` VALUES (3, 'League of Heroes', 0.00, 5, 5, '2019-09-20', 0, 'loh.jpg', 1, '2019-09-20 09:00:00', '2025-11-06 21:44:48');
INSERT INTO `game` VALUES (4, 'FIFA 21', 49.99, 5, 4, '2020-09-25', 0, 'fifa21.jpg', 1, '2020-09-25 08:30:00', '2025-11-06 22:56:53');
INSERT INTO `game` VALUES (5, 'Civilization VI', 39.99, 5, 5, '2018-10-20', 0, 'civ6.jpg', 1, '2018-10-20 13:00:00', '2025-11-06 21:45:15');
INSERT INTO `game` VALUES (6, 'Tomb Raider', 29.99, NULL, NULL, '2019-03-15', 0, 'tombraider.jpg', 1, '2019-03-15 14:00:00', '2020-05-01 10:30:00');
INSERT INTO `game` VALUES (7, 'Need for Speed', 19.99, NULL, NULL, '2017-08-18', 0, 'nfs.jpg', 1, '2017-08-18 17:00:00', '2018-12-20 09:00:00');
INSERT INTO `game` VALUES (8, 'Candy Crush', 0.00, NULL, NULL, '2016-04-10', 0, 'candycrush.jpg', 1, '2016-04-10 12:00:00', '2017-04-10 12:00:00');
INSERT INTO `game` VALUES (9, 'Hearthstone', 0.00, NULL, NULL, '2018-03-01', 0, 'hearthstone.jpg', 1, '2018-03-01 11:00:00', '2019-03-01 11:00:00');
INSERT INTO `game` VALUES (10, 'SimCity', 29.99, NULL, NULL, '2015-07-22', 0, 'simcity.jpg', 1, '2015-07-22 15:00:00', '2016-07-22 15:00:00');
INSERT INTO `game` VALUES (11, 'Among Us', 4.99, NULL, NULL, '2020-06-15', 0, 'amongus.jpg', 1, '2020-06-15 20:00:00', '2021-06-15 20:00:00');
INSERT INTO `game` VALUES (12, 'Minecraft', 26.95, NULL, NULL, '2016-05-17', 0, 'minecraft.jpg', 1, '2016-05-17 10:00:00', '2017-05-17 10:00:00');
INSERT INTO `game` VALUES (13, 'Rust', 34.99, NULL, NULL, '2019-12-13', 0, 'rust.jpg', 1, '2019-12-13 08:00:00', '2020-12-13 08:00:00');
INSERT INTO `game` VALUES (14, 'Resident Evil 7', 59.99, NULL, NULL, '2017-01-24', 0, 're7.jpg', 1, '2017-01-24 12:00:00', '2018-01-24 12:00:00');
INSERT INTO `game` VALUES (15, 'World of Warcraft', 0.00, NULL, NULL, '2015-11-23', 0, 'wow.jpg', 1, '2015-11-23 10:00:00', '2016-11-23 10:00:00');
INSERT INTO `game` VALUES (16, 'Beat Saber', 29.99, NULL, NULL, '2019-05-21', 0, 'beatsaber.jpg', 1, '2019-05-21 12:00:00', '2020-05-21 12:00:00');
INSERT INTO `game` VALUES (17, 'Tekken 7', 49.99, NULL, NULL, '2017-06-02', 0, 'tekken7.jpg', 1, '2017-06-02 09:00:00', '2018-06-02 09:00:00');
INSERT INTO `game` VALUES (18, 'Catan', 19.99, NULL, NULL, '2018-02-15', 0, 'catan.jpg', 1, '2018-02-15 13:00:00', '2019-02-15 13:00:00');
INSERT INTO `game` VALUES (19, 'Dark Souls III', 59.99, NULL, NULL, '2016-04-12', 0, 'ds3.jpg', 1, '2016-04-12 12:00:00', '2017-04-12 12:00:00');
INSERT INTO `game` VALUES (20, 'Cyberpunk 2077', 59.99, NULL, NULL, '2020-12-10', 0, 'cyberpunk2077.jpg', 1, '2020-12-10 09:00:00', '2021-12-10 09:00:00');

-- ----------------------------
-- Table structure for game_achievement
-- ----------------------------
DROP TABLE IF EXISTS `game_achievement`;
CREATE TABLE `game_achievement`  (
  `achievement_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '成就ID',
  `game_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '游戏名称',
  `game_id` int(0) NOT NULL COMMENT '游戏ID',
  `achievement_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '成就名称',
  `achievement_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '成就描述',
  `status` int(0) NULL DEFAULT 0 COMMENT '状态，0表示正常，1表示异常',
  `version` int(0) NULL DEFAULT 1 COMMENT '版本控制',
  `created_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`achievement_id`) USING BTREE,
  INDEX `fk_game_achievement_game`(`game_id`) USING BTREE,
  CONSTRAINT `fk_game_achievement_game` FOREIGN KEY (`game_id`) REFERENCES `game` (`game_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of game_achievement
-- ----------------------------
INSERT INTO `game_achievement` VALUES (1, 'Dragon Quest', 1, '初出茅庐', '完成第一章任务', 0, 1, '2020-01-01 12:00:00', '2020-06-01 12:00:00');
INSERT INTO `game_achievement` VALUES (2, 'Call of Duty', 2, '百发百中', '命中率达到90%', 0, 1, '2021-11-11 12:00:00', '2022-01-11 12:00:00');
INSERT INTO `game_achievement` VALUES (3, 'League of Heroes', 3, '五杀', '单局内连续击败5名敌人', 0, 1, '2019-09-20 12:00:00', '2020-09-20 12:00:00');
INSERT INTO `game_achievement` VALUES (4, 'FIFA 21', 4, '完美射门', '连续进3球', 0, 1, '2020-09-25 12:00:00', '2021-09-25 12:00:00');
INSERT INTO `game_achievement` VALUES (5, 'Civilization VI', 5, '世界霸主', '建立世界霸权', 0, 1, '2018-10-20 12:00:00', '2019-10-20 12:00:00');

-- ----------------------------
-- Table structure for game_bundle
-- ----------------------------
DROP TABLE IF EXISTS `game_bundle`;
CREATE TABLE `game_bundle`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '捆绑包ID',
  `bundle_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '捆绑包名称',
  `game_id` int(0) NOT NULL COMMENT '游戏ID',
  `discount_policy` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '优惠策略',
  `status` int(0) NULL DEFAULT 0 COMMENT '状态，0表示正常，1表示异常',
  `version` int(0) NULL DEFAULT 1 COMMENT '版本控制',
  `created_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_game_bundle_game`(`game_id`) USING BTREE,
  CONSTRAINT `fk_game_bundle_game` FOREIGN KEY (`game_id`) REFERENCES `game` (`game_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of game_bundle
-- ----------------------------
INSERT INTO `game_bundle` VALUES (1, 'Dragon Quest Starter Pack', 1, '包含主游戏+入门DLC，整体折扣20%', 0, 1, '2020-01-01 10:00:00', '2020-06-01 10:00:00');
INSERT INTO `game_bundle` VALUES (2, 'Call of Duty Shooter Bundle', 2, '主游戏+武器包，立减30%', 0, 1, '2021-11-11 12:00:00', '2022-01-01 12:00:00');
INSERT INTO `game_bundle` VALUES (3, 'MOBA Newcomer Pack', 3, '新手礼包：皮肤+经验加成，折扣15%', 0, 1, '2019-09-20 12:00:00', '2020-02-10 12:00:00');
INSERT INTO `game_bundle` VALUES (4, 'FIFA Family Bundle', 4, '多人组合包，买2赠1', 0, 1, '2020-09-25 08:30:00', '2021-09-25 08:30:00');
INSERT INTO `game_bundle` VALUES (5, 'Civ6 Expansion Pack', 5, '包含扩展包，整体9折', 0, 1, '2018-10-20 13:00:00', '2019-12-15 16:00:00');
INSERT INTO `game_bundle` VALUES (6, 'Tomb Raider Adventure Pack', 6, '主游戏+季票，优惠10%', 0, 1, '2019-03-15 14:00:00', '2020-05-01 10:30:00');
INSERT INTO `game_bundle` VALUES (7, 'Racing Essentials', 7, '赛车+赛道DLC，组合价更优', 0, 1, '2017-08-18 17:00:00', '2018-12-20 09:00:00');
INSERT INTO `game_bundle` VALUES (8, 'Puzzle Bundle', 8, '三款益智小游戏合集，折扣50%', 0, 1, '2016-04-10 12:00:00', '2017-04-10 12:00:00');
INSERT INTO `game_bundle` VALUES (9, 'Card Masters Set', 9, '卡牌扩展包合集，送新手包', 0, 1, '2018-03-01 11:00:00', '2019-03-01 11:00:00');
INSERT INTO `game_bundle` VALUES (10, 'SimCity Deluxe Bundle', 10, '城市素材包+官方扩展，打包价', 0, 1, '2015-07-22 15:00:00', '2016-07-22 15:00:00');
INSERT INTO `game_bundle` VALUES (11, 'Among Us Party Pack', 11, '多人派对皮肤包，优惠30%', 0, 1, '2020-06-15 20:00:00', '2021-06-15 20:00:00');
INSERT INTO `game_bundle` VALUES (12, 'Minecraft Builder Kit', 12, '建材/皮肤包合集，折扣25%', 0, 1, '2016-05-17 10:00:00', '2017-05-17 10:00:00');
INSERT INTO `game_bundle` VALUES (13, 'Rust Survival Kit', 13, '生存工具包+资源，促销40%', 0, 1, '2019-12-13 08:00:00', '2020-12-13 08:00:00');
INSERT INTO `game_bundle` VALUES (14, 'RE7 Horror Pack', 14, '恐怖体验包（含DLC），9折', 0, 1, '2017-01-24 12:00:00', '2018-01-24 12:00:00');
INSERT INTO `game_bundle` VALUES (15, 'WoW Expansion Bundle', 15, '资料片打包，豪华礼包', 0, 1, '2015-11-23 10:00:00', '2016-11-23 10:00:00');
INSERT INTO `game_bundle` VALUES (16, 'Beat Saber Music Pack', 16, '音乐曲包合集，买二送一', 0, 1, '2019-05-21 12:00:00', '2020-05-21 12:00:00');
INSERT INTO `game_bundle` VALUES (17, 'Tekken Fighter Pack', 17, '角色+DLC组合包，优惠25%', 0, 1, '2017-06-02 09:00:00', '2018-06-02 09:00:00');
INSERT INTO `game_bundle` VALUES (18, 'Catan Deluxe Set', 18, '桌游数字版扩展包，折扣35%', 0, 1, '2018-02-15 13:00:00', '2019-02-15 13:00:00');
INSERT INTO `game_bundle` VALUES (19, 'Dark Souls Collector', 19, '限量合集，含地图和服饰', 0, 1, '2016-04-12 12:00:00', '2017-04-12 12:00:00');
INSERT INTO `game_bundle` VALUES (20, 'Cyberpunk Ultimate Pack', 20, '包含季票+DLC，优惠20%', 0, 1, '2020-12-10 09:00:00', '2021-12-10 09:00:00');

-- ----------------------------
-- Table structure for game_images
-- ----------------------------
DROP TABLE IF EXISTS `game_images`;
CREATE TABLE `game_images`  (
  `image_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '游戏图片ID',
  `game_id` int(0) NOT NULL COMMENT '游戏ID',
  `image_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '图片 URL',
  `status` int(0) NULL DEFAULT 0 COMMENT '状态，0表示正常，1表示异常',
  `version` int(0) NULL DEFAULT 1 COMMENT '版本控制',
  `created_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`image_id`) USING BTREE,
  INDEX `fk_game_images_game`(`game_id`) USING BTREE,
  CONSTRAINT `fk_game_images_game` FOREIGN KEY (`game_id`) REFERENCES `game` (`game_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of game_images
-- ----------------------------
INSERT INTO `game_images` VALUES (1, 1, 'dragonquest_1.jpg', 0, 1, '2020-01-01 12:00:00', '2025-10-31 15:08:42');
INSERT INTO `game_images` VALUES (2, 1, 'dragonquest_2.jpg', 0, 1, '2020-01-02 14:00:00', '2025-10-31 15:08:52');
INSERT INTO `game_images` VALUES (3, 2, 'cod_1.jpg', 0, 1, '2021-11-11 10:00:00', '2022-01-01 10:00:00');
INSERT INTO `game_images` VALUES (4, 2, 'cod_2.jpg', 0, 1, '2021-11-12 09:00:00', '2022-02-01 09:00:00');
INSERT INTO `game_images` VALUES (5, 3, 'loh_1.jpg', 0, 1, '2019-09-20 11:00:00', '2020-01-20 11:00:00');
INSERT INTO `game_images` VALUES (6, 4, 'fifa21_1.jpg', 0, 1, '2020-09-25 08:00:00', '2021-01-01 08:00:00');
INSERT INTO `game_images` VALUES (7, 5, 'civ6_1.jpg', 0, 1, '2018-10-20 15:00:00', '2019-01-01 15:00:00');
INSERT INTO `game_images` VALUES (8, 6, 'tombraider_1.jpg', 0, 1, '2019-03-15 09:00:00', '2020-03-15 09:00:00');
INSERT INTO `game_images` VALUES (9, 7, 'nfs_1.jpg', 0, 1, '2017-08-18 12:00:00', '2018-01-01 12:00:00');
INSERT INTO `game_images` VALUES (10, 8, 'candycrush_1.jpg', 0, 1, '2016-04-10 10:00:00', '2017-01-01 10:00:00');
INSERT INTO `game_images` VALUES (11, 9, 'hearthstone_1.jpg', 0, 1, '2018-03-01 13:00:00', '2019-03-01 13:00:00');
INSERT INTO `game_images` VALUES (12, 10, 'simcity_1.jpg', 0, 1, '2015-07-22 17:00:00', '2016-01-01 17:00:00');
INSERT INTO `game_images` VALUES (13, 11, 'amongus_1.jpg', 0, 1, '2020-06-15 18:00:00', '2021-01-01 18:00:00');
INSERT INTO `game_images` VALUES (14, 12, 'minecraft_1.jpg', 0, 1, '2016-05-17 09:00:00', '2017-01-01 09:00:00');
INSERT INTO `game_images` VALUES (15, 13, 'rust_1.jpg', 0, 1, '2019-12-13 11:00:00', '2020-12-13 11:00:00');
INSERT INTO `game_images` VALUES (16, 14, 're7_1.jpg', 0, 1, '2017-01-24 10:00:00', '2018-01-01 10:00:00');
INSERT INTO `game_images` VALUES (17, 15, 'wow_1.jpg', 0, 1, '2015-11-23 08:00:00', '2016-11-23 08:00:00');
INSERT INTO `game_images` VALUES (18, 16, 'beatsaber_1.jpg', 0, 1, '2019-05-21 15:00:00', '2020-05-21 15:00:00');
INSERT INTO `game_images` VALUES (19, 17, 'tekken7_1.jpg', 0, 1, '2017-06-02 14:00:00', '2018-06-02 14:00:00');
INSERT INTO `game_images` VALUES (20, 20, 'cyberpunk2077_1.jpg', 0, 1, '2020-12-10 11:00:00', '2021-12-10 11:00:00');

-- ----------------------------
-- Table structure for game_price_history
-- ----------------------------
DROP TABLE IF EXISTS `game_price_history`;
CREATE TABLE `game_price_history`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `game_id` int(0) NOT NULL COMMENT '游戏ID',
  `original_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '原价',
  `lowest_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '史低价格',
  `lowest_price_time` timestamp(0) NULL DEFAULT NULL COMMENT '史低时间',
  `recent_lowest_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '近史低价格',
  `recent_lowest_price_time` timestamp(0) NULL DEFAULT NULL COMMENT '近史低时间',
  `current_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '当前价格',
  `next_discount_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '下次折扣价格',
  `next_discount_time` timestamp(0) NULL DEFAULT NULL COMMENT '下次折扣时间',
  `status` int(0) NULL DEFAULT 0 COMMENT '状态，0表示正常，1表示异常',
  `version` int(0) NULL DEFAULT 1 COMMENT '版本控制',
  `created_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_game_price_history_game`(`game_id`) USING BTREE,
  CONSTRAINT `fk_game_price_history_game` FOREIGN KEY (`game_id`) REFERENCES `game` (`game_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of game_price_history
-- ----------------------------
INSERT INTO `game_price_history` VALUES (1, 1, 200.00, 100.00, '2025-10-01 00:00:00', 29.99, '2020-11-01 00:00:00', 180.00, 39.99, '2021-11-25 00:00:00', 0, 1, '2025-09-29 00:00:00', '2025-10-23 20:07:22');
INSERT INTO `game_price_history` VALUES (2, 1, 200.00, 100.00, '2020-10-07 00:00:00', 39.99, '2021-05-01 00:00:00', 100.00, 44.99, '2022-02-01 00:00:00', 0, 1, '2025-09-30 00:00:00', '2025-10-23 20:05:32');
INSERT INTO `game_price_history` VALUES (3, 1, 200.00, 100.00, '2025-09-26 00:00:00', 0.00, '2020-06-01 00:00:00', 140.00, 0.00, NULL, 0, 1, '2025-10-01 00:00:00', '2025-10-23 20:07:16');
INSERT INTO `game_price_history` VALUES (4, 1, 200.00, 100.00, '2025-10-02 00:00:00', 29.99, '2021-01-10 00:00:00', 190.00, 34.99, '2021-11-26 00:00:00', 0, 1, '2025-10-02 00:00:00', '2025-10-23 20:07:10');
INSERT INTO `game_price_history` VALUES (5, 1, 200.00, 100.00, '2025-10-03 00:00:00', 14.99, '2019-06-01 00:00:00', 100.00, 19.99, '2020-12-20 00:00:00', 0, 1, '2025-10-03 00:00:00', '2025-10-23 20:05:53');
INSERT INTO `game_price_history` VALUES (6, 1, 200.00, 100.00, '2025-10-04 00:00:00', 9.99, '2019-12-01 00:00:00', 150.00, 14.99, '2020-04-02 00:00:00', 0, 1, '2025-10-04 00:00:00', '2025-10-23 20:07:05');
INSERT INTO `game_price_history` VALUES (7, 1, 200.00, 100.00, '2025-10-05 00:00:00', 7.99, '2018-12-01 00:00:00', 100.00, 9.99, '2019-08-01 00:00:00', 0, 1, '2025-10-05 00:00:00', '2025-10-23 20:06:17');
INSERT INTO `game_price_history` VALUES (8, 8, 0.00, 0.00, '2016-04-10 00:00:00', 0.00, '2017-04-10 00:00:00', 0.00, 0.00, NULL, 0, 1, '2016-04-10 00:00:00', '2017-04-10 00:00:00');
INSERT INTO `game_price_history` VALUES (9, 9, 0.00, 0.00, '2018-01-01 00:00:00', 0.00, '2018-03-01 00:00:00', 0.00, 0.00, NULL, 0, 1, '2018-03-01 00:00:00', '2019-03-01 00:00:00');
INSERT INTO `game_price_history` VALUES (10, 10, 29.99, 5.99, '2016-01-01 00:00:00', 7.99, '2016-07-01 00:00:00', 19.99, 14.99, '2017-07-01 00:00:00', 0, 1, '2015-07-22 00:00:00', '2016-07-22 00:00:00');
INSERT INTO `game_price_history` VALUES (11, 11, 4.99, 0.99, '2020-06-20 00:00:00', 1.99, '2020-07-01 00:00:00', 3.99, 2.99, '2020-06-20 00:00:00', 0, 1, '2020-06-15 00:00:00', '2021-06-15 00:00:00');
INSERT INTO `game_price_history` VALUES (12, 12, 26.95, 5.00, '2016-06-01 00:00:00', 9.99, '2017-03-01 00:00:00', 19.99, 14.99, '2017-11-11 00:00:00', 0, 1, '2016-05-17 00:00:00', '2017-05-17 00:00:00');
INSERT INTO `game_price_history` VALUES (13, 13, 34.99, 12.99, '2019-12-20 00:00:00', 19.99, '2020-06-01 00:00:00', 29.99, 24.99, '2020-12-24 00:00:00', 0, 1, '2019-12-13 00:00:00', '2020-12-13 00:00:00');
INSERT INTO `game_price_history` VALUES (14, 14, 59.99, 14.99, '2017-02-01 00:00:00', 24.99, '2017-08-01 00:00:00', 49.99, 39.99, '2018-01-24 00:00:00', 0, 1, '2017-01-24 00:00:00', '2018-01-24 00:00:00');
INSERT INTO `game_price_history` VALUES (15, 15, 0.00, 0.00, '2015-01-01 00:00:00', 0.00, '2015-06-01 00:00:00', 0.00, 0.00, NULL, 0, 1, '2015-11-23 00:00:00', '2016-11-23 00:00:00');
INSERT INTO `game_price_history` VALUES (16, 16, 29.99, 9.99, '2019-05-01 00:00:00', 12.99, '2019-11-01 00:00:00', 24.99, 19.99, '2020-05-21 00:00:00', 0, 1, '2019-05-21 00:00:00', '2020-05-21 00:00:00');
INSERT INTO `game_price_history` VALUES (17, 17, 49.99, 19.99, '2017-04-01 00:00:00', 24.99, '2018-02-01 00:00:00', 39.99, 34.99, '2018-06-02 00:00:00', 0, 1, '2017-06-02 00:00:00', '2018-06-02 00:00:00');
INSERT INTO `game_price_history` VALUES (18, 18, 19.99, 4.99, '2018-02-01 00:00:00', 7.99, '2018-08-01 00:00:00', 14.99, 9.99, '2019-02-15 00:00:00', 0, 1, '2018-02-15 00:00:00', '2019-02-15 00:00:00');
INSERT INTO `game_price_history` VALUES (19, 19, 59.99, 14.99, '2016-03-01 00:00:00', 29.99, '2016-09-01 00:00:00', 49.99, 39.99, '2017-04-12 00:00:00', 0, 1, '2016-04-12 00:00:00', '2017-04-12 00:00:00');
INSERT INTO `game_price_history` VALUES (20, 20, 59.99, 29.99, '2020-12-01 00:00:00', 39.99, '2021-07-01 00:00:00', 49.99, 44.99, '2021-07-10 00:00:00', 0, 1, '2020-12-10 00:00:00', '2021-12-10 00:00:00');

-- ----------------------------
-- Table structure for game_profile
-- ----------------------------
DROP TABLE IF EXISTS `game_profile`;
CREATE TABLE `game_profile`  (
  `game_profile_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '游戏详情ID',
  `game_id` int(0) NOT NULL COMMENT '游戏ID',
  `game_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '游戏名称',
  `game_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '游戏简介',
  `game_developer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '游戏开发商',
  `game_tag_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '游戏标签名称',
  `game_config` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '游戏配置',
  `series` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '游戏系列',
  `status` int(0) NULL DEFAULT 0 COMMENT '状态，0表示正常，1表示异常',
  `version` int(0) NULL DEFAULT 1 COMMENT '版本控制',
  `created_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`game_profile_id`) USING BTREE,
  INDEX `fk_game_profile_game`(`game_id`) USING BTREE,
  CONSTRAINT `fk_game_profile_game` FOREIGN KEY (`game_id`) REFERENCES `game` (`game_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of game_profile
-- ----------------------------
INSERT INTO `game_profile` VALUES (1, 1, 'Dragon Quest', '经典日式RPG游戏', 'Square Enix', 'RPG', 'Windows 10, 8GB RAM', 'DQ系列', 0, 1, '2020-01-01 10:00:00', '2021-01-01 10:00:00');
INSERT INTO `game_profile` VALUES (2, 2, 'Call of Duty', '热门FPS射击游戏', 'Activision', 'FPS', 'Windows 10, 16GB RAM', 'COD系列', 0, 1, '2021-11-11 15:00:00', '2022-06-01 11:00:00');
INSERT INTO `game_profile` VALUES (3, 3, 'League of Heroes', 'MOBA类竞技游戏', 'Riot Games', 'MOBA', 'Windows 10, 4GB RAM', '英雄联盟系列', 0, 1, '2019-09-20 09:00:00', '2020-02-10 12:00:00');
INSERT INTO `game_profile` VALUES (4, 4, 'FIFA 21', '足球体育类游戏', 'EA Sports', 'Sports', 'Windows 10, 8GB RAM', 'FIFA系列', 0, 1, '2020-09-25 08:30:00', '2021-09-25 08:30:00');
INSERT INTO `game_profile` VALUES (5, 5, 'Civilization VI', '策略模拟类游戏', '2K Games', 'Strategy', 'Windows 10, 6GB RAM', '文明系列', 0, 1, '2018-10-20 13:00:00', '2019-12-15 16:00:00');
INSERT INTO `game_profile` VALUES (6, 6, 'Tomb Raider', '冒险解谜类动作游戏', 'Crystal Dynamics', 'Adventure', 'Windows 10, 8GB RAM', '古墓丽影系列', 0, 1, '2019-03-15 14:00:00', '2020-05-01 10:30:00');
INSERT INTO `game_profile` VALUES (7, 7, 'Need for Speed', '赛车竞速类游戏', 'Electronic Arts', 'Racing', 'Windows 10, 4GB RAM', 'NFS系列', 0, 1, '2017-08-18 17:00:00', '2018-12-20 09:00:00');
INSERT INTO `game_profile` VALUES (8, 8, 'Candy Crush', '益智休闲类游戏', 'King', 'Puzzle', 'Android/iOS', 'Candy系列', 0, 1, '2016-04-10 12:00:00', '2017-04-10 12:00:00');
INSERT INTO `game_profile` VALUES (9, 9, 'Hearthstone', '卡牌对战类游戏', 'Blizzard', 'Card', 'Windows 10, 4GB RAM', '炉石传说', 0, 1, '2018-03-01 11:00:00', '2019-03-01 11:00:00');
INSERT INTO `game_profile` VALUES (10, 10, 'SimCity', '模拟经营类游戏', 'Maxis', 'Simulation', 'Windows 10, 8GB RAM', 'Sim系列', 0, 1, '2015-07-22 15:00:00', '2016-07-22 15:00:00');
INSERT INTO `game_profile` VALUES (11, 11, 'Among Us', '社交推理类游戏', 'Innersloth', 'Casual', 'Android/iOS', 'Among Us系列', 0, 1, '2020-06-15 20:00:00', '2021-06-15 20:00:00');
INSERT INTO `game_profile` VALUES (12, 12, 'Minecraft', '沙盒类开放世界', 'Mojang', 'Sandbox', 'Windows 10, 8GB RAM', 'Minecraft系列', 0, 1, '2016-05-17 10:00:00', '2017-05-17 10:00:00');
INSERT INTO `game_profile` VALUES (13, 13, 'Rust', '生存冒险类游戏', 'Facepunch Studios', 'Survival', 'Windows 10, 10GB RAM', 'Rust系列', 0, 1, '2019-12-13 08:00:00', '2020-12-13 08:00:00');
INSERT INTO `game_profile` VALUES (14, 14, 'Resident Evil 7', '恐怖冒险类游戏', 'Capcom', 'Horror', 'Windows 10, 8GB RAM', '生化危机系列', 0, 1, '2017-01-24 12:00:00', '2018-01-24 12:00:00');
INSERT INTO `game_profile` VALUES (15, 15, 'World of Warcraft', '大型多人在线MMO游戏', 'Blizzard', 'MMORPG', 'Windows 10, 4GB RAM', '魔兽世界', 0, 1, '2015-11-23 10:00:00', '2016-11-23 10:00:00');
INSERT INTO `game_profile` VALUES (16, 16, 'Beat Saber', '虚拟现实音乐游戏', 'Beat Games', 'VR', 'VR设备', 'Beat系列', 0, 1, '2019-05-21 12:00:00', '2020-05-21 12:00:00');
INSERT INTO `game_profile` VALUES (17, 17, 'Tekken 7', '格斗类对战游戏', 'Bandai Namco', 'Fighting', 'Windows 10, 6GB RAM', '铁拳系列', 0, 1, '2017-06-02 09:00:00', '2018-06-02 09:00:00');
INSERT INTO `game_profile` VALUES (18, 18, 'Catan', '桌游类策略游戏', 'KOSMOS', 'Board', '桌游', '卡坦岛系列', 0, 1, '2018-02-15 13:00:00', '2019-02-15 13:00:00');
INSERT INTO `game_profile` VALUES (19, 19, 'Dark Souls III', '高难度动作角色扮演游戏', 'FromSoftware', 'RPG', 'Windows 10, 12GB RAM', '黑暗之魂系列', 0, 1, '2016-04-12 12:00:00', '2017-04-12 12:00:00');
INSERT INTO `game_profile` VALUES (20, 20, 'Cyberpunk 2077', '科幻题材RPG游戏', 'CD Projekt', 'RPG', 'Windows 10, 16GB RAM', '赛博朋克系列', 0, 1, '2020-12-10 09:00:00', '2021-12-10 09:00:00');

-- ----------------------------
-- Table structure for game_tag
-- ----------------------------
DROP TABLE IF EXISTS `game_tag`;
CREATE TABLE `game_tag`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `game_id` int(0) NOT NULL COMMENT '游戏ID',
  `tag_id` int(0) NOT NULL COMMENT '标签ID',
  `status` int(0) NULL DEFAULT 0 COMMENT '状态，0表示正常，1表示异常',
  `version` int(0) NULL DEFAULT 1 COMMENT '版本控制',
  `created_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_game_tag_game`(`game_id`) USING BTREE,
  INDEX `fk_game_tag_tag`(`tag_id`) USING BTREE,
  CONSTRAINT `fk_game_tag_game` FOREIGN KEY (`game_id`) REFERENCES `game` (`game_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_game_tag_tag` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`tag_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of game_tag
-- ----------------------------
INSERT INTO `game_tag` VALUES (1, 1, 1, 0, 1, '2020-01-01 12:00:00', '2021-01-01 12:00:00');
INSERT INTO `game_tag` VALUES (2, 2, 2, 0, 1, '2021-11-11 12:00:00', '2022-01-01 12:00:00');
INSERT INTO `game_tag` VALUES (3, 3, 3, 0, 1, '2019-09-20 12:00:00', '2020-09-20 12:00:00');
INSERT INTO `game_tag` VALUES (4, 4, 4, 0, 1, '2020-09-25 12:00:00', '2021-09-25 12:00:00');
INSERT INTO `game_tag` VALUES (5, 5, 5, 0, 1, '2018-10-20 12:00:00', '2019-10-20 12:00:00');
INSERT INTO `game_tag` VALUES (6, 6, 6, 0, 1, '2019-03-15 12:00:00', '2020-03-15 12:00:00');
INSERT INTO `game_tag` VALUES (7, 7, 7, 0, 1, '2017-08-18 12:00:00', '2018-08-18 12:00:00');
INSERT INTO `game_tag` VALUES (8, 8, 8, 0, 1, '2016-04-10 12:00:00', '2017-04-10 12:00:00');
INSERT INTO `game_tag` VALUES (9, 9, 9, 0, 1, '2018-03-01 12:00:00', '2019-03-01 12:00:00');
INSERT INTO `game_tag` VALUES (10, 10, 10, 0, 1, '2015-07-22 12:00:00', '2016-07-22 12:00:00');
INSERT INTO `game_tag` VALUES (11, 11, 12, 0, 1, '2020-06-15 12:00:00', '2021-06-15 12:00:00');
INSERT INTO `game_tag` VALUES (12, 12, 13, 0, 1, '2016-05-17 12:00:00', '2017-05-17 12:00:00');
INSERT INTO `game_tag` VALUES (13, 13, 14, 0, 1, '2019-12-13 12:00:00', '2020-12-13 12:00:00');
INSERT INTO `game_tag` VALUES (14, 14, 15, 0, 1, '2017-01-24 12:00:00', '2018-01-24 12:00:00');
INSERT INTO `game_tag` VALUES (15, 15, 16, 0, 1, '2015-11-23 12:00:00', '2016-11-23 12:00:00');
INSERT INTO `game_tag` VALUES (16, 16, 17, 0, 1, '2019-05-21 12:00:00', '2020-05-21 12:00:00');
INSERT INTO `game_tag` VALUES (17, 17, 19, 0, 1, '2017-06-02 12:00:00', '2018-06-02 12:00:00');
INSERT INTO `game_tag` VALUES (18, 18, 20, 0, 1, '2018-02-15 12:00:00', '2019-02-15 12:00:00');
INSERT INTO `game_tag` VALUES (19, 19, 1, 0, 1, '2016-04-12 12:00:00', '2017-04-12 12:00:00');
INSERT INTO `game_tag` VALUES (20, 20, 1, 0, 1, '2020-12-10 12:00:00', '2021-12-10 12:00:00');

-- ----------------------------
-- Table structure for gift
-- ----------------------------
DROP TABLE IF EXISTS `gift`;
CREATE TABLE `gift`  (
  `gift_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '礼物ID',
  `game_id` int(0) NOT NULL COMMENT '游戏ID',
  `user1_id` int(0) NOT NULL COMMENT '赠送者ID',
  `user2_id` int(0) NOT NULL COMMENT '接收者ID',
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '寄语',
  `status` int(0) NULL DEFAULT 0 COMMENT '状态，0表示正常，1表示异常',
  `version` int(0) NULL DEFAULT 1 COMMENT '版本控制',
  `created_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`gift_id`) USING BTREE,
  INDEX `fk_gift_user1`(`user1_id`) USING BTREE,
  INDEX `fk_gift_user2`(`user2_id`) USING BTREE,
  INDEX `fk_gift_game`(`game_id`) USING BTREE,
  CONSTRAINT `fk_gift_game` FOREIGN KEY (`game_id`) REFERENCES `game` (`game_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_gift_user1` FOREIGN KEY (`user1_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_gift_user2` FOREIGN KEY (`user2_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gift
-- ----------------------------
INSERT INTO `gift` VALUES (1, 1, 2, 3, '生日快乐，送你龙战士！', 0, 1, '2021-01-01 10:00:00', '2021-01-01 10:00:00');
INSERT INTO `gift` VALUES (2, 2, 3, 4, '新年快乐，来把射击大作~', 0, 1, '2021-02-01 11:05:00', '2021-02-01 11:05:00');
INSERT INTO `gift` VALUES (3, 3, 4, 5, '恭喜升级，奖励一款MOBA', 0, 1, '2021-03-01 12:10:00', '2021-03-01 12:10:00');
INSERT INTO `gift` VALUES (4, 4, 5, 6, '假期快乐，送你足球游戏', 0, 1, '2021-04-01 13:15:00', '2021-04-01 13:15:00');
INSERT INTO `gift` VALUES (5, 5, 6, 7, '策略玩家福利，收下文明6', 0, 1, '2021-05-01 14:20:00', '2021-05-01 14:20:00');
INSERT INTO `gift` VALUES (6, 6, 7, 8, '冒险礼包，祝游戏愉快', 0, 1, '2021-06-01 15:25:00', '2021-06-01 15:25:00');
INSERT INTO `gift` VALUES (7, 7, 8, 9, '赛车党专属，车速带回家', 0, 1, '2021-07-01 16:30:00', '2021-07-01 16:30:00');
INSERT INTO `gift` VALUES (8, 8, 9, 10, '益智时间，送你关卡包', 0, 1, '2021-08-01 17:35:00', '2021-08-01 17:35:00');
INSERT INTO `gift` VALUES (9, 9, 10, 11, '卡牌新手包奉上', 0, 1, '2021-09-01 18:40:00', '2021-09-01 18:40:00');
INSERT INTO `gift` VALUES (10, 10, 11, 12, '模拟经营礼包，祝好运', 0, 1, '2021-10-01 19:45:00', '2021-10-01 19:45:00');
INSERT INTO `gift` VALUES (11, 11, 12, 13, '多人联机福利，收下AmongUs', 0, 1, '2021-11-01 20:50:00', '2021-11-01 20:50:00');
INSERT INTO `gift` VALUES (12, 12, 13, 14, '沙盒创意包，期待你的作品', 0, 1, '2021-12-01 21:55:00', '2021-12-01 21:55:00');
INSERT INTO `gift` VALUES (13, 13, 14, 15, '生存大礼包，祝你坚持到天亮', 0, 1, '2022-01-01 22:00:00', '2022-01-01 22:00:00');
INSERT INTO `gift` VALUES (14, 14, 15, 16, '恐怖体验赠送，胆小勿入', 0, 1, '2022-02-01 23:05:00', '2022-02-01 23:05:00');
INSERT INTO `gift` VALUES (15, 15, 16, 17, '怀旧大作，回忆满满', 0, 1, '2022-03-01 09:10:00', '2022-03-01 09:10:00');
INSERT INTO `gift` VALUES (16, 16, 17, 18, 'VR 体验卡，带上头显', 0, 1, '2022-04-01 10:15:00', '2022-04-01 10:15:00');
INSERT INTO `gift` VALUES (17, 17, 18, 19, '格斗高手包，练起来', 0, 1, '2022-05-01 11:20:00', '2022-05-01 11:20:00');
INSERT INTO `gift` VALUES (18, 18, 19, 20, '桌游数字版，约起来', 0, 1, '2022-06-01 12:25:00', '2022-06-01 12:25:00');
INSERT INTO `gift` VALUES (19, 19, 20, 1, '高难挑战包，祝你好运', 0, 1, '2022-07-01 13:30:00', '2022-07-01 13:30:00');
INSERT INTO `gift` VALUES (20, 20, 1, 2, '赛博主题礼包，欢迎体验', 0, 1, '2022-08-01 14:35:00', '2022-08-01 14:35:00');

-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message`  (
  `message_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '消息ID',
  `sender_id` int(0) NOT NULL COMMENT '发件人ID',
  `receiver_id` int(0) NOT NULL COMMENT '收件人ID',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '消息内容',
  `sent_time` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发送时间',
  `status` int(0) NULL DEFAULT 0 COMMENT '状态，0表示正常，1表示异常',
  `version` int(0) NULL DEFAULT 1 COMMENT '版本控制',
  `created_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`message_id`) USING BTREE,
  INDEX `fk_message_sender`(`sender_id`) USING BTREE,
  INDEX `fk_message_receiver`(`receiver_id`) USING BTREE,
  CONSTRAINT `fk_message_receiver` FOREIGN KEY (`receiver_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_message_sender` FOREIGN KEY (`sender_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of message
-- ----------------------------
INSERT INTO `message` VALUES (1, 1, 2, '你好，这是第一条测试消息。', '2021-01-01 09:00:00', 0, 1, '2021-01-01 09:00:00', '2021-01-01 09:00:00');
INSERT INTO `message` VALUES (2, 2, 1, '好的，我收到了你的消息。', '2021-01-01 09:05:00', 0, 1, '2021-01-01 09:05:00', '2021-01-01 09:05:00');
INSERT INTO `message` VALUES (3, 3, 4, '明天有空一起打游戏吗？', '2021-02-01 10:10:00', 0, 1, '2021-02-01 10:10:00', '2021-02-01 10:10:00');
INSERT INTO `message` VALUES (4, 4, 3, '可以啊，我正好有时间。', '2021-02-01 10:15:00', 0, 1, '2021-02-01 10:15:00', '2021-02-01 10:15:00');
INSERT INTO `message` VALUES (5, 5, 6, '请问你对这款游戏有兴趣吗？', '2021-03-01 11:20:00', 0, 1, '2021-03-01 11:20:00', '2021-03-01 11:20:00');
INSERT INTO `message` VALUES (6, 6, 5, '嗯，我看过介绍了，感觉挺不错。', '2021-03-01 11:25:00', 0, 1, '2021-03-01 11:25:00', '2021-03-01 11:25:00');
INSERT INTO `message` VALUES (7, 7, 8, '周末有空吗？咱们约一下比赛。', '2021-04-01 12:30:00', 0, 1, '2021-04-01 12:30:00', '2021-04-01 12:30:00');
INSERT INTO `message` VALUES (8, 8, 7, '好啊，到时候记得提醒我。', '2021-04-01 12:35:00', 0, 1, '2021-04-01 12:35:00', '2021-04-01 12:35:00');
INSERT INTO `message` VALUES (9, 9, 10, '你的账号安全提醒，请尽快修改密码。', '2021-05-01 13:40:00', 0, 1, '2021-05-01 13:40:00', '2021-05-01 13:40:00');
INSERT INTO `message` VALUES (10, 10, 9, '好的，我这就去修改，谢谢提醒。', '2021-05-01 13:45:00', 0, 1, '2021-05-01 13:45:00', '2021-05-01 13:45:00');

-- ----------------------------
-- Table structure for myorder
-- ----------------------------
DROP TABLE IF EXISTS `myorder`;
CREATE TABLE `myorder`  (
  `order_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '订单ID',
  `user_id` int(0) NOT NULL COMMENT '用户ID',
  `cart_id` int(0) NULL DEFAULT NULL COMMENT '购物车ID',
  `order_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '订单编号',
  `original_price` decimal(10, 2) NOT NULL COMMENT '订单原始价格',
  `final_price` decimal(10, 2) NOT NULL COMMENT '订单最终价格',
  `order_date` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '订单日期',
  `order_status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'unpaid' COMMENT '订单状态',
  `status` int(0) NULL DEFAULT 0 COMMENT '状态，0表示正常，1表示异常',
  `version` int(0) NULL DEFAULT 1 COMMENT '版本控制',
  `created_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`order_id`) USING BTREE,
  INDEX `fk_myorder_user`(`user_id`) USING BTREE,
  INDEX `fk_myorder_cart`(`cart_id`) USING BTREE,
  CONSTRAINT `fk_myorder_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 34 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of myorder
-- ----------------------------
INSERT INTO `myorder` VALUES (21, 1, 20, 'ORDER-1ff40d0d-d0fe-4c72-9d30-0d70df1f1036', 59.99, 59.99, '2025-10-22 00:48:37', 'unpaid', 0, 1, '2025-10-22 00:48:37', '2025-10-22 00:48:37');
INSERT INTO `myorder` VALUES (22, 1, NULL, 'ORDER53a4c581-9477-4516-9fb0-a141ca6caae5', 235.97, 202.97, '2025-11-02 13:39:40', 'cancelled', 0, 1, '2025-11-02 13:39:40', '2025-11-02 13:54:40');
INSERT INTO `myorder` VALUES (23, 1, NULL, 'ORDER6827ca69-9989-4b3a-aaa0-c466861f5ae0', 59.99, 59.99, '2025-11-03 13:06:07', 'cancelled', 0, 1, '2025-11-03 13:06:07', '2025-11-03 13:21:07');
INSERT INTO `myorder` VALUES (24, 1, NULL, 'ORDERf728afbe-ebd8-46db-abb9-a59c7995d6ec', 129.98, 108.98, '2025-11-04 13:30:53', 'cancelled', 0, 1, '2025-11-04 13:30:53', '2025-11-04 13:45:53');
INSERT INTO `myorder` VALUES (25, 1, NULL, 'ORDER076a053a-1b22-42da-a02f-47527eff1197', 129.98, 108.98, '2025-11-04 15:35:07', 'paid', 0, 1, '2025-11-04 15:35:07', '2025-11-04 15:35:58');
INSERT INTO `myorder` VALUES (26, 1, NULL, 'ORDER792daf68-8a35-4ffd-a1d0-c79a2d47172b', 129.98, 108.98, '2025-11-06 10:20:43', 'cancelled', 0, 1, '2025-11-06 10:20:43', '2025-11-06 10:35:43');
INSERT INTO `myorder` VALUES (27, 1, NULL, 'ORDERa86cab2d-7513-4e26-8e59-565885899037', 129.98, 108.98, '2025-11-06 10:54:54', 'cancelled', 0, 1, '2025-11-06 10:54:54', '2025-11-06 11:09:55');
INSERT INTO `myorder` VALUES (28, 1, NULL, 'ORDERfb345eb2-92d2-425c-89c4-fa5665b3a76d', 129.98, 108.98, '2025-11-06 10:58:57', 'cancelled', 0, 1, '2025-11-06 10:58:57', '2025-11-06 11:13:57');
INSERT INTO `myorder` VALUES (29, 1, NULL, 'ORDER990a9131-4618-48c2-a35f-10d3ae848522', 129.98, 108.98, '2025-11-06 11:02:00', 'cancelled', 0, 1, '2025-11-06 11:02:00', '2025-11-06 11:17:00');
INSERT INTO `myorder` VALUES (30, 1, NULL, 'ORDERebacca39-b72f-4f8c-a4e9-44f1752a96a3', 129.98, 108.98, '2025-11-06 11:10:33', 'cancelled', 0, 1, '2025-11-06 11:10:33', '2025-11-06 11:25:33');
INSERT INTO `myorder` VALUES (31, 1, NULL, 'ORDERc6532e60-d822-4eea-904b-275738a02feb', 129.98, 108.98, '2025-11-06 19:24:38', 'paid', 0, 1, '2025-11-06 19:24:38', '2025-11-06 19:26:13');
INSERT INTO `myorder` VALUES (32, 1, NULL, 'ORDERb66143c2-cc01-4917-852d-aefe1fec8c4a', 129.98, 108.98, '2025-11-06 21:13:39', 'cancelled', 0, 1, '2025-11-06 21:13:39', '2025-11-06 21:28:39');
INSERT INTO `myorder` VALUES (33, 2, NULL, 'ORDERe2cde23b-3539-4b8a-8d2e-b8d5ef67a1ce', 129.98, 129.98, '2025-11-06 21:50:19', 'paid', 0, 1, '2025-11-06 21:50:19', '2025-11-06 21:51:42');
INSERT INTO `myorder` VALUES (34, 2, NULL, 'ORDER6614054c-dac2-49d1-b506-167994c3a9f6', 109.98, 109.98, '2025-11-06 22:52:53', 'paid', 0, 1, '2025-11-06 22:52:53', '2025-11-06 22:56:54');
INSERT INTO `myorder` VALUES (35, 1, NULL, 'ORDER5cacbaac-ae5f-4d8a-8a0d-219527075c82', 119.98, 119.98, '2025-11-07 18:51:40', 'cancelled', 0, 1, '2025-11-07 18:51:40', '2025-11-07 18:52:22');
INSERT INTO `myorder` VALUES (36, 1, NULL, 'ORDER228d6174-85fa-447c-82bb-07b4de1bd642', 99.98, 99.98, '2025-11-07 18:52:49', 'cancelled', 0, 1, '2025-11-07 18:52:49', '2025-11-07 18:55:37');
INSERT INTO `myorder` VALUES (37, 1, NULL, 'ORDER4e78ee99-99fd-4c38-a09e-ea2700a95cf1', 129.98, 129.98, '2025-11-07 18:55:59', 'paid', 0, 1, '2025-11-07 18:55:59', '2025-11-07 18:57:36');
INSERT INTO `myorder` VALUES (38, 1, NULL, 'ORDER86518675-692b-4aef-81ab-1dec12dc51fe', 69.99, 69.99, '2025-11-07 19:09:05', 'paid', 0, 1, '2025-11-07 19:09:05', '2025-11-07 19:12:25');

-- ----------------------------
-- Table structure for order_details
-- ----------------------------
DROP TABLE IF EXISTS `order_details`;
CREATE TABLE `order_details`  (
  `detail_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '订单详情ID',
  `order_id` int(0) NOT NULL COMMENT '订单ID',
  `user_id` int(0) NOT NULL COMMENT '用户ID',
  `game_id` int(0) NOT NULL COMMENT '游戏ID',
  `discount_id` int(0) NULL DEFAULT NULL COMMENT '优惠ID',
  `status` int(0) NULL DEFAULT 0 COMMENT '状态，0表示正常，1表示异常',
  `version` int(0) NULL DEFAULT 1 COMMENT '版本控制',
  `created_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`detail_id`) USING BTREE,
  INDEX `fk_order_details_order`(`order_id`) USING BTREE,
  INDEX `fk_order_details_user`(`user_id`) USING BTREE,
  INDEX `fk_order_details_game`(`game_id`) USING BTREE,
  CONSTRAINT `fk_order_details_game` FOREIGN KEY (`game_id`) REFERENCES `game` (`game_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_order_details_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 49 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_details
-- ----------------------------
INSERT INTO `order_details` VALUES (1, 1, 1, 1, 1, 0, 1, '2021-01-01 10:05:00', '2021-01-01 10:05:00');
INSERT INTO `order_details` VALUES (2, 2, 1, 2, 2, 0, 1, '2021-02-01 11:05:00', '2025-10-30 20:15:25');
INSERT INTO `order_details` VALUES (3, 3, 1, 3, 3, 0, 1, '2021-03-01 12:05:00', '2025-10-30 20:15:31');
INSERT INTO `order_details` VALUES (4, 4, 4, 4, 4, 0, 1, '2021-04-01 13:05:00', '2021-04-01 13:05:00');
INSERT INTO `order_details` VALUES (5, 5, 5, 5, 5, 0, 1, '2021-05-01 14:05:00', '2021-05-01 14:05:00');
INSERT INTO `order_details` VALUES (6, 6, 6, 6, 6, 0, 1, '2021-06-01 15:05:00', '2021-06-01 15:05:00');
INSERT INTO `order_details` VALUES (7, 7, 7, 7, 7, 0, 1, '2021-07-01 16:05:00', '2021-07-01 16:05:00');
INSERT INTO `order_details` VALUES (8, 8, 8, 8, 8, 0, 1, '2021-08-01 17:05:00', '2021-08-01 17:05:00');
INSERT INTO `order_details` VALUES (9, 9, 9, 9, 9, 0, 1, '2021-09-01 18:05:00', '2021-09-01 18:05:00');
INSERT INTO `order_details` VALUES (10, 10, 10, 10, 10, 0, 1, '2021-10-01 19:05:00', '2021-10-01 19:05:00');
INSERT INTO `order_details` VALUES (11, 11, 11, 11, 11, 0, 1, '2021-11-01 20:05:00', '2021-11-01 20:05:00');
INSERT INTO `order_details` VALUES (12, 12, 12, 12, 12, 0, 1, '2021-12-01 21:05:00', '2021-12-01 21:05:00');
INSERT INTO `order_details` VALUES (13, 13, 13, 13, 13, 0, 1, '2022-01-01 22:05:00', '2022-01-01 22:05:00');
INSERT INTO `order_details` VALUES (14, 14, 14, 14, 14, 0, 1, '2022-02-01 23:05:00', '2022-02-01 23:05:00');
INSERT INTO `order_details` VALUES (15, 15, 15, 15, 15, 0, 1, '2022-03-01 09:05:00', '2022-03-01 09:05:00');
INSERT INTO `order_details` VALUES (16, 16, 16, 16, 16, 0, 1, '2022-04-01 10:05:00', '2022-04-01 10:05:00');
INSERT INTO `order_details` VALUES (17, 17, 17, 17, 17, 0, 1, '2022-05-01 11:05:00', '2022-05-01 11:05:00');
INSERT INTO `order_details` VALUES (18, 18, 18, 18, 18, 0, 1, '2022-06-01 12:05:00', '2022-06-01 12:05:00');
INSERT INTO `order_details` VALUES (19, 19, 19, 19, 19, 0, 1, '2022-07-01 13:05:00', '2022-07-01 13:05:00');
INSERT INTO `order_details` VALUES (20, 20, 20, 20, 20, 0, 1, '2022-08-01 14:05:00', '2022-08-01 14:05:00');
INSERT INTO `order_details` VALUES (21, 21, 1, 20, NULL, 0, 1, '2025-10-22 00:48:37', '2025-10-22 00:48:37');
INSERT INTO `order_details` VALUES (22, 22, 1, 1, 1, 0, 1, '2025-11-02 13:39:40', '2025-11-02 13:39:40');
INSERT INTO `order_details` VALUES (23, 22, 1, 2, 2, 0, 1, '2025-11-02 13:39:40', '2025-11-02 13:39:40');
INSERT INTO `order_details` VALUES (24, 22, 1, 3, 1, 0, 1, '2025-11-02 13:39:40', '2025-11-02 13:39:40');
INSERT INTO `order_details` VALUES (25, 22, 1, 20, 20, 0, 1, '2025-11-02 13:39:40', '2025-11-02 13:39:40');
INSERT INTO `order_details` VALUES (26, 22, 1, 10, 1, 0, 1, '2025-11-02 13:39:40', '2025-11-02 13:39:40');
INSERT INTO `order_details` VALUES (27, 23, 1, 1, 1, 0, 1, '2025-11-03 13:06:07', '2025-11-03 13:06:06');
INSERT INTO `order_details` VALUES (28, 24, 1, 1, 1, 0, 1, '2025-11-04 13:30:53', '2025-11-04 13:30:52');
INSERT INTO `order_details` VALUES (29, 24, 1, 2, 2, 0, 1, '2025-11-04 13:30:53', '2025-11-04 13:30:52');
INSERT INTO `order_details` VALUES (30, 25, 1, 1, 1, 0, 1, '2025-11-04 15:35:07', '2025-11-04 15:35:07');
INSERT INTO `order_details` VALUES (31, 25, 1, 2, 2, 0, 1, '2025-11-04 15:35:07', '2025-11-04 15:35:07');
INSERT INTO `order_details` VALUES (32, 26, 1, 1, 1, 0, 1, '2025-11-06 10:20:43', '2025-11-06 10:20:43');
INSERT INTO `order_details` VALUES (33, 26, 1, 2, 2, 0, 1, '2025-11-06 10:20:43', '2025-11-06 10:20:43');
INSERT INTO `order_details` VALUES (34, 27, 1, 1, 1, 0, 1, '2025-11-06 10:54:54', '2025-11-06 10:54:54');
INSERT INTO `order_details` VALUES (35, 27, 1, 2, 2, 0, 1, '2025-11-06 10:54:54', '2025-11-06 10:54:54');
INSERT INTO `order_details` VALUES (36, 28, 1, 1, 1, 0, 1, '2025-11-06 10:58:57', '2025-11-06 10:58:56');
INSERT INTO `order_details` VALUES (37, 28, 1, 2, 2, 0, 1, '2025-11-06 10:58:57', '2025-11-06 10:58:56');
INSERT INTO `order_details` VALUES (38, 29, 1, 1, 1, 0, 1, '2025-11-06 11:02:00', '2025-11-06 11:02:00');
INSERT INTO `order_details` VALUES (39, 29, 1, 2, 2, 0, 1, '2025-11-06 11:02:00', '2025-11-06 11:02:00');
INSERT INTO `order_details` VALUES (40, 30, 1, 1, 1, 0, 1, '2025-11-06 11:10:33', '2025-11-06 11:10:33');
INSERT INTO `order_details` VALUES (41, 30, 1, 2, 2, 0, 1, '2025-11-06 11:10:33', '2025-11-06 11:10:33');
INSERT INTO `order_details` VALUES (42, 31, 1, 1, 1, 0, 1, '2025-11-06 19:24:38', '2025-11-06 19:24:37');
INSERT INTO `order_details` VALUES (43, 31, 1, 2, 2, 0, 1, '2025-11-06 19:24:38', '2025-11-06 19:24:37');
INSERT INTO `order_details` VALUES (44, 32, 1, 1, 1, 0, 1, '2025-11-06 21:13:39', '2025-11-06 21:13:38');
INSERT INTO `order_details` VALUES (45, 32, 1, 2, 2, 0, 1, '2025-11-06 21:13:39', '2025-11-06 21:13:38');
INSERT INTO `order_details` VALUES (46, 33, 2, 1, 1, 0, 1, '2025-11-06 21:50:19', '2025-11-06 21:50:18');
INSERT INTO `order_details` VALUES (47, 33, 2, 2, 1, 0, 1, '2025-11-06 21:50:19', '2025-11-06 21:50:18');
INSERT INTO `order_details` VALUES (48, 34, 2, 4, 1, 0, 1, '2025-11-06 22:52:53', '2025-11-06 22:52:52');
INSERT INTO `order_details` VALUES (49, 34, 2, 1, 1, 0, 1, '2025-11-06 22:52:53', '2025-11-06 22:52:52');
INSERT INTO `order_details` VALUES (50, 35, 1, 2, 1, 0, 1, '2025-11-07 18:51:40', '2025-11-07 18:51:39');
INSERT INTO `order_details` VALUES (51, 35, 1, 4, 1, 0, 1, '2025-11-07 18:51:40', '2025-11-07 18:51:39');
INSERT INTO `order_details` VALUES (52, 36, 1, 1, 1, 0, 1, '2025-11-07 18:52:49', '2025-11-07 18:52:49');
INSERT INTO `order_details` VALUES (53, 36, 1, 5, 1, 0, 1, '2025-11-07 18:52:49', '2025-11-07 18:52:49');
INSERT INTO `order_details` VALUES (54, 37, 1, 1, 1, 0, 1, '2025-11-07 18:55:59', '2025-11-07 18:55:59');
INSERT INTO `order_details` VALUES (55, 37, 1, 2, 1, 0, 1, '2025-11-07 18:55:59', '2025-11-07 18:55:59');
INSERT INTO `order_details` VALUES (56, 38, 1, 2, 1, 0, 1, '2025-11-07 19:09:05', '2025-11-07 19:09:05');

-- ----------------------------
-- Table structure for order_history
-- ----------------------------
DROP TABLE IF EXISTS `order_history`;
CREATE TABLE `order_history`  (
  `order_history_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '历史订单id',
  `order_id` int(0) NOT NULL DEFAULT 0 COMMENT '订单ID',
  `user_id` int(0) NOT NULL COMMENT '用户ID',
  `cart_id` int(0) NULL DEFAULT NULL COMMENT '购物车ID',
  `order_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '订单编号',
  `original_price` decimal(10, 2) NOT NULL COMMENT '订单原始价格',
  `final_price` decimal(10, 2) NOT NULL COMMENT '订单最终价格',
  `order_date` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '订单日期',
  `order_status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'unpaid' COMMENT '订单状态',
  `status` int(0) NULL DEFAULT 0 COMMENT '状态，0表示正常，1表示异常',
  `version` int(0) NULL DEFAULT 1 COMMENT '版本控制',
  `created_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `add_time` datetime(0) NULL DEFAULT NULL COMMENT '迁移的时间',
  PRIMARY KEY (`order_history_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 60 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_history
-- ----------------------------
INSERT INTO `order_history` VALUES (41, 1, 1, 1, 'ORD20210101', 59.99, 59.99, '2021-01-01 10:00:00', 'paid', 0, 1, '2021-01-01 10:00:00', '2025-10-31 15:16:12', '2025-10-31 18:33:00');
INSERT INTO `order_history` VALUES (42, 2, 1, 2, 'ORD20210101', 69.99, 48.99, '2021-02-01 11:00:00', 'paid', 0, 1, '2021-02-01 11:00:00', '2025-10-30 20:06:40', '2025-10-31 18:33:00');
INSERT INTO `order_history` VALUES (43, 3, 1, 3, 'ORD20210101', 39.99, 33.99, '2021-03-01 12:00:00', 'paid', 0, 1, '2021-03-01 12:00:00', '2025-10-31 15:18:37', '2025-10-31 18:33:00');
INSERT INTO `order_history` VALUES (44, 4, 4, 4, 'ORD20210401', 49.99, 44.99, '2021-04-01 13:00:00', 'paid', 0, 1, '2021-04-01 13:00:00', '2021-04-01 13:00:00', '2025-10-31 18:33:00');
INSERT INTO `order_history` VALUES (45, 5, 5, 5, 'ORD20210501', 29.99, 24.99, '2021-05-01 14:00:00', 'paid', 0, 1, '2021-05-01 14:00:00', '2021-05-01 14:00:00', '2025-10-31 18:33:00');
INSERT INTO `order_history` VALUES (46, 6, 6, 6, 'ORD20210601', 19.99, 14.99, '2021-06-01 15:00:00', 'paid', 0, 1, '2021-06-01 15:00:00', '2021-06-01 15:00:00', '2025-10-31 18:33:00');
INSERT INTO `order_history` VALUES (47, 7, 7, 7, 'ORD20210701', 89.99, 69.99, '2021-07-01 16:00:00', 'unpaid', 0, 1, '2021-07-01 16:00:00', '2021-07-01 16:00:00', '2025-10-31 18:33:00');
INSERT INTO `order_history` VALUES (48, 8, 8, 8, 'ORD20210801', 79.99, 59.99, '2021-08-01 17:00:00', 'paid', 0, 1, '2021-08-01 17:00:00', '2021-08-01 17:00:00', '2025-10-31 18:33:00');
INSERT INTO `order_history` VALUES (49, 9, 9, 9, 'ORD20210901', 45.99, 40.99, '2021-09-01 18:00:00', 'paid', 0, 1, '2021-09-01 18:00:00', '2021-09-01 18:00:00', '2025-10-31 18:33:00');
INSERT INTO `order_history` VALUES (50, 10, 10, 10, 'ORD20211001', 55.99, 50.99, '2021-10-01 19:00:00', 'paid', 0, 1, '2021-10-01 19:00:00', '2021-10-01 19:00:00', '2025-10-31 18:33:00');
INSERT INTO `order_history` VALUES (51, 11, 11, 11, 'ORD20211101', 25.99, 20.99, '2021-11-01 20:00:00', 'unpaid', 0, 1, '2021-11-01 20:00:00', '2021-11-01 20:00:00', '2025-10-31 18:33:00');
INSERT INTO `order_history` VALUES (52, 12, 12, 12, 'ORD20211201', 35.99, 30.99, '2021-12-01 21:00:00', 'paid', 0, 1, '2021-12-01 21:00:00', '2021-12-01 21:00:00', '2025-10-31 18:33:00');
INSERT INTO `order_history` VALUES (53, 13, 13, 13, 'ORD20220101', 60.99, 55.99, '2022-01-01 22:00:00', 'paid', 0, 1, '2022-01-01 22:00:00', '2022-01-01 22:00:00', '2025-10-31 18:33:00');
INSERT INTO `order_history` VALUES (54, 14, 14, 14, 'ORD20220201', 70.99, 65.99, '2022-02-01 23:00:00', 'paid', 0, 1, '2022-02-01 23:00:00', '2022-02-01 23:00:00', '2025-10-31 18:33:00');
INSERT INTO `order_history` VALUES (55, 15, 15, 15, 'ORD20220301', 40.99, 35.99, '2022-03-01 09:00:00', 'unpaid', 0, 1, '2022-03-01 09:00:00', '2022-03-01 09:00:00', '2025-10-31 18:33:00');
INSERT INTO `order_history` VALUES (56, 16, 16, 16, 'ORD20220401', 50.99, 45.99, '2022-04-01 10:00:00', 'paid', 0, 1, '2022-04-01 10:00:00', '2022-04-01 10:00:00', '2025-10-31 18:33:00');
INSERT INTO `order_history` VALUES (57, 17, 17, 17, 'ORD20220501', 30.99, 25.99, '2022-05-01 11:00:00', 'paid', 0, 1, '2022-05-01 11:00:00', '2022-05-01 11:00:00', '2025-10-31 18:33:00');
INSERT INTO `order_history` VALUES (58, 18, 18, 18, 'ORD20220601', 20.99, 15.99, '2022-06-01 12:00:00', 'paid', 0, 1, '2022-06-01 12:00:00', '2022-06-01 12:00:00', '2025-10-31 18:33:00');
INSERT INTO `order_history` VALUES (59, 19, 19, 19, 'ORD20220701', 90.99, 85.99, '2022-07-01 13:00:00', 'unpaid', 0, 1, '2022-07-01 13:00:00', '2022-07-01 13:00:00', '2025-10-31 18:33:00');
INSERT INTO `order_history` VALUES (60, 20, 20, 20, 'ORD20220801', 59.99, 49.99, '2022-08-01 14:00:00', 'paid', 0, 1, '2022-08-01 14:00:00', '2022-08-01 14:00:00', '2025-10-31 18:33:00');

-- ----------------------------
-- Table structure for payment_records
-- ----------------------------
DROP TABLE IF EXISTS `payment_records`;
CREATE TABLE `payment_records`  (
  `payment_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '支付ID',
  `payer_id` int(0) NOT NULL COMMENT '支付者ID',
  `order_id` int(0) NOT NULL COMMENT '订单ID',
  `transaction_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '交易编号',
  `transaction_amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '交易金额',
  `payment_time` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '支付时间',
  `status` int(0) NULL DEFAULT 0 COMMENT '支付状态，0表示正常，1表示异常',
  `version` int(0) NULL DEFAULT 1 COMMENT '版本控制',
  `created_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`payment_id`) USING BTREE,
  INDEX `fk_payment_records_payer`(`payer_id`) USING BTREE,
  INDEX `fk_payment_records_order`(`order_id`) USING BTREE,
  CONSTRAINT `fk_payment_records_payer` FOREIGN KEY (`payer_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of payment_records
-- ----------------------------
INSERT INTO `payment_records` VALUES (1, 1, 1, 'TXN20210101A1', 47.99, '2021-01-01 10:10:00', 0, 1, '2021-01-01 10:10:00', '2021-01-01 10:10:00');
INSERT INTO `payment_records` VALUES (2, 2, 2, 'TXN20210201B2', 48.99, '2021-02-01 11:10:00', 0, 1, '2021-02-01 11:10:00', '2021-02-01 11:10:00');
INSERT INTO `payment_records` VALUES (3, 3, 3, 'TXN20210301C3', 33.99, '2021-03-01 12:10:00', 0, 1, '2021-03-01 12:10:00', '2021-03-01 12:10:00');
INSERT INTO `payment_records` VALUES (4, 4, 4, 'TXN20210401D4', 44.99, '2021-04-01 13:10:00', 0, 1, '2021-04-01 13:10:00', '2021-04-01 13:10:00');
INSERT INTO `payment_records` VALUES (5, 5, 5, 'TXN20210501E5', 24.99, '2021-05-01 14:10:00', 0, 1, '2021-05-01 14:10:00', '2021-05-01 14:10:00');
INSERT INTO `payment_records` VALUES (6, 6, 6, 'TXN20210601F6', 14.99, '2021-06-01 15:10:00', 0, 1, '2021-06-01 15:10:00', '2021-06-01 15:10:00');
INSERT INTO `payment_records` VALUES (7, 7, 7, 'TXN20210701G7', 69.99, '2021-07-01 16:10:00', 0, 1, '2021-07-01 16:10:00', '2021-07-01 16:10:00');
INSERT INTO `payment_records` VALUES (8, 8, 8, 'TXN20210801H8', 59.99, '2021-08-01 17:10:00', 0, 1, '2021-08-01 17:10:00', '2021-08-01 17:10:00');
INSERT INTO `payment_records` VALUES (9, 9, 9, 'TXN20210901I9', 40.99, '2021-09-01 18:10:00', 0, 1, '2021-09-01 18:10:00', '2021-09-01 18:10:00');
INSERT INTO `payment_records` VALUES (10, 10, 10, 'TXN20211001J10', 50.99, '2021-10-01 19:10:00', 0, 1, '2021-10-01 19:10:00', '2021-10-01 19:10:00');
INSERT INTO `payment_records` VALUES (11, 11, 11, 'TXN20211101K11', 20.99, '2021-11-01 20:10:00', 0, 1, '2021-11-01 20:10:00', '2021-11-01 20:10:00');
INSERT INTO `payment_records` VALUES (12, 12, 12, 'TXN20211201L12', 30.99, '2021-12-01 21:10:00', 0, 1, '2021-12-01 21:10:00', '2021-12-01 21:10:00');
INSERT INTO `payment_records` VALUES (13, 13, 13, 'TXN20220101M13', 55.99, '2022-01-01 22:10:00', 0, 1, '2022-01-01 22:10:00', '2022-01-01 22:10:00');
INSERT INTO `payment_records` VALUES (14, 14, 14, 'TXN20220201N14', 65.99, '2022-02-01 23:10:00', 0, 1, '2022-02-01 23:10:00', '2022-02-01 23:10:00');
INSERT INTO `payment_records` VALUES (15, 15, 15, 'TXN20220301O15', 35.99, '2022-03-01 09:10:00', 0, 1, '2022-03-01 09:10:00', '2022-03-01 09:10:00');
INSERT INTO `payment_records` VALUES (16, 16, 16, 'TXN20220401P16', 45.99, '2022-04-01 10:10:00', 0, 1, '2022-04-01 10:10:00', '2022-04-01 10:10:00');
INSERT INTO `payment_records` VALUES (17, 17, 17, 'TXN20220501Q17', 25.99, '2022-05-01 11:10:00', 0, 1, '2022-05-01 11:10:00', '2022-05-01 11:10:00');
INSERT INTO `payment_records` VALUES (18, 18, 18, 'TXN20220601R18', 15.99, '2022-06-01 12:10:00', 0, 1, '2022-06-01 12:10:00', '2022-06-01 12:10:00');
INSERT INTO `payment_records` VALUES (19, 19, 19, 'TXN20220701S19', 85.99, '2022-07-01 13:10:00', 0, 1, '2022-07-01 13:10:00', '2022-07-01 13:10:00');
INSERT INTO `payment_records` VALUES (20, 20, 20, 'TXN20220801T20', 49.99, '2022-08-01 14:10:00', 0, 1, '2022-08-01 14:10:00', '2022-08-01 14:10:00');
INSERT INTO `payment_records` VALUES (21, 1, 25, 'TNXb992ba790270404d8bb270b79033c824', 108.98, '2025-11-04 15:35:58', 0, 0, '2025-11-04 15:35:58', '2025-11-04 15:35:57');
INSERT INTO `payment_records` VALUES (23, 1, 31, '2025110622001405180507487428', 108.98, '2025-11-06 19:26:13', 0, 0, '2025-11-06 19:26:13', '2025-11-06 19:26:12');
INSERT INTO `payment_records` VALUES (24, 2, 33, '2025110622001405180507488694', 129.98, '2025-11-06 21:51:42', 0, 0, '2025-11-06 21:51:42', '2025-11-06 21:51:42');
INSERT INTO `payment_records` VALUES (25, 2, 34, '2025110622001405180507489806', 109.98, '2025-11-06 22:56:54', 0, 0, '2025-11-06 22:56:54', '2025-11-06 22:56:53');
INSERT INTO `payment_records` VALUES (26, 1, 37, '2025110722001405180507493527', 129.98, '2025-11-07 18:57:36', 0, 0, '2025-11-07 18:57:36', '2025-11-07 18:57:35');
INSERT INTO `payment_records` VALUES (27, 1, 38, '2025110722001405180507492362', 69.99, '2025-11-07 19:12:25', 0, 0, '2025-11-07 19:12:25', '2025-11-07 19:12:24');

-- ----------------------------
-- Table structure for post
-- ----------------------------
DROP TABLE IF EXISTS `post`;
CREATE TABLE `post`  (
  `post_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '帖子ID',
  `community_id` int(0) NOT NULL COMMENT '社区ID',
  `user_id` int(0) NOT NULL COMMENT '用户ID',
  `post_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '帖子标题',
  `post_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '帖子内容',
  `parent_post_id` int(0) NULL DEFAULT 0 COMMENT '父帖子ID',
  `like_count` int(0) NULL DEFAULT 0 COMMENT '点赞数',
  `created_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `status` int(0) NULL DEFAULT 0 COMMENT '状态，0表示正常，1表示异常',
  `version` int(0) NULL DEFAULT 1 COMMENT '版本控制',
  PRIMARY KEY (`post_id`) USING BTREE,
  INDEX `fk_post_community`(`community_id`) USING BTREE,
  INDEX `fk_post_user`(`user_id`) USING BTREE,
  CONSTRAINT `fk_post_community` FOREIGN KEY (`community_id`) REFERENCES `community` (`community_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_post_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of post
-- ----------------------------
INSERT INTO `post` VALUES (1, 1, 1, '新手攻略', '分享一些RPG新手技巧', NULL, 10, '2021-01-01 10:00:00', '2021-01-02 10:00:00', 0, 1);
INSERT INTO `post` VALUES (2, 2, 2, '枪械讨论', '哪把枪最好用？', NULL, 15, '2021-02-01 11:00:00', '2021-02-02 11:00:00', 0, 1);
INSERT INTO `post` VALUES (3, 3, 3, '英雄选择', '你们最喜欢哪个英雄？', NULL, 20, '2021-03-01 12:00:00', '2021-03-02 12:00:00', 0, 1);
INSERT INTO `post` VALUES (4, 4, 4, '进球分享', '我进了一个超级漂亮的球！', NULL, 8, '2021-04-01 13:00:00', '2021-04-02 13:00:00', 0, 1);
INSERT INTO `post` VALUES (5, 5, 5, '策略心得', '文明VI的胜利条件讨论', NULL, 12, '2021-05-01 14:00:00', '2021-05-02 14:00:00', 0, 1);
INSERT INTO `post` VALUES (6, 6, 6, '冒险故事', '分享我在古墓丽影里的经历', NULL, 18, '2021-06-01 15:00:00', '2021-06-02 15:00:00', 0, 1);
INSERT INTO `post` VALUES (7, 7, 7, '赛车技巧', '漂移技巧教学', NULL, 25, '2021-07-01 16:00:00', '2021-07-02 16:00:00', 0, 1);
INSERT INTO `post` VALUES (8, 8, 8, '解谜思路', '这个谜题该怎么破？', NULL, 6, '2021-08-01 17:00:00', '2021-08-02 17:00:00', 0, 1);
INSERT INTO `post` VALUES (9, 9, 9, '卡组推荐', '分享我的炉石卡组', NULL, 30, '2021-09-01 18:00:00', '2021-09-02 18:00:00', 0, 1);
INSERT INTO `post` VALUES (10, 10, 10, '城市建设', '如何规划城市才合理？', NULL, 22, '2021-10-01 19:00:00', '2021-10-02 19:00:00', 0, 1);
INSERT INTO `post` VALUES (11, 11, 11, 'Among Us套路', '讨论一些有趣的套路', NULL, 9, '2021-11-01 20:00:00', '2021-11-02 20:00:00', 0, 1);
INSERT INTO `post` VALUES (12, 12, 12, '建造心得', 'Minecraft建筑展示', NULL, 14, '2021-12-01 21:00:00', '2021-12-02 21:00:00', 0, 1);
INSERT INTO `post` VALUES (13, 13, 13, '生存技巧', 'Rust新手生存指南', NULL, 16, '2022-01-01 22:00:00', '2022-01-02 22:00:00', 0, 1);
INSERT INTO `post` VALUES (14, 14, 14, '恐怖体验', '生化危机吓到我了！', NULL, 19, '2022-02-01 23:00:00', '2022-02-02 23:00:00', 0, 1);
INSERT INTO `post` VALUES (15, 15, 15, '魔兽回忆', '怀念巫妖王之怒时代', NULL, 35, '2022-03-01 09:00:00', '2022-03-02 09:00:00', 0, 1);
INSERT INTO `post` VALUES (16, 16, 16, 'VR体验', 'Beat Saber太带感了！', NULL, 28, '2022-04-01 10:00:00', '2022-04-02 10:00:00', 0, 1);
INSERT INTO `post` VALUES (17, 17, 17, '格斗教学', '铁拳7连招教学', NULL, 40, '2022-05-01 11:00:00', '2022-05-02 11:00:00', 0, 1);
INSERT INTO `post` VALUES (18, 18, 18, '桌游聚会', '卡坦岛规则讨论', NULL, 7, '2022-06-01 12:00:00', '2022-06-02 12:00:00', 0, 1);
INSERT INTO `post` VALUES (19, 19, 19, '魂系挑战', '黑魂3无伤通关', NULL, 50, '2022-07-01 13:00:00', '2022-07-02 13:00:00', 0, 1);
INSERT INTO `post` VALUES (20, 20, 20, '赛博心得', '分享我在2077的体验', NULL, 33, '2022-08-01 14:00:00', '2022-08-02 14:00:00', 0, 1);

-- ----------------------------
-- Table structure for sales
-- ----------------------------
DROP TABLE IF EXISTS `sales`;
CREATE TABLE `sales`  (
  `sales_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '优惠ID',
  `sales_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '优惠名称',
  `game_id` int(0) NOT NULL COMMENT '游戏ID',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '优惠描述',
  `discount_rate` decimal(5, 2) NULL DEFAULT NULL COMMENT '折扣率',
  `start_time` timestamp(0) NULL DEFAULT NULL COMMENT '优惠开始时间',
  `end_time` timestamp(0) NULL DEFAULT NULL COMMENT '优惠结束时间',
  `status` int(0) NULL DEFAULT 0 COMMENT '状态，0表示正常，1表示异常',
  `version` int(0) NULL DEFAULT 1 COMMENT '版本控制',
  `created_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`sales_id`) USING BTREE,
  INDEX `fk_sales_game`(`game_id`) USING BTREE,
  CONSTRAINT `fk_sales_game` FOREIGN KEY (`game_id`) REFERENCES `game` (`game_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sales
-- ----------------------------
INSERT INTO `sales` VALUES (1, '新年折扣', 1, 'RPG大作新年特惠', 0.00, '2021-01-01 00:00:00', '2021-01-15 23:59:59', 0, 1, '2021-01-01 00:00:00', '2025-10-31 15:15:37');
INSERT INTO `sales` VALUES (2, '春节特惠', 2, 'FPS系列春节促销', 0.30, '2022-02-01 00:00:00', '2022-02-10 23:59:59', 0, 1, '2022-02-01 00:00:00', '2022-02-01 00:00:00');
INSERT INTO `sales` VALUES (3, '暑期特卖', 3, 'MOBA暑期活动', 0.15, '2021-07-01 00:00:00', '2021-07-31 23:59:59', 0, 1, '2021-07-01 00:00:00', '2021-07-01 00:00:00');
INSERT INTO `sales` VALUES (4, '黑五特惠', 4, 'FIFA系列黑五促销', 0.40, '2020-11-25 00:00:00', '2020-11-30 23:59:59', 0, 1, '2020-11-25 00:00:00', '2020-11-25 00:00:00');
INSERT INTO `sales` VALUES (5, '圣诞促销', 5, '文明系列圣诞折扣', 0.25, '2019-12-20 00:00:00', '2019-12-31 23:59:59', 0, 1, '2019-12-20 00:00:00', '2019-12-20 00:00:00');
INSERT INTO `sales` VALUES (6, '复活节活动', 6, '冒险解谜折扣', 0.10, '2021-04-02 00:00:00', '2021-04-05 23:59:59', 0, 1, '2021-04-02 00:00:00', '2021-04-02 00:00:00');
INSERT INTO `sales` VALUES (7, '夏季大促', 7, '赛车类夏季特惠', 0.35, '2020-08-01 00:00:00', '2020-08-15 23:59:59', 0, 1, '2020-08-01 00:00:00', '2020-08-01 00:00:00');
INSERT INTO `sales` VALUES (8, '愚人节折扣', 8, '益智类愚人节活动', 0.50, '2019-04-01 00:00:00', '2019-04-01 23:59:59', 0, 1, '2019-04-01 00:00:00', '2019-04-01 00:00:00');
INSERT INTO `sales` VALUES (9, '万圣节特卖', 9, '卡牌类万圣节折扣', 0.20, '2020-10-31 00:00:00', '2020-11-01 23:59:59', 0, 1, '2020-10-31 00:00:00', '2020-10-31 00:00:00');
INSERT INTO `sales` VALUES (10, '国庆促销', 10, '模拟类国庆活动', 0.15, '2021-10-01 00:00:00', '2021-10-07 23:59:59', 0, 1, '2021-10-01 00:00:00', '2021-10-01 00:00:00');
INSERT INTO `sales` VALUES (11, '周年庆典', 11, 'Among Us周年庆活动', 0.30, '2020-06-15 00:00:00', '2020-06-20 23:59:59', 0, 1, '2020-06-15 00:00:00', '2020-06-15 00:00:00');
INSERT INTO `sales` VALUES (12, '双十一', 12, 'Minecraft双十一促销', 0.25, '2021-11-11 00:00:00', '2021-11-12 23:59:59', 0, 1, '2021-11-11 00:00:00', '2021-11-11 00:00:00');
INSERT INTO `sales` VALUES (13, '双旦特惠', 13, 'Rust圣诞元旦活动', 0.40, '2019-12-24 00:00:00', '2020-01-01 23:59:59', 0, 1, '2019-12-24 00:00:00', '2019-12-24 00:00:00');
INSERT INTO `sales` VALUES (14, '女神节活动', 14, '恐怖类女神节折扣', 0.10, '2021-03-08 00:00:00', '2021-03-09 23:59:59', 0, 1, '2021-03-08 00:00:00', '2021-03-08 00:00:00');
INSERT INTO `sales` VALUES (15, '情人节折扣', 15, '魔兽世界情人节促销', 0.20, '2020-02-14 00:00:00', '2020-02-14 23:59:59', 0, 1, '2020-02-14 00:00:00', '2020-02-14 00:00:00');
INSERT INTO `sales` VALUES (16, '五一劳动节', 16, 'VR游戏五一特惠', 0.15, '2022-05-01 00:00:00', '2022-05-03 23:59:59', 0, 1, '2022-05-01 00:00:00', '2022-05-01 00:00:00');
INSERT INTO `sales` VALUES (17, '端午节折扣', 17, '格斗类端午节活动', 0.25, '2021-06-14 00:00:00', '2021-06-14 23:59:59', 0, 1, '2021-06-14 00:00:00', '2021-06-14 00:00:00');
INSERT INTO `sales` VALUES (18, '儿童节特卖', 18, '桌游类儿童节促销', 0.35, '2020-06-01 00:00:00', '2020-06-02 23:59:59', 0, 1, '2020-06-01 00:00:00', '2020-06-01 00:00:00');
INSERT INTO `sales` VALUES (19, '寒假活动', 19, 'RPG游戏寒假促销', 0.30, '2019-01-15 00:00:00', '2019-01-31 23:59:59', 0, 1, '2019-01-15 00:00:00', '2019-01-15 00:00:00');
INSERT INTO `sales` VALUES (20, '夏令营特惠', 20, '赛博朋克暑期活动', 0.20, '2021-07-10 00:00:00', '2021-07-20 23:59:59', 0, 1, '2021-07-10 00:00:00', '2021-07-10 00:00:00');

-- ----------------------------
-- Table structure for tag
-- ----------------------------
DROP TABLE IF EXISTS `tag`;
CREATE TABLE `tag`  (
  `tag_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '标签ID',
  `tag_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '标签名称',
  `usage_count` int(0) NULL DEFAULT 0 COMMENT '使用次数',
  `tag_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '标签描述',
  `created_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `status` int(0) NULL DEFAULT 0 COMMENT '状态，0表示正常，1表示异常',
  `version` int(0) NULL DEFAULT 1 COMMENT '版本控制',
  PRIMARY KEY (`tag_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tag
-- ----------------------------
INSERT INTO `tag` VALUES (1, 'RPG', 12, '角色扮演类游戏', '2021-01-01 12:00:00', '2022-01-01 12:00:00', 0, 1);
INSERT INTO `tag` VALUES (2, 'FPS', 7, '第一人称射击', '2020-05-11 09:20:00', '2021-07-22 15:10:00', 0, 1);
INSERT INTO `tag` VALUES (3, 'MOBA', 15, '多人竞技游戏', '2019-06-15 18:33:00', '2020-06-20 21:11:00', 0, 1);
INSERT INTO `tag` VALUES (4, 'Sports', 9, '体育运动类', '2021-04-01 14:50:00', '2022-04-01 14:50:00', 0, 1);
INSERT INTO `tag` VALUES (5, 'Strategy', 5, '策略类游戏', '2018-09-09 08:10:00', '2019-03-15 09:00:00', 0, 1);
INSERT INTO `tag` VALUES (6, 'Adventure', 13, '冒险解谜类', '2020-12-01 10:25:00', '2021-12-01 10:25:00', 0, 1);
INSERT INTO `tag` VALUES (7, 'Racing', 8, '赛车类', '2019-11-11 19:45:00', '2020-12-12 19:45:00', 0, 1);
INSERT INTO `tag` VALUES (8, 'Puzzle', 4, '益智解谜类', '2022-01-15 17:00:00', '2022-06-15 17:00:00', 0, 1);
INSERT INTO `tag` VALUES (9, 'Card', 3, '卡牌游戏', '2021-02-02 22:00:00', '2021-08-02 22:00:00', 0, 1);
INSERT INTO `tag` VALUES (10, 'Simulation', 6, '模拟经营类', '2018-04-04 13:10:00', '2019-04-04 13:10:00', 0, 1);
INSERT INTO `tag` VALUES (11, 'Indie', 2, '独立开发游戏', '2019-07-07 11:05:00', '2020-07-07 11:05:00', 0, 1);
INSERT INTO `tag` VALUES (12, 'Casual', 10, '休闲类', '2020-08-20 09:15:00', '2021-08-20 09:15:00', 0, 1);
INSERT INTO `tag` VALUES (13, 'Sandbox', 11, '开放世界沙盒', '2019-10-01 12:12:00', '2020-10-01 12:12:00', 0, 1);
INSERT INTO `tag` VALUES (14, 'Survival', 14, '生存类', '2021-03-03 20:30:00', '2022-03-03 20:30:00', 0, 1);
INSERT INTO `tag` VALUES (15, 'Horror', 7, '恐怖解谜类', '2018-06-06 08:40:00', '2019-06-06 08:40:00', 0, 1);
INSERT INTO `tag` VALUES (16, 'MMORPG', 16, '大型多人在线游戏', '2020-09-09 19:19:00', '2021-09-09 19:19:00', 0, 1);
INSERT INTO `tag` VALUES (17, 'VR', 5, '虚拟现实', '2022-02-14 12:00:00', '2022-07-14 12:00:00', 0, 1);
INSERT INTO `tag` VALUES (18, 'Music', 1, '音乐节奏类', '2020-11-22 15:30:00', '2021-11-22 15:30:00', 0, 1);
INSERT INTO `tag` VALUES (19, 'Fighting', 9, '格斗游戏', '2021-12-12 10:00:00', '2022-12-12 10:00:00', 0, 1);
INSERT INTO `tag` VALUES (20, 'Board', 3, '桌面棋类', '2019-08-08 18:00:00', '2020-08-08 18:00:00', 0, 1);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `user_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `steam_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `user_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户邮箱',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户密码',
  `register_time` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
  `status` int(0) NULL DEFAULT 0 COMMENT '用户状态，0表示正常，1表示异常',
  `phone_number` bigint(0) NOT NULL COMMENT '手机号',
  `role` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'user' COMMENT '用户角色（游客、普通用户、管理员）',
  `version` int(0) NULL DEFAULT 1 COMMENT '版本控制',
  `created_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`user_id`) USING BTREE,
  UNIQUE INDEX `email`(`email`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, NULL, 'alice01', 'alice01@example.com', 'pwA1@92', '2021-03-15 10:12:30', 0, 13847293810, 'user', 1, '2021-03-15 10:12:30', '2022-02-10 18:22:11');
INSERT INTO `user` VALUES (2, NULL, 'bob77', 'bob77@example.com', 'pwB9@11', '2020-07-22 15:32:12', 0, 13984756329, 'admin', 1, '2020-07-22 15:32:12', '2023-01-11 14:02:56');
INSERT INTO `user` VALUES (3, NULL, 'charlieX', 'charliex@mail.com', 'pwC8@73', '2019-12-09 21:03:45', 1, 13745920183, 'guest', 1, '2019-12-09 21:03:45', '2020-03-01 10:00:22');
INSERT INTO `user` VALUES (4, NULL, 'david99', 'david99@example.org', 'pwD7@45', '2022-01-05 08:45:01', 0, 13694758302, 'user', 1, '2022-01-05 08:45:01', '2022-11-12 20:30:42');
INSERT INTO `user` VALUES (5, NULL, 'eva_k', 'eva.k@example.com', 'pwE1@55', '2021-08-13 19:22:55', 0, 13582937465, 'user', 1, '2021-08-13 19:22:55', '2022-09-30 09:20:00');
INSERT INTO `user` VALUES (6, NULL, 'frankM', 'frank.m@mail.net', 'pwF5@64', '2018-04-30 11:02:18', 0, 13472839485, 'admin', 1, '2018-04-30 11:02:18', '2020-01-20 16:11:49');
INSERT INTO `user` VALUES (7, NULL, 'grace07', 'grace07@domain.com', 'pwG4@77', '2020-10-10 12:41:02', 0, 13928374652, 'user', 1, '2020-10-10 12:41:02', '2021-10-18 15:55:21');
INSERT INTO `user` VALUES (8, NULL, 'henryQ', 'henryq@example.com', 'pwH9@88', '2019-05-23 09:18:34', 1, 13837492018, 'guest', 1, '2019-05-23 09:18:34', '2020-02-14 19:02:18');
INSERT INTO `user` VALUES (9, NULL, 'irene55', 'irene55@mail.org', 'pwI3@20', '2022-02-28 14:14:14', 0, 13748592013, 'user', 1, '2022-02-28 14:14:14', '2023-01-09 17:25:09');
INSERT INTO `user` VALUES (10, NULL, 'jackson', 'jackson@example.net', 'pwJ6@39', '2020-09-19 20:33:20', 0, 13692837461, 'user', 1, '2020-09-19 20:33:20', '2021-12-25 22:10:00');
INSERT INTO `user` VALUES (11, NULL, 'kate33', 'kate33@example.com', 'pwK4@41', '2018-12-12 07:59:21', 0, 13592037486, 'admin', 1, '2018-12-12 07:59:21', '2019-10-03 19:48:29');
INSERT INTO `user` VALUES (12, NULL, 'leo88', 'leo88@mail.com', 'pwL7@82', '2021-11-11 11:11:11', 0, 13492038476, 'user', 1, '2021-11-11 11:11:11', '2022-06-15 20:00:01');
INSERT INTO `user` VALUES (13, NULL, 'mia_s', 'mia.s@example.com', 'pwM2@61', '2019-01-15 13:20:01', 1, 13948392010, 'guest', 1, '2019-01-15 13:20:01', '2019-07-18 18:15:35');
INSERT INTO `user` VALUES (14, NULL, 'nickL', 'nickl@example.org', 'pwN8@55', '2022-07-07 17:25:33', 0, 13829485730, 'user', 1, '2022-07-07 17:25:33', '2022-12-09 22:30:17');
INSERT INTO `user` VALUES (15, NULL, 'olivia', 'olivia@mail.com', 'pwO1@12', '2020-06-06 06:06:06', 0, 13759203847, 'user', 1, '2020-06-06 06:06:06', '2021-05-20 11:45:00');
INSERT INTO `user` VALUES (16, NULL, 'peterQ', 'peterq@example.com', 'pwP5@99', '2018-09-09 15:15:15', 0, 13692837409, 'admin', 1, '2018-09-09 15:15:15', '2020-04-12 19:20:00');
INSERT INTO `user` VALUES (17, NULL, 'queenV', 'queenv@example.net', 'pwQ4@82', '2021-04-14 04:44:44', 0, 13572938462, 'user', 1, '2021-04-14 04:44:44', '2022-10-18 13:30:00');
INSERT INTO `user` VALUES (18, NULL, 'robert9', 'robert9@example.com', 'pwR8@15', '2022-05-01 09:20:33', 0, 13483920194, 'user', 1, '2022-05-01 09:20:33', '2022-11-20 16:12:09');
INSERT INTO `user` VALUES (19, NULL, 'susanW', 'susanw@mail.com', 'pwS6@24', '2019-02-02 02:22:02', 1, 13927492038, 'guest', 1, '2019-02-02 02:22:02', '2019-08-05 18:00:45');
INSERT INTO `user` VALUES (20, NULL, 'tomH', 'tomh@example.org', 'pwT3@98', '2020-10-30 19:19:19', 0, 13839485720, 'user', 1, '2020-10-30 19:19:19', '2021-09-01 22:40:00');

-- ----------------------------
-- Table structure for user_achievement
-- ----------------------------
DROP TABLE IF EXISTS `user_achievement`;
CREATE TABLE `user_achievement`  (
  `user_achievement_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '用户成就ID',
  `user_id` int(0) NOT NULL COMMENT '用户ID',
  `achievement_id` int(0) NOT NULL COMMENT '成就ID',
  `achieved_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '达成日期',
  `status` int(0) NULL DEFAULT 0 COMMENT '状态，0表示正常，1表示异常',
  `version` int(0) NULL DEFAULT 1 COMMENT '版本控制',
  `updated_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`user_achievement_id`) USING BTREE,
  INDEX `fk_user_achievement_user`(`user_id`) USING BTREE,
  CONSTRAINT `fk_user_achievement_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_achievement
-- ----------------------------
INSERT INTO `user_achievement` VALUES (1, 7, 15, '2021-01-05 10:00:00', 0, 1, '2021-01-05 10:00:00');
INSERT INTO `user_achievement` VALUES (2, 14, 3, '2021-02-10 11:00:00', 0, 1, '2021-02-10 11:00:00');
INSERT INTO `user_achievement` VALUES (3, 2, 19, '2021-03-15 12:00:00', 0, 1, '2021-03-15 12:00:00');
INSERT INTO `user_achievement` VALUES (4, 18, 5, '2021-04-20 13:00:00', 0, 1, '2021-04-20 13:00:00');
INSERT INTO `user_achievement` VALUES (5, 11, 8, '2021-05-25 14:00:00', 0, 1, '2021-05-25 14:00:00');
INSERT INTO `user_achievement` VALUES (6, 4, 12, '2021-06-30 15:00:00', 0, 1, '2021-06-30 15:00:00');
INSERT INTO `user_achievement` VALUES (7, 20, 1, '2021-07-05 16:00:00', 0, 1, '2021-07-05 16:00:00');
INSERT INTO `user_achievement` VALUES (8, 9, 16, '2021-08-10 17:00:00', 0, 1, '2021-08-10 17:00:00');
INSERT INTO `user_achievement` VALUES (9, 5, 10, '2021-09-15 18:00:00', 0, 1, '2021-09-15 18:00:00');
INSERT INTO `user_achievement` VALUES (10, 13, 6, '2021-10-20 19:00:00', 0, 1, '2021-10-20 19:00:00');
INSERT INTO `user_achievement` VALUES (11, 1, 18, '2021-11-25 20:00:00', 0, 1, '2021-11-25 20:00:00');
INSERT INTO `user_achievement` VALUES (12, 15, 4, '2021-12-30 21:00:00', 0, 1, '2021-12-30 21:00:00');
INSERT INTO `user_achievement` VALUES (13, 8, 13, '2022-01-05 22:00:00', 0, 1, '2022-01-05 22:00:00');
INSERT INTO `user_achievement` VALUES (14, 17, 2, '2022-02-10 23:00:00', 0, 1, '2022-02-10 23:00:00');
INSERT INTO `user_achievement` VALUES (15, 6, 20, '2022-03-15 09:00:00', 0, 1, '2022-03-15 09:00:00');
INSERT INTO `user_achievement` VALUES (16, 19, 7, '2022-04-20 10:00:00', 0, 1, '2022-04-20 10:00:00');
INSERT INTO `user_achievement` VALUES (17, 3, 14, '2022-05-25 11:00:00', 0, 1, '2022-05-25 11:00:00');
INSERT INTO `user_achievement` VALUES (18, 16, 9, '2022-06-30 12:00:00', 0, 1, '2022-06-30 12:00:00');
INSERT INTO `user_achievement` VALUES (19, 10, 11, '2022-07-05 13:00:00', 0, 1, '2022-07-05 13:00:00');
INSERT INTO `user_achievement` VALUES (20, 12, 17, '2022-08-10 14:00:00', 0, 1, '2022-08-10 14:00:00');

-- ----------------------------
-- Table structure for user_follow
-- ----------------------------
DROP TABLE IF EXISTS `user_follow`;
CREATE TABLE `user_follow`  (
  `follow_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '关注ID',
  `user_id` int(0) NOT NULL COMMENT '用户ID',
  `game_id` int(0) NOT NULL COMMENT '游戏ID',
  `follow_time` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '关注时间',
  `status` int(0) NULL DEFAULT 0 COMMENT '关注状态，0表示已关注，1表示异常',
  `version` int(0) NULL DEFAULT 1 COMMENT '版本控制',
  `created_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`follow_id`) USING BTREE,
  INDEX `fk_user_follow_user`(`user_id`) USING BTREE,
  INDEX `fk_user_follow_game`(`game_id`) USING BTREE,
  CONSTRAINT `fk_user_follow_game` FOREIGN KEY (`game_id`) REFERENCES `game` (`game_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_user_follow_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_follow
-- ----------------------------
INSERT INTO `user_follow` VALUES (1, 1, 1, '2025-09-06 16:48:35', 0, 1, '2021-01-01 10:00:00', '2021-01-01 10:00:00');
INSERT INTO `user_follow` VALUES (2, 2, 2, '2025-09-06 16:48:35', 0, 1, '2021-02-01 11:00:00', '2021-02-01 11:00:00');
INSERT INTO `user_follow` VALUES (3, 3, 3, '2025-09-06 16:48:35', 0, 1, '2021-03-01 12:00:00', '2021-03-01 12:00:00');
INSERT INTO `user_follow` VALUES (4, 4, 4, '2025-09-06 16:48:35', 0, 1, '2021-04-01 13:00:00', '2021-04-01 13:00:00');
INSERT INTO `user_follow` VALUES (5, 5, 5, '2025-09-06 16:48:35', 0, 1, '2021-05-01 14:00:00', '2021-05-01 14:00:00');
INSERT INTO `user_follow` VALUES (6, 6, 6, '2025-09-06 16:48:35', 0, 1, '2021-06-01 15:00:00', '2021-06-01 15:00:00');
INSERT INTO `user_follow` VALUES (7, 7, 7, '2025-09-06 16:48:35', 0, 1, '2021-07-01 16:00:00', '2021-07-01 16:00:00');
INSERT INTO `user_follow` VALUES (8, 8, 8, '2025-09-06 16:48:35', 0, 1, '2021-08-01 17:00:00', '2021-08-01 17:00:00');
INSERT INTO `user_follow` VALUES (9, 9, 9, '2025-09-06 16:48:35', 0, 1, '2021-09-01 18:00:00', '2021-09-01 18:00:00');
INSERT INTO `user_follow` VALUES (10, 10, 10, '2025-09-06 16:48:35', 0, 1, '2021-10-01 19:00:00', '2021-10-01 19:00:00');
INSERT INTO `user_follow` VALUES (11, 11, 11, '2025-09-06 16:48:35', 0, 1, '2021-11-01 20:00:00', '2021-11-01 20:00:00');
INSERT INTO `user_follow` VALUES (12, 12, 12, '2025-09-06 16:48:35', 0, 1, '2021-12-01 21:00:00', '2021-12-01 21:00:00');
INSERT INTO `user_follow` VALUES (13, 13, 13, '2025-09-06 16:48:35', 0, 1, '2022-01-01 22:00:00', '2022-01-01 22:00:00');
INSERT INTO `user_follow` VALUES (14, 14, 14, '2025-09-06 16:48:35', 0, 1, '2022-02-01 23:00:00', '2022-02-01 23:00:00');
INSERT INTO `user_follow` VALUES (15, 15, 15, '2025-09-06 16:48:35', 0, 1, '2022-03-01 09:00:00', '2022-03-01 09:00:00');
INSERT INTO `user_follow` VALUES (16, 16, 16, '2025-09-06 16:48:35', 0, 1, '2022-04-01 10:00:00', '2022-04-01 10:00:00');
INSERT INTO `user_follow` VALUES (17, 17, 17, '2025-09-06 16:48:35', 0, 1, '2022-05-01 11:00:00', '2022-05-01 11:00:00');
INSERT INTO `user_follow` VALUES (18, 18, 18, '2025-09-06 16:48:35', 0, 1, '2022-06-01 12:00:00', '2022-06-01 12:00:00');
INSERT INTO `user_follow` VALUES (19, 19, 19, '2025-09-06 16:48:35', 0, 1, '2022-07-01 13:00:00', '2022-07-01 13:00:00');
INSERT INTO `user_follow` VALUES (20, 20, 20, '2025-09-06 16:48:35', 0, 1, '2022-08-01 14:00:00', '2022-08-01 14:00:00');

-- ----------------------------
-- Table structure for user_game_library
-- ----------------------------
DROP TABLE IF EXISTS `user_game_library`;
CREATE TABLE `user_game_library`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` int(0) NOT NULL COMMENT '用户ID',
  `game_id` int(0) NOT NULL COMMENT '游戏ID',
  `source` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'BUY' COMMENT '来源：BUY=购买, GIFT=礼包',
  `status` int(0) NULL DEFAULT 0 COMMENT '状态：0=正常, 1=异常',
  `version` int(0) NULL DEFAULT 1 COMMENT '版本号（乐观锁）',
  `created_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uq_user_game`(`user_id`, `game_id`) USING BTREE,
  INDEX `fk_user_library_game`(`game_id`) USING BTREE,
  CONSTRAINT `fk_user_library_game` FOREIGN KEY (`game_id`) REFERENCES `game` (`game_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_user_library_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 46 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_game_library
-- ----------------------------
INSERT INTO `user_game_library` VALUES (21, 1, 1, 'BUY', 0, 1, '2025-09-01 10:15:23', '2025-09-01 10:15:23');
INSERT INTO `user_game_library` VALUES (22, 1, 2, 'BUY', 0, 1, '2025-09-02 14:22:10', '2025-09-02 14:22:10');
INSERT INTO `user_game_library` VALUES (23, 1, 3, 'GIFT', 0, 1, '2025-09-05 09:45:00', '2025-09-05 09:45:00');
INSERT INTO `user_game_library` VALUES (24, 2, 1, 'BUY', 0, 1, '2025-09-03 11:33:41', '2025-09-03 11:33:41');
INSERT INTO `user_game_library` VALUES (25, 2, 4, 'BUY', 1, 1, '2025-09-04 18:10:52', '2025-09-04 18:10:52');
INSERT INTO `user_game_library` VALUES (26, 2, 5, 'GIFT', 0, 1, '2025-09-06 08:12:15', '2025-09-06 08:12:15');
INSERT INTO `user_game_library` VALUES (27, 3, 6, 'BUY', 0, 1, '2025-09-07 16:40:00', '2025-09-07 16:40:00');
INSERT INTO `user_game_library` VALUES (28, 3, 7, 'BUY', 0, 1, '2025-09-08 09:05:30', '2025-09-08 09:05:30');
INSERT INTO `user_game_library` VALUES (29, 3, 8, 'BUY', 1, 1, '2025-09-08 19:50:45', '2025-09-08 19:50:45');
INSERT INTO `user_game_library` VALUES (30, 4, 2, 'BUY', 0, 1, '2025-09-09 13:23:12', '2025-09-09 13:23:12');
INSERT INTO `user_game_library` VALUES (31, 4, 9, 'GIFT', 0, 1, '2025-09-09 17:40:33', '2025-09-09 17:40:33');
INSERT INTO `user_game_library` VALUES (32, 5, 10, 'BUY', 0, 1, '2025-09-10 12:11:00', '2025-09-10 12:11:00');
INSERT INTO `user_game_library` VALUES (33, 5, 11, 'GIFT', 0, 1, '2025-09-11 09:44:59', '2025-09-11 09:44:59');
INSERT INTO `user_game_library` VALUES (34, 6, 12, 'BUY', 1, 1, '2025-09-11 20:30:45', '2025-09-11 20:30:45');
INSERT INTO `user_game_library` VALUES (35, 6, 13, 'BUY', 0, 1, '2025-09-12 15:09:21', '2025-09-12 15:09:21');
INSERT INTO `user_game_library` VALUES (36, 7, 14, 'BUY', 0, 1, '2025-09-12 19:55:10', '2025-09-12 19:55:10');
INSERT INTO `user_game_library` VALUES (37, 7, 15, 'GIFT', 0, 1, '2025-09-13 08:40:00', '2025-09-13 08:40:00');
INSERT INTO `user_game_library` VALUES (38, 8, 16, 'BUY', 0, 1, '2025-09-13 14:22:55', '2025-09-13 14:22:55');
INSERT INTO `user_game_library` VALUES (39, 9, 17, 'BUY', 1, 1, '2025-09-14 11:33:48', '2025-09-14 11:33:48');
INSERT INTO `user_game_library` VALUES (40, 10, 18, 'GIFT', 0, 1, '2025-09-15 10:05:22', '2025-09-15 10:05:22');
INSERT INTO `user_game_library` VALUES (43, 1, 20, 'BUY', 0, 1, '2025-10-14 20:18:41', '2025-10-14 20:18:41');
INSERT INTO `user_game_library` VALUES (44, 1, 10, 'BUY', 0, 1, '2025-10-16 01:03:51', '2025-10-16 01:03:51');
INSERT INTO `user_game_library` VALUES (45, 1, 11, 'BUY', 0, 1, '2025-10-16 01:05:36', '2025-10-16 01:05:36');
INSERT INTO `user_game_library` VALUES (46, 1, 12, 'BUY', 0, 1, '2025-10-16 01:05:42', '2025-10-16 01:05:42');

-- ----------------------------
-- Table structure for user_profile
-- ----------------------------
DROP TABLE IF EXISTS `user_profile`;
CREATE TABLE `user_profile`  (
  `user_profile_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '用户详情ID',
  `user_id` int(0) NOT NULL COMMENT '用户ID',
  `age` int(0) NULL DEFAULT NULL COMMENT '年龄',
  `gender` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '性别',
  `birthday` date NULL DEFAULT NULL COMMENT '生日',
  `country` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '国家',
  `bio` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '个人简介',
  `user_device` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户设备',
  `avatar_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '头像 URL',
  `status` int(0) NULL DEFAULT 0 COMMENT '用户状态，0表示正常，1表示异常',
  `version` int(0) NULL DEFAULT 1 COMMENT '版本控制',
  `created_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`user_profile_id`) USING BTREE,
  INDEX `fk_user_profile_user`(`user_id`) USING BTREE,
  CONSTRAINT `fk_user_profile_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_profile
-- ----------------------------
INSERT INTO `user_profile` VALUES (1, 1, 25, 'M', '1997-04-15', 'China', '热爱RPG和FPS游戏', 'iPhone 13', 'avatar1.jpg', 0, 1, '2021-04-15 10:00:00', '2022-01-10 15:00:00');
INSERT INTO `user_profile` VALUES (2, 2, 30, 'F', '1992-09-20', 'USA', '策略游戏迷', 'Samsung S21', 'avatar2.jpg', 0, 1, '2020-09-20 11:00:00', '2021-12-11 16:00:00');
INSERT INTO `user_profile` VALUES (3, 3, 21, 'O', '2001-06-01', 'UK', '喜欢音乐游戏', 'iPad Pro', 'avatar3.jpg', 0, 1, '2021-06-01 12:00:00', '2022-03-01 12:00:00');
INSERT INTO `user_profile` VALUES (4, 4, 27, 'M', '1995-12-31', 'Canada', '沙盒类忠实粉丝', 'MacBook Air', 'avatar4.jpg', 0, 1, '2021-12-31 08:30:00', '2022-01-20 09:20:00');
INSERT INTO `user_profile` VALUES (5, 5, 19, 'F', '2003-03-05', 'Japan', '喜欢休闲类游戏', 'Switch', 'avatar5.jpg', 0, 1, '2021-03-05 10:00:00', '2022-01-01 12:00:00');
INSERT INTO `user_profile` VALUES (6, 6, 33, 'M', '1989-08-11', 'Germany', 'FPS玩家', 'Alienware PC', 'avatar6.jpg', 0, 1, '2019-08-11 14:00:00', '2020-08-11 14:00:00');
INSERT INTO `user_profile` VALUES (7, 7, 22, 'F', '2000-10-10', 'France', 'MMO游戏爱好者', 'PS5', 'avatar7.jpg', 0, 1, '2020-10-10 19:00:00', '2021-10-10 19:00:00');
INSERT INTO `user_profile` VALUES (8, 8, 29, 'M', '1993-01-18', 'Australia', '赛车类爱好者', 'Xbox Series X', 'avatar8.jpg', 0, 1, '2021-01-18 20:00:00', '2021-12-18 20:00:00');
INSERT INTO `user_profile` VALUES (9, 9, 26, 'F', '1996-05-25', 'Italy', '恐怖游戏粉丝', 'OnePlus 9', 'avatar9.jpg', 0, 1, '2021-05-25 21:00:00', '2022-05-25 21:00:00');
INSERT INTO `user_profile` VALUES (10, 10, 35, 'M', '1987-07-07', 'Spain', '喜欢独立游戏', 'Surface Pro', 'avatar10.jpg', 0, 1, '2019-07-07 22:00:00', '2020-07-07 22:00:00');
INSERT INTO `user_profile` VALUES (11, 11, 24, 'F', '1998-11-11', 'Russia', '二次元爱好者', 'Huawei P50', 'avatar11.jpg', 0, 1, '2020-11-11 10:10:00', '2021-11-11 10:10:00');
INSERT INTO `user_profile` VALUES (12, 12, 28, 'M', '1994-02-22', 'Brazil', '喜欢策略和战争类', 'ThinkPad X1', 'avatar12.jpg', 0, 1, '2020-02-22 18:00:00', '2021-02-22 18:00:00');
INSERT INTO `user_profile` VALUES (13, 13, 20, 'O', '2002-12-01', 'India', '热爱音乐节奏游戏', 'Oppo Find X3', 'avatar13.jpg', 0, 1, '2021-12-01 12:00:00', '2022-06-01 12:00:00');
INSERT INTO `user_profile` VALUES (14, 14, 31, 'M', '1991-06-06', 'Korea', '喜欢恐怖游戏', 'LG V60', 'avatar14.jpg', 0, 1, '2020-06-06 09:00:00', '2021-06-06 09:00:00');
INSERT INTO `user_profile` VALUES (15, 15, 23, 'F', '1999-09-09', 'Mexico', '喜欢沙盒类', 'Asus ROG Phone', 'avatar15.jpg', 0, 1, '2021-09-09 11:00:00', '2022-01-01 11:00:00');
INSERT INTO `user_profile` VALUES (16, 16, 36, 'M', '1986-04-04', 'Sweden', '赛车类粉丝', 'Lenovo Legion', 'avatar16.jpg', 0, 1, '2019-04-04 13:00:00', '2020-04-04 13:00:00');
INSERT INTO `user_profile` VALUES (17, 17, 27, 'F', '1995-12-24', 'Norway', '解谜类爱好者', 'iPhone 12', 'avatar17.jpg', 0, 1, '2020-12-24 16:00:00', '2021-12-24 16:00:00');
INSERT INTO `user_profile` VALUES (18, 18, 22, 'M', '2000-01-01', 'Singapore', '喜欢休闲益智', 'Samsung Tab S7', 'avatar18.jpg', 0, 1, '2021-01-01 08:00:00', '2021-07-01 08:00:00');
INSERT INTO `user_profile` VALUES (19, 19, 34, 'F', '1988-07-15', 'Thailand', '喜欢MOBA类', 'iPhone XR', 'avatar19.jpg', 0, 1, '2020-07-15 10:00:00', '2021-07-15 10:00:00');
INSERT INTO `user_profile` VALUES (20, 20, 29, 'M', '1993-11-30', 'Malaysia', '喜欢独立游戏', 'Dell G15', 'avatar20.jpg', 0, 1, '2021-11-30 21:00:00', '2022-06-30 21:00:00');

SET FOREIGN_KEY_CHECKS = 1;
