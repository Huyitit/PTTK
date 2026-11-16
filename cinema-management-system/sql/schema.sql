-- ====================================================================
-- KỊCH BẢN KHỞI TẠO CƠ SỞ DỮ LIỆU: cinema_db3
-- Chủ đề số 17: Cinema Management System (Hệ thống quản lý rạp chiếu phim)
-- Môn học: Đảm bảo chất lượng phần mềm (Software Assurance)
-- Cơ sở thiết kế: Mục 3.2 và Biểu đồ CSDL image12.puml trong final-document
-- ====================================================================

SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
SET CHARACTER SET utf8mb4;

CREATE DATABASE IF NOT EXISTS `cinema_db3`
DEFAULT CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE `cinema_db3`;

-- Xóa các bảng cũ theo thứ tự phụ thuộc khóa ngoại nếu đã tồn tại
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `tblTicket3`;
DROP TABLE IF EXISTS `tblInvoice3`;
DROP TABLE IF EXISTS `tblShowtime3`;
DROP TABLE IF EXISTS `tblMovieActor3`;
DROP TABLE IF EXISTS `tblMovieGenre3`;
DROP TABLE IF EXISTS `tblActor3`;
DROP TABLE IF EXISTS `tblGenre3`;
DROP TABLE IF EXISTS `tblMovie3`;
DROP TABLE IF EXISTS `tblSeat3`;
DROP TABLE IF EXISTS `tblScreeningRoom3`;
DROP TABLE IF EXISTS `tblCinema3`;
DROP TABLE IF EXISTS `tblMembershipCard3`;
DROP TABLE IF EXISTS `tblCustomer3`;
DROP TABLE IF EXISTS `tblSaler3`;
DROP TABLE IF EXISTS `tblManager3`;
DROP TABLE IF EXISTS `tblStaff3`;
DROP TABLE IF EXISTS `tblUser3`;
SET FOREIGN_KEY_CHECKS = 1;

-- ====================================================================
-- 1. NHÓM BẢNG NGƯỜI DÙNG & PHÂN QUYỀN VAI TRÒ
-- ====================================================================

-- 1.1 Bảng tblUser3: Tài khoản người dùng cơ sở
CREATE TABLE `tblUser3` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `username` VARCHAR(255) NOT NULL UNIQUE,
    `password` VARCHAR(255) NOT NULL,
    `fullName` VARCHAR(255) NOT NULL,
    `email` VARCHAR(255) NULL,
    `phone` VARCHAR(255) NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 1.2 Bảng tblStaff3: Nhân viên (Kế thừa User3)
CREATE TABLE `tblStaff3` (
    `tblUserId` INT PRIMARY KEY,
    `role` VARCHAR(255) NOT NULL,
    CONSTRAINT `fk_staff_user`
        FOREIGN KEY (`tblUserId`) REFERENCES `tblUser3` (`id`)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 1.3 Bảng tblManager3: Nhân viên quản lý (Kế thừa Staff3)
CREATE TABLE `tblManager3` (
    `tblStaffId` INT PRIMARY KEY,
    CONSTRAINT `fk_manager_staff`
        FOREIGN KEY (`tblStaffId`) REFERENCES `tblStaff3` (`tblUserId`)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 1.4 Bảng tblSaler3: Nhân viên bán vé (Kế thừa Staff3)
CREATE TABLE `tblSaler3` (
    `tblStaffId` INT PRIMARY KEY,
    CONSTRAINT `fk_saler_staff`
        FOREIGN KEY (`tblStaffId`) REFERENCES `tblStaff3` (`tblUserId`)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 1.5 Bảng tblCustomer3: Khách hàng (Kế thừa User3)
CREATE TABLE `tblCustomer3` (
    `tblUserId` INT PRIMARY KEY,
    `code` VARCHAR(255) NOT NULL UNIQUE,
    CONSTRAINT `fk_customer_user`
        FOREIGN KEY (`tblUserId`) REFERENCES `tblUser3` (`id`)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 1.6 Bảng tblMembershipCard3: Thẻ thành viên khách hàng (Quan hệ 1-1 với Customer3)
CREATE TABLE `tblMembershipCard3` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `issueDate` DATE NOT NULL,
    `points` INT NOT NULL DEFAULT 0,
    `tblCustomer3UserId` INT NOT NULL UNIQUE,
    CONSTRAINT `fk_card_customer`
        FOREIGN KEY (`tblCustomer3UserId`) REFERENCES `tblCustomer3` (`tblUserId`)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ====================================================================
-- 2. NHÓM BẢNG CƠ SỞ VẬT CHẤT (RẠP, PHÒNG CHIẾU, GHẾ NGỒI)
-- ====================================================================

-- 2.1 Bảng tblCinema3: Cụm rạp chiếu phim
CREATE TABLE `tblCinema3` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL,
    `address` VARCHAR(255) NOT NULL,
    `phone` VARCHAR(255) NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 2.2 Bảng tblScreeningRoom3: Phòng chiếu thuộc rạp
CREATE TABLE `tblScreeningRoom3` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL,
    `capacity` INT NOT NULL,
    `type` VARCHAR(255) NULL,
    `tblCinema3Id` INT NOT NULL,
    CONSTRAINT `fk_room_cinema`
        FOREIGN KEY (`tblCinema3Id`) REFERENCES `tblCinema3` (`id`)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 2.3 Bảng tblSeat3: Vị trí ghế ngồi trong phòng chiếu
CREATE TABLE `tblSeat3` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `row` VARCHAR(255) NOT NULL,
    `number` INT NOT NULL,
    `type` VARCHAR(255) NULL,
    `tblScreeningRoom3Id` INT NOT NULL,
    CONSTRAINT `fk_seat_room`
        FOREIGN KEY (`tblScreeningRoom3Id`) REFERENCES `tblScreeningRoom3` (`id`)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ====================================================================
-- 3. NHÓM BẢNG PHIM, THỂ LOẠI & DIỄN VIÊN
-- ====================================================================

-- 3.1 Bảng tblMovie3: Thông tin bộ phim
CREATE TABLE `tblMovie3` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `title` VARCHAR(255) NOT NULL,
    `director` VARCHAR(255) NULL,
    `duration` INT NOT NULL,
    `releaseDate` DATE NULL,
    `ageRestriction` INT NOT NULL DEFAULT 0,
    `description` VARCHAR(500) NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 3.2 Bảng tblGenre3: Thể loại phim
CREATE TABLE `tblGenre3` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 3.3 Bảng tblActor3: Diễn viên tham gia phim
CREATE TABLE `tblActor3` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 3.4 Bảng tblMovieGenre3: Liên kết Phim - Thể loại (Bảng trung gian quan hệ n-n)
CREATE TABLE `tblMovieGenre3` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `rate` FLOAT NOT NULL DEFAULT 0,
    `tblMovie3Id` INT NOT NULL,
    `tblGenre3Id` INT NOT NULL,
    CONSTRAINT `fk_mg_movie`
        FOREIGN KEY (`tblMovie3Id`) REFERENCES `tblMovie3` (`id`)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_mg_genre`
        FOREIGN KEY (`tblGenre3Id`) REFERENCES `tblGenre3` (`id`)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 3.5 Bảng tblMovieActor3: Liên kết Phim - Diễn viên (Bảng trung gian quan hệ n-n)
CREATE TABLE `tblMovieActor3` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `characterName` VARCHAR(255) NULL,
    `tblMovie3Id` INT NOT NULL,
    `tblActor3Id` INT NOT NULL,
    CONSTRAINT `fk_ma_movie`
        FOREIGN KEY (`tblMovie3Id`) REFERENCES `tblMovie3` (`id`)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_ma_actor`
        FOREIGN KEY (`tblActor3Id`) REFERENCES `tblActor3` (`id`)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ====================================================================
-- 4. NHÓM BẢNG GIAO DỊCH TÁC NGHIỆP (SUẤT CHIẾU, HÓA ĐƠN, VÉ)
-- ====================================================================

-- 4.1 Bảng tblShowtime3: Suất chiếu phim
CREATE TABLE `tblShowtime3` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `showDate` DATE NOT NULL,
    `startTime` VARCHAR(10) NOT NULL,
    `endTime` VARCHAR(10) NOT NULL,
    `format` VARCHAR(255) NULL,
    `basePrice` FLOAT NOT NULL,
    `tblMovie3Id` INT NOT NULL,
    `tblScreeningRoom3Id` INT NOT NULL,
    CONSTRAINT `fk_showtime_movie`
        FOREIGN KEY (`tblMovie3Id`) REFERENCES `tblMovie3` (`id`)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_showtime_room`
        FOREIGN KEY (`tblScreeningRoom3Id`) REFERENCES `tblScreeningRoom3` (`id`)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 4.2 Bảng tblInvoice3: Hóa đơn thanh toán giao dịch
CREATE TABLE `tblInvoice3` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `createdDate` DATETIME NOT NULL,
    `totalAmount` FLOAT NOT NULL,
    `paymentMethod` VARCHAR(255) NULL,
    `tblCustomer3UserId` INT NOT NULL,
    `tblSaler3StaffId` INT NULL,
    CONSTRAINT `fk_invoice_customer`
        FOREIGN KEY (`tblCustomer3UserId`) REFERENCES `tblCustomer3` (`tblUserId`)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_invoice_saler`
        FOREIGN KEY (`tblSaler3StaffId`) REFERENCES `tblSaler3` (`tblStaffId`)
        ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 4.3 Bảng tblTicket3: Vé xem phim được xuất bán
CREATE TABLE `tblTicket3` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `price` FLOAT NOT NULL,
    `issueTime` DATETIME NOT NULL,
    `status` VARCHAR(255) NULL,
    `type` VARCHAR(255) NULL,
    `tblShowtime3Id` INT NOT NULL,
    `tblSeat3Id` INT NOT NULL,
    `tblInvoice3Id` INT NOT NULL,
    CONSTRAINT `fk_ticket_showtime`
        FOREIGN KEY (`tblShowtime3Id`) REFERENCES `tblShowtime3` (`id`)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_ticket_seat`
        FOREIGN KEY (`tblSeat3Id`) REFERENCES `tblSeat3` (`id`)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_ticket_invoice`
        FOREIGN KEY (`tblInvoice3Id`) REFERENCES `tblInvoice3` (`id`)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ====================================================================
-- HOÀN TẤT KHỞI TẠO CẤU TRÚC 17 BẢNG QUAN HỆ CHUẨN HÓA
-- ====================================================================
