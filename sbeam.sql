/*
 Navicat Premium Data Transfer

 Source Server         : mysqlDemo
 Source Server Type    : MySQL
 Source Server Version : 80029
 Source Host           : localhost:3306
 Source Schema         : sbeam

 Target Server Type    : MySQL
 Target Server Version : 80029
 File Encoding         : 65001

 Date: 10/11/2025 11:12:14
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for cart
-- ----------------------------
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart`  (
  `cart_id` int NOT NULL AUTO_INCREMENT COMMENT '购物车ID',
  `user_id` int NOT NULL COMMENT '用户ID',
  `game_id` int NOT NULL COMMENT '游戏ID',
  `game_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '游戏名称',
  `game_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '游戏加入购物车时的价格',
  `sales_id` int NULL DEFAULT 0 COMMENT '折扣ID',
  `status` int NULL DEFAULT 0 COMMENT '购物车状态，0表示正常，1表示异常',
  `version` int NULL DEFAULT 1 COMMENT '版本控制',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`cart_id`) USING BTREE,
  INDEX `fk_cart_user`(`user_id` ASC) USING BTREE,
  INDEX `fk_cart_game`(`game_id` ASC) USING BTREE,
  INDEX `fk_cart_sales`(`sales_id` ASC) USING BTREE,
  CONSTRAINT `fk_cart_game` FOREIGN KEY (`game_id`) REFERENCES `game` (`game_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_cart_sales` FOREIGN KEY (`sales_id`) REFERENCES `sales` (`sales_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_cart_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 53 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cart
-- ----------------------------
INSERT INTO `cart` VALUES (23, 1, 1, 'Dragon Quest', 59.99, 1, 1, 1, '2025-11-07 21:26:45', '2025-11-07 21:26:45');
INSERT INTO `cart` VALUES (24, 1, 1, 'Dragon Quest', 59.99, 1, 1, 1, '2025-11-08 15:04:42', '2025-11-08 15:04:42');
INSERT INTO `cart` VALUES (25, 1, 6, 'Tomb Raider', 29.99, 1, 1, 1, '2025-11-08 15:10:18', '2025-11-08 15:10:18');
INSERT INTO `cart` VALUES (26, 1, 1, 'Dragon Quest', 59.99, 1, 1, 1, '2025-11-08 23:41:48', '2025-11-08 23:41:55');
INSERT INTO `cart` VALUES (27, 1, 1, 'Dragon Quest', 59.99, 1, 1, 1, '2025-11-09 22:34:52', '2025-11-09 22:37:12');
INSERT INTO `cart` VALUES (28, 1, 2, 'Call of Duty', 69.99, 1, 1, 1, '2025-11-09 22:36:40', '2025-11-09 22:36:40');
INSERT INTO `cart` VALUES (29, 1, 28, 'Call of Duty: Warzone', 0.00, 1, 1, 1, '2025-11-09 22:36:45', '2025-11-09 22:37:10');
INSERT INTO `cart` VALUES (30, 1, 32, 'Battlefield V', 39.99, 1, 1, 1, '2025-11-09 22:36:50', '2025-11-09 22:37:08');
INSERT INTO `cart` VALUES (31, 1, 2, 'Call of Duty', 69.99, 1, 1, 1, '2025-11-09 22:40:03', '2025-11-09 22:40:03');
INSERT INTO `cart` VALUES (32, 1, 28, 'Call of Duty: Warzone', 0.00, 1, 1, 1, '2025-11-09 22:40:07', '2025-11-09 22:40:17');
INSERT INTO `cart` VALUES (33, 1, 2, 'Call of Duty', 69.99, 1, 1, 1, '2025-11-09 22:49:59', '2025-11-09 22:49:59');
INSERT INTO `cart` VALUES (34, 1, 28, 'Call of Duty: Warzone', 0.00, 1, 1, 1, '2025-11-09 22:50:59', '2025-11-09 22:55:40');
INSERT INTO `cart` VALUES (35, 1, 1, 'Dragon Quest', 59.99, 1, 1, 1, '2025-11-09 22:55:45', '2025-11-09 22:55:45');
INSERT INTO `cart` VALUES (36, 1, 2, 'Call of Duty', 69.99, 1, 1, 1, '2025-11-09 22:55:47', '2025-11-09 22:55:47');
INSERT INTO `cart` VALUES (37, 1, 3, 'League of Heroes', 0.00, 1, 1, 1, '2025-11-09 22:55:49', '2025-11-09 22:55:49');
INSERT INTO `cart` VALUES (38, 1, 4, 'FIFA 21', 49.99, 1, 1, 1, '2025-11-09 22:55:52', '2025-11-09 22:55:52');
INSERT INTO `cart` VALUES (39, 1, 5, 'Civilization VI', 39.99, 1, 1, 1, '2025-11-09 22:55:55', '2025-11-09 22:55:55');
INSERT INTO `cart` VALUES (40, 1, 6, 'Tomb Raider', 29.99, 1, 1, 1, '2025-11-09 22:55:57', '2025-11-09 22:55:57');
INSERT INTO `cart` VALUES (41, 1, 7, 'Need for Speed', 19.99, 1, 1, 1, '2025-11-09 22:56:00', '2025-11-09 22:56:00');
INSERT INTO `cart` VALUES (42, 1, 1, 'Dragon Quest', 59.99, 1, 1, 1, '2025-11-09 22:58:12', '2025-11-09 22:58:12');
INSERT INTO `cart` VALUES (43, 1, 2, 'Call of Duty', 69.99, 1, 1, 1, '2025-11-09 22:58:14', '2025-11-09 22:58:14');
INSERT INTO `cart` VALUES (44, 1, 3, 'League of Heroes', 0.00, 1, 1, 1, '2025-11-09 22:58:18', '2025-11-09 22:58:18');
INSERT INTO `cart` VALUES (45, 1, 4, 'FIFA 21', 49.99, 1, 1, 1, '2025-11-09 22:58:21', '2025-11-09 22:58:21');
INSERT INTO `cart` VALUES (46, 1, 8, 'Candy Crush', 0.00, 1, 1, 1, '2025-11-09 22:58:25', '2025-11-09 22:58:25');
INSERT INTO `cart` VALUES (47, 1, 10, 'SimCity', 29.99, 1, 1, 1, '2025-11-09 22:58:28', '2025-11-09 22:58:28');
INSERT INTO `cart` VALUES (48, 1, 1, 'Dragon Quest', 59.99, 1, 1, 1, '2025-11-09 23:51:41', '2025-11-09 23:52:06');
INSERT INTO `cart` VALUES (49, 1, 2, 'Call of Duty', 69.99, 1, 1, 1, '2025-11-09 23:51:50', '2025-11-09 23:51:50');
INSERT INTO `cart` VALUES (50, 1, 7, 'Need for Speed', 19.99, 1, 1, 1, '2025-11-09 23:51:55', '2025-11-09 23:51:55');
INSERT INTO `cart` VALUES (51, 1, 12, 'Minecraft', 26.95, 1, 1, 1, '2025-11-09 23:51:59', '2025-11-09 23:51:59');
INSERT INTO `cart` VALUES (52, 1, 1, 'Dragon Quest', 59.99, 1, 0, 1, '2025-11-10 00:12:17', '2025-11-10 00:12:17');

-- ----------------------------
-- Table structure for cdkey_stock
-- ----------------------------
DROP TABLE IF EXISTS `cdkey_stock`;
CREATE TABLE `cdkey_stock`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `game_id` int NOT NULL,
  `cdkey` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '激活码',
  `status` int NULL DEFAULT 0 COMMENT '0未售出 1已售出 2作废',
  `order_id` int NULL DEFAULT NULL,
  `user_id` int NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_game_cdkey`(`game_id` ASC, `cdkey` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 144 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'CDKey库存表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cdkey_stock
-- ----------------------------
INSERT INTO `cdkey_stock` VALUES (44, 1, '54c6ca07-1ea3-4e35-aae1-cbb0c9d9494c', 1, 31, 1, '2025-11-07 21:21:25', '2025-11-09 22:59:05');
INSERT INTO `cdkey_stock` VALUES (45, 2, '447946eb-4c1c-43a8-9fc7-9fec925f2f80', 1, 27, 1, '2025-11-07 21:21:25', '2025-11-09 22:38:10');
INSERT INTO `cdkey_stock` VALUES (46, 3, '001f5cef-1445-4824-a58e-7f367b8c80b1', 1, 31, 1, '2025-11-07 21:21:25', '2025-11-09 22:59:05');
INSERT INTO `cdkey_stock` VALUES (47, 4, '62f292ea-46e8-4990-b293-55dd14ab62c2', 0, NULL, NULL, '2025-11-07 21:21:25', '2025-11-07 21:21:25');
INSERT INTO `cdkey_stock` VALUES (48, 5, '1553aecf-8e7c-4056-92d9-339e9faaa399', 0, NULL, NULL, '2025-11-07 21:21:26', '2025-11-07 21:21:25');
INSERT INTO `cdkey_stock` VALUES (49, 6, '0c72c78b-1806-4fb7-a3dc-2ace50c68953', 0, NULL, NULL, '2025-11-07 21:21:26', '2025-11-07 21:21:25');
INSERT INTO `cdkey_stock` VALUES (50, 7, 'd3a9e99c-be80-4a97-9e97-710f4e7fe870', 0, NULL, NULL, '2025-11-07 21:21:26', '2025-11-07 21:21:25');
INSERT INTO `cdkey_stock` VALUES (51, 8, '3778d8bb-4d3c-4ba8-84f9-cf26d9660b8e', 0, NULL, NULL, '2025-11-07 21:21:26', '2025-11-07 21:21:25');
INSERT INTO `cdkey_stock` VALUES (52, 9, 'c4893205-0590-4ae9-af93-0a0aae3767e3', 0, NULL, NULL, '2025-11-07 21:21:26', '2025-11-07 21:21:25');
INSERT INTO `cdkey_stock` VALUES (53, 10, '2adeb2db-c498-4d0d-a7a8-affa91d0fcdd', 0, NULL, NULL, '2025-11-07 21:21:26', '2025-11-07 21:21:25');
INSERT INTO `cdkey_stock` VALUES (54, 11, '97c612cc-4047-4236-ad95-80bb9f1d276e', 0, NULL, NULL, '2025-11-07 21:21:26', '2025-11-07 21:21:25');
INSERT INTO `cdkey_stock` VALUES (55, 12, '64b90b7b-4b27-4beb-b46d-e5c720b2c23f', 0, NULL, NULL, '2025-11-07 21:21:26', '2025-11-07 21:21:25');
INSERT INTO `cdkey_stock` VALUES (56, 13, '6f10fdcd-991b-454f-992b-c5597b0a97bf', 0, NULL, NULL, '2025-11-07 21:21:26', '2025-11-07 21:21:25');
INSERT INTO `cdkey_stock` VALUES (57, 14, '0cd04738-7438-4071-b365-790abdb1c640', 0, NULL, NULL, '2025-11-07 21:21:26', '2025-11-07 21:21:26');
INSERT INTO `cdkey_stock` VALUES (58, 15, '19111198-fa34-4dac-bace-a68c87fceca3', 0, NULL, NULL, '2025-11-07 21:21:26', '2025-11-07 21:21:26');
INSERT INTO `cdkey_stock` VALUES (59, 16, '5c81e9a4-08c9-4c72-81e8-67d32dfede5d', 0, NULL, NULL, '2025-11-07 21:21:26', '2025-11-07 21:21:26');
INSERT INTO `cdkey_stock` VALUES (60, 17, '7a235aa0-4ffc-487b-b4fa-b308fe87a984', 0, NULL, NULL, '2025-11-07 21:21:26', '2025-11-07 21:21:26');
INSERT INTO `cdkey_stock` VALUES (61, 18, 'b4d63d5a-56b0-44a4-9746-75b04fea711e', 0, NULL, NULL, '2025-11-07 21:21:26', '2025-11-07 21:21:26');
INSERT INTO `cdkey_stock` VALUES (62, 19, '572614a3-30c2-450e-914c-a37f1d6815d5', 0, NULL, NULL, '2025-11-07 21:21:26', '2025-11-07 21:21:26');
INSERT INTO `cdkey_stock` VALUES (63, 20, '76360e67-f14b-4235-96fe-d78c7172db0d', 0, NULL, NULL, '2025-11-07 21:21:26', '2025-11-07 21:21:26');
INSERT INTO `cdkey_stock` VALUES (64, 1, '32222aaf-67e3-4ff5-8f1c-b7dd1289243c', 1, 25, 1, '2025-11-07 21:21:26', '2025-11-07 21:27:42');
INSERT INTO `cdkey_stock` VALUES (65, 2, 'ed4b5589-818d-4768-bd89-35fdc0856b72', 1, 32, 1, '2025-11-07 21:21:26', '2025-11-09 23:52:44');
INSERT INTO `cdkey_stock` VALUES (66, 3, 'c29288a4-1d51-4f43-9d7d-397fe9fdc30f', 0, NULL, NULL, '2025-11-07 21:21:26', '2025-11-07 21:21:26');
INSERT INTO `cdkey_stock` VALUES (67, 4, 'fb4d73bf-171c-4a55-8f4c-b943386c5351', 0, NULL, NULL, '2025-11-07 21:21:26', '2025-11-07 21:21:26');
INSERT INTO `cdkey_stock` VALUES (68, 5, '8d92a1b6-36bc-40c4-9881-4d27e428d601', 0, NULL, NULL, '2025-11-07 21:21:27', '2025-11-07 21:21:26');
INSERT INTO `cdkey_stock` VALUES (69, 6, 'f58aaa3b-9595-4f25-923a-0dd49816718e', 0, NULL, NULL, '2025-11-07 21:21:27', '2025-11-07 21:21:26');
INSERT INTO `cdkey_stock` VALUES (70, 7, '92aea885-c15c-4d46-808e-bea151a462a9', 0, NULL, NULL, '2025-11-07 21:21:27', '2025-11-07 21:21:26');
INSERT INTO `cdkey_stock` VALUES (71, 8, '10b1dce6-2e88-497f-a038-29a3577e339a', 1, 31, 1, '2025-11-07 21:21:27', '2025-11-09 22:59:05');
INSERT INTO `cdkey_stock` VALUES (72, 9, 'a7dd2e35-75c0-4bcb-897c-93520f7829a1', 0, NULL, NULL, '2025-11-07 21:21:27', '2025-11-07 21:21:26');
INSERT INTO `cdkey_stock` VALUES (73, 10, 'b92c4b3b-da5b-4465-8037-2860b43aa825', 0, NULL, NULL, '2025-11-07 21:21:27', '2025-11-07 21:21:26');
INSERT INTO `cdkey_stock` VALUES (74, 11, 'a3f7db74-4170-46a0-9635-2e0b7f7b45d2', 0, NULL, NULL, '2025-11-07 21:21:27', '2025-11-07 21:21:26');
INSERT INTO `cdkey_stock` VALUES (75, 12, '12aee42e-075e-4d80-b0ca-ff9f70f529e1', 1, 32, 1, '2025-11-07 21:21:27', '2025-11-09 23:52:44');
INSERT INTO `cdkey_stock` VALUES (76, 13, 'dce0b41a-bfba-4602-a4d8-a7d6bdd487bd', 0, NULL, NULL, '2025-11-07 21:21:27', '2025-11-07 21:21:26');
INSERT INTO `cdkey_stock` VALUES (77, 14, 'a6f76580-3e2b-44f1-b5f0-042ed1b6976c', 0, NULL, NULL, '2025-11-07 21:21:27', '2025-11-07 21:21:26');
INSERT INTO `cdkey_stock` VALUES (78, 15, '9258bebb-f9a3-4463-b4e0-dcbb35de8639', 0, NULL, NULL, '2025-11-07 21:21:27', '2025-11-07 21:21:27');
INSERT INTO `cdkey_stock` VALUES (79, 16, 'd25e1560-e09c-49a9-a6c1-b2acb986079a', 0, NULL, NULL, '2025-11-07 21:21:27', '2025-11-07 21:21:27');
INSERT INTO `cdkey_stock` VALUES (80, 17, 'ad13269a-e6df-450e-989c-792ac953a651', 0, NULL, NULL, '2025-11-07 21:21:27', '2025-11-07 21:21:27');
INSERT INTO `cdkey_stock` VALUES (81, 18, '04579b49-6e83-4260-9e78-91af218ebcba', 0, NULL, NULL, '2025-11-07 21:21:27', '2025-11-07 21:21:27');
INSERT INTO `cdkey_stock` VALUES (82, 19, '43c0d82d-c70e-4172-9710-f9ad1e1f62b5', 0, NULL, NULL, '2025-11-07 21:21:27', '2025-11-07 21:21:27');
INSERT INTO `cdkey_stock` VALUES (83, 20, 'bc0978f6-9479-4f53-b033-4eace820174f', 0, NULL, NULL, '2025-11-07 21:21:27', '2025-11-07 21:21:27');
INSERT INTO `cdkey_stock` VALUES (84, 1, 'c4850388-973e-48cc-9000-7dcfa65ddfeb', 0, NULL, NULL, '2025-11-07 21:21:27', '2025-11-07 21:21:27');
INSERT INTO `cdkey_stock` VALUES (85, 2, '9fa75e83-ab3b-46a2-9781-ef45ff7e5baf', 1, 29, 1, '2025-11-07 21:21:27', '2025-11-09 22:50:39');
INSERT INTO `cdkey_stock` VALUES (86, 3, 'a3add4a0-fdcd-44eb-8d4c-d8fc3b1c75c3', 0, NULL, NULL, '2025-11-07 21:21:27', '2025-11-07 21:21:27');
INSERT INTO `cdkey_stock` VALUES (87, 4, '2538fcae-961a-455f-a163-4c646847c237', 1, 31, 1, '2025-11-07 21:21:28', '2025-11-09 22:59:05');
INSERT INTO `cdkey_stock` VALUES (88, 5, '434897e6-c030-4603-9a32-fb76091c4e6e', 0, NULL, NULL, '2025-11-07 21:21:28', '2025-11-07 21:21:27');
INSERT INTO `cdkey_stock` VALUES (89, 6, '821ff3d1-744d-42f9-b43f-b30a24433742', 0, NULL, NULL, '2025-11-07 21:21:28', '2025-11-07 21:21:27');
INSERT INTO `cdkey_stock` VALUES (90, 7, '2f80c738-81a0-4367-b714-06f7ed3b3dfb', 1, 32, 1, '2025-11-07 21:21:28', '2025-11-09 23:52:44');
INSERT INTO `cdkey_stock` VALUES (91, 8, '8ae6d1e3-481c-4051-8209-f7f0ee2a6523', 0, NULL, NULL, '2025-11-07 21:21:28', '2025-11-07 21:21:27');
INSERT INTO `cdkey_stock` VALUES (92, 9, '564d8b0e-9c73-4295-9fce-6780ce760add', 0, NULL, NULL, '2025-11-07 21:21:28', '2025-11-07 21:21:27');
INSERT INTO `cdkey_stock` VALUES (93, 10, '74ed9770-457b-42af-958a-0b56a8e4c7b0', 0, NULL, NULL, '2025-11-07 21:21:28', '2025-11-07 21:21:27');
INSERT INTO `cdkey_stock` VALUES (94, 11, '523e42ed-45df-4399-87cf-9e399fa4347f', 0, NULL, NULL, '2025-11-07 21:21:28', '2025-11-07 21:21:27');
INSERT INTO `cdkey_stock` VALUES (95, 12, '99af41ff-9f41-4838-a39e-6320edfb3aa7', 0, NULL, NULL, '2025-11-07 21:21:28', '2025-11-07 21:21:27');
INSERT INTO `cdkey_stock` VALUES (96, 13, '5ba7fb46-f88a-4f79-9bcd-a70e8a2f8a0c', 0, NULL, NULL, '2025-11-07 21:21:28', '2025-11-07 21:21:27');
INSERT INTO `cdkey_stock` VALUES (97, 14, '4f8627c5-a825-413b-a408-63c5f495fa23', 0, NULL, NULL, '2025-11-07 21:21:28', '2025-11-07 21:21:27');
INSERT INTO `cdkey_stock` VALUES (98, 15, '121a957c-8809-41c0-a6ea-93bf9a2725f0', 0, NULL, NULL, '2025-11-07 21:21:28', '2025-11-07 21:21:28');
INSERT INTO `cdkey_stock` VALUES (99, 16, '4fdf87db-d130-48ca-b1f9-d69c6fa6da68', 0, NULL, NULL, '2025-11-07 21:21:28', '2025-11-07 21:21:28');
INSERT INTO `cdkey_stock` VALUES (100, 17, '442f226e-68cc-4c03-89c9-bbeef5efd832', 0, NULL, NULL, '2025-11-07 21:21:28', '2025-11-07 21:21:28');
INSERT INTO `cdkey_stock` VALUES (101, 18, 'c4d3329a-9de2-4062-b84d-ef130a1f7f40', 0, NULL, NULL, '2025-11-07 21:21:28', '2025-11-07 21:21:28');
INSERT INTO `cdkey_stock` VALUES (102, 19, '24d24ea6-b538-4056-b307-03c4e459dfc3', 0, NULL, NULL, '2025-11-07 21:21:28', '2025-11-07 21:21:28');
INSERT INTO `cdkey_stock` VALUES (103, 20, '61ae97c6-3478-45b6-84b6-08e75a39d9aa', 0, NULL, NULL, '2025-11-07 21:21:28', '2025-11-07 21:21:28');
INSERT INTO `cdkey_stock` VALUES (104, 1, '72f9ed05-e5f0-400b-8c74-32a38f74fe34', 0, NULL, NULL, '2025-11-07 21:21:28', '2025-11-07 21:21:28');
INSERT INTO `cdkey_stock` VALUES (105, 2, '841f4bd9-1a71-4dbe-8968-ab9422cd4d8c', 1, 28, 1, '2025-11-07 21:21:28', '2025-11-09 22:40:52');
INSERT INTO `cdkey_stock` VALUES (106, 3, '40efe158-4628-4179-afe7-b46ac4430d51', 0, NULL, NULL, '2025-11-07 21:21:28', '2025-11-07 21:21:28');
INSERT INTO `cdkey_stock` VALUES (107, 4, '5d478958-663b-4723-8b4a-b2ab1c448ad7', 0, NULL, NULL, '2025-11-07 21:21:28', '2025-11-07 21:21:28');
INSERT INTO `cdkey_stock` VALUES (108, 5, '3ed42295-f05f-4eef-ace8-f483e8452c76', 0, NULL, NULL, '2025-11-07 21:21:29', '2025-11-07 21:21:28');
INSERT INTO `cdkey_stock` VALUES (109, 6, '603aba19-5189-4b2f-af4a-5b0d468804ce', 0, NULL, NULL, '2025-11-07 21:21:29', '2025-11-07 21:21:28');
INSERT INTO `cdkey_stock` VALUES (110, 7, 'ea4002c6-5fb6-4e9d-9192-1e3a0abd1f65', 0, NULL, NULL, '2025-11-07 21:21:29', '2025-11-07 21:21:28');
INSERT INTO `cdkey_stock` VALUES (111, 8, '89063582-34fa-403f-b9d8-1179bb8a674d', 0, NULL, NULL, '2025-11-07 21:21:29', '2025-11-07 21:21:28');
INSERT INTO `cdkey_stock` VALUES (112, 9, 'fdc66a2e-8631-415d-b24b-4afcdd8a48f4', 0, NULL, NULL, '2025-11-07 21:21:29', '2025-11-07 21:21:28');
INSERT INTO `cdkey_stock` VALUES (113, 10, '30716054-8229-4e79-a260-6603c4f589c6', 0, NULL, NULL, '2025-11-07 21:21:29', '2025-11-07 21:21:28');
INSERT INTO `cdkey_stock` VALUES (114, 11, '400c9192-9b1f-4efb-88e7-519c6b925146', 0, NULL, NULL, '2025-11-07 21:21:29', '2025-11-07 21:21:28');
INSERT INTO `cdkey_stock` VALUES (115, 12, 'ee93bffd-6db4-47dd-aaf4-d65b40ada93d', 0, NULL, NULL, '2025-11-07 21:21:29', '2025-11-07 21:21:28');
INSERT INTO `cdkey_stock` VALUES (116, 13, '16fbfa04-9f80-48ac-b43a-d14a09d22916', 0, NULL, NULL, '2025-11-07 21:21:29', '2025-11-07 21:21:28');
INSERT INTO `cdkey_stock` VALUES (117, 14, 'ee5b9114-9b84-453c-bedb-7a3eef315123', 0, NULL, NULL, '2025-11-07 21:21:29', '2025-11-07 21:21:28');
INSERT INTO `cdkey_stock` VALUES (118, 15, '2c87ccff-0adb-4a44-89a2-076d9728b22c', 0, NULL, NULL, '2025-11-07 21:21:29', '2025-11-07 21:21:29');
INSERT INTO `cdkey_stock` VALUES (119, 16, 'c8398c70-3cde-4b83-aa94-e07d1a4fba24', 0, NULL, NULL, '2025-11-07 21:21:29', '2025-11-07 21:21:29');
INSERT INTO `cdkey_stock` VALUES (120, 17, '63134329-6b9e-4574-9531-4b2e0052be03', 0, NULL, NULL, '2025-11-07 21:21:29', '2025-11-07 21:21:29');
INSERT INTO `cdkey_stock` VALUES (121, 18, '334734d8-c56a-4846-bbef-8a005c81bfff', 0, NULL, NULL, '2025-11-07 21:21:29', '2025-11-07 21:21:29');
INSERT INTO `cdkey_stock` VALUES (122, 19, '1378595b-bea4-4552-8b62-4cf6149c753a', 0, NULL, NULL, '2025-11-07 21:21:29', '2025-11-07 21:21:29');
INSERT INTO `cdkey_stock` VALUES (123, 20, '243308bf-44f2-4c5f-bebb-2ba1f01143a2', 0, NULL, NULL, '2025-11-07 21:21:29', '2025-11-07 21:21:29');
INSERT INTO `cdkey_stock` VALUES (124, 1, '9b5e1e99-6015-4a67-a9f7-bd16c1543eec', 0, NULL, NULL, '2025-11-07 21:21:29', '2025-11-07 21:21:29');
INSERT INTO `cdkey_stock` VALUES (125, 2, 'c7e775d8-9dfc-4377-a624-e039cb5b1e1d', 1, 31, 1, '2025-11-07 21:21:29', '2025-11-09 22:59:05');
INSERT INTO `cdkey_stock` VALUES (126, 3, '06d40de5-95b7-4524-928f-7b7ad6a634d6', 0, NULL, NULL, '2025-11-07 21:21:29', '2025-11-07 21:21:29');
INSERT INTO `cdkey_stock` VALUES (127, 4, 'db8450ee-fcdd-4277-8ed6-b15a91408af1', 0, NULL, NULL, '2025-11-07 21:21:29', '2025-11-07 21:21:29');
INSERT INTO `cdkey_stock` VALUES (128, 5, 'ef5495f3-1954-452f-8e79-109a7eb2a402', 0, NULL, NULL, '2025-11-07 21:21:30', '2025-11-07 21:21:29');
INSERT INTO `cdkey_stock` VALUES (129, 6, '30a15f66-000b-422a-86b6-f78b6cde135c', 0, NULL, NULL, '2025-11-07 21:21:30', '2025-11-07 21:21:29');
INSERT INTO `cdkey_stock` VALUES (130, 7, '7219f148-fbbb-4dd4-b11c-4d8b5813a0f2', 0, NULL, NULL, '2025-11-07 21:21:30', '2025-11-07 21:21:29');
INSERT INTO `cdkey_stock` VALUES (131, 8, '861c0ee5-1af4-4c90-955a-c01f549aaa80', 0, NULL, NULL, '2025-11-07 21:21:30', '2025-11-07 21:21:29');
INSERT INTO `cdkey_stock` VALUES (132, 9, 'db66f808-653b-4ce2-9e26-d1c5664eb3bc', 0, NULL, NULL, '2025-11-07 21:21:30', '2025-11-07 21:21:29');
INSERT INTO `cdkey_stock` VALUES (133, 10, '141f7096-1493-413c-8d5a-4e083a520630', 1, 31, 1, '2025-11-07 21:21:30', '2025-11-09 22:59:05');
INSERT INTO `cdkey_stock` VALUES (134, 11, 'ee1dd622-0a76-4e80-b215-ebe5c418f3ee', 0, NULL, NULL, '2025-11-07 21:21:30', '2025-11-07 21:21:29');
INSERT INTO `cdkey_stock` VALUES (135, 12, '4dce6387-6ad9-4028-9303-4511f2c02069', 0, NULL, NULL, '2025-11-07 21:21:30', '2025-11-07 21:21:29');
INSERT INTO `cdkey_stock` VALUES (136, 13, '1473d38f-c727-43af-906e-9addf8d99ec3', 0, NULL, NULL, '2025-11-07 21:21:30', '2025-11-07 21:21:29');
INSERT INTO `cdkey_stock` VALUES (137, 14, '1523f263-c512-4e5c-84f7-7ca42e8a7bc3', 0, NULL, NULL, '2025-11-07 21:21:30', '2025-11-07 21:21:29');
INSERT INTO `cdkey_stock` VALUES (138, 15, '318b3990-3b86-4797-a4dd-3351bf8cf08b', 0, NULL, NULL, '2025-11-07 21:21:30', '2025-11-07 21:21:29');
INSERT INTO `cdkey_stock` VALUES (139, 16, 'edd4f3c0-4d83-4bf3-8cdd-a34180990ccc', 0, NULL, NULL, '2025-11-07 21:21:30', '2025-11-07 21:21:30');
INSERT INTO `cdkey_stock` VALUES (140, 17, '14375e17-9f38-4cf2-86b6-222a87c91574', 0, NULL, NULL, '2025-11-07 21:21:30', '2025-11-07 21:21:30');
INSERT INTO `cdkey_stock` VALUES (141, 18, '362b6916-3788-4d47-a832-1eaa6575756a', 0, NULL, NULL, '2025-11-07 21:21:30', '2025-11-07 21:21:30');
INSERT INTO `cdkey_stock` VALUES (142, 19, '23256f24-329b-46c0-85bd-7110815d05bc', 0, NULL, NULL, '2025-11-07 21:21:30', '2025-11-07 21:21:30');
INSERT INTO `cdkey_stock` VALUES (143, 20, '1b6aa6eb-e8b7-4e5e-a269-02b8881fff46', 0, NULL, NULL, '2025-11-07 21:21:30', '2025-11-07 21:21:30');

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment`  (
  `comment_id` int NOT NULL AUTO_INCREMENT COMMENT '评论ID',
  `post_id` int NULL DEFAULT NULL COMMENT '帖子 id',
  `user_id` int NOT NULL COMMENT '用户ID',
  `game_id` int NULL DEFAULT NULL COMMENT '游戏ID',
  `rating` decimal(2, 1) NULL DEFAULT NULL COMMENT '评分',
  `comment_text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '评论内容',
  `parent_comment_id` int NULL DEFAULT NULL COMMENT '父评论ID',
  `status` int NULL DEFAULT 0 COMMENT '状态，0表示正常，1表示异常',
  `version` int NULL DEFAULT 1 COMMENT '版本控制',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`comment_id`) USING BTREE,
  INDEX `fk_comment_user`(`user_id` ASC) USING BTREE,
  INDEX `fk_comment_game`(`game_id` ASC) USING BTREE,
  INDEX `fk_comment_post`(`post_id` ASC) USING BTREE,
  CONSTRAINT `fk_comment_game` FOREIGN KEY (`game_id`) REFERENCES `game` (`game_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_comment_post` FOREIGN KEY (`post_id`) REFERENCES `post` (`post_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_comment_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

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
  `community_id` int NOT NULL AUTO_INCREMENT COMMENT '社区ID',
  `community_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '社区名称',
  `community_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '社区描述',
  `status` int NULL DEFAULT 0 COMMENT '状态，0表示正常，1表示异常',
  `version` int NULL DEFAULT 1 COMMENT '版本控制',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`community_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 101 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

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
INSERT INTO `community` VALUES (21, 'Dragon Quest', '这是Dragon Quest的讨论组!', 0, 1, '2025-11-08 11:36:07', '2025-11-08 11:36:07');
INSERT INTO `community` VALUES (22, 'Call of Duty', '这是Call of Duty的讨论组!', 0, 1, '2025-11-08 11:36:08', '2025-11-08 11:36:08');
INSERT INTO `community` VALUES (23, 'League of Heroes', '这是League of Heroes的讨论组!', 0, 1, '2025-11-08 11:36:08', '2025-11-08 11:36:08');
INSERT INTO `community` VALUES (24, 'FIFA 21', '这是FIFA 21的讨论组!', 0, 1, '2025-11-08 11:36:08', '2025-11-08 11:36:08');
INSERT INTO `community` VALUES (25, 'Civilization VI', '这是Civilization VI的讨论组!', 0, 1, '2025-11-08 11:36:08', '2025-11-08 11:36:08');
INSERT INTO `community` VALUES (26, 'Tomb Raider', '这是Tomb Raider的讨论组!', 0, 1, '2025-11-08 11:36:08', '2025-11-08 11:36:08');
INSERT INTO `community` VALUES (27, 'Need for Speed', '这是Need for Speed的讨论组!', 0, 1, '2025-11-08 11:36:08', '2025-11-08 11:36:08');
INSERT INTO `community` VALUES (28, 'Candy Crush', '这是Candy Crush的讨论组!', 0, 1, '2025-11-08 11:36:09', '2025-11-08 11:36:09');
INSERT INTO `community` VALUES (29, 'Hearthstone', '这是Hearthstone的讨论组!', 0, 1, '2025-11-08 11:36:09', '2025-11-08 11:36:09');
INSERT INTO `community` VALUES (30, 'SimCity', '这是SimCity的讨论组!', 0, 1, '2025-11-08 11:36:09', '2025-11-08 11:36:09');
INSERT INTO `community` VALUES (31, 'Among Us', '这是Among Us的讨论组!', 0, 1, '2025-11-08 11:36:09', '2025-11-08 11:36:09');
INSERT INTO `community` VALUES (32, 'Minecraft', '这是Minecraft的讨论组!', 0, 1, '2025-11-08 11:36:09', '2025-11-08 11:36:09');
INSERT INTO `community` VALUES (33, 'Rust', '这是Rust的讨论组!', 0, 1, '2025-11-08 11:36:09', '2025-11-08 11:36:09');
INSERT INTO `community` VALUES (34, 'Resident Evil 7', '这是Resident Evil 7的讨论组!', 0, 1, '2025-11-08 11:36:09', '2025-11-08 11:36:09');
INSERT INTO `community` VALUES (35, 'World of Warcraft', '这是World of Warcraft的讨论组!', 0, 1, '2025-11-08 11:36:09', '2025-11-08 11:36:09');
INSERT INTO `community` VALUES (36, 'Beat Saber', '这是Beat Saber的讨论组!', 0, 1, '2025-11-08 11:36:09', '2025-11-08 11:36:09');
INSERT INTO `community` VALUES (37, 'Tekken 7', '这是Tekken 7的讨论组!', 0, 1, '2025-11-08 11:36:09', '2025-11-08 11:36:09');
INSERT INTO `community` VALUES (38, 'Catan', '这是Catan的讨论组!', 0, 1, '2025-11-08 11:36:09', '2025-11-08 11:36:09');
INSERT INTO `community` VALUES (39, 'Dark Souls III', '这是Dark Souls III的讨论组!', 0, 1, '2025-11-08 11:36:09', '2025-11-08 11:36:09');
INSERT INTO `community` VALUES (40, 'Cyberpunk 2077', '这是Cyberpunk 2077的讨论组!', 0, 1, '2025-11-08 11:36:09', '2025-11-08 11:36:09');
INSERT INTO `community` VALUES (41, 'The Witcher 3: Wild Hunt', '这是The Witcher 3: Wild Hunt的讨论组!', 0, 1, '2025-11-08 11:36:09', '2025-11-08 11:36:09');
INSERT INTO `community` VALUES (42, 'Grand Theft Auto V', '这是Grand Theft Auto V的讨论组!', 0, 1, '2025-11-08 11:36:09', '2025-11-08 11:36:09');
INSERT INTO `community` VALUES (43, 'Red Dead Redemption 2', '这是Red Dead Redemption 2的讨论组!', 0, 1, '2025-11-08 11:36:09', '2025-11-08 11:36:09');
INSERT INTO `community` VALUES (44, 'Minecraft', '这是Minecraft的讨论组!', 0, 1, '2025-11-08 11:36:09', '2025-11-08 11:36:09');
INSERT INTO `community` VALUES (45, 'Cyberpunk 2077', '这是Cyberpunk 2077的讨论组!', 0, 1, '2025-11-08 11:36:09', '2025-11-08 11:36:09');
INSERT INTO `community` VALUES (46, 'The Elder Scrolls V: Skyrim', '这是The Elder Scrolls V: Skyrim的讨论组!', 0, 1, '2025-11-08 11:36:09', '2025-11-08 11:36:09');
INSERT INTO `community` VALUES (47, 'Assassin\'s Creed Valhalla', '这是Assassin\'s Creed Valhalla的讨论组!', 0, 1, '2025-11-08 11:36:09', '2025-11-08 11:36:09');
INSERT INTO `community` VALUES (48, 'Call of Duty: Warzone', '这是Call of Duty: Warzone的讨论组!', 0, 1, '2025-11-08 11:36:09', '2025-11-08 11:36:09');
INSERT INTO `community` VALUES (49, 'Fortnite', '这是Fortnite的讨论组!', 0, 1, '2025-11-08 11:36:09', '2025-11-08 11:36:09');
INSERT INTO `community` VALUES (50, 'Among Us', '这是Among Us的讨论组!', 0, 1, '2025-11-08 11:36:09', '2025-11-08 11:36:09');
INSERT INTO `community` VALUES (51, 'Fall Guys', '这是Fall Guys的讨论组!', 0, 1, '2025-11-08 11:36:09', '2025-11-08 11:36:09');
INSERT INTO `community` VALUES (52, 'Battlefield V', '这是Battlefield V的讨论组!', 0, 1, '2025-11-08 11:36:09', '2025-11-08 11:36:09');
INSERT INTO `community` VALUES (53, 'Horizon Zero Dawn', '这是Horizon Zero Dawn的讨论组!', 0, 1, '2025-11-08 11:36:09', '2025-11-08 11:36:09');
INSERT INTO `community` VALUES (54, 'FIFA 22', '这是FIFA 22的讨论组!', 0, 1, '2025-11-08 11:36:10', '2025-11-08 11:36:10');
INSERT INTO `community` VALUES (55, 'Sekiro: Shadows Die Twice', '这是Sekiro: Shadows Die Twice的讨论组!', 0, 1, '2025-11-08 11:36:10', '2025-11-08 11:36:10');
INSERT INTO `community` VALUES (56, 'The Last of Us Part II', '这是The Last of Us Part II的讨论组!', 0, 1, '2025-11-08 11:36:10', '2025-11-08 11:36:10');
INSERT INTO `community` VALUES (57, 'Ghost of Tsushima', '这是Ghost of Tsushima的讨论组!', 0, 1, '2025-11-08 11:36:10', '2025-11-08 11:36:10');
INSERT INTO `community` VALUES (58, 'The Legend of Zelda: Breath of the Wild', '这是The Legend of Zelda: Breath of the Wild的讨论组!', 0, 1, '2025-11-08 11:36:10', '2025-11-08 11:36:10');
INSERT INTO `community` VALUES (59, 'Super Mario Odyssey', '这是Super Mario Odyssey的讨论组!', 0, 1, '2025-11-08 11:36:10', '2025-11-08 11:36:10');
INSERT INTO `community` VALUES (60, 'Animal Crossing: New Horizons', '这是Animal Crossing: New Horizons的讨论组!', 0, 1, '2025-11-08 11:36:10', '2025-11-08 11:36:10');
INSERT INTO `community` VALUES (61, 'Apex Legends', '这是Apex Legends的讨论组!', 0, 1, '2025-11-08 11:36:10', '2025-11-08 11:36:10');
INSERT INTO `community` VALUES (62, 'Overwatch', '这是Overwatch的讨论组!', 0, 1, '2025-11-08 11:36:10', '2025-11-08 11:36:10');
INSERT INTO `community` VALUES (63, 'World of Warcraft', '这是World of Warcraft的讨论组!', 0, 1, '2025-11-08 11:36:10', '2025-11-08 11:36:10');
INSERT INTO `community` VALUES (64, 'The Sims 4', '这是The Sims 4的讨论组!', 0, 1, '2025-11-08 11:36:10', '2025-11-08 11:36:10');
INSERT INTO `community` VALUES (65, 'Monster Hunter: World', '这是Monster Hunter: World的讨论组!', 0, 1, '2025-11-08 11:36:10', '2025-11-08 11:36:10');
INSERT INTO `community` VALUES (66, 'Dark Souls III', '这是Dark Souls III的讨论组!', 0, 1, '2025-11-08 11:36:10', '2025-11-08 11:36:10');
INSERT INTO `community` VALUES (67, 'Destiny 2', '这是Destiny 2的讨论组!', 0, 1, '2025-11-08 11:36:10', '2025-11-08 11:36:10');
INSERT INTO `community` VALUES (68, 'Doom Eternal', '这是Doom Eternal的讨论组!', 0, 1, '2025-11-08 11:36:10', '2025-11-08 11:36:10');
INSERT INTO `community` VALUES (69, 'Halo: The Master Chief Collection', '这是Halo: The Master Chief Collection的讨论组!', 0, 1, '2025-11-08 11:36:10', '2025-11-08 11:36:10');
INSERT INTO `community` VALUES (70, 'No Man\'s Sky', '这是No Man\'s Sky的讨论组!', 0, 1, '2025-11-08 11:36:10', '2025-11-08 11:36:10');
INSERT INTO `community` VALUES (71, 'Dead by Daylight', '这是Dead by Daylight的讨论组!', 0, 1, '2025-11-08 11:36:10', '2025-11-08 11:36:10');
INSERT INTO `community` VALUES (72, 'Rocket League', '这是Rocket League的讨论组!', 0, 1, '2025-11-08 11:36:10', '2025-11-08 11:36:10');
INSERT INTO `community` VALUES (73, 'Spelunky 2', '这是Spelunky 2的讨论组!', 0, 1, '2025-11-08 11:36:10', '2025-11-08 11:36:10');
INSERT INTO `community` VALUES (74, 'Monster Hunter Rise', '这是Monster Hunter Rise的讨论组!', 0, 1, '2025-11-08 11:36:10', '2025-11-08 11:36:10');
INSERT INTO `community` VALUES (75, 'Hitman 3', '这是Hitman 3的讨论组!', 0, 1, '2025-11-08 11:36:10', '2025-11-08 11:36:10');
INSERT INTO `community` VALUES (76, 'Resident Evil Village', '这是Resident Evil Village的讨论组!', 0, 1, '2025-11-08 11:36:10', '2025-11-08 11:36:10');
INSERT INTO `community` VALUES (77, 'F1 2021', '这是F1 2021的讨论组!', 0, 1, '2025-11-08 11:36:10', '2025-11-08 11:36:10');
INSERT INTO `community` VALUES (78, 'NBA 2K21', '这是NBA 2K21的讨论组!', 0, 1, '2025-11-08 11:36:10', '2025-11-08 11:36:10');
INSERT INTO `community` VALUES (79, 'Borderlands 3', '这是Borderlands 3的讨论组!', 0, 1, '2025-11-08 11:36:10', '2025-11-08 11:36:10');
INSERT INTO `community` VALUES (80, 'FIFA 21 Players', 'FIFA 21 玩家交流社区，分享游戏技巧、球员搭配、赛事讨论等内容', 1, 1, '2025-11-08 16:23:14', '2025-11-08 16:23:14');
INSERT INTO `community` VALUES (81, 'RPG Lovers', 'RPG游戏爱好者社区', 0, 1, '2025-11-08 10:23:45', '2025-11-08 10:23:45');
INSERT INTO `community` VALUES (82, 'Open World Fans', '开放世界游戏粉丝社区', 0, 1, '2025-11-07 19:56:12', '2025-11-07 19:56:12');
INSERT INTO `community` VALUES (83, 'Survival Gamers', '生存游戏玩家社区', 0, 1, '2025-11-07 14:30:22', '2025-11-07 14:30:22');
INSERT INTO `community` VALUES (84, 'MMORPG Hub', '大型多人在线角色扮演游戏中心', 0, 1, '2025-11-06 21:15:33', '2025-11-06 21:15:33');
INSERT INTO `community` VALUES (85, 'Strategy Masters', '策略游戏大师社区', 0, 1, '2025-11-06 10:08:55', '2025-11-06 10:08:55');
INSERT INTO `community` VALUES (86, 'Horror Club', '恐怖游戏俱乐部', 0, 1, '2025-11-05 23:40:11', '2025-11-05 23:40:11');
INSERT INTO `community` VALUES (87, 'Shooter Arena', '射击游戏竞技场', 0, 1, '2025-11-05 16:22:33', '2025-11-05 16:22:33');
INSERT INTO `community` VALUES (88, 'Sports Gamers', '体育游戏玩家社区', 0, 1, '2025-11-04 19:50:44', '2025-11-04 19:50:44');
INSERT INTO `community` VALUES (89, 'Adventure Seekers', '冒险游戏探索者社区', 0, 1, '2025-11-04 11:35:22', '2025-11-04 11:35:22');
INSERT INTO `community` VALUES (90, 'Racing Legends', '赛车游戏传奇社区', 0, 1, '2025-11-03 20:18:55', '2025-11-03 20:18:55');
INSERT INTO `community` VALUES (91, 'Puzzle Gamers', '益智游戏玩家社区', 0, 1, '2025-11-03 09:42:11', '2025-11-03 09:42:11');
INSERT INTO `community` VALUES (92, 'Card Battles', '卡牌对战游戏社区', 0, 1, '2025-11-02 17:25:33', '2025-11-02 17:25:33');
INSERT INTO `community` VALUES (93, 'City Builders', '城市建造游戏社区', 0, 1, '2025-11-02 13:10:44', '2025-11-02 13:10:44');
INSERT INTO `community` VALUES (94, 'Party Games', '派对游戏社区', 0, 1, '2025-11-01 22:05:11', '2025-11-01 22:05:11');
INSERT INTO `community` VALUES (95, 'Creators Guild', '创作者公会', 0, 1, '2025-11-01 15:38:22', '2025-11-01 15:38:22');
INSERT INTO `community` VALUES (96, 'Fighting Arena', '格斗游戏竞技场', 0, 1, '2025-10-31 18:50:33', '2025-10-31 18:50:33');
INSERT INTO `community` VALUES (97, 'Board Gamers', '桌面游戏玩家社区', 0, 1, '2025-10-31 10:22:55', '2025-10-31 10:22:55');
INSERT INTO `community` VALUES (98, 'Souls Fans', '魂类游戏粉丝社区', 0, 1, '2025-10-30 21:17:11', '2025-10-30 21:17:11');
INSERT INTO `community` VALUES (99, 'RPG Elite', '精英RPG玩家社区', 0, 1, '2025-10-30 16:40:22', '2025-10-30 16:40:22');
INSERT INTO `community` VALUES (100, 'Open World Elite', '精英开放世界玩家社区', 0, 1, '2025-10-29 19:33:44', '2025-10-29 19:33:44');

-- ----------------------------
-- Table structure for game
-- ----------------------------
DROP TABLE IF EXISTS `game`;
CREATE TABLE `game`  (
  `game_id` int NOT NULL AUTO_INCREMENT COMMENT '游戏ID',
  `game_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '游戏名称',
  `game_original_price` decimal(10, 2) NOT NULL COMMENT '游戏原始价格',
  `release_date` date NULL DEFAULT NULL COMMENT '游戏发行日期',
  `status` int NULL DEFAULT 0 COMMENT '游戏状态,0表示可获取,1表示下架',
  `main_image_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '主图片 URL',
  `version` int NULL DEFAULT 1 COMMENT '版本控制',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `total_stock` int NULL DEFAULT NULL COMMENT '总库存',
  `remain_stock` int NULL DEFAULT NULL COMMENT '剩余库存',
  PRIMARY KEY (`game_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 61 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of game
-- ----------------------------
INSERT INTO `game` VALUES (1, 'Dragon Quest', 59.99, '2020-01-01', 0, '1.jpg', 1, '2020-01-01 10:00:00', '2025-11-09 22:59:04', 5, 8);
INSERT INTO `game` VALUES (2, 'Call of Duty', 69.99, '2021-11-11', 0, '2.jpg', 1, '2021-11-11 15:00:00', '2025-11-09 23:52:43', 5, 5);
INSERT INTO `game` VALUES (3, 'League of Heroes', 0.00, '2019-09-20', 0, '3.jpg', 1, '2019-09-20 09:00:00', '2025-11-09 22:59:04', 5, 9);
INSERT INTO `game` VALUES (4, 'FIFA 21', 49.99, '2020-09-25', 0, '4.jpg', 1, '2020-09-25 08:30:00', '2025-11-09 22:59:04', 5, 9);
INSERT INTO `game` VALUES (5, 'Civilization VI', 39.99, '2018-10-20', 0, '5.jpg', 1, '2018-10-20 13:00:00', '2025-11-09 14:38:59', 5, 10);
INSERT INTO `game` VALUES (6, 'Tomb Raider', 29.99, '2019-03-15', 0, '6.jpg', 1, '2019-03-15 14:00:00', '2025-11-09 14:39:00', 5, 10);
INSERT INTO `game` VALUES (7, 'Need for Speed', 19.99, '2017-08-18', 0, '7.jpg', 1, '2017-08-18 17:00:00', '2025-11-09 23:52:43', 5, 9);
INSERT INTO `game` VALUES (8, 'Candy Crush', 0.00, '2016-04-10', 0, '8.jpg', 1, '2016-04-10 12:00:00', '2025-11-09 22:59:04', 5, 9);
INSERT INTO `game` VALUES (9, 'Hearthstone', 0.00, '2018-03-01', 0, '9.jpg', 1, '2018-03-01 11:00:00', '2025-11-09 14:39:04', 5, 10);
INSERT INTO `game` VALUES (10, 'SimCity', 29.99, '2015-07-22', 0, 'simcity.jpg', 1, '2015-07-22 15:00:00', '2025-11-09 22:59:04', 5, 9);
INSERT INTO `game` VALUES (11, 'Among Us', 4.99, '2020-06-15', 0, 'amongus.jpg', 1, '2020-06-15 20:00:00', '2025-11-09 14:39:05', 5, 10);
INSERT INTO `game` VALUES (12, 'Minecraft', 26.95, '2016-05-17', 0, 'minecraft.jpg', 1, '2016-05-17 10:00:00', '2025-11-09 23:52:43', 5, 9);
INSERT INTO `game` VALUES (13, 'Rust', 34.99, '2019-12-13', 0, 'rust.jpg', 1, '2019-12-13 08:00:00', '2025-11-09 14:39:06', 5, 10);
INSERT INTO `game` VALUES (14, 'Resident Evil 7', 59.99, '2017-01-24', 0, 're7.jpg', 1, '2017-01-24 12:00:00', '2025-11-09 14:39:07', 5, 10);
INSERT INTO `game` VALUES (15, 'World of Warcraft', 0.00, '2015-11-23', 0, 'wow.jpg', 1, '2015-11-23 10:00:00', '2025-11-09 14:39:07', 5, 10);
INSERT INTO `game` VALUES (16, 'Beat Saber', 29.99, '2019-05-21', 0, 'beatsaber.jpg', 1, '2019-05-21 12:00:00', '2025-11-09 14:39:08', 5, 10);
INSERT INTO `game` VALUES (17, 'Tekken 7', 49.99, '2017-06-02', 0, 'tekken7.jpg', 1, '2017-06-02 09:00:00', '2025-11-09 14:39:09', 5, 10);
INSERT INTO `game` VALUES (18, 'Catan', 19.99, '2018-02-15', 0, 'catan.jpg', 1, '2018-02-15 13:00:00', '2025-11-09 14:39:09', 5, 10);
INSERT INTO `game` VALUES (19, 'Dark Souls III', 59.99, '2016-04-12', 0, 'ds3.jpg', 1, '2016-04-12 12:00:00', '2025-11-09 14:39:10', 5, 10);
INSERT INTO `game` VALUES (20, 'Cyberpunk 2077', 59.99, '2020-12-10', 0, 'cyberpunk2077.jpg', 1, '2020-12-10 09:00:00', '2025-11-09 14:39:12', 5, 10);
INSERT INTO `game` VALUES (21, 'The Witcher 3: Wild Hunt', 39.99, '2015-05-19', 0, 'thewitcher3.jpg', 1, '2015-05-19 12:00:00', '2025-11-07 21:18:10', 0, 0);
INSERT INTO `game` VALUES (22, 'Grand Theft Auto V', 29.99, '2015-04-14', 0, 'gtav.jpg', 1, '2015-04-14 09:00:00', '2025-11-07 21:18:10', 0, 0);
INSERT INTO `game` VALUES (23, 'Red Dead Redemption 2', 59.99, '2018-10-26', 0, 'rdr2.jpg', 1, '2018-10-26 13:00:00', '2025-11-07 21:18:10', 0, 0);
INSERT INTO `game` VALUES (24, 'Minecraft', 26.95, '2011-11-18', 0, 'minecraft.jpg', 1, '2011-11-18 15:00:00', '2025-11-07 21:18:10', 0, 0);
INSERT INTO `game` VALUES (25, 'Cyberpunk 2077', 59.99, '2020-12-10', 0, 'cyberpunk2077.jpg', 1, '2020-12-10 11:00:00', '2025-11-07 21:18:10', 0, 0);
INSERT INTO `game` VALUES (26, 'The Elder Scrolls V: Skyrim', 39.99, '2011-11-11', 0, 'skyrim.jpg', 1, '2011-11-11 10:00:00', '2025-11-07 21:18:10', 0, 0);
INSERT INTO `game` VALUES (27, 'Assassin\'s Creed Valhalla', 59.99, '2020-11-10', 0, 'acvalhalla.jpg', 1, '2020-11-10 14:00:00', '2025-11-07 21:18:10', 0, 0);
INSERT INTO `game` VALUES (28, 'Call of Duty: Warzone', 0.00, '2020-03-10', 0, 'warzone.jpg', 1, '2020-03-10 09:00:00', '2025-11-07 21:18:10', 0, 0);
INSERT INTO `game` VALUES (29, 'Fortnite', 0.00, '2017-09-26', 0, 'fortnite.jpg', 1, '2017-09-26 12:00:00', '2025-11-07 21:18:10', 0, 0);
INSERT INTO `game` VALUES (30, 'Among Us', 4.99, '2020-06-15', 0, 'amongus.jpg', 1, '2020-06-15 20:00:00', '2025-11-07 21:18:11', 0, 0);
INSERT INTO `game` VALUES (31, 'Fall Guys', 19.99, '2020-08-04', 0, 'fallguys.jpg', 1, '2020-08-04 15:00:00', '2025-11-07 21:18:11', 0, 0);
INSERT INTO `game` VALUES (32, 'Battlefield V', 39.99, '2018-11-20', 0, 'bfv.jpg', 1, '2018-11-20 11:00:00', '2025-11-07 21:18:11', 0, 0);
INSERT INTO `game` VALUES (33, 'Horizon Zero Dawn', 49.99, '2020-08-07', 0, 'horizonzerodawn.jpg', 1, '2020-08-07 14:00:00', '2025-11-07 21:18:11', 0, 0);
INSERT INTO `game` VALUES (34, 'FIFA 22', 59.99, '2021-10-01', 0, 'fifa22.jpg', 1, '2021-10-01 10:00:00', '2025-11-07 21:18:11', 0, 0);
INSERT INTO `game` VALUES (35, 'Sekiro: Shadows Die Twice', 59.99, '2019-03-22', 0, 'sekiro.jpg', 1, '2019-03-22 12:00:00', '2025-11-07 21:18:11', 0, 0);
INSERT INTO `game` VALUES (36, 'The Last of Us Part II', 59.99, '2020-06-19', 0, 'lastofus2.jpg', 1, '2020-06-19 12:00:00', '2025-11-07 21:18:11', 0, 0);
INSERT INTO `game` VALUES (37, 'Ghost of Tsushima', 59.99, '2020-07-17', 0, 'ghostoftsushima.jpg', 1, '2020-07-17 12:00:00', '2025-11-07 21:18:11', 0, 0);
INSERT INTO `game` VALUES (38, 'The Legend of Zelda: Breath of the Wild', 59.99, '2017-03-03', 0, 'zelda.jpg', 1, '2017-03-03 13:00:00', '2025-11-07 21:18:11', 0, 0);
INSERT INTO `game` VALUES (39, 'Super Mario Odyssey', 59.99, '2017-10-27', 0, 'marioodyssey.jpg', 1, '2017-10-27 09:00:00', '2025-11-07 21:18:11', 0, 0);
INSERT INTO `game` VALUES (40, 'Animal Crossing: New Horizons', 59.99, '2020-03-20', 0, 'animalcrossing.jpg', 1, '2020-03-20 10:00:00', '2025-11-07 21:18:11', 0, 0);
INSERT INTO `game` VALUES (41, 'Apex Legends', 0.00, '2019-02-04', 0, 'apexlegends.jpg', 1, '2019-02-04 11:00:00', '2025-11-07 21:18:11', 0, 0);
INSERT INTO `game` VALUES (42, 'Overwatch', 39.99, '2016-05-24', 0, 'overwatch.jpg', 1, '2016-05-24 13:00:00', '2025-11-07 21:18:11', 0, 0);
INSERT INTO `game` VALUES (43, 'World of Warcraft', 14.99, '2004-11-23', 0, 'wow.jpg', 1, '2004-11-23 12:00:00', '2025-11-07 21:18:11', 0, 0);
INSERT INTO `game` VALUES (44, 'The Sims 4', 39.99, '2014-09-02', 0, 'sims4.jpg', 1, '2014-09-02 10:00:00', '2025-11-07 21:18:11', 0, 0);
INSERT INTO `game` VALUES (45, 'Monster Hunter: World', 59.99, '2018-08-09', 0, 'monsterhunterworld.jpg', 1, '2018-08-09 13:00:00', '2025-11-07 21:18:11', 0, 0);
INSERT INTO `game` VALUES (46, 'Dark Souls III', 59.99, '2016-04-12', 0, 'darksouls3.jpg', 1, '2016-04-12 12:00:00', '2025-11-07 21:18:11', 0, 0);
INSERT INTO `game` VALUES (47, 'Destiny 2', 0.00, '2017-09-06', 0, 'destiny2.jpg', 1, '2017-09-06 10:00:00', '2025-11-07 21:18:11', 0, 0);
INSERT INTO `game` VALUES (48, 'Doom Eternal', 59.99, '2020-03-20', 0, 'doometernal.jpg', 1, '2020-03-20 12:00:00', '2025-11-07 21:18:11', 0, 0);
INSERT INTO `game` VALUES (49, 'Halo: The Master Chief Collection', 39.99, '2014-11-11', 0, 'halo.jpg', 1, '2014-11-11 11:00:00', '2025-11-07 21:18:11', 0, 0);
INSERT INTO `game` VALUES (50, 'No Man\'s Sky', 59.99, '2016-08-09', 0, 'nomanssky.jpg', 1, '2016-08-09 10:00:00', '2025-11-07 21:18:11', 0, 0);
INSERT INTO `game` VALUES (52, 'Dead by Daylight', 19.99, '2016-06-14', 0, 'deadbydaylight.jpg', 1, '2016-06-14 11:00:00', '2025-11-07 21:18:11', 0, 0);
INSERT INTO `game` VALUES (53, 'Rocket League', 19.99, '2015-07-07', 0, 'rocketleague.jpg', 1, '2015-07-07 10:00:00', '2025-11-07 21:18:12', 0, 0);
INSERT INTO `game` VALUES (54, 'Spelunky 2', 19.99, '2020-09-15', 0, 'spelunky2.jpg', 1, '2020-09-15 11:00:00', '2025-11-07 21:18:12', 0, 0);
INSERT INTO `game` VALUES (55, 'Monster Hunter Rise', 59.99, '2021-03-26', 0, 'monsterhunterrise.jpg', 1, '2021-03-26 10:00:00', '2025-11-07 21:18:12', 0, 0);
INSERT INTO `game` VALUES (56, 'Hitman 3', 59.99, '2021-01-20', 0, 'hitman3.jpg', 1, '2021-01-20 10:00:00', '2025-11-07 21:18:12', 0, 0);
INSERT INTO `game` VALUES (57, 'Resident Evil Village', 59.99, '2021-05-07', 0, 're8.jpg', 1, '2021-05-07 12:00:00', '2025-11-07 21:18:12', 0, 0);
INSERT INTO `game` VALUES (58, 'F1 2021', 59.99, '2021-07-16', 0, 'f12021.jpg', 1, '2021-07-16 10:00:00', '2025-11-07 21:18:12', 0, 0);
INSERT INTO `game` VALUES (59, 'NBA 2K21', 59.99, '2020-09-04', 0, 'nba2k21.jpg', 1, '2020-09-04 13:00:00', '2025-11-07 21:18:12', 0, 0);
INSERT INTO `game` VALUES (60, 'Borderlands 3', 59.99, '2019-09-13', 0, 'borderlands3.jpg', 1, '2019-09-13 10:00:00', '2025-11-07 21:18:12', 0, 0);

-- ----------------------------
-- Table structure for game_achievement
-- ----------------------------
DROP TABLE IF EXISTS `game_achievement`;
CREATE TABLE `game_achievement`  (
  `achievement_id` int NOT NULL AUTO_INCREMENT COMMENT '成就ID',
  `game_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '游戏名称',
  `game_id` int NOT NULL COMMENT '游戏ID',
  `achievement_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '成就名称',
  `achievement_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '成就描述',
  `status` int NULL DEFAULT 0 COMMENT '状态，0表示正常，1表示异常',
  `version` int NULL DEFAULT 1 COMMENT '版本控制',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`achievement_id`) USING BTREE,
  INDEX `fk_game_achievement_game`(`game_id` ASC) USING BTREE,
  CONSTRAINT `fk_game_achievement_game` FOREIGN KEY (`game_id`) REFERENCES `game` (`game_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

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
  `id` int NOT NULL AUTO_INCREMENT COMMENT '捆绑包ID',
  `bundle_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '捆绑包名称',
  `game_id` int NOT NULL COMMENT '游戏ID',
  `discount_policy` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '优惠策略',
  `status` int NULL DEFAULT 0 COMMENT '状态，0表示正常，1表示异常',
  `version` int NULL DEFAULT 1 COMMENT '版本控制',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_game_bundle_game`(`game_id` ASC) USING BTREE,
  CONSTRAINT `fk_game_bundle_game` FOREIGN KEY (`game_id`) REFERENCES `game` (`game_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

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
  `image_id` int NOT NULL AUTO_INCREMENT COMMENT '游戏图片ID',
  `game_id` int NOT NULL COMMENT '游戏ID',
  `image_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '图片 URL',
  `status` int NULL DEFAULT 0 COMMENT '状态，0表示正常，1表示异常',
  `version` int NULL DEFAULT 1 COMMENT '版本控制',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`image_id`) USING BTREE,
  INDEX `fk_game_images_game`(`game_id` ASC) USING BTREE,
  CONSTRAINT `fk_game_images_game` FOREIGN KEY (`game_id`) REFERENCES `game` (`game_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of game_images
-- ----------------------------
INSERT INTO `game_images` VALUES (1, 1, 'dragonquest_1.jpg', 0, 1, '2020-01-01 12:00:00', '2020-06-01 12:00:00');
INSERT INTO `game_images` VALUES (2, 1, 'dragonquest_2.jpg', 0, 1, '2020-01-02 14:00:00', '2020-06-05 14:00:00');
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
  `id` int NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `game_id` int NOT NULL COMMENT '游戏ID',
  `original_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '原价',
  `lowest_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '史低价格',
  `lowest_price_time` timestamp NULL DEFAULT NULL COMMENT '史低时间',
  `recent_lowest_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '近史低价格',
  `recent_lowest_price_time` timestamp NULL DEFAULT NULL COMMENT '近史低时间',
  `current_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '当前价格',
  `next_discount_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '下次折扣价格',
  `next_discount_time` timestamp NULL DEFAULT NULL COMMENT '下次折扣时间',
  `status` int NULL DEFAULT 0 COMMENT '状态，0表示正常，1表示异常',
  `version` int NULL DEFAULT 1 COMMENT '版本控制',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_game_price_history_game`(`game_id` ASC) USING BTREE,
  CONSTRAINT `fk_game_price_history_game` FOREIGN KEY (`game_id`) REFERENCES `game` (`game_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of game_price_history
-- ----------------------------
INSERT INTO `game_price_history` VALUES (1, 1, 59.99, 19.99, '2019-12-01 00:00:00', 29.99, '2020-11-01 00:00:00', 49.99, 39.99, '2021-11-25 00:00:00', 0, 1, '2020-01-01 00:00:00', '2021-12-01 00:00:00');
INSERT INTO `game_price_history` VALUES (2, 2, 69.99, 29.99, '2020-10-01 00:00:00', 39.99, '2021-05-01 00:00:00', 59.99, 44.99, '2022-02-01 00:00:00', 0, 1, '2021-01-11 00:00:00', '2022-01-01 00:00:00');
INSERT INTO `game_price_history` VALUES (3, 3, 0.00, 0.00, '2019-01-01 00:00:00', 0.00, '2020-06-01 00:00:00', 0.00, 0.00, NULL, 0, 1, '2019-09-20 00:00:00', '2020-02-10 00:00:00');
INSERT INTO `game_price_history` VALUES (4, 4, 49.99, 19.99, '2020-09-01 00:00:00', 29.99, '2021-01-10 00:00:00', 39.99, 34.99, '2021-11-26 00:00:00', 0, 1, '2020-09-25 00:00:00', '2021-09-25 00:00:00');
INSERT INTO `game_price_history` VALUES (5, 5, 39.99, 9.99, '2018-03-01 00:00:00', 14.99, '2019-06-01 00:00:00', 24.99, 19.99, '2020-12-20 00:00:00', 0, 1, '2018-10-20 00:00:00', '2019-12-15 00:00:00');
INSERT INTO `game_price_history` VALUES (6, 6, 29.99, 4.99, '2019-02-01 00:00:00', 9.99, '2019-12-01 00:00:00', 19.99, 14.99, '2020-04-02 00:00:00', 0, 1, '2019-03-15 00:00:00', '2020-05-01 00:00:00');
INSERT INTO `game_price_history` VALUES (7, 7, 19.99, 3.99, '2017-11-01 00:00:00', 7.99, '2018-12-01 00:00:00', 14.99, 9.99, '2019-08-01 00:00:00', 0, 1, '2017-08-18 00:00:00', '2018-12-20 00:00:00');
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
  `game_profile_id` int NOT NULL AUTO_INCREMENT COMMENT '游戏详情ID',
  `game_id` int NOT NULL COMMENT '游戏ID',
  `game_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '游戏名称',
  `game_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '游戏简介',
  `game_developer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '游戏开发商',
  `game_tag_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '游戏标签名称',
  `game_config` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '游戏配置',
  `series` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '游戏系列',
  `status` int NULL DEFAULT 0 COMMENT '状态，0表示正常，1表示异常',
  `version` int NULL DEFAULT 1 COMMENT '版本控制',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`game_profile_id`) USING BTREE,
  INDEX `fk_game_profile_game`(`game_id` ASC) USING BTREE,
  CONSTRAINT `fk_game_profile_game` FOREIGN KEY (`game_id`) REFERENCES `game` (`game_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 52 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

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
INSERT INTO `game_profile` VALUES (21, 21, 'The Witcher 3: Wild Hunt', '开放世界动作角色扮演游戏', 'CD Projekt Red', 'RPG', 'Windows 10, 12GB RAM', '巫师系列', 0, 1, '2015-05-19 12:00:00', '2021-06-01 10:00:00');
INSERT INTO `game_profile` VALUES (22, 22, 'Grand Theft Auto V', '开放世界动作冒险游戏', 'Rockstar Games', 'Action', 'Windows 10, 16GB RAM', 'GTA系列', 0, 1, '2015-04-14 09:00:00', '2022-07-05 15:00:00');
INSERT INTO `game_profile` VALUES (23, 23, 'Red Dead Redemption 2', '开放世界动作冒险游戏', 'Rockstar Games', 'Action', 'Windows 10, 16GB RAM', '荒野大镖客系列', 0, 1, '2018-10-26 13:00:00', '2022-08-10 14:30:00');
INSERT INTO `game_profile` VALUES (24, 24, 'Minecraft', '沙盒建造类游戏', 'Mojang', 'Sandbox', 'Windows 10, 8GB RAM', 'Minecraft系列', 0, 1, '2011-11-18 15:00:00', '2022-09-10 11:00:00');
INSERT INTO `game_profile` VALUES (25, 25, 'Cyberpunk 2077', '开放世界角色扮演游戏', 'CD Projekt Red', 'RPG', 'Windows 10, 16GB RAM', '赛博朋克系列', 0, 1, '2020-12-10 11:00:00', '2022-10-15 12:00:00');
INSERT INTO `game_profile` VALUES (26, 26, 'The Elder Scrolls V: Skyrim', '开放世界角色扮演游戏', 'Bethesda Game Studios', 'RPG', 'Windows 10, 8GB RAM', '上古卷轴系列', 0, 1, '2011-11-11 10:00:00', '2021-11-11 10:00:00');
INSERT INTO `game_profile` VALUES (27, 27, 'Assassin\'s Creed Valhalla', '动作冒险游戏', 'Ubisoft', 'Action', 'Windows 10, 16GB RAM', '刺客信条系列', 0, 1, '2020-11-10 14:00:00', '2021-12-01 16:00:00');
INSERT INTO `game_profile` VALUES (28, 28, 'Call of Duty: Warzone', '第一人称射击游戏', 'Activision', 'FPS', 'Windows 10, 16GB RAM', 'COD系列', 0, 1, '2020-03-10 09:00:00', '2021-09-15 13:00:00');
INSERT INTO `game_profile` VALUES (29, 29, 'Fortnite', '多人在线生存竞技游戏', 'Epic Games', 'Battle Royale', 'Windows 10, 8GB RAM', 'Fortnite系列', 0, 1, '2017-09-26 12:00:00', '2022-11-01 10:00:00');
INSERT INTO `game_profile` VALUES (30, 30, 'Among Us', '多人社交推理游戏', 'Innersloth', 'Social Deduction', 'Windows 10, 4GB RAM', 'Among Us系列', 0, 1, '2020-06-15 20:00:00', '2021-06-15 20:00:00');
INSERT INTO `game_profile` VALUES (31, 31, 'Fall Guys', '多人竞速游戏', 'Mediatonic', 'Party Game', 'Windows 10, 8GB RAM', 'Fall Guys系列', 0, 1, '2020-08-04 15:00:00', '2022-05-20 14:00:00');
INSERT INTO `game_profile` VALUES (32, 32, 'Battlefield V', '第一人称射击游戏', 'EA DICE', 'FPS', 'Windows 10, 16GB RAM', 'Battlefield系列', 0, 1, '2018-11-20 11:00:00', '2021-10-10 16:00:00');
INSERT INTO `game_profile` VALUES (33, 33, 'Horizon Zero Dawn', '开放世界动作冒险游戏', 'Guerrilla Games', 'Action', 'Windows 10, 16GB RAM', 'Horizon系列', 0, 1, '2020-08-07 14:00:00', '2022-08-20 12:30:00');
INSERT INTO `game_profile` VALUES (34, 34, 'FIFA 22', '足球模拟类游戏', 'EA Sports', 'Sports', 'Windows 10, 8GB RAM', 'FIFA系列', 0, 1, '2021-10-01 10:00:00', '2022-07-25 11:00:00');
INSERT INTO `game_profile` VALUES (35, 35, 'Sekiro: Shadows Die Twice', '动作冒险游戏', 'FromSoftware', 'Action', 'Windows 10, 8GB RAM', '黑暗之魂系列', 0, 1, '2019-03-22 12:00:00', '2022-03-20 14:00:00');
INSERT INTO `game_profile` VALUES (36, 36, 'The Last of Us Part II', '动作冒险游戏', 'Naughty Dog', 'Action', 'Windows 10, 16GB RAM', '最后生还者系列', 0, 1, '2020-06-19 12:00:00', '2021-08-10 10:00:00');
INSERT INTO `game_profile` VALUES (37, 37, 'Ghost of Tsushima', '开放世界动作冒险游戏', 'Sucker Punch Productions', 'Action', 'PlayStation 4, 8GB RAM', '鬼泣系列', 0, 1, '2020-07-17 12:00:00', '2021-12-15 14:00:00');
INSERT INTO `game_profile` VALUES (38, 38, 'The Legend of Zelda: Breath of the Wild', '开放世界动作冒险游戏', 'Nintendo', 'Action', 'Nintendo Switch, 4GB RAM', '塞尔达传说系列', 0, 1, '2017-03-03 13:00:00', '2022-01-01 12:00:00');
INSERT INTO `game_profile` VALUES (39, 39, 'Super Mario Odyssey', '平台跳跃游戏', 'Nintendo', 'Action', 'Nintendo Switch, 4GB RAM', '超级马里奥系列', 0, 1, '2017-10-27 09:00:00', '2022-07-10 11:00:00');
INSERT INTO `game_profile` VALUES (40, 40, 'Animal Crossing: New Horizons', '社交模拟类游戏', 'Nintendo', 'Simulation', 'Nintendo Switch, 4GB RAM', '动物森友会系列', 0, 1, '2020-03-20 10:00:00', '2022-11-05 09:00:00');
INSERT INTO `game_profile` VALUES (41, 41, 'Apex Legends', '多人在线射击游戏', 'Respawn Entertainment', 'FPS', 'Windows 10, 8GB RAM', 'Apex系列', 0, 1, '2019-02-04 11:00:00', '2021-06-15 14:00:00');
INSERT INTO `game_profile` VALUES (42, 42, 'Overwatch', '第一人称射击游戏', 'Blizzard Entertainment', 'FPS', 'Windows 10, 8GB RAM', 'Overwatch系列', 0, 1, '2016-05-24 13:00:00', '2022-10-20 15:00:00');

-- ----------------------------
-- Table structure for game_tag
-- ----------------------------
DROP TABLE IF EXISTS `game_tag`;
CREATE TABLE `game_tag`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `game_id` int NOT NULL COMMENT '游戏ID',
  `tag_id` int NOT NULL COMMENT '标签ID',
  `status` int NULL DEFAULT 0 COMMENT '状态，0表示正常，1表示异常',
  `version` int NULL DEFAULT 1 COMMENT '版本控制',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_game_tag_game`(`game_id` ASC) USING BTREE,
  INDEX `fk_game_tag_tag`(`tag_id` ASC) USING BTREE,
  CONSTRAINT `fk_game_tag_game` FOREIGN KEY (`game_id`) REFERENCES `game` (`game_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_game_tag_tag` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`tag_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

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
  `gift_id` int NOT NULL AUTO_INCREMENT COMMENT '礼物ID',
  `game_id` int NOT NULL COMMENT '游戏ID',
  `user1_id` int NOT NULL COMMENT '赠送者ID',
  `user2_id` int NOT NULL COMMENT '接收者ID',
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '寄语',
  `status` int NULL DEFAULT 0 COMMENT '状态，0表示正常，1表示异常',
  `version` int NULL DEFAULT 1 COMMENT '版本控制',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`gift_id`) USING BTREE,
  INDEX `fk_gift_user1`(`user1_id` ASC) USING BTREE,
  INDEX `fk_gift_user2`(`user2_id` ASC) USING BTREE,
  INDEX `fk_gift_game`(`game_id` ASC) USING BTREE,
  CONSTRAINT `fk_gift_game` FOREIGN KEY (`game_id`) REFERENCES `game` (`game_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_gift_user1` FOREIGN KEY (`user1_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_gift_user2` FOREIGN KEY (`user2_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

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
-- Table structure for historical_orders
-- ----------------------------
DROP TABLE IF EXISTS `historical_orders`;
CREATE TABLE `historical_orders`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '历史订单ID',
  `order_id` int NOT NULL COMMENT '订单ID',
  `user_id` int NOT NULL COMMENT '用户ID',
  `game_id` int NOT NULL COMMENT '游戏ID',
  `discount_id` int NULL DEFAULT NULL COMMENT '优惠ID',
  `order_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '订单编号',
  `original_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '原价',
  `final_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '最终价格',
  `order_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '订单日期',
  `status` int NULL DEFAULT 0 COMMENT '订单状态，0表示正常，1表示异常',
  `version` int NULL DEFAULT 1 COMMENT '版本控制',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_historical_orders_order`(`order_id` ASC) USING BTREE,
  INDEX `fk_historical_orders_user`(`user_id` ASC) USING BTREE,
  INDEX `fk_historical_orders_game`(`game_id` ASC) USING BTREE,
  CONSTRAINT `fk_historical_orders_game` FOREIGN KEY (`game_id`) REFERENCES `game` (`game_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_historical_orders_order` FOREIGN KEY (`order_id`) REFERENCES `myorder` (`order_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_historical_orders_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of historical_orders
-- ----------------------------
INSERT INTO `historical_orders` VALUES (1, 1, 1, 1, 1, 'ORD20210101', 59.99, 47.99, '2021-01-01 10:00:00', 0, 1, '2021-01-02 12:00:00', '2021-01-02 12:00:00');
INSERT INTO `historical_orders` VALUES (2, 2, 2, 2, 2, 'ORD20210201', 69.99, 48.99, '2021-02-01 11:00:00', 0, 1, '2021-02-02 12:00:00', '2021-02-02 12:00:00');
INSERT INTO `historical_orders` VALUES (3, 3, 3, 3, 3, 'ORD20210301', 39.99, 33.99, '2021-03-01 12:00:00', 0, 1, '2021-03-02 12:00:00', '2021-03-02 12:00:00');
INSERT INTO `historical_orders` VALUES (4, 4, 4, 4, 4, 'ORD20210401', 49.99, 44.99, '2021-04-01 13:00:00', 0, 1, '2021-04-02 12:00:00', '2021-04-02 12:00:00');
INSERT INTO `historical_orders` VALUES (5, 5, 5, 5, 5, 'ORD20210501', 29.99, 24.99, '2021-05-01 14:00:00', 0, 1, '2021-05-02 12:00:00', '2021-05-02 12:00:00');
INSERT INTO `historical_orders` VALUES (6, 6, 6, 6, 6, 'ORD20210601', 19.99, 14.99, '2021-06-01 15:00:00', 0, 1, '2021-06-02 12:00:00', '2021-06-02 12:00:00');
INSERT INTO `historical_orders` VALUES (7, 7, 7, 7, 7, 'ORD20210701', 89.99, 69.99, '2021-07-01 16:00:00', 0, 1, '2021-07-02 12:00:00', '2021-07-02 12:00:00');
INSERT INTO `historical_orders` VALUES (8, 8, 8, 8, 8, 'ORD20210801', 79.99, 59.99, '2021-08-01 17:00:00', 0, 1, '2021-08-02 12:00:00', '2021-08-02 12:00:00');
INSERT INTO `historical_orders` VALUES (9, 9, 9, 9, 9, 'ORD20210901', 45.99, 40.99, '2021-09-01 18:00:00', 0, 1, '2021-09-02 12:00:00', '2021-09-02 12:00:00');
INSERT INTO `historical_orders` VALUES (10, 10, 10, 10, 10, 'ORD20211001', 55.99, 50.99, '2021-10-01 19:00:00', 0, 1, '2021-10-02 12:00:00', '2021-10-02 12:00:00');
INSERT INTO `historical_orders` VALUES (11, 11, 11, 11, 11, 'ORD20211101', 25.99, 20.99, '2021-11-01 20:00:00', 0, 1, '2021-11-02 12:00:00', '2021-11-02 12:00:00');
INSERT INTO `historical_orders` VALUES (12, 12, 12, 12, 12, 'ORD20211201', 35.99, 30.99, '2021-12-01 21:00:00', 0, 1, '2021-12-02 12:00:00', '2021-12-02 12:00:00');
INSERT INTO `historical_orders` VALUES (13, 13, 13, 13, 13, 'ORD20220101', 60.99, 55.99, '2022-01-01 22:00:00', 0, 1, '2022-01-02 12:00:00', '2022-01-02 12:00:00');
INSERT INTO `historical_orders` VALUES (14, 14, 14, 14, 14, 'ORD20220201', 70.99, 65.99, '2022-02-01 23:00:00', 0, 1, '2022-02-02 12:00:00', '2022-02-02 12:00:00');
INSERT INTO `historical_orders` VALUES (15, 15, 15, 15, 15, 'ORD20220301', 40.99, 35.99, '2022-03-01 09:00:00', 0, 1, '2022-03-02 12:00:00', '2022-03-02 12:00:00');
INSERT INTO `historical_orders` VALUES (16, 16, 16, 16, 16, 'ORD20220401', 50.99, 45.99, '2022-04-01 10:00:00', 0, 1, '2022-04-02 12:00:00', '2022-04-02 12:00:00');
INSERT INTO `historical_orders` VALUES (17, 17, 17, 17, 17, 'ORD20220501', 30.99, 25.99, '2022-05-01 11:00:00', 0, 1, '2022-05-02 12:00:00', '2022-05-02 12:00:00');
INSERT INTO `historical_orders` VALUES (18, 18, 18, 18, 18, 'ORD20220601', 20.99, 15.99, '2022-06-01 12:00:00', 0, 1, '2022-06-02 12:00:00', '2022-06-02 12:00:00');
INSERT INTO `historical_orders` VALUES (19, 19, 19, 19, 19, 'ORD20220701', 90.99, 85.99, '2022-07-01 13:00:00', 0, 1, '2022-07-02 12:00:00', '2022-07-02 12:00:00');
INSERT INTO `historical_orders` VALUES (20, 20, 20, 20, 20, 'ORD20220801', 59.99, 49.99, '2022-08-01 14:00:00', 0, 1, '2022-08-02 12:00:00', '2022-08-02 12:00:00');

-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message`  (
  `message_id` int NOT NULL AUTO_INCREMENT COMMENT '消息ID',
  `sender_id` int NOT NULL COMMENT '发件人ID',
  `receiver_id` int NOT NULL COMMENT '收件人ID',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '消息内容',
  `sent_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发送时间',
  `status` int NULL DEFAULT 0 COMMENT '状态，0表示正常，1表示异常',
  `version` int NULL DEFAULT 1 COMMENT '版本控制',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`message_id`) USING BTREE,
  INDEX `fk_message_sender`(`sender_id` ASC) USING BTREE,
  INDEX `fk_message_receiver`(`receiver_id` ASC) USING BTREE,
  CONSTRAINT `fk_message_receiver` FOREIGN KEY (`receiver_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_message_sender` FOREIGN KEY (`sender_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

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
  `order_id` int NOT NULL AUTO_INCREMENT COMMENT '订单ID',
  `user_id` int NULL DEFAULT NULL COMMENT '用户ID',
  `cart_id` int NULL DEFAULT NULL COMMENT '购物车ID',
  `order_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '订单编号',
  `original_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '订单原始价格',
  `final_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '订单最终价格',
  `order_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '订单日期',
  `order_status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'unpaid' COMMENT '订单状态',
  `status` int NULL DEFAULT 0 COMMENT '状态，0表示正常，1表示异常',
  `version` int NULL DEFAULT 1 COMMENT '版本控制',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`order_id`) USING BTREE,
  INDEX `fk_myorder_user`(`user_id` ASC) USING BTREE,
  INDEX `fk_myorder_cart`(`cart_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 33 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of myorder
-- ----------------------------
INSERT INTO `myorder` VALUES (1, 1, 1, 'ORD20210101', 59.99, 47.99, '2021-01-01 10:00:00', 'paid', 0, 1, '2021-01-01 10:00:00', '2021-01-01 10:00:00');
INSERT INTO `myorder` VALUES (2, 2, 2, 'ORD20210201', 69.99, 48.99, '2021-02-01 11:00:00', 'paid', 0, 1, '2021-02-01 11:00:00', '2021-02-01 11:00:00');
INSERT INTO `myorder` VALUES (3, 3, 3, 'ORD20210301', 39.99, 33.99, '2021-03-01 12:00:00', 'unpaid', 0, 1, '2021-03-01 12:00:00', '2021-03-01 12:00:00');
INSERT INTO `myorder` VALUES (4, 4, 4, 'ORD20210401', 49.99, 44.99, '2021-04-01 13:00:00', 'paid', 0, 1, '2021-04-01 13:00:00', '2021-04-01 13:00:00');
INSERT INTO `myorder` VALUES (5, 5, 5, 'ORD20210501', 29.99, 24.99, '2021-05-01 14:00:00', 'paid', 0, 1, '2021-05-01 14:00:00', '2021-05-01 14:00:00');
INSERT INTO `myorder` VALUES (6, 6, 6, 'ORD20210601', 19.99, 14.99, '2021-06-01 15:00:00', 'paid', 0, 1, '2021-06-01 15:00:00', '2021-06-01 15:00:00');
INSERT INTO `myorder` VALUES (7, 7, 7, 'ORD20210701', 89.99, 69.99, '2021-07-01 16:00:00', 'unpaid', 0, 1, '2021-07-01 16:00:00', '2021-07-01 16:00:00');
INSERT INTO `myorder` VALUES (8, 8, 8, 'ORD20210801', 79.99, 59.99, '2021-08-01 17:00:00', 'paid', 0, 1, '2021-08-01 17:00:00', '2021-08-01 17:00:00');
INSERT INTO `myorder` VALUES (9, 9, 9, 'ORD20210901', 45.99, 40.99, '2021-09-01 18:00:00', 'paid', 0, 1, '2021-09-01 18:00:00', '2021-09-01 18:00:00');
INSERT INTO `myorder` VALUES (10, 10, 10, 'ORD20211001', 55.99, 50.99, '2021-10-01 19:00:00', 'paid', 0, 1, '2021-10-01 19:00:00', '2021-10-01 19:00:00');
INSERT INTO `myorder` VALUES (11, 11, 11, 'ORD20211101', 25.99, 20.99, '2021-11-01 20:00:00', 'unpaid', 0, 1, '2021-11-01 20:00:00', '2021-11-01 20:00:00');
INSERT INTO `myorder` VALUES (12, 12, 12, 'ORD20211201', 35.99, 30.99, '2021-12-01 21:00:00', 'paid', 0, 1, '2021-12-01 21:00:00', '2021-12-01 21:00:00');
INSERT INTO `myorder` VALUES (13, 13, 13, 'ORD20220101', 60.99, 55.99, '2022-01-01 22:00:00', 'paid', 0, 1, '2022-01-01 22:00:00', '2022-01-01 22:00:00');
INSERT INTO `myorder` VALUES (14, 14, 14, 'ORD20220201', 70.99, 65.99, '2022-02-01 23:00:00', 'paid', 0, 1, '2022-02-01 23:00:00', '2022-02-01 23:00:00');
INSERT INTO `myorder` VALUES (15, 15, 15, 'ORD20220301', 40.99, 35.99, '2022-03-01 09:00:00', 'unpaid', 0, 1, '2022-03-01 09:00:00', '2022-03-01 09:00:00');
INSERT INTO `myorder` VALUES (16, 16, 16, 'ORD20220401', 50.99, 45.99, '2022-04-01 10:00:00', 'paid', 0, 1, '2022-04-01 10:00:00', '2022-04-01 10:00:00');
INSERT INTO `myorder` VALUES (17, 17, 17, 'ORD20220501', 30.99, 25.99, '2022-05-01 11:00:00', 'paid', 0, 1, '2022-05-01 11:00:00', '2022-05-01 11:00:00');
INSERT INTO `myorder` VALUES (18, 18, 18, 'ORD20220601', 20.99, 15.99, '2022-06-01 12:00:00', 'paid', 0, 1, '2022-06-01 12:00:00', '2022-06-01 12:00:00');
INSERT INTO `myorder` VALUES (19, 19, 19, 'ORD20220701', 90.99, 85.99, '2022-07-01 13:00:00', 'unpaid', 0, 1, '2022-07-01 13:00:00', '2022-07-01 13:00:00');
INSERT INTO `myorder` VALUES (20, 20, 20, 'ORD20220801', 59.99, 49.99, '2022-08-01 14:00:00', 'paid', 0, 1, '2022-08-01 14:00:00', '2022-08-01 14:00:00');
INSERT INTO `myorder` VALUES (21, 1, NULL, 'ORDER-4b3b6ee6-7b82-4d41-898c-c75dde0cb535', 59.99, 59.99, '2025-10-27 12:00:47', 'cancelled', 0, 1, '2025-10-27 12:00:47', '2025-10-27 12:00:48');
INSERT INTO `myorder` VALUES (22, 1, NULL, 'ORDER-94853ea9-4b01-4bc9-9e52-ce903a308868', 129.98, 129.98, '2025-10-27 12:07:45', 'cancelled', 0, 1, '2025-10-27 12:07:45', '2025-10-27 12:07:45');
INSERT INTO `myorder` VALUES (23, 1, NULL, 'ORDER-0ca2fa9d-41b0-4b69-8212-6b53672a96cc', 129.98, 129.98, '2025-10-27 12:08:42', 'paid', 0, 1, '2025-10-27 12:08:42', '2025-10-27 12:08:43');
INSERT INTO `myorder` VALUES (24, 1, NULL, 'ORDER-855a11f8-d822-4fd8-8c47-e1be42d7702d', 129.98, 129.98, '2025-10-28 19:53:40', 'cancelled', 0, 1, '2025-10-28 19:53:40', '2025-10-28 19:53:40');
INSERT INTO `myorder` VALUES (25, 1, NULL, 'ORDER72df414a-f3b8-439d-af6d-8fd9b81b18d7', 59.99, 47.99, '2025-11-07 21:26:51', 'paid', 0, 1, '2025-11-07 21:26:51', '2025-11-07 21:27:42');
INSERT INTO `myorder` VALUES (26, 1, NULL, 'ORDER209eb85e-f700-4078-89d5-fae5760d5931', 89.98, 71.98, '2025-11-08 15:10:34', 'cancelled', 0, 1, '2025-11-08 15:10:34', '2025-11-08 15:25:34');
INSERT INTO `myorder` VALUES (32, 1, NULL, 'ORDER9fe999e2e5574bfbbd0e3bdab163887a', 116.93, 93.54, '2025-11-09 23:52:08', 'paid', 0, 1, '2025-11-09 23:52:08', '2025-11-09 23:52:44');

-- ----------------------------
-- Table structure for order_details
-- ----------------------------
DROP TABLE IF EXISTS `order_details`;
CREATE TABLE `order_details`  (
  `detail_id` int NOT NULL AUTO_INCREMENT COMMENT '订单详情ID',
  `order_id` int NOT NULL COMMENT '订单ID',
  `user_id` int NOT NULL COMMENT '用户ID',
  `game_id` int NOT NULL COMMENT '游戏ID',
  `discount_id` int NULL DEFAULT NULL COMMENT '优惠ID',
  `status` int NULL DEFAULT 0 COMMENT '状态，0表示正常，1表示异常',
  `version` int NULL DEFAULT 1 COMMENT '版本控制',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`detail_id`) USING BTREE,
  INDEX `fk_order_details_order`(`order_id` ASC) USING BTREE,
  INDEX `fk_order_details_user`(`user_id` ASC) USING BTREE,
  INDEX `fk_order_details_game`(`game_id` ASC) USING BTREE,
  CONSTRAINT `fk_order_details_game` FOREIGN KEY (`game_id`) REFERENCES `game` (`game_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_order_details_order` FOREIGN KEY (`order_id`) REFERENCES `myorder` (`order_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_order_details_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 51 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of order_details
-- ----------------------------
INSERT INTO `order_details` VALUES (1, 1, 1, 1, 1, 0, 1, '2021-01-01 10:05:00', '2021-01-01 10:05:00');
INSERT INTO `order_details` VALUES (2, 2, 2, 2, 2, 0, 1, '2021-02-01 11:05:00', '2021-02-01 11:05:00');
INSERT INTO `order_details` VALUES (3, 3, 3, 3, 3, 0, 1, '2021-03-01 12:05:00', '2021-03-01 12:05:00');
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
INSERT INTO `order_details` VALUES (21, 21, 1, 1, 1, 0, 1, '2025-10-27 12:00:47', '2025-10-27 12:00:47');
INSERT INTO `order_details` VALUES (22, 21, 1, 1, 1, 0, 1, '2025-10-27 12:00:48', '2025-10-27 12:00:47');
INSERT INTO `order_details` VALUES (23, 22, 1, 1, 1, 0, 1, '2025-10-27 12:07:45', '2025-10-27 12:07:45');
INSERT INTO `order_details` VALUES (24, 22, 1, 2, 1, 0, 1, '2025-10-27 12:07:45', '2025-10-27 12:07:45');
INSERT INTO `order_details` VALUES (25, 23, 1, 1, 1, 0, 1, '2025-10-27 12:08:42', '2025-10-27 12:08:42');
INSERT INTO `order_details` VALUES (26, 23, 1, 2, 1, 0, 1, '2025-10-27 12:08:42', '2025-10-27 12:08:42');
INSERT INTO `order_details` VALUES (27, 24, 1, 1, 1, 0, 1, '2025-10-28 19:53:40', '2025-10-28 19:53:40');
INSERT INTO `order_details` VALUES (28, 24, 1, 2, 1, 0, 1, '2025-10-28 19:53:40', '2025-10-28 19:53:40');
INSERT INTO `order_details` VALUES (29, 25, 1, 1, 1, 0, 1, '2025-11-07 21:26:51', '2025-11-07 21:26:50');
INSERT INTO `order_details` VALUES (30, 26, 1, 1, 1, 0, 1, '2025-11-08 15:10:34', '2025-11-08 15:10:34');
INSERT INTO `order_details` VALUES (31, 26, 1, 6, 1, 0, 1, '2025-11-08 15:10:34', '2025-11-08 15:10:34');
INSERT INTO `order_details` VALUES (48, 32, 1, 2, 1, 0, 1, '2025-11-09 23:52:08', '2025-11-09 23:52:08');
INSERT INTO `order_details` VALUES (49, 32, 1, 7, 1, 0, 1, '2025-11-09 23:52:08', '2025-11-09 23:52:08');
INSERT INTO `order_details` VALUES (50, 32, 1, 12, 1, 0, 1, '2025-11-09 23:52:08', '2025-11-09 23:52:08');

-- ----------------------------
-- Table structure for payment_records
-- ----------------------------
DROP TABLE IF EXISTS `payment_records`;
CREATE TABLE `payment_records`  (
  `payment_id` int NOT NULL AUTO_INCREMENT COMMENT '支付ID',
  `payer_id` int NOT NULL COMMENT '支付者ID',
  `order_id` int NOT NULL COMMENT '订单ID',
  `transaction_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '交易编号',
  `transaction_amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '交易金额',
  `payment_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '支付时间',
  `status` int NULL DEFAULT 0 COMMENT '支付状态，0表示正常，1表示异常',
  `version` int NULL DEFAULT 1 COMMENT '版本控制',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`payment_id`) USING BTREE,
  INDEX `fk_payment_records_payer`(`payer_id` ASC) USING BTREE,
  INDEX `fk_payment_records_order`(`order_id` ASC) USING BTREE,
  CONSTRAINT `fk_payment_records_order` FOREIGN KEY (`order_id`) REFERENCES `myorder` (`order_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_payment_records_payer` FOREIGN KEY (`payer_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

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
INSERT INTO `payment_records` VALUES (27, 1, 32, '2025110922001405180507507086', 93.54, '2025-11-09 23:52:44', 0, 0, '2025-11-09 23:52:44', '2025-11-09 23:52:43');

-- ----------------------------
-- Table structure for post
-- ----------------------------
DROP TABLE IF EXISTS `post`;
CREATE TABLE `post`  (
  `post_id` int NOT NULL AUTO_INCREMENT COMMENT '帖子ID',
  `community_id` int NOT NULL COMMENT '社区ID',
  `user_id` int NOT NULL COMMENT '用户ID',
  `post_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '帖子标题',
  `post_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '帖子内容',
  `parent_post_id` int NULL DEFAULT 0 COMMENT '父帖子ID',
  `like_count` int NULL DEFAULT 0 COMMENT '点赞数',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `status` int NULL DEFAULT 0 COMMENT '状态，0表示正常，1表示异常',
  `version` int NULL DEFAULT 1 COMMENT '版本控制',
  PRIMARY KEY (`post_id`) USING BTREE,
  INDEX `fk_post_community`(`community_id` ASC) USING BTREE,
  INDEX `fk_post_user`(`user_id` ASC) USING BTREE,
  CONSTRAINT `fk_post_community` FOREIGN KEY (`community_id`) REFERENCES `community` (`community_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_post_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

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
  `sales_id` int NOT NULL AUTO_INCREMENT COMMENT '优惠ID',
  `sales_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '优惠名称',
  `game_id` int NOT NULL COMMENT '游戏ID',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '优惠描述',
  `discount_rate` decimal(5, 2) NULL DEFAULT NULL COMMENT '折扣率',
  `start_time` timestamp NULL DEFAULT NULL COMMENT '优惠开始时间',
  `end_time` timestamp NULL DEFAULT NULL COMMENT '优惠结束时间',
  `status` int NULL DEFAULT 0 COMMENT '状态，0表示正常，1表示异常',
  `version` int NULL DEFAULT 1 COMMENT '版本控制',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`sales_id`) USING BTREE,
  INDEX `fk_sales_game`(`game_id` ASC) USING BTREE,
  CONSTRAINT `fk_sales_game` FOREIGN KEY (`game_id`) REFERENCES `game` (`game_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sales
-- ----------------------------
INSERT INTO `sales` VALUES (1, '新年折扣', 1, 'RPG大作新年特惠', 0.20, '2021-01-01 00:00:00', '2021-01-15 23:59:59', 0, 1, '2021-01-01 00:00:00', '2021-01-01 00:00:00');
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
  `tag_id` int NOT NULL AUTO_INCREMENT COMMENT '标签ID',
  `tag_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '标签名称',
  `usage_count` int NULL DEFAULT 0 COMMENT '使用次数',
  `tag_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '标签描述',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `status` int NULL DEFAULT 0 COMMENT '状态，0表示正常，1表示异常',
  `version` int NULL DEFAULT 1 COMMENT '版本控制',
  PRIMARY KEY (`tag_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

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
  `user_id` int NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `user_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户邮箱',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户密码',
  `register_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
  `status` int NULL DEFAULT 0 COMMENT '用户状态，0表示正常，1表示异常',
  `phone_number` bigint NULL DEFAULT NULL COMMENT '手机号',
  `role` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'user' COMMENT '用户角色（游客、普通用户、管理员）',
  `version` int NULL DEFAULT 1 COMMENT '版本控制',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `steam_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'Steam ID',
  PRIMARY KEY (`user_id`) USING BTREE,
  UNIQUE INDEX `email`(`email` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, '爱丽丝', 'alice01@example.com', 'isepura', '2021-03-15 10:12:30', 0, 13847293810, 'user', 1, '2021-03-15 10:12:30', '2025-11-09 15:52:36', NULL);
INSERT INTO `user` VALUES (2, 'kafu', 'bob77@example.com', 'kafkaf', '2020-07-22 15:32:12', 0, 13984756329, 'admin', 1, '2020-07-22 15:32:12', '2025-11-09 16:28:40', NULL);
INSERT INTO `user` VALUES (3, 'charlieX', 'charliex@mail.com', 'pwC8@73', '2019-12-09 21:03:45', 1, 13745920183, 'guest', 1, '2019-12-09 21:03:45', '2020-03-01 10:00:22', NULL);
INSERT INTO `user` VALUES (4, 'david99', 'david99@example.org', 'pwD7@45', '2022-01-05 08:45:01', 0, 13694758302, 'user', 1, '2022-01-05 08:45:01', '2022-11-12 20:30:42', NULL);
INSERT INTO `user` VALUES (5, 'eva_k', 'eva.k@example.com', 'pwE1@55', '2021-08-13 19:22:55', 0, 13582937465, 'user', 1, '2021-08-13 19:22:55', '2022-09-30 09:20:00', NULL);
INSERT INTO `user` VALUES (6, 'frankM', 'frank.m@mail.net', 'pwF5@64', '2018-04-30 11:02:18', 0, 13472839485, 'admin', 1, '2018-04-30 11:02:18', '2020-01-20 16:11:49', NULL);
INSERT INTO `user` VALUES (7, 'grace07', 'grace07@domain.com', 'pwG4@77', '2020-10-10 12:41:02', 0, 13928374652, 'user', 1, '2020-10-10 12:41:02', '2021-10-18 15:55:21', NULL);
INSERT INTO `user` VALUES (8, 'henryQ', 'henryq@example.com', 'pwH9@88', '2019-05-23 09:18:34', 1, 13837492018, 'guest', 1, '2019-05-23 09:18:34', '2020-02-14 19:02:18', NULL);
INSERT INTO `user` VALUES (9, 'irene55', 'irene55@mail.org', 'pwI3@20', '2022-02-28 14:14:14', 0, 13748592013, 'user', 1, '2022-02-28 14:14:14', '2023-01-09 17:25:09', NULL);
INSERT INTO `user` VALUES (10, 'jackson', 'jackson@example.net', 'pwJ6@39', '2020-09-19 20:33:20', 0, 13692837461, 'user', 1, '2020-09-19 20:33:20', '2021-12-25 22:10:00', NULL);
INSERT INTO `user` VALUES (11, 'kate33', 'kate33@example.com', 'pwK4@41', '2018-12-12 07:59:21', 0, 13592037486, 'admin', 1, '2018-12-12 07:59:21', '2019-10-03 19:48:29', NULL);
INSERT INTO `user` VALUES (12, 'leo88', 'leo88@mail.com', 'pwL7@82', '2021-11-11 11:11:11', 0, 13492038476, 'user', 1, '2021-11-11 11:11:11', '2022-06-15 20:00:01', NULL);
INSERT INTO `user` VALUES (13, 'mia_s', 'mia.s@example.com', 'pwM2@61', '2019-01-15 13:20:01', 1, 13948392010, 'guest', 1, '2019-01-15 13:20:01', '2019-07-18 18:15:35', NULL);
INSERT INTO `user` VALUES (14, 'nickL', 'nickl@example.org', 'pwN8@55', '2022-07-07 17:25:33', 0, 13829485730, 'user', 1, '2022-07-07 17:25:33', '2022-12-09 22:30:17', NULL);
INSERT INTO `user` VALUES (15, 'olivia', 'olivia@mail.com', 'pwO1@12', '2020-06-06 06:06:06', 0, 13759203847, 'user', 1, '2020-06-06 06:06:06', '2021-05-20 11:45:00', NULL);
INSERT INTO `user` VALUES (16, 'peterQ', 'peterq@example.com', 'pwP5@99', '2018-09-09 15:15:15', 0, 13692837409, 'admin', 1, '2018-09-09 15:15:15', '2020-04-12 19:20:00', NULL);
INSERT INTO `user` VALUES (17, 'queenV', 'queenv@example.net', 'pwQ4@82', '2021-04-14 04:44:44', 0, 13572938462, 'user', 1, '2021-04-14 04:44:44', '2022-10-18 13:30:00', NULL);
INSERT INTO `user` VALUES (18, 'robert9', 'robert9@example.com', 'pwR8@15', '2022-05-01 09:20:33', 0, 13483920194, 'user', 1, '2022-05-01 09:20:33', '2022-11-20 16:12:09', NULL);
INSERT INTO `user` VALUES (19, 'susanW', 'susanw@mail.com', 'pwS6@24', '2019-02-02 02:22:02', 1, 13927492038, 'guest', 1, '2019-02-02 02:22:02', '2019-08-05 18:00:45', NULL);
INSERT INTO `user` VALUES (20, 'tomH', 'tomh@example.org', 'pwT3@98', '2020-10-30 19:19:19', 0, 13839485720, 'user', 1, '2020-10-30 19:19:19', '2021-09-01 22:40:00', NULL);
INSERT INTO `user` VALUES (21, 'Edmond', '2073026640@qq.com', '132456', '2025-10-23 05:16:36', 0, NULL, 'user', 1, '2025-10-23 05:16:36', '2025-10-23 05:16:36', NULL);
INSERT INTO `user` VALUES (22, '1234', '1', '123', '2025-11-03 11:50:09', 0, NULL, 'user', 1, '2025-11-03 11:50:09', '2025-11-06 11:03:49', NULL);

-- ----------------------------
-- Table structure for user_achievement
-- ----------------------------
DROP TABLE IF EXISTS `user_achievement`;
CREATE TABLE `user_achievement`  (
  `user_achievement_id` int NOT NULL AUTO_INCREMENT COMMENT '用户成就ID',
  `user_id` int NOT NULL COMMENT '用户ID',
  `achievement_id` int NOT NULL COMMENT '成就ID',
  `achieved_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '达成日期',
  `status` int NULL DEFAULT 0 COMMENT '状态，0表示正常，1表示异常',
  `version` int NULL DEFAULT 1 COMMENT '版本控制',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`user_achievement_id`) USING BTREE,
  INDEX `fk_user_achievement_user`(`user_id` ASC) USING BTREE,
  CONSTRAINT `fk_user_achievement_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

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
  `follow_id` int NOT NULL AUTO_INCREMENT COMMENT '关注ID',
  `user_id` int NOT NULL COMMENT '用户ID',
  `game_id` int NOT NULL COMMENT '游戏ID',
  `follow_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '关注时间',
  `status` int NULL DEFAULT 0 COMMENT '关注状态，0表示已关注，1表示异常',
  `version` int NULL DEFAULT 1 COMMENT '版本控制',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`follow_id`) USING BTREE,
  INDEX `fk_user_follow_user`(`user_id` ASC) USING BTREE,
  INDEX `fk_user_follow_game`(`game_id` ASC) USING BTREE,
  CONSTRAINT `fk_user_follow_game` FOREIGN KEY (`game_id`) REFERENCES `game` (`game_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_user_follow_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

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
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` int NOT NULL COMMENT '用户ID',
  `game_id` int NOT NULL COMMENT '游戏ID',
  `source` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'BUY' COMMENT '来源：BUY=购买, GIFT=礼包',
  `status` int NULL DEFAULT 0 COMMENT '状态：0=正常, 1=异常',
  `version` int NULL DEFAULT 1 COMMENT '版本号（乐观锁）',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uq_user_game`(`user_id` ASC, `game_id` ASC) USING BTREE,
  INDEX `fk_user_library_game`(`game_id` ASC) USING BTREE,
  CONSTRAINT `fk_user_library_game` FOREIGN KEY (`game_id`) REFERENCES `game` (`game_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_user_library_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 47 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

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
  `user_profile_id` int NOT NULL AUTO_INCREMENT COMMENT '用户详情ID',
  `user_id` int NOT NULL COMMENT '用户ID',
  `age` int NULL DEFAULT NULL COMMENT '年龄',
  `gender` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '性别',
  `birthday` date NULL DEFAULT NULL COMMENT '生日',
  `country` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '国家',
  `bio` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '个人简介',
  `user_device` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户设备',
  `avatar_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '头像 URL',
  `status` int NULL DEFAULT 0 COMMENT '用户状态，0表示正常，1表示异常',
  `version` int NULL DEFAULT 1 COMMENT '版本控制',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`user_profile_id`) USING BTREE,
  INDEX `fk_user_profile_user`(`user_id` ASC) USING BTREE,
  CONSTRAINT `fk_user_profile_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_profile
-- ----------------------------
INSERT INTO `user_profile` VALUES (1, 1, 25, 'M', '1997-04-15', 'China', '热爱RPG和FPS游戏', 'iPhone 13', '4473ccba-61ea-426b-b6f9-dc985eff0afc.png', 0, 1, '2021-04-15 10:00:00', '2025-11-09 23:52:56');
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
