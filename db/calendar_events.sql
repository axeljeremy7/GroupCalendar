-- phpMyAdmin SQL Dump
-- version 4.7.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: Mar 25, 2018 at 04:43 PM
-- Server version: 5.6.38
-- PHP Version: 7.2.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `group_calendar`
--

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
(6, 1, 'April', '2018-04-10 08:20:20', '2018-04-10 08:20:20');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `calendar_events`
--
ALTER TABLE `calendar_events`
  ADD PRIMARY KEY (`event_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `calendar_events`
--
ALTER TABLE `calendar_events`
  MODIFY `event_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
