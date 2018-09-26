-- phpMyAdmin SQL Dump
-- version 4.7.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Apr 05, 2018 at 01:07 AM
-- Server version: 5.6.38
-- PHP Version: 7.2.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `group_calendar`
--

-- --------------------------------------------------------

--
-- Table structure for table `calendar`
--

CREATE TABLE `calendar` (
  `calendar_id` int(11) NOT NULL,
  `calendar_name` varchar(128) DEFAULT NULL,
  `calendar_group` varchar(128) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `calendar`
--

INSERT INTO `calendar` (`calendar_id`, `calendar_name`, `calendar_group`) VALUES
(1, 'calendar1', 'calendarGroup1'),
(2, 'Calendar 2', 'calendarGroup1'),
(3, 'Calendar 3', 'calendarGroup1');

-- --------------------------------------------------------

--
-- Table structure for table `calendar_events`
--

CREATE TABLE `calendar_events` (
  `event_id` int(11) NOT NULL,
  `calendar_id` int(11) DEFAULT NULL,
  `name` varchar(128) DEFAULT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `calendar_events`
--

INSERT INTO `calendar_events` (`event_id`, `calendar_id`, `name`, `start_date`, `end_date`) VALUES
(1, 1, 'First Event', '2000-01-01 01:01:01', '2000-01-01 01:01:01'),
(2, 1, 'Second', '2018-03-25 11:09:09', '2018-03-25 11:09:09'),
(3, 1, '4430 Assignment', '2018-03-29 08:20:20', '2018-03-30 08:20:20'),
(5, 1, 'Long Event', '2018-03-26 08:20:20', '2018-03-30 08:20:20'),
(6, 1, 'April', '2018-04-10 08:20:20', '2018-04-10 08:20:20'),
(7, 2, 'Calendar 2 test1', '2018-04-10 02:02:02', '2018-04-10 03:02:02'),
(8, 3, 'Calendar 3 - test1', '2018-04-04 12:12:12', '2018-04-04 13:12:12');

-- --------------------------------------------------------

--
-- Table structure for table `calendar_rights`
--

CREATE TABLE `calendar_rights` (
  `calendar_id` int(11) NOT NULL,
  `username` varchar(128) DEFAULT NULL,
  `permission` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `calendar_rights`
--

INSERT INTO `calendar_rights` (`calendar_id`, `username`, `permission`) VALUES
(1, 'user1', 1),
(2, 'user1', 1);

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
  `username` varchar(128) NOT NULL,
  `first_name` varchar(128) DEFAULT NULL,
  `last_name` varchar(128) DEFAULT NULL,
  `email` varchar(128) DEFAULT NULL,
  `phone` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_info`
--

INSERT INTO `user_info` (`username`, `first_name`, `last_name`, `email`, `phone`) VALUES
('user1', 'myfname1', 'mylname1', 'user1@gmail.com', '7183472250');

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
  ADD PRIMARY KEY (`event_id`);

--
-- Indexes for table `calendar_rights`
--
ALTER TABLE `calendar_rights`
  ADD PRIMARY KEY (`calendar_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `user_info`
--
ALTER TABLE `user_info`
  ADD PRIMARY KEY (`username`);

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
  MODIFY `event_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `calendar_rights`
--
ALTER TABLE `calendar_rights`
  MODIFY `calendar_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;