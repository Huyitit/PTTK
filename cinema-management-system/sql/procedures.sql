-- ====================================================================
-- KỊCH BẢN KHỞI TẠO STORED PROCEDURES (MySQL 8.0)
-- Chủ đề số 17: Cinema Management System (Hệ thống quản lý rạp chiếu phim)
-- Môn học: Đảm bảo chất lượng phần mềm (Software Assurance)
-- Cơ sở thiết kế: Thiết kế tĩnh & động Mục 3.3.1 & 3.3.2 của 2 module
-- ====================================================================

SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
SET CHARACTER SET utf8mb4;

USE `cinema_db3`;

DELIMITER //

-- ====================================================================
-- PHÂN HỆ 1: KHÁCH HÀNG TÌM KIẾM THÔNG TIN PHIM (MODULE 1)
-- Các thủ tục phục vụ lớp MovieDAO3
-- ====================================================================

-- 1.1 Thủ tục tìm kiếm phim theo từ khóa tên phim
DROP PROCEDURE IF EXISTS `sp_searchMovies`//
CREATE PROCEDURE `sp_searchMovies`(IN `kw` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci)
BEGIN
    IF `kw` IS NULL OR TRIM(`kw`) = '' THEN
        -- Nếu từ khóa rỗng, hiển thị toàn bộ danh sách phim sắp xếp theo ngày phát hành mới nhất
        SELECT 
            `id`,
            `title`,
            `director`,
            `duration`,
            `releaseDate`,
            `ageRestriction`,
            `description`
        FROM `tblMovie3`
        ORDER BY `releaseDate` DESC, `title` ASC;
    ELSE
        -- Tìm kiếm gần đúng (case-insensitive substring match) theo tên phim
        SELECT 
            `id`,
            `title`,
            `director`,
            `duration`,
            `releaseDate`,
            `ageRestriction`,
            `description`
        FROM `tblMovie3`
        WHERE `title` LIKE CONCAT('%', TRIM(`kw`), '%') COLLATE utf8mb4_unicode_ci
        ORDER BY `title` ASC;
    END IF;
END//

-- 1.2 Thủ tục lấy thông tin chi tiết cơ bản của một bộ phim theo ID
DROP PROCEDURE IF EXISTS `sp_getMovieDetail`//
CREATE PROCEDURE `sp_getMovieDetail`(IN `mId` INT)
BEGIN
    SELECT 
        `id`,
        `title`,
        `director`,
        `duration`,
        `releaseDate`,
        `ageRestriction`,
        `description`
    FROM `tblMovie3`
    WHERE `id` = `mId`;
END//

-- 1.3 Thủ tục lấy danh sách thể loại của một bộ phim
DROP PROCEDURE IF EXISTS `sp_getMovieGenres`//
CREATE PROCEDURE `sp_getMovieGenres`(IN `mId` INT)
BEGIN
    SELECT 
        mg.`id` AS `movieGenreId`,
        mg.`rate` AS `rate`,
        g.`id` AS `genreId`,
        g.`name` AS `genreName`
    FROM `tblMovieGenre3` mg
    JOIN `tblGenre3` g ON mg.`tblGenre3Id` = g.`id`
    WHERE mg.`tblMovie3Id` = `mId`
    ORDER BY g.`name` ASC;
END//

-- 1.4 Thủ tục lấy danh sách diễn viên tham gia một bộ phim
DROP PROCEDURE IF EXISTS `sp_getMovieActors`//
CREATE PROCEDURE `sp_getMovieActors`(IN `mId` INT)
BEGIN
    SELECT 
        ma.`id` AS `movieActorId`,
        ma.`characterName` AS `characterName`,
        a.`id` AS `actorId`,
        a.`name` AS `actorName`
    FROM `tblMovieActor3` ma
    JOIN `tblActor3` a ON ma.`tblActor3Id` = a.`id`
    WHERE ma.`tblMovie3Id` = `mId`
    ORDER BY a.`name` ASC;
END//

-- ====================================================================
-- PHÂN HỆ 2: NHÂN VIÊN QUẢN LÝ XEM THỐNG KÊ KHÁCH HÀNG THEO DOANH THU (MODULE 2)
-- Các thủ tục phục vụ lớp CustomerStatDAO3 và InvoiceDAO3
-- ====================================================================

-- 2.1 Thủ tục tổng hợp báo cáo doanh thu theo khách hàng trong kỳ [sDate, eDate]
-- Sắp xếp giảm dần theo tổng doanh thu (totalRevenue DESC)
DROP PROCEDURE IF EXISTS `sp_getCustomerRevenueStat`//
CREATE PROCEDURE `sp_getCustomerRevenueStat`(IN `sDate` DATE, IN `eDate` DATE)
BEGIN
    SELECT 
        c.`tblUserId` AS `id`,
        c.`code` AS `code`,
        u.`fullName` AS `fullName`,
        u.`phone` AS `phone`,
        COUNT(DISTINCT i.`id`) AS `totalTransactions`,
        COALESCE(SUM(i.`totalAmount`), 0) AS `totalRevenue`
    FROM `tblCustomer3` c
    JOIN `tblUser3` u ON c.`tblUserId` = u.`id`
    JOIN `tblInvoice3` i ON c.`tblUserId` = i.`tblCustomer3UserId`
    WHERE DATE(i.`createdDate`) >= `sDate` AND DATE(i.`createdDate`) <= `eDate`
    GROUP BY c.`tblUserId`, c.`code`, u.`fullName`, u.`phone`
    ORDER BY `totalRevenue` DESC, `totalTransactions` DESC;
END//

-- 2.2 Thủ tục truy vấn danh sách hóa đơn của một khách hàng trong kỳ [sDate, eDate]
DROP PROCEDURE IF EXISTS `sp_getInvoicesOfCustomer`//
CREATE PROCEDURE `sp_getInvoicesOfCustomer`(IN `cId` INT, IN `sDate` DATE, IN `eDate` DATE)
BEGIN
    SELECT 
        i.`id` AS `id`,
        i.`createdDate` AS `createdDate`,
        i.`totalAmount` AS `totalAmount`,
        i.`paymentMethod` AS `paymentMethod`,
        COUNT(t.`id`) AS `totalTickets`
    FROM `tblInvoice3` i
    LEFT JOIN `tblTicket3` t ON i.`id` = t.`tblInvoice3Id`
    WHERE i.`tblCustomer3UserId` = `cId`
      AND DATE(i.`createdDate`) >= `sDate` AND DATE(i.`createdDate`) <= `eDate`
    GROUP BY i.`id`, i.`createdDate`, i.`totalAmount`, i.`paymentMethod`
    ORDER BY i.`createdDate` DESC;
END//

-- 2.3 Thủ tục lấy danh sách vé chi tiết thuộc một hóa đơn cụ thể
DROP PROCEDURE IF EXISTS `sp_getTicketsOfInvoice`//
CREATE PROCEDURE `sp_getTicketsOfInvoice`(IN `invId` INT)
BEGIN
    SELECT 
        t.`id` AS `ticketId`,
        t.`price` AS `price`,
        t.`issueTime` AS `issueTime`,
        t.`status` AS `status`,
        t.`type` AS `ticketType`,
        st.`id` AS `showtimeId`,
        st.`showDate` AS `showDate`,
        st.`startTime` AS `startTime`,
        st.`endTime` AS `endTime`,
        m.`title` AS `movieTitle`,
        r.`name` AS `roomName`,
        seat.`row` AS `seatRow`,
        seat.`number` AS `seatNumber`,
        seat.`type` AS `seatType`
    FROM `tblTicket3` t
    JOIN `tblShowtime3` st ON t.`tblShowtime3Id` = st.`id`
    JOIN `tblMovie3` m ON st.`tblMovie3Id` = m.`id`
    JOIN `tblScreeningRoom3` r ON st.`tblScreeningRoom3Id` = r.`id`
    JOIN `tblSeat3` seat ON t.`tblSeat3Id` = seat.`id`
    WHERE t.`tblInvoice3Id` = `invId`
    ORDER BY seat.`row` ASC, seat.`number` ASC;
END//

DELIMITER ;
