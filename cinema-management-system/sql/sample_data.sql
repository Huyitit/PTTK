-- ====================================================================
-- SAMPLE DATA SCRIPT (MySQL 8.0)
-- Subject No. 17: Cinema Management System
-- Course: Software Assurance
-- Standard: English language data, pure ASCII, preserving all Section 2.1 scenarios
-- ====================================================================

SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
SET CHARACTER SET utf8mb4;

USE `cinema_db3`;

SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE `tblTicket3`;
TRUNCATE TABLE `tblInvoice3`;
TRUNCATE TABLE `tblShowtime3`;
TRUNCATE TABLE `tblMovieActor3`;
TRUNCATE TABLE `tblMovieGenre3`;
TRUNCATE TABLE `tblActor3`;
TRUNCATE TABLE `tblGenre3`;
TRUNCATE TABLE `tblMovie3`;
TRUNCATE TABLE `tblSeat3`;
TRUNCATE TABLE `tblScreeningRoom3`;
TRUNCATE TABLE `tblCinema3`;
TRUNCATE TABLE `tblMembershipCard3`;
TRUNCATE TABLE `tblCustomer3`;
TRUNCATE TABLE `tblSaler3`;
TRUNCATE TABLE `tblManager3`;
TRUNCATE TABLE `tblStaff3`;
TRUNCATE TABLE `tblUser3`;
SET FOREIGN_KEY_CHECKS = 1;

-- ====================================================================
-- 1. USERS DATA (30 Users)
-- ====================================================================
INSERT INTO `tblUser3` (`id`, `username`, `password`, `fullName`, `email`, `phone`) VALUES
(1, 'manager1', '123456', 'John Manager', 'manager1@cinema.com', '0901000001'),
(2, 'saler1', '123456', 'Alice Cashier', 'saler1@cinema.com', '0901000002'),
(3, 'saler2', '123456', 'Bob Cashier', 'saler2@cinema.com', '0901000003'),
(4, 'customer01', '123456', 'John Doe', 'johndoe@gmail.com', '0912345678'),
(5, 'customer02', '123456', 'Jane Smith', 'janesmith@gmail.com', '0987654321'),
(6, 'customer03', '123456', 'Michael Brown', 'michaelbrown@gmail.com', '0903123456'),
(7, 'customer04', '123456', 'David Wilson', 'davidwilson@gmail.com', '0945678901'),
(8, 'customer05', '123456', 'Emma Johnson', 'emmajohnson@gmail.com', '0911223344'),
(9, 'customer06', '123456', 'James Williams', 'jameswilliams@gmail.com', '0922334455'),
(10, 'customer07', '123456', 'Olivia Jones', 'oliviajones@gmail.com', '0933445566'),
(11, 'customer08', '123456', 'William Garcia', 'williamgarcia@gmail.com', '0944556677'),
(12, 'customer09', '123456', 'Sophia Miller', 'sophiamiller@gmail.com', '0955667788'),
(13, 'customer10', '123456', 'Benjamin Davis', 'benjamindavis@gmail.com', '0966778899'),
(14, 'customer11', '123456', 'Mia Rodriguez', 'miarodriguez@gmail.com', '0977889900'),
(15, 'customer12', '123456', 'Lucas Martinez', 'lucasmartinez@gmail.com', '0988990011'),
(16, 'customer13', '123456', 'Henry Hernandez', 'henryhernandez@gmail.com', '0999001122'),
(17, 'customer14', '123456', 'Alexander Lopez', 'alexanderlopez@gmail.com', '0900112233'),
(18, 'customer15', '123456', 'Charlotte Gonzalez', 'charlottegonzalez@gmail.com', '0912233445'),
(19, 'customer16', '123456', 'Daniel Wilson', 'danielwilson@gmail.com', '0923344556'),
(20, 'customer17', '123456', 'Matthew Anderson', 'matthewanderson@gmail.com', '0934455667'),
(21, 'customer18', '123456', 'Jackson Thomas', 'jacksonthomas@gmail.com', '0945566778'),
(22, 'customer19', '123456', 'Sebastian Taylor', 'sebastiantaylor@gmail.com', '0956677889'),
(23, 'customer20', '123456', 'Jack Moore', 'jackmoore@gmail.com', '0967788990'),
(24, 'customer21', '123456', 'Samuel Jackson', 'samueljackson@gmail.com', '0978899001'),
(25, 'customer22', '123456', 'Owen Martin', 'owenmartin@gmail.com', '0989900112'),
(26, 'customer23', '123456', 'Ethan Lee', 'ethanlee@gmail.com', '0990011223'),
(27, 'customer24', '123456', 'Liam Harris', 'liamharris@gmail.com', '0901122334'),
(28, 'customer25', '123456', 'Noah Clark', 'noahclark@gmail.com', '0913344556'),
(29, 'customer26', '123456', 'Oliver Lewis', 'oliverlewis@gmail.com', '0924455667'),
(30, 'customer27', '123456', 'Robert Evans', 'robertevans@gmail.com', '0935566778');

-- ====================================================================
-- 2. STAFF & ROLES DATA (tblStaff3, tblManager3, tblSaler3)
-- ====================================================================
INSERT INTO `tblStaff3` (`tblUserId`, `role`) VALUES
(1, 'Cinema Manager'),
(2, 'Ticket Saler'),
(3, 'Cashier');

INSERT INTO `tblManager3` (`tblStaffId`) VALUES (1);
INSERT INTO `tblSaler3` (`tblStaffId`) VALUES (2), (3);

-- ====================================================================
-- 3. CUSTOMER & MEMBERSHIP CARDS (27 Customers)
-- ====================================================================
INSERT INTO `tblCustomer3` (`tblUserId`, `code`) VALUES
(4, 'KH001'),
(5, 'KH008'),
(6, 'KH015'),
(7, 'KH003'),
(8, 'KH005'),
(9, 'KH006'),
(10, 'KH007'),
(11, 'KH009'),
(12, 'KH010'),
(13, 'KH011'),
(14, 'KH012'),
(15, 'KH013'),
(16, 'KH014'),
(17, 'KH016'),
(18, 'KH017'),
(19, 'KH018'),
(20, 'KH019'),
(21, 'KH020'),
(22, 'KH021'),
(23, 'KH022'),
(24, 'KH023'),
(25, 'KH024'),
(26, 'KH025'),
(27, 'KH026'),
(28, 'KH027'),
(29, 'KH028'),
(30, 'KH099');

INSERT INTO `tblMembershipCard3` (`id`, `issueDate`, `points`, `tblCustomer3UserId`) VALUES
(1, '2024-01-10', 150, 4),
(2, '2024-02-15', 120, 5),
(3, '2024-03-20', 95, 6),
(4, '2024-04-05', 60, 7),
(5, '2024-05-12', 40, 8),
(6, '2024-06-18', 85, 9),
(7, '2024-07-22', 110, 10),
(8, '2024-08-30', 30, 11),
(9, '2024-09-14', 55, 12),
(10, '2024-10-01', 70, 13),
(11, '2024-10-15', 25, 14),
(12, '2024-11-02', 90, 15),
(13, '2024-11-20', 45, 16),
(14, '2024-12-05', 130, 17),
(15, '2024-12-18', 65, 18),
(16, '2025-01-08', 50, 19),
(17, '2025-01-20', 80, 20),
(18, '2025-02-14', 105, 21),
(19, '2025-03-01', 35, 22),
(20, '2025-03-15', 75, 23),
(21, '2025-04-10', 115, 24),
(22, '2025-05-05', 20, 25),
(23, '2025-06-12', 60, 26),
(24, '2025-07-01', 40, 27),
(25, '2025-08-15', 95, 28),
(26, '2025-09-20', 10, 29),
(27, '2025-10-01', 0, 30);

-- ====================================================================
-- 4. VENUES & ROOMS (3 Cinemas, 6 Screening Rooms, 60 Seats)
-- ====================================================================
INSERT INTO `tblCinema3` (`id`, `name`, `address`, `phone`) VALUES
(1, 'CGV Vincom Center', '191 Ba Trieu, Hai Ba Trung, Hanoi', '02439743333'),
(2, 'CGV Trang Tien Plaza', '24 Hai Ba Trung, Hoan Kiem, Hanoi', '02439365555'),
(3, 'CGV Aeon Mall Ha Dong', 'Hoang Van Thu Urban Area, Ha Dong, Hanoi', '02432008888');

INSERT INTO `tblScreeningRoom3` (`id`, `name`, `capacity`, `type`, `tblCinema3Id`) VALUES
(1, 'Screen 01 (IMAX)', 20, 'IMAX Laser', 1),
(2, 'Screen 02 (2D Standard)', 20, '2D Standard', 1),
(3, 'Screen 03 (3D Digital)', 20, '3D Digital', 2),
(4, 'Screen 04 (Gold Class VIP)', 20, 'Gold Class VIP', 2),
(5, 'Screen 05 (4DX)', 20, '4DX Motion', 3),
(6, 'Screen 06 (ScreenX)', 20, 'ScreenX 270', 3);

-- 60 seats (10 seats per room: A1-A5 Standard, B1-B5 VIP)
INSERT INTO `tblSeat3` (`id`, `row`, `number`, `type`, `tblScreeningRoom3Id`) VALUES
-- Room 1
(1, 'A', 1, 'Standard', 1), (2, 'A', 2, 'Standard', 1), (3, 'A', 3, 'Standard', 1), (4, 'A', 4, 'Standard', 1), (5, 'A', 5, 'Standard', 1),
(6, 'B', 1, 'VIP', 1), (7, 'B', 2, 'VIP', 1), (8, 'B', 3, 'VIP', 1), (9, 'B', 4, 'VIP', 1), (10, 'B', 5, 'VIP', 1),
-- Room 2
(11, 'A', 1, 'Standard', 2), (12, 'A', 2, 'Standard', 2), (13, 'A', 3, 'Standard', 2), (14, 'A', 4, 'Standard', 2), (15, 'A', 5, 'Standard', 2),
(16, 'B', 1, 'VIP', 2), (17, 'B', 2, 'VIP', 2), (18, 'B', 3, 'VIP', 2), (19, 'B', 4, 'VIP', 2), (20, 'B', 5, 'VIP', 2),
-- Room 3
(21, 'A', 1, 'Standard', 3), (22, 'A', 2, 'Standard', 3), (23, 'A', 3, 'Standard', 3), (24, 'A', 4, 'Standard', 3), (25, 'A', 5, 'Standard', 3),
(26, 'B', 1, 'VIP', 3), (27, 'B', 2, 'VIP', 3), (28, 'B', 3, 'VIP', 3), (29, 'B', 4, 'VIP', 3), (30, 'B', 5, 'VIP', 3),
-- Room 4
(31, 'A', 1, 'Standard', 4), (32, 'A', 2, 'Standard', 4), (33, 'A', 3, 'Standard', 4), (34, 'A', 4, 'Standard', 4), (35, 'A', 5, 'Standard', 4),
(36, 'B', 1, 'VIP', 4), (37, 'B', 2, 'VIP', 4), (38, 'B', 3, 'VIP', 4), (39, 'B', 4, 'VIP', 4), (40, 'B', 5, 'VIP', 4),
-- Room 5
(41, 'A', 1, 'Standard', 5), (42, 'A', 2, 'Standard', 5), (43, 'A', 3, 'Standard', 5), (44, 'A', 4, 'Standard', 5), (45, 'A', 5, 'Standard', 5),
(46, 'B', 1, 'VIP', 5), (47, 'B', 2, 'VIP', 5), (48, 'B', 3, 'VIP', 5), (49, 'B', 4, 'VIP', 5), (50, 'B', 5, 'VIP', 5),
-- Room 6
(51, 'A', 1, 'Standard', 6), (52, 'A', 2, 'Standard', 6), (53, 'A', 3, 'Standard', 6), (54, 'A', 4, 'Standard', 6), (55, 'A', 5, 'Standard', 6),
(56, 'B', 1, 'VIP', 6), (57, 'B', 2, 'VIP', 6), (58, 'B', 3, 'VIP', 6), (59, 'B', 4, 'VIP', 6), (60, 'B', 5, 'VIP', 6);

-- ====================================================================
-- 5. GENRES (10 Genres) & ACTORS (25 Actors)
-- ====================================================================
INSERT INTO `tblGenre3` (`id`, `name`) VALUES
(1, 'Action'),
(2, 'Sci-Fi'),
(3, 'Adventure'),
(4, 'Animation'),
(5, 'Drama'),
(6, 'Horror'),
(7, 'Comedy'),
(8, 'Romance'),
(9, 'War'),
(10, 'Crime');

INSERT INTO `tblActor3` (`id`, `name`) VALUES
(1, 'Sam Worthington'),
(2, 'Zoe Saldana'),
(3, 'Sigourney Weaver'),
(4, 'Tom Cruise'),
(5, 'Leonardo DiCaprio'),
(6, 'Cillian Murphy'),
(7, 'Keanu Reeves'),
(8, 'Brad Pitt'),
(9, 'Robert Downey Jr.'),
(10, 'Chris Evans'),
(11, 'Scarlett Johansson'),
(12, 'Christian Bale'),
(13, 'Matthew McConaughey'),
(14, 'Anne Hathaway'),
(15, 'Morgan Freeman'),
(16, 'Gary Oldman'),
(17, 'Florence Pugh'),
(18, 'Timothee Chalamet'),
(19, 'Zendaya'),
(20, 'Heath Ledger'),
(21, 'Emily Blunt'),
(22, 'Matt Damon'),
(23, 'Hugh Jackman'),
(24, 'Kate Winslet'),
(25, 'Ryan Gosling');

-- ====================================================================
-- 6. MOVIES DATA (25 Movies)
-- ====================================================================
INSERT INTO `tblMovie3` (`id`, `title`, `director`, `duration`, `releaseDate`, `ageRestriction`, `description`) VALUES
(1, 'Avatar: The Way of Water', 'James Cameron', 192, '2022-12-16', 0, 'Jake Sully lives with his newfound family formed on the extrasolar moon Pandora. Once a familiar threat returns to finish what was previously started, Jake must work with Neytiri and the army of the Na\'vi race to protect their home.'),
(2, 'Avatar: The First Journey', 'James Cameron', 162, '2024-12-18', 13, 'A paraplegic Marine dispatched to the moon Pandora on a unique mission becomes torn between following his orders and protecting the world he feels is his home.'),
(3, 'Mission: Impossible - Dead Reckoning', 'Christopher McQuarrie', 163, '2023-07-14', 16, 'Ethan Hunt and his IMF team must track down a dangerous weapon before it falls into the wrong hands.'),
(4, 'Inception', 'Christopher Nolan', 148, '2010-07-16', 16, 'A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a C.E.O.'),
(5, 'Oppenheimer', 'Christopher Nolan', 180, '2023-08-11', 18, 'The story of American scientist J. Robert Oppenheimer and his role in the development of the atomic bomb.'),
(6, 'Interstellar', 'Christopher Nolan', 169, '2014-11-07', 13, 'When Earth becomes uninhabitable in the future, a farmer and ex-NASA pilot, Joseph Cooper, is tasked to pilot a spacecraft, along with a team of researchers, to find a new planet for humans.'),
(7, 'John Wick: Chapter 4', 'Chad Stahelski', 169, '2023-03-24', 18, 'John Wick uncovers a path to defeating The High Table. But before he can earn his freedom, Wick must face off against a new enemy with powerful alliances across the globe.'),
(8, 'The Dark Knight', 'Christopher Nolan', 152, '2008-07-18', 16, 'When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.'),
(9, 'Avengers: Endgame', 'Anthony Russo', 181, '2019-04-26', 13, 'After the devastating events of Avengers: Infinity War, the universe is in ruins. With the help of remaining allies, the Avengers assemble once more in order to reverse Thanos\' actions and restore balance to the universe.'),
(10, 'Iron Man', 'Jon Favreau', 126, '2008-05-02', 13, 'After being held captive in an Afghan cave, billionaire engineer Tony Stark creates a unique weaponized suit of armor to fight evil.'),
(11, 'Top Gun: Maverick', 'Joseph Kosinski', 130, '2022-05-27', 13, 'After thirty years, Maverick is still pushing the envelope as a top naval aviator, but must confront ghosts of his past when he leads TOP GUN\'s elite graduates on a mission that demands the ultimate sacrifice from those chosen to fly it.'),
(12, 'Dune: Part Two', 'Denis Villeneuve', 166, '2024-03-01', 13, 'Paul Atreides unites with Chani and the Fremen while seeking revenge against the conspirators who destroyed his family.'),
(13, 'Blade Runner 2049', 'Denis Villeneuve', 164, '2017-10-06', 16, 'Young Blade Runner K\'s discovery of a long-buried secret leads him to track down former Blade Runner Rick Deckard, who\'s been missing for thirty years.'),
(14, 'Spirited Away', 'Hayao Miyazaki', 125, '2001-07-20', 0, 'During her family\'s move to the suburbs, a sullen 10-year-old girl wanders into a world ruled by gods, witches, and spirits, and where humans are changed into beasts.'),
(15, 'Titanic', 'James Cameron', 195, '1997-12-19', 16, 'A seventeen-year-old aristocrat falls in love with a kind but poor artist aboard the luxurious, ill-fated R.M.S. Titanic.'),
(16, 'The Prestige', 'Christopher Nolan', 130, '2006-10-20', 16, 'After a tragic accident, two stage magicians in 1890s London engage in a battle to create the ultimate illusion while sacrificing everything they have to outwit each other.'),
(17, 'Gladiator', 'Ridley Scott', 155, '2000-05-05', 16, 'A former Roman General sets out to exact vengeance against the corrupt emperor who murdered his family and sent him into slavery.'),
(18, 'La La Land', 'Damien Chazelle', 128, '2016-12-09', 13, 'While navigating their careers in Los Angeles, a pianist and an actress fall in love while attempting to reconcile their aspirations for the future.'),
(19, 'The Wolf of Wall Street', 'Martin Scorsese', 180, '2013-12-25', 18, 'Based on the true story of Jordan Belfort, from his rise to a wealthy stock-broker living the high life to his fall involving crime, corruption and the federal government.'),
(20, 'Spider-Man: Across the Spider-Verse', 'Joaquim Dos Santos', 140, '2023-06-02', 0, 'Miles Morales catapults across the Multiverse, where he encounters a team of Spider-People charged with protecting its very existence.'),
(21, 'The Shawshank Redemption', 'Frank Darabont', 142, '1994-10-14', 16, 'Over the course of several years, two convicts form a friendship, seeking consolation and, eventually, redemption through basic compassion.'),
(22, 'Fight Club', 'David Fincher', 139, '1999-10-15', 18, 'An insomniac office worker and a devil-may-care soap maker form an underground fight club that evolves into much more.'),
(23, 'Pulp Fiction', 'Quentin Tarantino', 154, '1994-10-14', 18, 'The lives of two mob hitmen, a boxer, a gangster and his wife, and a pair of diner bandits intertwine in four tales of violence and redemption.'),
(24, 'The Matrix', 'Lana Wachowski', 136, '1999-03-31', 16, 'When a beautiful stranger leads computer hacker Neo to a forbidding underworld, he discovers the shocking truth--the life he knows is the elaborate deception of an evil cyber-intelligence.'),
(25, 'Dunkirk', 'Christopher Nolan', 106, '2017-07-21', 13, 'Allied soldiers from Belgium, the British Commonwealth and Empire, and France are surrounded by the German Army and evacuated during a fierce battle in World War II.');

-- ====================================================================
-- 7. MOVIE - GENRE RELATIONS (tblMovieGenre3)
-- ====================================================================
INSERT INTO `tblMovieGenre3` (`id`, `rate`, `tblMovie3Id`, `tblGenre3Id`) VALUES
(1, 0.9, 1, 1), (2, 0.9, 1, 2), (3, 0.8, 1, 3),
(4, 0.9, 2, 2), (5, 0.8, 2, 3),
(6, 0.95, 3, 1), (7, 0.8, 3, 3),
(8, 0.9, 4, 2), (9, 0.85, 4, 1),
(10, 0.95, 5, 5), (11, 0.8, 5, 9),
(12, 0.9, 6, 2), (13, 0.85, 6, 5),
(14, 0.95, 7, 1), (15, 0.8, 7, 10),
(16, 0.95, 8, 1), (17, 0.9, 8, 10),
(18, 0.95, 9, 1), (19, 0.9, 9, 2),
(20, 0.9, 10, 1), (21, 0.85, 10, 2),
(22, 0.95, 11, 1), (23, 0.8, 11, 5),
(24, 0.95, 12, 2), (25, 0.8, 12, 3),
(26, 0.95, 13, 2), (27, 0.85, 13, 1),
(28, 0.95, 14, 4), (29, 0.9, 14, 3),
(30, 0.95, 15, 8), (31, 0.9, 15, 5),
(32, 0.9, 16, 5), (33, 0.85, 16, 2),
(34, 0.9, 17, 1), (35, 0.8, 17, 5),
(36, 0.9, 18, 8), (37, 0.8, 18, 5),
(38, 0.9, 19, 5), (39, 0.85, 19, 7),
(40, 0.9, 20, 4), (41, 0.8, 20, 1),
(42, 0.95, 21, 5), (43, 0.9, 21, 10),
(44, 0.9, 22, 5), (45, 0.8, 22, 1),
(46, 0.95, 23, 10), (47, 0.85, 23, 1),
(48, 0.95, 24, 1), (49, 0.85, 24, 2),
(50, 0.9, 25, 9), (51, 0.85, 25, 5);

-- ====================================================================
-- 8. MOVIE - ACTOR RELATIONS (tblMovieActor3)
-- ====================================================================
INSERT INTO `tblMovieActor3` (`id`, `characterName`, `tblMovie3Id`, `tblActor3Id`) VALUES
(1, 'Jake Sully', 1, 1),
(2, 'Neytiri', 1, 2),
(3, 'Kiri', 1, 3),
(4, 'Jake Sully', 2, 1),
(5, 'Neytiri', 2, 2),
(6, 'Ethan Hunt', 3, 4),
(7, 'Dom Cobb', 4, 5),
(8, 'J. Robert Oppenheimer', 5, 6),
(9, 'John Wick', 7, 7),
(10, 'Bruce Wayne / Batman', 8, 12),
(11, 'Tony Stark / Iron Man', 9, 9),
(12, 'Steve Rogers / Captain America', 9, 10),
(13, 'Natasha Romanoff / Black Widow', 9, 11),
(14, 'Tony Stark / Iron Man', 10, 9),
(15, 'Pete Maverick Mitchell', 11, 4),
(16, 'Paul Atreides', 12, 18),
(17, 'Chani', 12, 19),
(18, 'Princess Irulan', 12, 17),
(19, 'Rick Deckard', 13, 25),
(20, 'Chihiro', 14, 2),
(21, 'Jack Dawson', 15, 5),
(22, 'Rose DeWitt Bukater', 15, 24),
(23, 'Alfred Borden', 16, 12),
(24, 'Robert Angier', 16, 23),
(25, 'Maximus', 17, 12),
(26, 'Sebastian Wilder', 18, 25),
(27, 'Mia Dolan', 18, 11),
(28, 'Jordan Belfort', 19, 5),
(29, 'Andy Dufresne', 21, 15),
(30, 'Tyler Durden', 22, 8),
(31, 'Vincent Vega', 23, 7),
(32, 'Thomas A. Anderson / Neo', 24, 7);

-- ====================================================================
-- 9. SHOWTIMES DATA (tblShowtime3 - 35 Showtimes)
-- ====================================================================
INSERT INTO `tblShowtime3` (`id`, `showDate`, `startTime`, `endTime`, `format`, `basePrice`, `tblMovie3Id`, `tblScreeningRoom3Id`) VALUES
-- January 2026 (Main Report Period)
(1, '2026-01-05', '19:30', '22:45', '2D Subtitle', 250000, 1, 1),
(2, '2026-01-05', '20:00', '22:30', '2D Dubbed', 200000, 3, 2),
(3, '2026-01-10', '14:00', '17:15', '3D Subtitle', 300000, 1, 3),
(4, '2026-01-15', '20:15', '23:30', '2D Subtitle', 300000, 1, 1),
(5, '2026-01-15', '18:00', '20:30', '2D Subtitle', 150000, 4, 2),
(6, '2026-01-20', '19:00', '21:15', '2D Original', 120000, 16, 4),
(7, '2026-01-22', '20:00', '22:30', '2D Original', 130000, 17, 2),
(8, '2026-01-25', '15:00', '17:00', '2D Dubbed', 100000, 12, 1),
(9, '2026-01-28', '18:00', '21:15', '2D Subtitle', 200000, 1, 1),
(10, '2026-01-28', '21:30', '23:45', '2D Subtitle', 150000, 7, 2),
(11, '2026-01-30', '19:30', '22:00', '2D Original', 140000, 18, 5),
-- December 2025
(12, '2025-12-15', '19:00', '21:30', '2D Subtitle', 150000, 4, 1),
(13, '2025-12-20', '20:00', '22:30', '2D Subtitle', 180000, 5, 2),
(14, '2025-12-24', '18:30', '21:45', '3D Subtitle', 250000, 1, 3),
(15, '2025-12-31', '21:00', '23:30', '2D Subtitle', 200000, 3, 1),
-- February 2026
(16, '2026-02-05', '19:00', '21:30', '2D Subtitle', 150000, 6, 2),
(17, '2026-02-10', '20:00', '22:30', '2D Subtitle', 160000, 8, 1),
(18, '2026-02-14', '19:30', '22:45', '2D Subtitle', 250000, 15, 4),
(19, '2026-02-20', '18:00', '20:30', '2D Original', 120000, 16, 2),
(20, '2026-02-25', '20:30', '22:45', '2D Original', 130000, 21, 5),
-- Diverse Showtimes in January 2026
(21, '2026-01-02', '09:30', '11:45', '2D Dubbed', 90000, 12, 1),
(22, '2026-01-03', '13:30', '15:45', '2D Subtitle', 110000, 13, 2),
(23, '2026-01-04', '16:00', '18:30', '2D Subtitle', 130000, 11, 3),
(24, '2026-01-06', '10:00', '12:30', '2D Subtitle', 100000, 10, 1),
(25, '2026-01-08', '14:30', '17:30', '2D Subtitle', 140000, 9, 2),
(26, '2026-01-12', '18:00', '20:30', '2D Original', 120000, 19, 4),
(27, '2026-01-14', '20:30', '22:30', '2D Original', 100000, 20, 5),
(28, '2026-01-16', '19:00', '21:00', '2D Original', 110000, 22, 6),
(29, '2026-01-18', '21:00', '23:00', '2D Original', 130000, 23, 1),
(30, '2026-01-21', '19:30', '21:30', '2D Original', 120000, 24, 2),
(31, '2026-01-24', '18:00', '20:00', '2D Original', 110000, 25, 3),
(32, '2026-01-26', '20:00', '22:30', '2D Subtitle', 140000, 8, 4),
(33, '2026-01-27', '19:00', '21:30', '2D Subtitle', 150000, 6, 5),
(34, '2026-01-29', '21:00', '23:30', '2D Subtitle', 160000, 5, 6),
(35, '2026-01-31', '20:00', '22:30', '2D Subtitle', 150000, 3, 1);

-- ====================================================================
-- 10. INVOICES DATA (tblInvoice3 - 45 Invoices)
-- Strictly preserves Section 2.1 business scenarios:
-- KH001: 3 invoices, 1,500,000 VND
-- KH008: 4 invoices, 1,200,000 VND
-- KH015: 4 invoices, 950,000 VND
-- KH003: 3 invoices, 600,000 VND
-- ====================================================================
INSERT INTO `tblInvoice3` (`id`, `createdDate`, `totalAmount`, `paymentMethod`, `tblCustomer3UserId`, `tblSaler3StaffId`) VALUES
-- 1. Customer 4 (KH001 - John Doe): 3 invoices in Jan 2026, total 1,500,000 VND
(1, '2026-01-05 19:30:00', 500000, 'Credit Card', 4, 2),
(2, '2026-01-15 20:15:00', 600000, 'E-Wallet', 4, 2),
(3, '2026-01-28 18:00:00', 400000, 'Cash', 4, 3),

-- 2. Customer 5 (KH008 - Jane Smith): 4 invoices in Jan 2026, total 1,200,000 VND
(4, '2026-01-06 10:15:00', 300000, 'E-Wallet', 5, 2),
(5, '2026-01-12 18:30:00', 300000, 'Cash', 5, 3),
(6, '2026-01-19 19:00:00', 300000, 'Credit Card', 5, 2),
(7, '2026-01-26 20:30:00', 300000, 'E-Wallet', 5, 2),

-- 3. Customer 6 (KH015 - Michael Brown): 4 invoices in Jan 2026, total 950,000 VND
(8, '2026-01-04 16:30:00', 250000, 'Cash', 6, 3),
(9, '2026-01-11 14:00:00', 200000, 'Credit Card', 6, 2),
(10, '2026-01-18 21:15:00', 300000, 'E-Wallet', 6, 2),
(11, '2026-01-25 15:30:00', 200000, 'Cash', 6, 3),

-- 4. Customer 7 (KH003 - David Wilson): 3 invoices in Jan 2026, total 600,000 VND
(12, '2026-01-08 15:00:00', 200000, 'E-Wallet', 7, 2),
(13, '2026-01-17 19:30:00', 200000, 'Credit Card', 7, 3),
(14, '2026-01-27 20:00:00', 200000, 'Cash', 7, 2),

-- 5. Other Customers in January 2026
(15, '2026-01-02 09:45:00', 180000, 'E-Wallet', 8, 2),
(16, '2026-01-07 14:00:00', 220000, 'Credit Card', 8, 3),
(17, '2026-01-14 20:45:00', 200000, 'Cash', 9, 2),
(18, '2026-01-21 19:45:00', 240000, 'E-Wallet', 9, 2),
(19, '2026-01-09 18:00:00', 300000, 'Credit Card', 10, 3),
(20, '2026-01-23 20:00:00', 260000, 'Cash', 10, 2),
(21, '2026-01-13 18:30:00', 220000, 'E-Wallet', 11, 2),
(22, '2026-01-24 18:15:00', 220000, 'Credit Card', 12, 3),
(23, '2026-01-16 19:15:00', 220000, 'Cash', 13, 2),
(24, '2026-01-29 21:15:00', 320000, 'E-Wallet', 14, 2),
(25, '2026-01-30 19:45:00', 280000, 'Credit Card', 15, 3),
(26, '2026-01-03 13:45:00', 220000, 'Cash', 16, 2),
(27, '2026-01-22 20:15:00', 260000, 'E-Wallet', 17, 2),
(28, '2026-01-31 20:15:00', 300000, 'Credit Card', 18, 3),

-- 6. December 2025 Invoices (For date-range filtering verification)
(29, '2025-12-15 19:15:00', 300000, 'Credit Card', 4, 2),
(30, '2025-12-20 20:15:00', 360000, 'E-Wallet', 5, 2),
(31, '2025-12-24 18:45:00', 500000, 'Cash', 6, 3),
(32, '2025-12-31 21:15:00', 400000, 'Credit Card', 7, 2),
(33, '2025-12-10 14:00:00', 200000, 'E-Wallet', 8, 3),
(34, '2025-12-18 19:00:00', 250000, 'Cash', 9, 2),
(35, '2025-12-25 20:00:00', 300000, 'Credit Card', 10, 3),

-- 7. February 2026 Invoices (For date-range filtering verification)
(36, '2026-02-05 19:15:00', 300000, 'E-Wallet', 4, 2),
(37, '2026-02-10 20:15:00', 320000, 'Credit Card', 5, 3),
(38, '2026-02-14 19:45:00', 500000, 'Cash', 6, 2),
(39, '2026-02-14 20:00:00', 500000, 'E-Wallet', 7, 2),
(40, '2026-02-20 18:15:00', 240000, 'Credit Card', 8, 3),
(41, '2026-02-22 19:00:00', 260000, 'Cash', 19, 2),
(42, '2026-02-24 20:00:00', 280000, 'E-Wallet', 20, 2),
(43, '2026-02-25 20:45:00', 260000, 'Credit Card', 21, 3),
(44, '2026-02-26 18:30:00', 300000, 'Cash', 22, 2),
(45, '2026-02-28 21:00:00', 350000, 'E-Wallet', 23, 2);

-- ====================================================================
-- 11. TICKETS DATA (tblTicket3 - 90 Tickets)
-- ====================================================================
INSERT INTO `tblTicket3` (`id`, `price`, `issueTime`, `status`, `type`, `tblShowtime3Id`, `tblSeat3Id`, `tblInvoice3Id`) VALUES
-- Invoice 1 (KH001): 2 tickets x 250k = 500k
(1, 250000, '2026-01-05 19:30:00', 'Printed', 'Standard', 1, 1, 1),
(2, 250000, '2026-01-05 19:30:00', 'Printed', 'Standard', 1, 2, 1),

-- Invoice 2 (KH001): 2 tickets x 300k = 600k
(3, 300000, '2026-01-15 20:15:00', 'Printed', 'VIP', 4, 6, 2),
(4, 300000, '2026-01-15 20:15:00', 'Printed', 'VIP', 4, 7, 2),

-- Invoice 3 (KH001): 2 tickets x 200k = 400k
(5, 200000, '2026-01-28 18:00:00', 'Printed', 'Standard', 9, 3, 3),
(6, 200000, '2026-01-28 18:00:00', 'Printed', 'Standard', 9, 4, 3),

-- Invoice 4 (KH008): 2 tickets x 150k = 300k
(7, 150000, '2026-01-06 10:15:00', 'Printed', 'Standard', 24, 1, 4),
(8, 150000, '2026-01-06 10:15:00', 'Printed', 'Standard', 24, 2, 4),

-- Invoice 5 (KH008): 2 tickets x 150k = 300k
(9, 150000, '2026-01-12 18:30:00', 'Printed', 'VIP', 26, 36, 5),
(10, 150000, '2026-01-12 18:30:00', 'Printed', 'VIP', 26, 37, 5),

-- Invoice 6 (KH008): 2 tickets x 150k = 300k
(11, 150000, '2026-01-19 19:00:00', 'Printed', 'Standard', 6, 31, 6),
(12, 150000, '2026-01-19 19:00:00', 'Printed', 'Standard', 6, 32, 6),

-- Invoice 7 (KH008): 2 tickets x 150k = 300k
(13, 150000, '2026-01-26 20:30:00', 'Printed', 'VIP', 32, 38, 7),
(14, 150000, '2026-01-26 20:30:00', 'Printed', 'VIP', 32, 39, 7),

-- Invoice 8 (KH015): 2 tickets x 125k = 250k
(15, 125000, '2026-01-04 16:30:00', 'Printed', 'Standard', 23, 21, 8),
(16, 125000, '2026-01-04 16:30:00', 'Printed', 'Standard', 23, 22, 8),

-- Invoice 9 (KH015): 2 tickets x 100k = 200k
(17, 100000, '2026-01-11 14:00:00', 'Printed', 'Standard', 21, 1, 9),
(18, 100000, '2026-01-11 14:00:00', 'Printed', 'Standard', 21, 2, 9),

-- Invoice 10 (KH015): 2 tickets x 150k = 300k
(19, 150000, '2026-01-18 21:15:00', 'Printed', 'VIP', 29, 8, 10),
(20, 150000, '2026-01-18 21:15:00', 'Printed', 'VIP', 29, 9, 10),

-- Invoice 11 (KH015): 2 tickets x 100k = 200k
(21, 100000, '2026-01-25 15:30:00', 'Printed', 'Standard', 8, 5, 11),
(22, 100000, '2026-01-25 15:30:00', 'Printed', 'Standard', 8, 6, 11),

-- Invoice 12 (KH003): 2 tickets x 100k = 200k
(23, 100000, '2026-01-08 15:00:00', 'Printed', 'Standard', 25, 11, 12),
(24, 100000, '2026-01-08 15:00:00', 'Printed', 'Standard', 25, 12, 12),

-- Invoice 13 (KH003): 2 tickets x 100k = 200k
(25, 100000, '2026-01-17 19:30:00', 'Printed', 'Standard', 5, 13, 13),
(26, 100000, '2026-01-17 19:30:00', 'Printed', 'Standard', 5, 14, 13),

-- Invoice 14 (KH003): 2 tickets x 100k = 200k
(27, 100000, '2026-01-27 20:00:00', 'Printed', 'Standard', 33, 41, 14),
(28, 100000, '2026-01-27 20:00:00', 'Printed', 'Standard', 33, 42, 14),

-- Invoices 15 - 45: Tickets for other invoices
(29, 90000, '2026-01-02 09:45:00', 'Printed', 'Standard', 21, 3, 15),
(30, 90000, '2026-01-02 09:45:00', 'Printed', 'Standard', 21, 4, 15),
(31, 110000, '2026-01-07 14:00:00', 'Printed', 'Standard', 22, 13, 16),
(32, 110000, '2026-01-07 14:00:00', 'Printed', 'Standard', 22, 14, 16),
(33, 100000, '2026-01-14 20:45:00', 'Printed', 'Standard', 27, 43, 17),
(34, 100000, '2026-01-14 20:45:00', 'Printed', 'Standard', 27, 44, 17),
(35, 120000, '2026-01-21 19:45:00', 'Printed', 'Standard', 30, 15, 18),
(36, 120000, '2026-01-21 19:45:00', 'Printed', 'Standard', 30, 16, 18),
(37, 150000, '2026-01-09 18:00:00', 'Printed', 'VIP', 2, 8, 19),
(38, 150000, '2026-01-09 18:00:00', 'Printed', 'VIP', 2, 9, 19),
(39, 130000, '2026-01-23 20:00:00', 'Printed', 'VIP', 7, 18, 20),
(40, 130000, '2026-01-23 20:00:00', 'Printed', 'VIP', 7, 19, 20),
(41, 110000, '2026-01-13 18:30:00', 'Printed', 'Standard', 28, 51, 21),
(42, 110000, '2026-01-13 18:30:00', 'Printed', 'Standard', 28, 52, 21),
(43, 110000, '2026-01-24 18:15:00', 'Printed', 'Standard', 31, 23, 22),
(44, 110000, '2026-01-24 18:15:00', 'Printed', 'Standard', 31, 24, 22),
(45, 110000, '2026-01-16 19:15:00', 'Printed', 'Standard', 28, 53, 23),
(46, 110000, '2026-01-16 19:15:00', 'Printed', 'Standard', 28, 54, 23),
(47, 160000, '2026-01-29 21:15:00', 'Printed', 'VIP', 34, 58, 24),
(48, 160000, '2026-01-29 21:15:00', 'Printed', 'VIP', 34, 59, 24),
(49, 140000, '2026-01-30 19:45:00', 'Printed', 'VIP', 11, 48, 25),
(50, 140000, '2026-01-30 19:45:00', 'Printed', 'VIP', 11, 49, 25),
(51, 110000, '2026-01-03 13:45:00', 'Printed', 'Standard', 22, 15, 26),
(52, 110000, '2026-01-03 13:45:00', 'Printed', 'Standard', 22, 16, 26),
(53, 130000, '2026-01-22 20:15:00', 'Printed', 'VIP', 7, 20, 27),
(54, 130000, '2026-01-22 20:15:00', 'Printed', 'VIP', 7, 17, 27),
(55, 150000, '2026-01-31 20:15:00', 'Printed', 'VIP', 35, 8, 28),
(56, 150000, '2026-01-31 20:15:00', 'Printed', 'VIP', 35, 9, 28),
-- Tickets for Dec 2025 and Feb 2026 invoices
(57, 150000, '2025-12-15 19:15:00', 'Printed', 'Standard', 12, 1, 29),
(58, 150000, '2025-12-15 19:15:00', 'Printed', 'Standard', 12, 2, 29),
(59, 180000, '2025-12-20 20:15:00', 'Printed', 'Standard', 13, 11, 30),
(60, 180000, '2025-12-20 20:15:00', 'Printed', 'Standard', 13, 12, 30),
(61, 250000, '2025-12-24 18:45:00', 'Printed', 'Standard', 14, 21, 31),
(62, 250000, '2025-12-24 18:45:00', 'Printed', 'Standard', 14, 22, 31),
(63, 200000, '2025-12-31 21:15:00', 'Printed', 'Standard', 15, 1, 32),
(64, 200000, '2025-12-31 21:15:00', 'Printed', 'Standard', 15, 2, 32),
(65, 100000, '2025-12-10 14:00:00', 'Printed', 'Standard', 8, 1, 33),
(66, 100000, '2025-12-10 14:00:00', 'Printed', 'Standard', 8, 2, 33),
(67, 125000, '2025-12-18 19:00:00', 'Printed', 'Standard', 26, 31, 34),
(68, 125000, '2025-12-18 19:00:00', 'Printed', 'Standard', 26, 32, 34),
(69, 150000, '2025-12-25 20:00:00', 'Printed', 'VIP', 13, 16, 35),
(70, 150000, '2025-12-25 20:00:00', 'Printed', 'VIP', 13, 17, 35),
(71, 150000, '2026-02-05 19:15:00', 'Printed', 'Standard', 16, 11, 36),
(72, 150000, '2026-02-05 19:15:00', 'Printed', 'Standard', 16, 12, 36),
(73, 160000, '2026-02-10 20:15:00', 'Printed', 'Standard', 17, 1, 37),
(74, 160000, '2026-02-10 20:15:00', 'Printed', 'Standard', 17, 2, 37),
(75, 250000, '2026-02-14 19:45:00', 'Printed', 'VIP', 18, 36, 38),
(76, 250000, '2026-02-14 19:45:00', 'Printed', 'VIP', 18, 37, 38),
(77, 250000, '2026-02-14 20:00:00', 'Printed', 'VIP', 18, 38, 39),
(78, 250000, '2026-02-14 20:00:00', 'Printed', 'VIP', 18, 39, 39),
(79, 120000, '2026-02-20 18:15:00', 'Printed', 'Standard', 19, 11, 40),
(80, 120000, '2026-02-20 18:15:00', 'Printed', 'Standard', 19, 12, 40),
(81, 130000, '2026-02-22 19:00:00', 'Printed', 'VIP', 27, 46, 41),
(82, 130000, '2026-02-22 19:00:00', 'Printed', 'VIP', 27, 47, 41),
(83, 140000, '2026-02-24 20:00:00', 'Printed', 'VIP', 32, 36, 42),
(84, 140000, '2026-02-24 20:00:00', 'Printed', 'VIP', 32, 37, 42),
(85, 130000, '2026-02-25 20:45:00', 'Printed', 'VIP', 20, 48, 43),
(86, 130000, '2026-02-25 20:45:00', 'Printed', 'VIP', 20, 49, 43),
(87, 150000, '2026-02-26 18:30:00', 'Printed', 'Standard', 33, 43, 44),
(88, 150000, '2026-02-26 18:30:00', 'Printed', 'Standard', 33, 44, 44),
(89, 175000, '2026-02-28 21:00:00', 'Printed', 'VIP', 34, 56, 45),
(90, 175000, '2026-02-28 21:00:00', 'Printed', 'VIP', 34, 57, 45);

-- ====================================================================
-- SAMPLE DATA SCRIPT COMPLETED
-- ====================================================================
