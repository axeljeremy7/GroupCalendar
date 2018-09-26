-- phpMyAdmin SQL Dump
-- version 4.7.9
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 16, 2018 at 02:33 AM
-- Server version: 10.1.31-MariaDB
-- PHP Version: 5.6.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `group_calendar`
--

-- --------------------------------------------------------

--
-- Table structure for table `calendar`
--

CREATE DATABASE  `group_calendar` ;

USE `group_calendar`;

CREATE TABLE `calendar` (
  `calendar_id` int(11) NOT NULL,
  `calendar_name` varchar(128) NOT NULL,
  `calendar_group` varchar(128) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `calendar`
--

INSERT INTO `calendar` (`calendar_id`, `calendar_name`, `calendar_group`) VALUES
(1, 'firstCalendar', NULL),
(2, 'secondCalendar', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `calendar_events`
--

CREATE TABLE `calendar_events` (
  `event_id` int(11) NOT NULL,
  `calendar_id` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `all_day` int(1) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `color` varchar(128) DEFAULT NULL,
  `text_color` varchar(128) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `calendar_events`
--

INSERT INTO `calendar_events` (`event_id`, `calendar_id`, `title`, `start_date`, `end_date`, `all_day`, `description`, `color`, `text_color`) VALUES
(1, 1, 'Important Meeting', '2018-04-02 00:00:00', '2018-04-04 00:00:00', 1, 'Must meed with my manager', 'red', 'white'),
(2, 1, 'secondEvent', '2018-04-05 01:30:00', '2018-04-05 05:30:00', 0, 'secondEventDescription', 'Blue', 'yellow'),
(3, 1, 'Study for test', '2018-04-05 00:00:00', '2018-04-07 00:00:00', 1, '', '', ''),
(4, 1, 'haha', '2018-04-03 01:00:00', '2018-04-03 02:00:00', 1, NULL, NULL, NULL),
(5, 1, 'febuary event', '2018-02-28 00:00:00', '0000-00-00 00:00:00', 1, '', '', ''),
(8, 1, 'hello', '2018-04-11 00:00:00', '2018-04-12 00:00:00', 1, 'asd', NULL, 'red'),
(9, 1, 'Friday', '2018-04-13 00:00:00', '2018-04-14 00:00:00', 1, 'Does this need a description? It\'s Friday.', '', 'chrome'),
(10, 1, 'Database Presentation', '2018-04-16 00:00:00', '2018-04-17 00:00:00', 1, 'First day of final project for CS4430', 'green', ''),
(11, 1, 'Database Presentation', '2018-04-18 00:00:00', '2018-04-19 00:00:00', 1, 'Final day for the CS4430 Presentations', 'Yellow', 'Black'),
(12, 1, 'Keep working on database project', '2018-03-09 13:04:00', '2018-03-09 20:05:00', 0, '', '', ''),
(13, 1, 'Top Secret', '2018-03-05 02:40:00', '2018-03-05 20:00:00', 0, 'Don\'t let anyone see this.', 'black', 'white'),
(14, 1, 'Summer time', '2018-05-14 00:00:00', '2018-05-14 00:00:00', 0, '', 'green', ''),
(15, 1, 'Enjoy the weekend', '2018-05-04 00:00:00', '2018-05-05 00:00:00', 1, '', 'purple', ''),
(16, 2, 'User 2 Event', '2018-04-10 00:00:00', '2018-04-10 00:00:00', 0, '', '', ''),
(17, 2, 'User 2 Event', '2018-04-18 00:00:00', '0000-00-00 00:00:00', 0, '', '', ''),
(18, 2, 'User 2 - Event 1', '2018-04-15 00:00:00', '2018-04-16 00:00:00', 1, '', '', ''),
(19, 2, 'March Event - User 2', '2018-03-20 00:00:00', '2018-03-20 00:00:00', 0, '', 'yellow', 'black');

-- --------------------------------------------------------

--
-- Table structure for table `calendar_rights`
--

CREATE TABLE `calendar_rights` (
  `rights_id` int(11) NOT NULL,
  `calendar_id` int(11) NOT NULL,
  `username` varchar(128) NOT NULL,
  `permission` bit(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `calendar_rights`
--

INSERT INTO `calendar_rights` (`rights_id`, `calendar_id`, `username`, `permission`) VALUES
(1, 1, 'user1', b'1'),
(2, 2, 'user2', b'1');

-- --------------------------------------------------------

--
-- Table structure for table `google_calendar`
--

CREATE TABLE `google_calendar` (
  `username` varchar(128) NOT NULL,
  `google_calendar` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `google_calendar`
--

INSERT INTO `google_calendar` (`username`, `google_calendar`) VALUES
('user1', ''),
('user1', '38aictv8rqf4dcthup70843jm0@group.calendar.google.com'),
('user1', '74vpamcd7ags2g10p3ijb7gn0k@group.calendar.google.com'),
('user2', ''),
('user2', '38aictv8rqf4dcthup70843jm0@group.calendar.google.com');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `username` varchar(128) NOT NULL,
  `password` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`username`, `password`) VALUES
('user1', 'user1'),
('user2', 'user2'),
('user3', 'user3');

-- --------------------------------------------------------

--
-- Table structure for table `user_info`
--

CREATE TABLE `user_info` (
  `info_id` int(11) NOT NULL,
  `username` varchar(128) NOT NULL,
  `first_name` varchar(128) DEFAULT NULL,
  `last_name` varchar(128) DEFAULT NULL,
  `email` varchar(128) NOT NULL,
  `phone` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_info`
--

INSERT INTO `user_info` (`info_id`, `username`, `first_name`, `last_name`, `email`, `phone`) VALUES
(1, 'user1', 'fname1', 'lname1', 'user1@user.com', NULL),
(2, 'user2', 'Fname', 'Lname', 'user2@user.com', NULL),
(3, 'user3', 'Fname', 'Lname', 'user3@user.com', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `calendar`
--
ALTER TABLE `calendar`
  ADD PRIMARY KEY (`calendar_id`);

--
-- Indexes for table `calendar_events`
--
ALTER TABLE `calendar_events`
  ADD PRIMARY KEY (`event_id`),
  ADD KEY `FK_calendar_events_calendar_id` (`calendar_id`);

--
-- Indexes for table `calendar_rights`
--
ALTER TABLE `calendar_rights`
  ADD PRIMARY KEY (`rights_id`),
  ADD KEY `FK_calendar_rights_username` (`username`),
  ADD KEY `FK_calendar_rights_calendar_id` (`calendar_id`);

--
-- Indexes for table `google_calendar`
--
ALTER TABLE `google_calendar`
  ADD PRIMARY KEY (`username`,`google_calendar`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `user_info`
--
ALTER TABLE `user_info`
  ADD PRIMARY KEY (`info_id`),
  ADD KEY `FK_user_info_username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `calendar`
--
ALTER TABLE `calendar`
  MODIFY `calendar_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `calendar_events`
--
ALTER TABLE `calendar_events`
  MODIFY `event_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `calendar_rights`
--
ALTER TABLE `calendar_rights`
  MODIFY `rights_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `user_info`
--
ALTER TABLE `user_info`
  MODIFY `info_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `calendar_events`
--
ALTER TABLE `calendar_events`
  ADD CONSTRAINT `FK_calendar_events_calendar_id` FOREIGN KEY (`calendar_id`) REFERENCES `calendar` (`calendar_id`);

--
-- Constraints for table `calendar_rights`
--
ALTER TABLE `calendar_rights`
  ADD CONSTRAINT `FK_calendar_rights_calendar_id` FOREIGN KEY (`calendar_id`) REFERENCES `calendar` (`calendar_id`),
  ADD CONSTRAINT `FK_calendar_rights_username` FOREIGN KEY (`username`) REFERENCES `users` (`username`);

--
-- Constraints for table `google_calendar`
--
ALTER TABLE `google_calendar`
  ADD CONSTRAINT `FK_google_calendar_username` FOREIGN KEY (`username`) REFERENCES `users` (`username`);

--
-- Constraints for table `user_info`
--
ALTER TABLE `user_info`
  ADD CONSTRAINT `FK_user_info_username` FOREIGN KEY (`username`) REFERENCES `users` (`username`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
