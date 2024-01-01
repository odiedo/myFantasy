-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jan 01, 2024 at 05:10 AM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 7.4.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `myVideo`
--

-- --------------------------------------------------------

--
-- Table structure for table `video`
--

CREATE TABLE `video` (
  `video_id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `desc` varchar(255) NOT NULL,
  `video` varchar(255) NOT NULL,
  `v_image` varchar(255) NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `video`
--

INSERT INTO `video` (`video_id`, `title`, `desc`, `video`, `v_image`, `time`) VALUES
(24, 'The killing', 'Its among my favorite movies in 2023', 'vlc-record-2023-11-15-13h02m18s-3a9aaa18a312970884ae8d260ca65d4e76f77d11.mp4-.mp4', 'cover_The_killing_odiedo.jpg', '2023-11-21 10:56:31'),
(25, 'Little capture  for trial!', 'Look, which move is this?', 'vlc-record-2023-08-20-01h46m04s-two.and.a.half.men.s10e14.480p.hdtv.x264-mRS.mkv-.mp4', 'cover_Little_capture_for_trial_odiedo.jpg', '2023-11-21 10:57:46'),
(26, 'How about this?', 'No way you will be able to get the name of this movie!, Try it', 'vlc-record-2023-08-17-20h24m57s-friends.s08e06.720p.bluray.x264-mrs.sujaidr.mkv-.mp4', 'cover_How_about_this_odiedo.jpg', '2023-11-21 10:59:00'),
(27, 'Two and A Half Men ', 'Its a coup to beat a big guy, what if you dont', 'vlc-record-2023-08-20-01h52m39s-two.and.a.half.men.s10e14.480p.hdtv.x264-mRS.mkv-.mp4', 'cover_Two_and_A_Half_Men_odiedo.jpg', '2024-01-01 03:45:28');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `video`
--
ALTER TABLE `video`
  ADD PRIMARY KEY (`video_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `video`
--
ALTER TABLE `video`
  MODIFY `video_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
