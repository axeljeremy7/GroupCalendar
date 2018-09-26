-- phpMyAdmin SQL Dump
-- version 4.7.9
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Apr 09, 2018 at 01:14 AM
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

CREATE TABLE `calendar` (
  `calendar_id` int(11) NOT NULL,
  `calendar_name` varchar(128) NOT NULL,
  `calendar_group` varchar(128) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `calendar`
--

INSERT INTO `calendar` (`calendar_id`, `calendar_name`, `calendar_group`) VALUES
(1, 'firstCalendar', NULL);

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
  `all_day` bit(1) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `color` varchar(128) DEFAULT NULL,
  `text_color` varchar(128) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `calendar_events`
--

INSERT INTO `calendar_events` (`event_id`, `calendar_id`, `title`, `start_date`, `end_date`, `all_day`, `description`, `color`, `text_color`) VALUES
(1, 1, 'firstEvent', '2018-04-04 10:00:00', '2018-04-04 12:00:00', b'0', 'firstEventDescription', 'yellow', 'white'),
(2, 1, 'secondEvent', '2018-04-05 00:00:00', '2018-04-05 00:00:00', b'1', 'secondEventDescription', 'white', 'yellow'),
(3, 1, 'someEvent', '2018-04-05 00:00:00', '2018-04-05 00:00:00', b'1', NULL, NULL, NULL);

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
(1, 1, 'user1', b'1');

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
('user1', 'user1');

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
  MODIFY `calendar_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `calendar_events`
--
ALTER TABLE `calendar_events`
  MODIFY `event_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `calendar_rights`
--
ALTER TABLE `calendar_rights`
  MODIFY `rights_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user_info`
--
ALTER TABLE `user_info`
  MODIFY `info_id` int(11) NOT NULL AUTO_INCREMENT;

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
-- Constraints for table `user_info`
--
ALTER TABLE `user_info`
  ADD CONSTRAINT `FK_user_info_username` FOREIGN KEY (`username`) REFERENCES `users` (`username`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
