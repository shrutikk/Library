-- phpMyAdmin SQL Dump
-- version 4.2.11
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Oct 10, 2015 at 01:28 AM
-- Server version: 5.6.21
-- PHP Version: 5.6.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `db_project`
--

-- --------------------------------------------------------

--
-- Table structure for table `author`
--

CREATE TABLE IF NOT EXISTS `author` (
  `author_name` varchar(45) NOT NULL,
  `pub_id` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `book`
--

CREATE TABLE IF NOT EXISTS `book` (
  `isbn` varchar(45) NOT NULL,
  `edition` varchar(45) NOT NULL,
  `publisher` varchar(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `camera`
--

CREATE TABLE IF NOT EXISTS `camera` (
  `cam_id` varchar(45) NOT NULL,
  `lens_config` varchar(45) NOT NULL,
  `memory` varchar(45) NOT NULL,
  `make` varchar(45) NOT NULL,
  `model` varchar(45) NOT NULL,
  `lib_id` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `cam_checked_out`
--

CREATE TABLE IF NOT EXISTS `cam_checked_out` (
  `cam_id` varchar(45) NOT NULL,
  `patron_id` varchar(45) NOT NULL,
  `checkout_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `cam_queue`
--

CREATE TABLE IF NOT EXISTS `cam_queue` (
  `cam_id` varchar(45) NOT NULL,
  `patron_id` varchar(45) NOT NULL,
  `booking_date` date NOT NULL,
  `request_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `conf_paper`
--

CREATE TABLE IF NOT EXISTS `conf_paper` (
  `conf_num` varchar(45) NOT NULL,
  `conf_name` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `course`
--

CREATE TABLE IF NOT EXISTS `course` (
  `cid` varchar(45) NOT NULL,
  `cname` varchar(45) NOT NULL,
  `dept_id` varchar(45) NOT NULL,
  `fid` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `degree`
--

CREATE TABLE IF NOT EXISTS `degree` (
  `Name` varchar(45) NOT NULL,
  `Duration` int(11) NOT NULL,
  `Category` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `department`
--

CREATE TABLE IF NOT EXISTS `department` (
  `did` varchar(45) NOT NULL,
  `dname` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `document`
--

CREATE TABLE IF NOT EXISTS `document` (
`doc_id` int(11) NOT NULL,
  `pub_id` varchar(45) NOT NULL,
  `category` varchar(45) NOT NULL,
  `lib_id` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `document_checkout`
--

CREATE TABLE IF NOT EXISTS `document_checkout` (
  `patron_id` varchar(45) NOT NULL,
  `doc_id` int(45) NOT NULL,
  `checkout_date` date NOT NULL,
  `ret_deadline` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `faculty`
--

CREATE TABLE IF NOT EXISTS `faculty` (
  `category` varchar(45) NOT NULL,
  `fid` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `faculty_reserved_book`
--

CREATE TABLE IF NOT EXISTS `faculty_reserved_book` (
  `fid` varchar(45) NOT NULL,
  `cid` varchar(45) NOT NULL,
  `isbn` varchar(45) NOT NULL,
  `start` date NOT NULL,
  `end` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `hold`
--

CREATE TABLE IF NOT EXISTS `hold` (
  `student_id` varchar(45) NOT NULL,
  `reason` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `journal`
--

CREATE TABLE IF NOT EXISTS `journal` (
  `issn` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `library`
--

CREATE TABLE IF NOT EXISTS `library` (
  `lib_id` varchar(45) NOT NULL,
  `lib_name` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `notification`
--

CREATE TABLE IF NOT EXISTS `notification` (
  `patron_id` varchar(45) NOT NULL,
`id` int(11) NOT NULL,
  `read_flag` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `patron`
--

CREATE TABLE IF NOT EXISTS `patron` (
  `id` varchar(45) NOT NULL,
  `fname` varchar(45) NOT NULL,
  `lname` varchar(45) NOT NULL,
  `nationality` varchar(45) DEFAULT NULL,
  `password` varchar(45) NOT NULL,
  `balance` float NOT NULL,
  `dept_id` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `patron_room`
--

CREATE TABLE IF NOT EXISTS `patron_room` (
  `start` datetime NOT NULL,
  `end` datetime NOT NULL,
  `checked_out` tinyint(1) NOT NULL,
  `patron_id` varchar(45) NOT NULL,
  `room_id` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `phone_number`
--

CREATE TABLE IF NOT EXISTS `phone_number` (
  `number` varchar(45) NOT NULL,
  `student_id` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `publication`
--

CREATE TABLE IF NOT EXISTS `publication` (
  `pub_id` varchar(45) NOT NULL,
  `title` varchar(45) NOT NULL,
  `type` varchar(45) NOT NULL,
  `year` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `publication_queue`
--

CREATE TABLE IF NOT EXISTS `publication_queue` (
  `pub_id` varchar(45) NOT NULL,
  `patron_id` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `room`
--

CREATE TABLE IF NOT EXISTS `room` (
  `room_no` varchar(45) NOT NULL,
  `type` varchar(45) NOT NULL,
  `floor` varchar(45) NOT NULL,
  `capacity` int(11) NOT NULL,
  `lib_id` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE IF NOT EXISTS `student` (
  `dob` date NOT NULL,
  `street` varchar(45) NOT NULL,
  `city` varchar(45) NOT NULL,
  `pin` varchar(45) NOT NULL,
  `sex` varchar(45) NOT NULL,
  `sid` varchar(45) NOT NULL,
  `did` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `student_course`
--

CREATE TABLE IF NOT EXISTS `student_course` (
  `student_id` varchar(45) NOT NULL,
  `cid` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `author`
--
ALTER TABLE `author`
 ADD PRIMARY KEY (`author_name`,`pub_id`), ADD KEY `pub_id` (`pub_id`);

--
-- Indexes for table `book`
--
ALTER TABLE `book`
 ADD PRIMARY KEY (`isbn`);

--
-- Indexes for table `camera`
--
ALTER TABLE `camera`
 ADD PRIMARY KEY (`cam_id`), ADD KEY `lib_id` (`lib_id`);

--
-- Indexes for table `cam_checked_out`
--
ALTER TABLE `cam_checked_out`
 ADD PRIMARY KEY (`cam_id`,`patron_id`), ADD KEY `checkout_date` (`checkout_date`), ADD KEY `patron_id` (`patron_id`);

--
-- Indexes for table `cam_queue`
--
ALTER TABLE `cam_queue`
 ADD PRIMARY KEY (`cam_id`,`patron_id`), ADD UNIQUE KEY `request_time` (`request_time`), ADD KEY `patron_id` (`patron_id`), ADD KEY `booking_date` (`booking_date`);

--
-- Indexes for table `conf_paper`
--
ALTER TABLE `conf_paper`
 ADD PRIMARY KEY (`conf_num`);

--
-- Indexes for table `course`
--
ALTER TABLE `course`
 ADD PRIMARY KEY (`cid`), ADD KEY `dept_id` (`dept_id`), ADD KEY `fid` (`fid`);

--
-- Indexes for table `degree`
--
ALTER TABLE `degree`
 ADD PRIMARY KEY (`Name`);

--
-- Indexes for table `department`
--
ALTER TABLE `department`
 ADD PRIMARY KEY (`did`);

--
-- Indexes for table `document`
--
ALTER TABLE `document`
 ADD PRIMARY KEY (`doc_id`), ADD KEY `pub_id` (`pub_id`), ADD KEY `lib_id` (`lib_id`);

--
-- Indexes for table `document_checkout`
--
ALTER TABLE `document_checkout`
 ADD PRIMARY KEY (`doc_id`), ADD KEY `patron_id` (`patron_id`);

--
-- Indexes for table `faculty`
--
ALTER TABLE `faculty`
 ADD PRIMARY KEY (`fid`);

--
-- Indexes for table `faculty_reserved_book`
--
ALTER TABLE `faculty_reserved_book`
 ADD PRIMARY KEY (`fid`,`isbn`), ADD KEY `cid` (`cid`), ADD KEY `isbn` (`isbn`);

--
-- Indexes for table `hold`
--
ALTER TABLE `hold`
 ADD KEY `student_id` (`student_id`);

--
-- Indexes for table `journal`
--
ALTER TABLE `journal`
 ADD PRIMARY KEY (`issn`);

--
-- Indexes for table `library`
--
ALTER TABLE `library`
 ADD PRIMARY KEY (`lib_id`);

--
-- Indexes for table `notification`
--
ALTER TABLE `notification`
 ADD PRIMARY KEY (`id`), ADD KEY `patron_id` (`patron_id`);

--
-- Indexes for table `patron`
--
ALTER TABLE `patron`
 ADD PRIMARY KEY (`id`), ADD KEY `dept_id` (`dept_id`);

--
-- Indexes for table `patron_room`
--
ALTER TABLE `patron_room`
 ADD PRIMARY KEY (`start`,`end`,`patron_id`,`room_id`), ADD KEY `patron_id` (`patron_id`), ADD KEY `room_id` (`room_id`);

--
-- Indexes for table `phone_number`
--
ALTER TABLE `phone_number`
 ADD PRIMARY KEY (`number`), ADD KEY `number` (`number`), ADD KEY `patron_id` (`student_id`);

--
-- Indexes for table `publication`
--
ALTER TABLE `publication`
 ADD PRIMARY KEY (`pub_id`);

--
-- Indexes for table `publication_queue`
--
ALTER TABLE `publication_queue`
 ADD PRIMARY KEY (`pub_id`,`patron_id`), ADD KEY `patron_id` (`patron_id`);

--
-- Indexes for table `room`
--
ALTER TABLE `room`
 ADD PRIMARY KEY (`room_no`), ADD KEY `lib_id` (`lib_id`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
 ADD PRIMARY KEY (`sid`), ADD KEY `did_idx` (`did`);

--
-- Indexes for table `student_course`
--
ALTER TABLE `student_course`
 ADD PRIMARY KEY (`student_id`,`cid`), ADD KEY `cid` (`cid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `document`
--
ALTER TABLE `document`
MODIFY `doc_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `notification`
--
ALTER TABLE `notification`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `author`
--
ALTER TABLE `author`
ADD CONSTRAINT `author_ibfk_1` FOREIGN KEY (`pub_id`) REFERENCES `publication` (`pub_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `book`
--
ALTER TABLE `book`
ADD CONSTRAINT `book_ibfk_1` FOREIGN KEY (`isbn`) REFERENCES `publication` (`pub_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `camera`
--
ALTER TABLE `camera`
ADD CONSTRAINT `camera_ibfk_1` FOREIGN KEY (`lib_id`) REFERENCES `library` (`lib_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `cam_checked_out`
--
ALTER TABLE `cam_checked_out`
ADD CONSTRAINT `cam_checked_out_ibfk_1` FOREIGN KEY (`cam_id`) REFERENCES `camera` (`cam_id`),
ADD CONSTRAINT `cam_checked_out_ibfk_2` FOREIGN KEY (`patron_id`) REFERENCES `patron` (`id`);

--
-- Constraints for table `cam_queue`
--
ALTER TABLE `cam_queue`
ADD CONSTRAINT `cam_queue_ibfk_1` FOREIGN KEY (`cam_id`) REFERENCES `camera` (`cam_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `cam_queue_ibfk_2` FOREIGN KEY (`patron_id`) REFERENCES `patron` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `conf_paper`
--
ALTER TABLE `conf_paper`
ADD CONSTRAINT `conf_paper_ibfk_1` FOREIGN KEY (`conf_num`) REFERENCES `publication` (`pub_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `course`
--
ALTER TABLE `course`
ADD CONSTRAINT `course_ibfk_1` FOREIGN KEY (`dept_id`) REFERENCES `department` (`did`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `course_ibfk_2` FOREIGN KEY (`fid`) REFERENCES `faculty` (`fid`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `document`
--
ALTER TABLE `document`
ADD CONSTRAINT `document_ibfk_1` FOREIGN KEY (`pub_id`) REFERENCES `publication` (`pub_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `document_ibfk_2` FOREIGN KEY (`lib_id`) REFERENCES `library` (`lib_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `document_checkout`
--
ALTER TABLE `document_checkout`
ADD CONSTRAINT `document_checkout_ibfk_1` FOREIGN KEY (`patron_id`) REFERENCES `patron` (`id`),
ADD CONSTRAINT `document_checkout_ibfk_2` FOREIGN KEY (`doc_id`) REFERENCES `document` (`doc_id`);

--
-- Constraints for table `faculty`
--
ALTER TABLE `faculty`
ADD CONSTRAINT `fid` FOREIGN KEY (`fid`) REFERENCES `patron` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `faculty_reserved_book`
--
ALTER TABLE `faculty_reserved_book`
ADD CONSTRAINT `faculty_reserved_book_ibfk_1` FOREIGN KEY (`fid`) REFERENCES `faculty` (`fid`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `faculty_reserved_book_ibfk_2` FOREIGN KEY (`cid`) REFERENCES `course` (`cid`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `faculty_reserved_book_ibfk_3` FOREIGN KEY (`isbn`) REFERENCES `book` (`isbn`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `hold`
--
ALTER TABLE `hold`
ADD CONSTRAINT `hold_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `student` (`sid`);

--
-- Constraints for table `journal`
--
ALTER TABLE `journal`
ADD CONSTRAINT `journal_ibfk_1` FOREIGN KEY (`issn`) REFERENCES `publication` (`pub_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `notification`
--
ALTER TABLE `notification`
ADD CONSTRAINT `notification_ibfk_1` FOREIGN KEY (`patron_id`) REFERENCES `patron` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `patron`
--
ALTER TABLE `patron`
ADD CONSTRAINT `patron_ibfk_1` FOREIGN KEY (`dept_id`) REFERENCES `department` (`did`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `patron_room`
--
ALTER TABLE `patron_room`
ADD CONSTRAINT `patron_room_ibfk_1` FOREIGN KEY (`patron_id`) REFERENCES `patron` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `patron_room_ibfk_2` FOREIGN KEY (`room_id`) REFERENCES `room` (`room_no`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `phone_number`
--
ALTER TABLE `phone_number`
ADD CONSTRAINT `student phone` FOREIGN KEY (`student_id`) REFERENCES `student` (`sid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `publication_queue`
--
ALTER TABLE `publication_queue`
ADD CONSTRAINT `publication_queue_ibfk_1` FOREIGN KEY (`patron_id`) REFERENCES `patron` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `publication_queue_ibfk_2` FOREIGN KEY (`pub_id`) REFERENCES `publication` (`pub_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `room`
--
ALTER TABLE `room`
ADD CONSTRAINT `room_ibfk_1` FOREIGN KEY (`lib_id`) REFERENCES `library` (`lib_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `student`
--
ALTER TABLE `student`
ADD CONSTRAINT `did` FOREIGN KEY (`did`) REFERENCES `degree` (`Name`) ON DELETE NO ACTION ON UPDATE NO ACTION,
ADD CONSTRAINT `sid` FOREIGN KEY (`sid`) REFERENCES `patron` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `student_course`
--
ALTER TABLE `student_course`
ADD CONSTRAINT `student_course_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `student` (`sid`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `student_course_ibfk_2` FOREIGN KEY (`cid`) REFERENCES `course` (`cid`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
