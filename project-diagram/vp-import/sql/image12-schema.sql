-- =============================================================================
-- Database Schema DDL for Cinema Management System (Subject No. 17)
-- Diagram: image12 (Relational Database Schema Diagram)
-- Format: Standard MySQL / Visual Paradigm Reverse DDL Compatible
-- Generated in compliance with case-study/BG HP TTTN 2 CNPM 2020 final.pdf
-- =============================================================================

DROP TABLE IF EXISTS tblTicket3;
DROP TABLE IF EXISTS tblInvoice3;
DROP TABLE IF EXISTS tblShowtime3;
DROP TABLE IF EXISTS tblMovieActor3;
DROP TABLE IF EXISTS tblMovieGenre3;
DROP TABLE IF EXISTS tblActor3;
DROP TABLE IF EXISTS tblGenre3;
DROP TABLE IF EXISTS tblMovie3;
DROP TABLE IF EXISTS tblSeat3;
DROP TABLE IF EXISTS tblScreeningRoom3;
DROP TABLE IF EXISTS tblCinema3;
DROP TABLE IF EXISTS tblMembershipCard3;
DROP TABLE IF EXISTS tblCustomer3;
DROP TABLE IF EXISTS tblSaler3;
DROP TABLE IF EXISTS tblManager3;
DROP TABLE IF EXISTS tblStaff3;
DROP TABLE IF EXISTS tblUser3;

-- -----------------------------------------------------------------------------
-- 1. NHÓM NGƯỜI DÙNG & PHÂN QUYỀN (Inheritance Mapping via Shared PK/FK)
-- -----------------------------------------------------------------------------

CREATE TABLE tblUser3 (
    id int(10) NOT NULL AUTO_INCREMENT,
    username varchar(255) NOT NULL UNIQUE,
    password varchar(255) NOT NULL,
    fullName varchar(255) NOT NULL,
    email varchar(255),
    phone varchar(255),
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE tblStaff3 (
    tblUserId int(10) NOT NULL,
    role varchar(255) NOT NULL,
    PRIMARY KEY (tblUserId),
    CONSTRAINT fk_staff_user FOREIGN KEY (tblUserId) REFERENCES tblUser3 (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE tblManager3 (
    tblStaffId int(10) NOT NULL,
    PRIMARY KEY (tblStaffId),
    CONSTRAINT fk_manager_staff FOREIGN KEY (tblStaffId) REFERENCES tblStaff3 (tblUserId) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE tblSaler3 (
    tblStaffId int(10) NOT NULL,
    PRIMARY KEY (tblStaffId),
    CONSTRAINT fk_saler_staff FOREIGN KEY (tblStaffId) REFERENCES tblStaff3 (tblUserId) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE tblCustomer3 (
    tblUserId int(10) NOT NULL,
    code varchar(255) NOT NULL UNIQUE,
    PRIMARY KEY (tblUserId),
    CONSTRAINT fk_customer_user FOREIGN KEY (tblUserId) REFERENCES tblUser3 (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE tblMembershipCard3 (
    id int(10) NOT NULL AUTO_INCREMENT,
    issueDate date NOT NULL,
    points int(10) NOT NULL DEFAULT 0,
    tblCustomer3UserId int(10) NOT NULL UNIQUE,
    PRIMARY KEY (id),
    CONSTRAINT fk_card_customer FOREIGN KEY (tblCustomer3UserId) REFERENCES tblCustomer3 (tblUserId) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- -----------------------------------------------------------------------------
-- 2. NHÓM CƠ SỞ VẬT CHẤT (Facilities: Cinema -> ScreeningRoom -> Seat)
-- -----------------------------------------------------------------------------

CREATE TABLE tblCinema3 (
    id int(10) NOT NULL AUTO_INCREMENT,
    name varchar(255) NOT NULL,
    address varchar(255) NOT NULL,
    phone varchar(255),
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE tblScreeningRoom3 (
    id int(10) NOT NULL AUTO_INCREMENT,
    name varchar(255) NOT NULL,
    capacity int(10) NOT NULL,
    type varchar(255),
    tblCinema3Id int(10) NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_room_cinema FOREIGN KEY (tblCinema3Id) REFERENCES tblCinema3 (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE tblSeat3 (
    id int(10) NOT NULL AUTO_INCREMENT,
    row varchar(255) NOT NULL,
    number int(10) NOT NULL,
    type varchar(255),
    tblScreeningRoom3Id int(10) NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_seat_room FOREIGN KEY (tblScreeningRoom3Id) REFERENCES tblScreeningRoom3 (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- -----------------------------------------------------------------------------
-- 3. NHÓM PHIM, NGHỆ THUẬT & LIÊN KẾT (Movie, Genre, Actor)
-- -----------------------------------------------------------------------------

CREATE TABLE tblMovie3 (
    id int(10) NOT NULL AUTO_INCREMENT,
    title varchar(255) NOT NULL,
    director varchar(255),
    duration int(10) NOT NULL,
    releaseDate date,
    ageRestriction int(10) DEFAULT 0,
    description varchar(500),
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE tblGenre3 (
    id int(10) NOT NULL AUTO_INCREMENT,
    name varchar(255) NOT NULL,
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE tblActor3 (
    id int(10) NOT NULL AUTO_INCREMENT,
    name varchar(255) NOT NULL,
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE tblMovieGenre3 (
    id int(10) NOT NULL AUTO_INCREMENT,
    rate float(10) DEFAULT 0,
    tblMovie3Id int(10) NOT NULL,
    tblGenre3Id int(10) NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_mg_movie FOREIGN KEY (tblMovie3Id) REFERENCES tblMovie3 (id) ON DELETE CASCADE,
    CONSTRAINT fk_mg_genre FOREIGN KEY (tblGenre3Id) REFERENCES tblGenre3 (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE tblMovieActor3 (
    id int(10) NOT NULL AUTO_INCREMENT,
    characterName varchar(255),
    tblMovie3Id int(10) NOT NULL,
    tblActor3Id int(10) NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_ma_movie FOREIGN KEY (tblMovie3Id) REFERENCES tblMovie3 (id) ON DELETE CASCADE,
    CONSTRAINT fk_ma_actor FOREIGN KEY (tblActor3Id) REFERENCES tblActor3 (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- -----------------------------------------------------------------------------
-- 4. NHÓM SUẤT CHIẾU, HÓA ĐƠN & VÉ (Showtime, Invoice, Ticket)
-- -----------------------------------------------------------------------------

CREATE TABLE tblShowtime3 (
    id int(10) NOT NULL AUTO_INCREMENT,
    showDate date NOT NULL,
    startTime varchar(10) NOT NULL,
    endTime varchar(10) NOT NULL,
    format varchar(255),
    basePrice float(10) NOT NULL,
    tblMovie3Id int(10) NOT NULL,
    tblScreeningRoom3Id int(10) NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_showtime_movie FOREIGN KEY (tblMovie3Id) REFERENCES tblMovie3 (id) ON DELETE CASCADE,
    CONSTRAINT fk_showtime_room FOREIGN KEY (tblScreeningRoom3Id) REFERENCES tblScreeningRoom3 (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE tblInvoice3 (
    id int(10) NOT NULL AUTO_INCREMENT,
    createdDate datetime NOT NULL,
    totalAmount float(10) NOT NULL,
    paymentMethod varchar(255),
    tblCustomer3UserId int(10) NOT NULL,
    tblSaler3StaffId int(10),
    PRIMARY KEY (id),
    CONSTRAINT fk_invoice_customer FOREIGN KEY (tblCustomer3UserId) REFERENCES tblCustomer3 (tblUserId),
    CONSTRAINT fk_invoice_saler FOREIGN KEY (tblSaler3StaffId) REFERENCES tblSaler3 (tblStaffId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE tblTicket3 (
    id int(10) NOT NULL AUTO_INCREMENT,
    price float(10) NOT NULL,
    issueTime datetime NOT NULL,
    status varchar(255),
    type varchar(255),
    tblShowtime3Id int(10) NOT NULL,
    tblSeat3Id int(10) NOT NULL,
    tblInvoice3Id int(10) NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_ticket_showtime FOREIGN KEY (tblShowtime3Id) REFERENCES tblShowtime3 (id) ON DELETE CASCADE,
    CONSTRAINT fk_ticket_seat FOREIGN KEY (tblSeat3Id) REFERENCES tblSeat3 (id) ON DELETE CASCADE,
    CONSTRAINT fk_ticket_invoice FOREIGN KEY (tblInvoice3Id) REFERENCES tblInvoice3 (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
