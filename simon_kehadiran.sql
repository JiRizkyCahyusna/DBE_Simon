/*
 Navicat MySQL Dump SQL

 Source Server         : koneksi
 Source Server Type    : MySQL
 Source Server Version : 80030 (8.0.30)
 Source Host           : localhost:3306
 Source Schema         : simon_kehadiran

 Target Server Type    : MySQL
 Target Server Version : 80030 (8.0.30)
 File Encoding         : 65001

 Date: 07/03/2025 12:20:22
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for dosen
-- ----------------------------
DROP TABLE IF EXISTS `dosen`;
CREATE TABLE `dosen`  (
  `nidn` int NOT NULL,
  `nama_dosen` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `id_user` int NOT NULL,
  PRIMARY KEY (`nidn`) USING BTREE,
  INDEX `id_user`(`id_user` ASC) USING BTREE,
  CONSTRAINT `dosen_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dosen
-- ----------------------------
INSERT INTO `dosen` VALUES (2206231, 'Andin Ardelina', 1);
INSERT INTO `dosen` VALUES (2206232, 'Windy Anggita', 4);
INSERT INTO `dosen` VALUES (2206233, 'Putri Aulia', 6);
INSERT INTO `dosen` VALUES (2206234, 'Surya Wijaya', 7);
INSERT INTO `dosen` VALUES (2206235, 'Dedi Prasetyo', 10);

-- ----------------------------
-- Table structure for kehadiran
-- ----------------------------
DROP TABLE IF EXISTS `kehadiran`;
CREATE TABLE `kehadiran`  (
  `id_kehadiran` int NOT NULL AUTO_INCREMENT,
  `tanggal` date NOT NULL,
  `pertemuan` int NOT NULL,
  `status` enum('Hadir','Alpha','Izin','Sakit') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `npm` int NOT NULL,
  `nidn` int NOT NULL,
  `kode_matkul` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `kode_kelas` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id_kehadiran`) USING BTREE,
  UNIQUE INDEX `unique_kehadiran`(`npm` ASC, `tanggal` ASC, `pertemuan` ASC) USING BTREE,
  INDEX `nidn`(`nidn` ASC) USING BTREE,
  INDEX `kode_matkul`(`kode_matkul` ASC) USING BTREE,
  INDEX `kode_kelas`(`kode_kelas` ASC) USING BTREE,
  CONSTRAINT `kehadiran_ibfk_1` FOREIGN KEY (`npm`) REFERENCES `mahasiswa` (`npm`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `kehadiran_ibfk_2` FOREIGN KEY (`nidn`) REFERENCES `dosen` (`nidn`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `kehadiran_ibfk_3` FOREIGN KEY (`kode_matkul`) REFERENCES `matkul` (`kode_matkul`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `kehadiran_ibfk_4` FOREIGN KEY (`kode_kelas`) REFERENCES `kelas` (`kode_kelas`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of kehadiran
-- ----------------------------
INSERT INTO `kehadiran` VALUES (1, '2025-02-11', 1, 'Hadir', 330102065, 2206232, 'SBD04', 'KLS03');
INSERT INTO `kehadiran` VALUES (2, '2025-02-12', 1, 'Izin', 330102066, 2206235, 'FIS02', 'KLS05');
INSERT INTO `kehadiran` VALUES (3, '2025-02-13', 2, 'Sakit', 330102067, 2206231, 'JRM05', 'KLS04');
INSERT INTO `kehadiran` VALUES (4, '2025-02-14', 2, 'Alpha', 330102068, 2206234, 'MTK01', 'KLS01');
INSERT INTO `kehadiran` VALUES (5, '2025-02-15', 3, 'Hadir', 330102069, 2206233, 'PGR03', 'KLS02');

-- ----------------------------
-- Table structure for kelas
-- ----------------------------
DROP TABLE IF EXISTS `kelas`;
CREATE TABLE `kelas`  (
  `kode_kelas` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nama_kelas` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`kode_kelas`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of kelas
-- ----------------------------
INSERT INTO `kelas` VALUES ('KLS01', 'A');
INSERT INTO `kelas` VALUES ('KLS02', 'B');
INSERT INTO `kelas` VALUES ('KLS03', 'C');
INSERT INTO `kelas` VALUES ('KLS04', 'D');
INSERT INTO `kelas` VALUES ('KLS05', 'E');

-- ----------------------------
-- Table structure for mahasiswa
-- ----------------------------
DROP TABLE IF EXISTS `mahasiswa`;
CREATE TABLE `mahasiswa`  (
  `npm` int NOT NULL,
  `nama_mahasiswa` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `email` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `id_user` int NOT NULL,
  `kode_kelas` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`npm`) USING BTREE,
  INDEX `id_user`(`id_user` ASC) USING BTREE,
  INDEX `kode_kelas`(`kode_kelas` ASC) USING BTREE,
  CONSTRAINT `mahasiswa_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `mahasiswa_ibfk_2` FOREIGN KEY (`kode_kelas`) REFERENCES `kelas` (`kode_kelas`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mahasiswa
-- ----------------------------
INSERT INTO `mahasiswa` VALUES (330102065, 'Ji Rizky Cahyusna', 'jicantik12@gmail.com', 2, 'KLS03');
INSERT INTO `mahasiswa` VALUES (330102066, 'Ibnu Zaki', 'ibnuzaki@gmail.com', 5, 'KLS05');
INSERT INTO `mahasiswa` VALUES (330102067, 'Amelia Zahra', 'amelia@gmail.com', 8, 'KLS04');
INSERT INTO `mahasiswa` VALUES (330102068, 'Santosa Setiya', 'santosa@gmail.com', 9, 'KLS01');
INSERT INTO `mahasiswa` VALUES (330102069, 'Sarah Amaleya', 'sarah@gmail.com', 11, 'KLS02');

-- ----------------------------
-- Table structure for matkul
-- ----------------------------
DROP TABLE IF EXISTS `matkul`;
CREATE TABLE `matkul`  (
  `kode_matkul` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nama_matkul` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `sks` int NOT NULL,
  PRIMARY KEY (`kode_matkul`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of matkul
-- ----------------------------
INSERT INTO `matkul` VALUES ('FIS02', 'Fisika', 2);
INSERT INTO `matkul` VALUES ('JRM05', 'Jaringan Komputer', 3);
INSERT INTO `matkul` VALUES ('MTK01', 'Matematika Dasar', 3);
INSERT INTO `matkul` VALUES ('PGR03', 'Pemrograman Web', 4);
INSERT INTO `matkul` VALUES ('SBD04', 'Sistem Basis Data', 3);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id_user` int NOT NULL AUTO_INCREMENT,
  `username` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `level` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id_user`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'Andin Ardelina', 'andin03', 'dosen');
INSERT INTO `user` VALUES (2, 'Ji Rizky Cahyusna', 'nana12', 'mahasiswa');
INSERT INTO `user` VALUES (3, 'Hana Kurnia', 'hana14', 'admin');
INSERT INTO `user` VALUES (4, 'Windy Anggita', 'windy23', 'dosen');
INSERT INTO `user` VALUES (5, 'Ibnu Zaki', 'ibnu22', 'mahasiswa');
INSERT INTO `user` VALUES (6, 'Putri Aulia', 'putri29', 'dosen');
INSERT INTO `user` VALUES (7, 'Surya Wijaya', 'surya30', 'dosen');
INSERT INTO `user` VALUES (8, 'Amelia Zahra', 'amel91', 'mahasiswa');
INSERT INTO `user` VALUES (9, 'Santosa Setiya', 'santosa76', 'mahasiswa');
INSERT INTO `user` VALUES (10, 'Dedi Prasetyo', 'dedi56', 'dosen');
INSERT INTO `user` VALUES (11, 'Sarah Amaleya', 'sarah40', 'mahasiswa');

-- ----------------------------
-- View structure for v_dosen
-- ----------------------------
DROP VIEW IF EXISTS `v_dosen`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_dosen` AS select row_number() OVER (ORDER BY `d`.`nidn` )  AS `No`,`d`.`nidn` AS `nidn`,`d`.`nama_dosen` AS `nama_dosen` from `dosen` `d`;

-- ----------------------------
-- View structure for v_kehadiran_mahasiswa
-- ----------------------------
DROP VIEW IF EXISTS `v_kehadiran_mahasiswa`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_kehadiran_mahasiswa` AS select `kh`.`id_kehadiran` AS `id_kehadiran`,`m`.`npm` AS `npm`,`m`.`nama_mahasiswa` AS `nama_mahasiswa`,`kh`.`tanggal` AS `tanggal`,`kh`.`pertemuan` AS `pertemuan`,`kh`.`status` AS `status`,`mk`.`nama_matkul` AS `nama_matkul`,`d`.`nama_dosen` AS `nama_dosen` from (((`kehadiran` `kh` join `mahasiswa` `m` on((`kh`.`npm` = `m`.`npm`))) join `matkul` `mk` on((`kh`.`kode_matkul` = `mk`.`kode_matkul`))) join `dosen` `d` on((`kh`.`nidn` = `d`.`nidn`)));

-- ----------------------------
-- View structure for v_kelas
-- ----------------------------
DROP VIEW IF EXISTS `v_kelas`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_kelas` AS select row_number() OVER (ORDER BY `kelas`.`kode_kelas` )  AS `No`,`kelas`.`kode_kelas` AS `kode_kelas`,`kelas`.`nama_kelas` AS `nama_kelas` from `kelas`;

-- ----------------------------
-- View structure for v_mahasiswa_kelas
-- ----------------------------
DROP VIEW IF EXISTS `v_mahasiswa_kelas`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_mahasiswa_kelas` AS select row_number() OVER (ORDER BY `m`.`npm` )  AS `No`,`m`.`npm` AS `npm`,`m`.`nama_mahasiswa` AS `nama_mahasiswa`,`m`.`email` AS `email`,`k`.`nama_kelas` AS `nama_kelas` from (`mahasiswa` `m` join `kelas` `k` on((`m`.`kode_kelas` = `k`.`kode_kelas`)));

-- ----------------------------
-- View structure for v_matkul
-- ----------------------------
DROP VIEW IF EXISTS `v_matkul`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_matkul` AS select row_number() OVER (ORDER BY `matkul`.`kode_matkul` )  AS `No`,`matkul`.`kode_matkul` AS `kode_matkul`,`matkul`.`nama_matkul` AS `nama_matkul`,`matkul`.`sks` AS `sks` from `matkul`;

SET FOREIGN_KEY_CHECKS = 1;
