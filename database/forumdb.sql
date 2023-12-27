-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 31, 2022 at 08:40 AM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `forumdb`
--

-- --------------------------------------------------------

--
-- Table structure for table `category_tbl`
--

CREATE TABLE `category_tbl` (
  `id` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `description` varchar(100) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `delete_flag` tinyint(1) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `category_tbl`
--

INSERT INTO `category_tbl` (`id`, `name`, `description`, `status`, `delete_flag`, `created_at`, `updated_at`) VALUES
(6, 'Piano', '', 1, 0, '2022-08-22 12:58:36', '2022-08-22 12:58:36'),
(7, 'Guitar', '', 1, 0, '2022-08-22 12:58:36', '2022-08-22 12:58:36'),
(8, 'Drums', '', 1, 0, '2022-08-22 12:58:36', '2022-08-22 12:58:36'),
(9, 'Violin', '', 1, 0, '2022-08-22 12:58:36', '2022-08-22 12:58:36');

-- --------------------------------------------------------

--
-- Table structure for table `comment_tbl`
--

CREATE TABLE `comment_tbl` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `comment` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `comment_tbl`
--

INSERT INTO `comment_tbl` (`id`, `user_id`, `post_id`, `comment`, `created_at`) VALUES
(2, 10, 1, 'I don\'t use it much now but even when it was my main guitar the battery lasted a couple of years. It never actually needed a new battery I just don\'t like leaving it in too long in case it leaks.', '2022-08-31 06:17:48'),
(3, 20, 1, 'Ah! Needs a new set of machines. These are worn and have a dead spot JUST where it is bang in tune! How much should I pay for a decent set?', '2022-08-31 06:19:48'),
(4, 23, 1, 'I’m assuming it’s the old J-bass copy he’s mentioned recently, so will be 4-in-line.', '2022-08-31 06:21:19'),
(5, 21, 2, 'Tuning is typically \'stretched\' to make it sound subjectively correct. So using any tuner alone is not going to get the result you want. Tuning by ear is essential to the task.', '2022-08-31 06:26:18'),
(6, 22, 2, 'I\'ll choose Smartphone!.', '2022-08-31 06:27:46'),
(7, 20, 3, 'That\'s pretty impressive Dustin!', '2022-08-31 06:31:06');

-- --------------------------------------------------------

--
-- Table structure for table `post_tbl`
--

CREATE TABLE `post_tbl` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `title` varchar(50) NOT NULL,
  `content` text DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `delete_flag` tinyint(1) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `post_tbl`
--

INSERT INTO `post_tbl` (`id`, `user_id`, `category_id`, `title`, `content`, `status`, `delete_flag`, `created_at`, `updated_at`) VALUES
(1, 22, 7, 'Active Guitars', 'During a conversation with son last night these came up and I mean \'solid electric active\' guitars, not acoustics. What was the idea behind them and why do they seem to have gone out of favour?\r\n\r\nAny links to schematics greatly \'preciated.', 1, 0, '2022-08-31 06:14:12', '2022-08-31 06:14:12'),
(2, 10, 6, 'piano tuning: smartphone or battery-operated tuner', 'I would like to ask if some still prefer the old Korg/Yamaha tuners when tuning upright and grand pianos. Or do many here believe that smartphones do the job just fine? \r\nOf course using a cellphone is an obvious choice, but one time I used my phone to tune a whole piano, it yielded underwhelming results, and I ended up turning it off with 2 octaves on the furthest sides still left to tune.', 1, 0, '2022-08-31 06:25:27', '2022-08-31 06:25:27'),
(3, 23, 8, 'Yoshimi Ride Cymbal', 'This is a demo of the new addition to the Drums bank simply called \'Ride\'\r\nThe first part of the demo is with all \'hits\' being C1 note. The second part is a random selection from C0 to C2. Even when you do hit the same note you don\'t always get exactly the same sound :)\r\n\r\nwww.musically.me.uk/themainevent/Ride.wav', 1, 0, '2022-08-31 06:30:10', '2022-08-31 06:30:10'),
(4, 22, 9, 'Violin Lesson Book or Youtube?', 'I want your opinion guys.', 0, 0, '2022-08-31 06:34:11', '2022-08-31 06:34:11');

-- --------------------------------------------------------

--
-- Table structure for table `user_tbl`
--

CREATE TABLE `user_tbl` (
  `id` int(11) NOT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `middlename` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `type` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user_tbl`
--

INSERT INTO `user_tbl` (`id`, `firstname`, `middlename`, `lastname`, `username`, `password`, `avatar`, `type`, `created_at`, `updated_at`) VALUES
(4, 'spike', 'redoble', 'torrado', 'jok', '1234', '20-UR-1158.jpg', 0, '2022-08-21 14:31:42', '2022-08-21 14:31:42'),
(5, 'spike', 'redoble', 'torrado', 'jok', '1234', '20-UR-1158.jpg', 0, '2022-08-21 14:31:50', '2022-08-21 14:31:50'),
(8, 'admin', 'admin', 'admin', 'admin', 'admin', '', 1, '2022-08-24 13:52:11', '2022-08-24 13:52:11'),
(10, 'deoff', 'redoble', 'torrado', 'dof', '1234', '20-UR-1158.jpg', 0, '2022-08-30 00:25:17', '2022-08-30 00:25:17'),
(18, 'halo', 'halooo', 'halooo', 'halo1', '1234', 'halo', 0, '2022-08-30 01:40:04', '2022-08-30 01:40:04'),
(19, 'deoff', 'redoble', 'torrado', 'jop', '123456789', 'broomm.jpg', 0, '2022-08-30 13:34:03', '2022-08-30 13:34:03'),
(20, 'Chrissha', 'Helloo', 'Balbin', 'maymay', '123456789', 'chrissha.jpg', 0, '2022-08-30 14:03:34', '2022-08-30 14:03:34'),
(21, 'Royce', 'Pogi', 'Hortaleza', 'royce', '123456789', 'royce.jpeg', 0, '2022-08-30 14:07:46', '2022-08-30 14:07:46'),
(22, 'Mark', 'pogi', 'Andaya', 'Mark', '123456789', 'mark.jpg', 0, '2022-08-31 03:08:41', '2022-08-31 03:08:41'),
(23, 'Justin', 'Pogi', 'Antinew', 'Dustin', '123456789', 'justin.jpg', 0, '2022-08-31 05:28:34', '2022-08-31 05:28:34');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `category_tbl`
--
ALTER TABLE `category_tbl`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `comment_tbl`
--
ALTER TABLE `comment_tbl`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `post_id` (`post_id`);

--
-- Indexes for table `post_tbl`
--
ALTER TABLE `post_tbl`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `user_tbl`
--
ALTER TABLE `user_tbl`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `category_tbl`
--
ALTER TABLE `category_tbl`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `comment_tbl`
--
ALTER TABLE `comment_tbl`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `post_tbl`
--
ALTER TABLE `post_tbl`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `user_tbl`
--
ALTER TABLE `user_tbl`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `comment_tbl`
--
ALTER TABLE `comment_tbl`
  ADD CONSTRAINT `comment_tbl_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user_tbl` (`id`),
  ADD CONSTRAINT `comment_tbl_ibfk_2` FOREIGN KEY (`post_id`) REFERENCES `post_tbl` (`id`);

--
-- Constraints for table `post_tbl`
--
ALTER TABLE `post_tbl`
  ADD CONSTRAINT `post_tbl_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user_tbl` (`id`),
  ADD CONSTRAINT `post_tbl_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `category_tbl` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
