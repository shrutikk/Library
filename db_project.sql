-- phpMyAdmin SQL Dump
-- version 4.2.11
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Oct 17, 2015 at 10:17 AM
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

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkinCamera`(IN `patron_id` VARCHAR(45), IN `cam_id` VARCHAR(45))
    NO SQL
delete from cam_checked_out where cam_checked_out.patron_id=patron_id and cam_checked_out.cam_id=cam_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `checkInRoom`(IN `resv_no` INT, OUT `return_value` INT)
    NO SQL
begin
if exists(select * from patron_room where patron_room.resv_no=resv_no) then
    delete from patron_room where patron_room.resv_no= resv_no;
    set return_value = 1;
else
	set return_value =0;
end if;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `checkLogin`(IN `username` VARCHAR(45), IN `password` VARCHAR(128), IN `type` INT, OUT `allow` BOOLEAN)
    NO SQL
begin
	set allow = false;
	if type = 0 then
		if exists(select * from student, patron where patron.id=student.sid 			and student.sid=username and patron.password=password) 		
        then
			set allow = true;
        end if;
     elseif type = 1 then
    	if exists(select * from faculty, patron where patron.id=faculty.fid 			and faculty.fid=username and patron.password=password)
        then
        	set allow = true;
        end if;
     end if;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `checkoutCamera`(IN `cam_id` VARCHAR(45), IN `patron_id` VARCHAR(45), IN `booking_date` DATE, OUT `return_value` INT)
    NO SQL
begin
declare
helper_variable varchar(45);
set helper_variable = (select patron_id from cam_queue where cam_queue.booking_date=booking_date and cam_queue.cam_id=cam_id order by cam_queue.request_time limit 1);
if booking_date = CURDATE() and '09:00:00'<=CURTIME()<='12:00:00' then
    if helper_variable = patron_id then
        set helper_variable = concat(DATE_ADD(booking_date, INTERVAL 6 DAY),' ','18:00:00.000');
        delete from cam_queue where cam_queue.booking_date=booking_date and cam_queue.cam_id=cam_id and cam_queue.patron_id=patron_id;
        insert into cam_checked_out(cam_id, patron_id, return_deadline) values (cam_id, patron_id, helper_variable);
        set return_value = 1;
    else
        set return_value = 2;
    end if;
else
    set return_value = 0;
end if;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `checkOutRoom`(IN `resv_no` INT, OUT `return_value` INT)
    NO SQL
begin
declare
start_time datetime;
if exists(select * from patron_room where patron_room.resv_no=resv_no) then
	set start_time = (select patron_room.start from patron_room where patron_room.resv_no=resv_no);
    if timestampdiff(MINUTE, start_time, NOW())>=0 then
    	update patron_room set checked_out = 1 where patron_room.resv_no= resv_no;
        set return_value =1;
    else
    	set return_value = 0;
    end if;
else
	set return_value = 2;
end if;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `editFaculty`(IN `id` VARCHAR(45), IN `fname` VARCHAR(45), IN `lname` VARCHAR(45), IN `nationality` VARCHAR(45))
    MODIFIES SQL DATA
begin
	UPDATE patron SET fname = fname, lname = lname, nationality = nationality 	  WHERE patron.id = id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `editStudent`(IN `id` VARCHAR(45), IN `firstname` VARCHAR(45), IN `lastname` VARCHAR(45), IN `nationality` VARCHAR(45), IN `sex` VARCHAR(45), IN `phone` VARCHAR(45), IN `altphone` VARCHAR(45), IN `dob` DATE, IN `street` VARCHAR(45), IN `city` VARCHAR(45), IN `pin` VARCHAR(45))
    MODIFIES SQL DATA
begin

UPDATE patron SET fname = firstname, lname = lastname, nationality = nationality WHERE patron.id = id;

UPDATE student SET dob = dob, street = street, city = city, pin = pin, sex = sex, phone = phone, alternate_phone = altphone
WHERE student.sid = id;

	
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllBooks`()
SELECT  p.pub_id, 
        p.title
        FROM    publication p
        INNER JOIN book b
            ON p.pub_id = b.isbn 
        INNER JOIN author c
            ON p.pub_id = c.pub_id
GROUP   BY p.pub_id,p.title$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllCameras`()
    NO SQL
select cam.cam_id, lib.lib_name
from camera cam, library lib
where cam.lib_id = lib.lib_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllConfs`()
    NO SQL
SELECT  p.pub_id, 
        p.title
FROM    publication p
        INNER JOIN conf_paper c
            ON p.pub_id = c.conf_num 
        INNER JOIN author a
            ON p.pub_id = a.pub_id
GROUP   BY p.pub_id,p.title$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllJournals`()
    NO SQL
SELECT  p.pub_id, 
        p.title
FROM    publication p
        INNER JOIN journal j
            ON p.pub_id = j.issn 
        INNER JOIN author a
            ON p.pub_id = a.pub_id
GROUP   BY p.pub_id,p.title$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllRooms`(IN `occupants` INT, IN `lib_id` VARCHAR(45), IN `type` INT)
    NO SQL
begin
     if type = 0 then
     select *
     from room
     where room.type='study room' and room.lib_id=lib_id and  	room.capacity>=occupants;
     elseif type = 1 then
      select *
     from room
     where room.lib_id=lib_id and room.capacity>=occupants;
     end if;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getBookById`(IN `id` VARCHAR(45))
    READS SQL DATA
SELECT  p.pub_id, 
        p.title,p.year,b.edition,b.publisher,
        GROUP_CONCAT(c.author_name ORDER BY c.author_name) Authors
FROM    publication p
        INNER JOIN book b
            ON p.pub_id = b.isbn 
        INNER JOIN author c
            ON p.pub_id = c.pub_id
        WHERE p.pub_id = id
GROUP   BY p.pub_id,p.title$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getCameraById`(IN `id` VARCHAR(45))
    READS SQL DATA
select cam_id,lens_config, memory, make, model, lib_name
from camera cam, library lib
where cam_id = id and cam.lib_id=lib.lib_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getCheckedOutDocDetails`(IN `doc_id` VARCHAR(45))
    NO SQL
begin
	SELECT dc.doc_id,p.pub_id, p.title, dc.checkout_date, dc.ret_deadline
    FROM document_checkout dc
         INNER JOIN document d
         ON d.doc_id = dc.doc_id
         INNER JOIN publication p
         ON p.pub_id = d.pub_id
         where dc.doc_id = doc_id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getCheckedOutDocs`(IN `id` VARCHAR(45))
    READS SQL DATA
begin
	SELECT d.doc_id,p.pub_id, p.title
    FROM document_checkout dc
         INNER JOIN document d
         ON d.doc_id = dc.doc_id
         INNER JOIN publication p
         ON p.pub_id = d.pub_id
         where dc.patron_id = id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getConfById`(IN `id` VARCHAR(45))
    NO SQL
SELECT  p.pub_id, 
        p.title,p.year,c.conf_name,
        GROUP_CONCAT(a.author_name ORDER BY a.author_name) Authors
FROM    publication p
        INNER JOIN conf_paper c
            ON p.pub_id = c.conf_num 
        INNER JOIN author a
            ON p.pub_id = a.pub_id
        WHERE p.pub_id = id
GROUP   BY p.pub_id,p.title$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getFacultyProfile`(IN `username` VARCHAR(45))
    NO SQL
begin
	select p.id, p.fname, p.lname ,f.category, p.nationality,d.dname, p.balance
    from patron p
	inner join faculty f on p.id=f.fid
	inner join department d on p.dept_id=d.did 
	where f.fid=username;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getJournalById`(IN `id` INT)
    NO SQL
SELECT  p.pub_id, 
        p.title,p.year,
        GROUP_CONCAT(a.author_name ORDER BY a.author_name) Authors
FROM    publication p
        INNER JOIN journal j
            ON p.pub_id = j.issn 
        INNER JOIN author a
            ON p.pub_id = a.pub_id
        WHERE p.pub_id = id
GROUP   BY p.pub_id,p.title$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getStudentProfile`(IN `username` VARCHAR(45))
    NO SQL
begin
	select p.id, p.fname, p.lname , p.nationality, d.dname, s.sex, s.phone, s.alternate_phone, s.dob, s.street, s.city, s.pin, p.balance, student_degree.classification, degree.category, degree.name as degree_name  from patron p
	inner join student s on p.id=s.sid
	inner join department d on p.dept_id=d.did, student_degree, degree
    where s.sid=username and student_degree.student_id=s.sid and student_degree.degree_id=degree.name;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `isReservationTimedOut`(IN `resv_no` INT, OUT `return_val` BOOLEAN)
    NO SQL
begin
if exists (select * from patron_room where patron_room.resv_no=resv_no and timestampdiff(HOUR,patron_room.start, NOW())>1 and patron_room.checked_out = 0) then
	set return_val = true;
else
	set return_val = false;
end if;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `reserveCamera`(IN `cam_id` VARCHAR(45), IN `booking_date` DATE, IN `patron_id` INT, OUT `queue_position` INT)
    NO SQL
begin
	set queue_position = (select count(*) from cam_queue queue where queue.cam_id=cam_id and queue.booking_date=booking_date);
    insert into cam_queue(cam_id, patron_id, booking_date, request_time) values(cam_id, patron_id, booking_date, NOW());
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `reserveRoom`(IN `arg_patron_id` VARCHAR(45), IN `arg_room_id` VARCHAR(45), IN `arg_start` DATETIME, IN `arg_end` DATETIME, OUT `return_value` INT)
    NO SQL
begin
    if timestampdiff(HOUR, arg_start, arg_end)<=3 then
        if not exists (select * from patron_room where patron_room.room_id=room_id and ((arg_start>=patron_room.start and arg_start < patron_room.end) or (arg_end> patron_room.start and arg_end <= patron_room.end) or (arg_start<=patron_room.start and arg_end>=patron_room.end) or (arg_start>=patron_room.start and arg_end<=patron_room.end))) then
            insert into patron_room(start, end, checked_out ,patron_id, room_id) values(arg_start, arg_end, 0, arg_patron_id, arg_room_id);
            set return_value =1;
        else 
            set return_value = 0;
        end if;
    else 
        set return_value =2;
    end if;
end$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `author`
--

CREATE TABLE IF NOT EXISTS `author` (
  `author_name` varchar(45) NOT NULL,
  `pub_id` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `author`
--

INSERT INTO `author` (`author_name`, `pub_id`) VALUES
('Linus Torvalds', 'CONF0000'),
('Chris Martin', 'ISBN1234'),
('John Smith', 'ISBN1234'),
('Galvin', 'ISBN1235'),
('Tom Moody', 'ISSN1111');

-- --------------------------------------------------------

--
-- Table structure for table `book`
--

CREATE TABLE IF NOT EXISTS `book` (
  `isbn` varchar(45) NOT NULL,
  `edition` varchar(45) NOT NULL,
  `publisher` varchar(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `book`
--

INSERT INTO `book` (`isbn`, `edition`, `publisher`) VALUES
('ISBN1234', '1', 'ABC'),
('ISBN1235', '2', 'ABC');

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

--
-- Dumping data for table `camera`
--

INSERT INTO `camera` (`cam_id`, `lens_config`, `memory`, `make`, `model`, `lib_id`) VALUES
('123', 'conf', '256', 'canon', '500D', '1'),
('234', 'good ones', '1024', 'nikon', 'DSC 3000D', '1'),
('456', 'prime', '512', 'sony', 'vr', '2'),
('789', 'Zoom', '128', 'kodak', 'old', '2');

-- --------------------------------------------------------

--
-- Table structure for table `cam_checked_out`
--

CREATE TABLE IF NOT EXISTS `cam_checked_out` (
  `cam_id` varchar(45) NOT NULL,
  `patron_id` varchar(45) NOT NULL,
  `return_deadline` datetime NOT NULL
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

--
-- Dumping data for table `conf_paper`
--

INSERT INTO `conf_paper` (`conf_num`, `conf_name`) VALUES
('CONF0000', 'Linux Conference');

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

--
-- Dumping data for table `degree`
--

INSERT INTO `degree` (`Name`, `Duration`, `Category`) VALUES
('Masters in Computer Science', 24, 'Graduate');

-- --------------------------------------------------------

--
-- Table structure for table `department`
--

CREATE TABLE IF NOT EXISTS `department` (
  `did` varchar(45) NOT NULL,
  `dname` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `department`
--

INSERT INTO `department` (`did`, `dname`) VALUES
('CSC', 'Computer Science Department');

-- --------------------------------------------------------

--
-- Table structure for table `document`
--

CREATE TABLE IF NOT EXISTS `document` (
`doc_id` int(11) NOT NULL,
  `pub_id` varchar(45) NOT NULL,
  `category` varchar(45) NOT NULL,
  `lib_id` varchar(45) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `document`
--

INSERT INTO `document` (`doc_id`, `pub_id`, `category`, `lib_id`) VALUES
(1, 'ISBN1234', 'HardCopy', '1'),
(2, 'ISBN1235', 'HardCopy', '1'),
(3, 'ISBN1234', 'HardCopy', '1'),
(4, 'ISSN1111', 'HardCopy', '1');

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

--
-- Dumping data for table `document_checkout`
--

INSERT INTO `document_checkout` (`patron_id`, `doc_id`, `checkout_date`, `ret_deadline`) VALUES
('sdrangne', 1, '2015-10-08', '2015-10-24'),
('sdrangne', 2, '2015-10-09', '2015-10-10'),
('oghanek', 3, '2015-10-08', '2015-10-17'),
('oghanek', 4, '2015-10-08', '2015-10-09');

-- --------------------------------------------------------

--
-- Table structure for table `faculty`
--

CREATE TABLE IF NOT EXISTS `faculty` (
  `category` varchar(45) NOT NULL,
  `fid` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `faculty`
--

INSERT INTO `faculty` (`category`, `fid`) VALUES
('Professor', 'sheber');

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

--
-- Dumping data for table `journal`
--

INSERT INTO `journal` (`issn`) VALUES
('ISSN1111');

-- --------------------------------------------------------

--
-- Table structure for table `library`
--

CREATE TABLE IF NOT EXISTS `library` (
  `lib_id` varchar(45) NOT NULL,
  `lib_name` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `library`
--

INSERT INTO `library` (`lib_id`, `lib_name`) VALUES
('1', 'Hunt'),
('2', 'hill');

-- --------------------------------------------------------

--
-- Table structure for table `notification`
--

CREATE TABLE IF NOT EXISTS `notification` (
  `patron_id` varchar(45) NOT NULL,
`id` int(11) NOT NULL,
  `read_flag` tinyint(1) NOT NULL DEFAULT '0',
  `detail` varchar(100) NOT NULL
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
  `password` varchar(128) NOT NULL,
  `balance` float NOT NULL,
  `dept_id` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `patron`
--

INSERT INTO `patron` (`id`, `fname`, `lname`, `nationality`, `password`, `balance`, `dept_id`) VALUES
('oghanek', 'omkar1', '0', 'US', '81beaf49dac3e6e7e4e95b124a0ecbd6', 0, 'CSC'),
('sdrangne', 'Sarvesh', 'Rangnekar', 'Indian', '6d93ed7878be5ff1cdd2681e0eeb0f91', 12, 'CSC'),
('sheber', 'Steffan', 'Heber', 'German', '2e8c07e09c32161ecb19a6d9ddc2c024', 0, 'CSC');

-- --------------------------------------------------------

--
-- Table structure for table `patron_room`
--

CREATE TABLE IF NOT EXISTS `patron_room` (
`resv_no` int(11) NOT NULL,
  `start` datetime NOT NULL,
  `end` datetime NOT NULL,
  `checked_out` tinyint(1) NOT NULL,
  `patron_id` varchar(45) NOT NULL,
  `room_id` varchar(45) NOT NULL
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

--
-- Dumping data for table `publication`
--

INSERT INTO `publication` (`pub_id`, `title`, `type`, `year`) VALUES
('CONF0000', 'Conference1', 'Conference', '2010'),
('ISBN1234', 'Database Management', 'Book', '2015'),
('ISBN1235', 'Operating Systems', 'Book', '2000'),
('ISSN1111', 'Journal1', 'Journal', '2014');

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

--
-- Dumping data for table `room`
--

INSERT INTO `room` (`room_no`, `type`, `floor`, `capacity`, `lib_id`) VALUES
('123', 'conference room', 'level 0', 15, '1'),
('345', 'study room', 'level 1', 4, '2'),
('5657', 'conference room', 'level 2', 25, '2'),
('678', 'study room', 'level 2', 6, '1');

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
  `phone` varchar(45) NOT NULL,
  `alternate_phone` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `student`
--

INSERT INTO `student` (`dob`, `street`, `city`, `pin`, `sex`, `sid`, `phone`, `alternate_phone`) VALUES
('1969-12-31', 'Avent ferry', 'Raleigh', '27606', 'Male', 'oghanek', '9199999999', '9999999999'),
('1992-12-18', 'Avery', 'Raleigh', '411009', 'Male', 'sdrangne', '1111111111', '9999999999');

-- --------------------------------------------------------

--
-- Table structure for table `student_course`
--

CREATE TABLE IF NOT EXISTS `student_course` (
  `student_id` varchar(45) NOT NULL,
  `cid` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `student_degree`
--

CREATE TABLE IF NOT EXISTS `student_degree` (
  `student_id` varchar(45) NOT NULL,
  `degree_id` varchar(45) NOT NULL,
  `classification` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `student_degree`
--

INSERT INTO `student_degree` (`student_id`, `degree_id`, `classification`) VALUES
('oghanek', 'Masters in Computer Science', 'first year'),
('sdrangne', 'Masters in Computer Science', 'second year');

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
 ADD PRIMARY KEY (`cam_id`,`patron_id`), ADD KEY `checkout_date` (`return_deadline`), ADD KEY `patron_id` (`patron_id`);

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
 ADD PRIMARY KEY (`resv_no`), ADD KEY `patron_id` (`patron_id`), ADD KEY `room_id` (`room_id`);

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
 ADD PRIMARY KEY (`sid`);

--
-- Indexes for table `student_course`
--
ALTER TABLE `student_course`
 ADD PRIMARY KEY (`student_id`,`cid`), ADD KEY `cid` (`cid`);

--
-- Indexes for table `student_degree`
--
ALTER TABLE `student_degree`
 ADD PRIMARY KEY (`student_id`), ADD KEY `degree_id` (`degree_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `document`
--
ALTER TABLE `document`
MODIFY `doc_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `notification`
--
ALTER TABLE `notification`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `patron_room`
--
ALTER TABLE `patron_room`
MODIFY `resv_no` int(11) NOT NULL AUTO_INCREMENT;
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
ADD CONSTRAINT `sid` FOREIGN KEY (`sid`) REFERENCES `patron` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `student_course`
--
ALTER TABLE `student_course`
ADD CONSTRAINT `student_course_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `student` (`sid`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `student_course_ibfk_2` FOREIGN KEY (`cid`) REFERENCES `course` (`cid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `student_degree`
--
ALTER TABLE `student_degree`
ADD CONSTRAINT `student_degree_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `student` (`sid`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `student_degree_ibfk_2` FOREIGN KEY (`degree_id`) REFERENCES `degree` (`Name`);

DELIMITER $$
--
-- Events
--
CREATE DEFINER=`root`@`localhost` EVENT `clearTimedOutRoomReservations` ON SCHEDULE EVERY 30 MINUTE STARTS '2015-10-16 00:00:00' ON COMPLETION PRESERVE ENABLE DO begin
delete from patron_room
where (timestampdiff(MINUTE, patron_room.start, NOW())>=60 and checked_out =0) or (timestampdiff(MINUTE, patron_room.end, NOW())>=0);
end$$

CREATE DEFINER=`root`@`localhost` EVENT `latePenaltyNotifForCamera` ON SCHEDULE EVERY 7 DAY STARTS '2015-10-15 18:01:00' ON COMPLETION PRESERVE ENABLE DO insert into notification(patron_id, detail)
select patron_id, concat(cam_id,' is due for return')
from cam_checked_out
where date(cam_checked_out.return_deadline)=curdate()$$

DELIMITER ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
