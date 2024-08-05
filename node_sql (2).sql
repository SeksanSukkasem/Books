-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Aug 05, 2024 at 10:36 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `node_sql`
--

-- --------------------------------------------------------

--
-- Table structure for table `bestselling`
--

CREATE TABLE `bestselling` (
  `id` int(11) NOT NULL,
  `productTitle` varchar(255) NOT NULL,
  `productDescription` text DEFAULT NULL,
  `author` varchar(255) DEFAULT NULL,
  `publisher` varchar(255) DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  `pages` int(11) DEFAULT NULL,
  `productType` varchar(255) DEFAULT NULL,
  `size` varchar(255) DEFAULT NULL,
  `weight` varchar(255) DEFAULT NULL,
  `barcode` varchar(255) DEFAULT NULL,
  `productPrice` decimal(10,2) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `soldCount` int(11) DEFAULT 0,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `updatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bestselling`
--

INSERT INTO `bestselling` (`id`, `productTitle`, `productDescription`, `author`, `publisher`, `category`, `pages`, `productType`, `size`, `weight`, `barcode`, `productPrice`, `image`, `soldCount`, `createdAt`, `updatedAt`) VALUES
(7, 'จิตวิทยาสายดาร์ก', ' มองโลกผ่านมุมจิตวิทยาเพื่อตั้งรับและก้าวผ่านปัญหาในวันที่ชีวิตโยนบททดสอบอันหนักหนามาให้หนังสือเล่มนี้ได้รวบรวบชุดเครื่องมือที่ใช้กันโดยจิตแพทย์และนักจิตบำบัดแต่มันไม่ใช่ทักษะสำหรับผู้ป่วยเท่านั้น  ทว่าเป็นทักษะชีวิตที่จะช่วยนำทางพวกเราทุกคนให้ก้าวผ่านช่วงเวลาอันยากลำบาก \r\nเมื่อเราเข้าใจกลไกการทำงานของจิตใจและเรียนรู้วิธีที่เหมาะสมในการจัดการกับอารมณ์ความรู้สึก  เราไม่เพียงสร้างเบาะไว้รองรับจิตใจในวันที่พายุถาโถมเข้าใส่  แต่ยังสามารถเติบโตและรับมือกับโลกได้ดีขึ้นในทุก ๆ วัน', ' ภมุ ภามุ', 'ดี สนพ./D Publishing', 'หนังสือเตรียมสอบ แนวข้อสอบ , พจนานุกรม', 352, 'Books', '18.5 x 12.8 x 1.5 CM', '0.264 KG', '32554565475647', 276.00, '/uploads/1718213871943.jpg', 10, '2024-06-12 17:37:51', '2024-06-12 17:37:51'),
(11, 'ความรักในกาลครั้งหนึ่ง', 'กาลครั้งหนึ่ง...ไม่รู้จักกัน กาลครั้งหนึ่ง...ได้รักกัน กาลครั้งหนึ่ง...จะลืมกัน เรื่องราวของความรักที่แบ่งออกเป็น 3 ห้วงเวลา ในหนังสือ “ความรักในกาลครั้งหนึ่ง” เล่มนี้ เป็นผลงานเขียนของ “ยอดภักดี\" เจ้าของเพจคำคมสุดฮิต “ธรรมทาน” ที่มียอดผู้ติดตามกว่า 800,000 คน และอินสตาแกรม dhammatan ที่ได้รับความนิยม จากยอดกว่า 500,000 followers จะพาทุกคนเดินทางไปสู่ดินแดน แห่งความรักไม่ว่าจะเป็นคนที่กำลังตามหาความรัก คนที่กำลังอยู่ในห้วงแห่งความรัก และคนที่ปลายทางแห่งรักได้สิ้นสุดลงแล้วก็ตาม ให้พื้นที่ในหัวใจได้ลองสัมผัสอุ่นไอแห่งรัก ผ่านตัวอักษร ของ “ยอดภักดี” เพื่อค้นหาความหมายและความงดงามในห้วง “ความรักในกาลครั้งหนึ่ง” ของคุณสักครั้ง', 'ยอดภักดี', 'LEMON', 'จิตวิทยา การพัฒนาตัวเอง , การพัฒนาตัวเอง how to', 232, 'Books', '0 x 0 x 0 CM', '0.227 KG', '98309289085493', 250.00, '/uploads/1721792096276.jpg', 20, '2024-07-24 03:34:56', '2024-07-24 03:34:56');

-- --------------------------------------------------------

--
-- Table structure for table `login_logs`
--

CREATE TABLE `login_logs` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `status` varchar(10) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `login_logs`
--

INSERT INTO `login_logs` (`id`, `user_id`, `status`, `timestamp`) VALUES
(1, 1, 'success', '2024-07-27 08:05:23'),
(2, 1, 'success', '2024-07-27 08:37:05'),
(3, 1, 'success', '2024-07-27 08:39:44'),
(4, 1, 'success', '2024-07-27 08:41:24'),
(5, 1, 'success', '2024-07-27 08:43:13'),
(6, 1, 'success', '2024-07-27 08:44:47'),
(7, 1, 'success', '2024-07-27 08:45:46'),
(8, 1, 'success', '2024-07-28 18:52:27'),
(9, 1, 'success', '2024-07-28 18:54:54'),
(10, 1, 'success', '2024-07-28 18:56:45'),
(11, 1, 'success', '2024-07-28 18:57:02'),
(12, 1, 'success', '2024-07-28 18:57:33'),
(13, 1, 'failed', '2024-07-28 18:58:10'),
(14, 1, 'failed', '2024-07-28 18:58:16'),
(15, 1, 'failed', '2024-07-28 18:59:55'),
(16, 1, 'failed', '2024-07-28 19:01:42'),
(17, 1, 'success', '2024-07-28 19:01:48'),
(18, 1, 'failed', '2024-07-28 19:32:35'),
(19, 1, 'success', '2024-07-28 19:32:37'),
(20, 1, 'success', '2024-07-28 19:49:49'),
(21, 1, 'failed', '2024-07-28 19:52:59'),
(22, 1, 'failed', '2024-07-28 19:53:03'),
(23, 1, 'success', '2024-07-28 20:30:48'),
(24, 1, 'success', '2024-07-29 09:07:41'),
(25, 1, 'success', '2024-07-29 09:11:29'),
(26, 1, 'success', '2024-07-29 09:12:11'),
(27, 1, 'success', '2024-07-29 12:36:06'),
(28, 1, 'success', '2024-07-29 12:37:08'),
(29, 1, 'failed', '2024-07-29 12:37:21'),
(30, 1, 'failed', '2024-07-29 12:37:23'),
(31, 1, 'failed', '2024-07-29 12:37:24'),
(32, 1, 'success', '2024-07-29 12:37:28'),
(33, 1, 'success', '2024-07-29 12:38:14'),
(34, 1, 'success', '2024-07-29 12:41:10'),
(35, 1, 'success', '2024-07-29 12:41:35'),
(36, 1, 'failed', '2024-07-30 19:18:19'),
(37, 1, 'failed', '2024-07-30 19:21:32'),
(38, NULL, 'failed', '2024-07-31 03:31:37'),
(39, NULL, 'failed', '2024-07-31 03:32:41'),
(40, NULL, 'failed', '2024-07-31 03:36:29'),
(41, 4, 'success', '2024-07-31 03:39:12'),
(42, 4, 'success', '2024-07-31 03:39:34'),
(43, NULL, 'failed', '2024-07-31 03:50:27'),
(44, NULL, 'failed', '2024-07-31 03:50:48'),
(45, 5, 'success', '2024-07-31 06:10:39'),
(46, 5, 'success', '2024-07-31 06:11:57'),
(47, 5, 'success', '2024-07-31 06:14:25'),
(48, 5, 'failed', '2024-08-05 08:14:13');

-- --------------------------------------------------------

--
-- Table structure for table `market`
--

CREATE TABLE `market` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_title` varchar(255) NOT NULL,
  `product_price` decimal(10,2) NOT NULL,
  `quantity` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `market`
--

INSERT INTO `market` (`id`, `product_id`, `product_title`, `product_price`, `quantity`) VALUES
(176, 60, 'ศิลปะของการมีชีวิตที่ดี', 310.00, 1),
(177, 66, 'ชีวิตเรามีแค่สี่พันสัปดาห์', 234.60, 1),
(178, 62, 'STOP READING THE NEWS มืดบอดเพราะอ่านข่าว', 149.60, 1);

-- --------------------------------------------------------

--
-- Table structure for table `newbook`
--

CREATE TABLE `newbook` (
  `id` int(11) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `newbook`
--

INSERT INTO `newbook` (`id`, `image`, `createdAt`) VALUES
(10, '/uploads/1718204476662.jpg', '2024-06-12 15:01:16'),
(11, '/uploads/1718204482715.jpg', '2024-06-12 15:01:22'),
(12, '/uploads/1718204510748.jpg', '2024-06-12 15:01:50');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `productTitle` varchar(255) NOT NULL,
  `productDescription` text NOT NULL,
  `productPrice` decimal(10,2) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `author` varchar(255) NOT NULL,
  `publisher` varchar(255) NOT NULL,
  `category` varchar(255) NOT NULL,
  `pages` int(11) NOT NULL,
  `productType` varchar(255) NOT NULL,
  `size` varchar(255) NOT NULL,
  `weight` varchar(255) NOT NULL,
  `barcode` varchar(255) NOT NULL,
  `bestSelling` tinyint(1) DEFAULT 0,
  `newBook` tinyint(1) DEFAULT 0,
  `isBestSelling` tinyint(1) DEFAULT 0,
  `isNew` tinyint(1) DEFAULT 0,
  `discount` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `productTitle`, `productDescription`, `productPrice`, `image`, `author`, `publisher`, `category`, `pages`, `productType`, `size`, `weight`, `barcode`, `bestSelling`, `newBook`, `isBestSelling`, `isNew`, `discount`) VALUES
(56, 'พจนานุกรมอังกฤษ-ไทย ฉบับทันสมัย (ใหม่)', 'Dr. Hiro  เคยเป็นนักขายที่ล้มเหลว  ขายอะไรก็ไม่มีใครซื้อแต่แล้ววันหนึ่งขณะกำลังดูข่าว ', 175.00, '/uploads/1718165197409.jpg', 'วิทย์ เที่ยงบูรณธรรม', 'ซีเอ็ดยูเคชั่น/se-ed', 'การพัฒนาตัวเอง how to ', 0, 'Books', '10.4 x 14.2 x 3.7 CM', '0.49 KG', '1234567890', 0, 0, 0, 0, NULL),
(59, 'ความรักในกาลครั้งหนึ่ง', '   กาลครั้งหนึ่ง...ไม่รู้จักกัน  กาลครั้งหนึ่ง...ได้รักกัน  กาลครั้งหนึ่ง...จะลืมกัน\r\n\r\n เรื่องราวของความรักที่แบ่งออกเป็น 3 ห้วงเวลา ในหนังสือ “ความรักในกาลครั้งหนึ่ง” เล่มนี้ เป็นผลงานเขียนของ “ยอดภักดี\" เจ้าของเพจคำคมสุดฮิต “ธรรมทาน” ที่มียอดผู้ติดตามกว่า 800,000 คน และอินสตาแกรม dhammatan ที่ได้รับความนิยม จากยอดกว่า 500,000 followers จะพาทุกคนเดินทางไปสู่ดินแดน แห่งความรักไม่ว่าจะเป็นคนที่กำลังตามหาความรัก คนที่กำลังอยู่ในห้วงแห่งความรัก และคนที่ปลายทางแห่งรักได้สิ้นสุดลงแล้วก็ตาม\r\n\r\n ให้พื้นที่ในหัวใจได้ลองสัมผัสอุ่นไอแห่งรัก ผ่านตัวอักษร ของ “ยอดภักดี” เพื่อค้นหาความหมายและความงดงามในห้วง “ความรักในกาลครั้งหนึ่ง” ของคุณสักครั้ง', 250.00, '/uploads/1718196904503.jpg', 'ยอดภักดี', 'LEMON', 'จิตวิทยา การพัฒนาตัวเอง , การพัฒนาตัวเอง how to', 232, 'Books', '0 x 0 x 0 CM', '0.227 KG', '98309289085493', 0, 0, 0, 0, NULL),
(60, 'ศิลปะของการมีชีวิตที่ดี', ' ชีวิตที่ดีคืออะไร?ตลอด 2,500 กว่าปีที่ผ่านมา  มนุษย์เราตั้งคำถามนี้กันอยู่เสมอผู้คนในแต่ละยุคสมัยเฝ้าแสวงหาคำตอบกันครั้งแล้วครั้งเล่า  แต่ไม่ว่าอย่างไรก็ไม่เจอคำตอบที่น่าพึงพอใจสักทีหรือแท้จริงแล้ว  “การมีชีวิตที่ดี”  อาจเรียบง่ายกว่าที่เราคิด?รอล์ฟ โดเบลลี  กลั่นกรองความรู้จากภูมิปัญญาโบราณและงานวิจัยแขนงต่าง ๆ  จนกลายมาเป็น 52 ปรัชญาสมัยใหม่ที่จะช่วยให้คุณมีชีวิตที่ดีได้ในแบบที่ต้องการ\r\n\r\n- ไม่ต้องฟังเสียงในใจคุณ\r\n- จดบันทึกความผิดพลาดของตัวเองทุกวัน\r\n- ใส่ใจสิ่งแย่ ๆ  แล้วสิ่งดี ๆ จะเกิดขึ้นเอง\r\n- ซื้อข้าวของให้น้อยลง  และเก็บเกี่ยวประสบการณ์ให้มากขึ้น\r\n- เก็บออมอิสรภาพให้มากกว่าเงิน', 310.00, '/uploads/1718196967024.jpg', 'Rolf Dobelli (รอล์ฟ โดเบลลี)', 'วีเลิร์น (WeLearn)', ' จิตวิทยา การพัฒนาตัวเอง , การพัฒนาตัวเอง how to', 416, 'Books', '18.5 x 12.8 x 2.4 CM', '0.387 KG', '08983046543', 0, 0, 0, 0, NULL),
(62, 'STOP READING THE NEWS มืดบอดเพราะอ่านข่าว', 'STOP READING THE NEWS มืดบอดเพราะอ่านข่าว\r\n\r\nผมมีข่าวร้ายและข่าวดีมาบอกครับ\r\n\r\nข่าวร้ายก็คือ\r\nต่อให้คุณเป็นที่หนึ่งของชั้นเรียนก็หมดอนาคตได้เพราะข่าว\r\nต่อให้คุณรวยแค่ไหนก็กลายเป็นยาจกได้เพราะข่าว\r\nต่อให้คุณนิสัยดีขนาดไหนก็เป็นศัตรูกับคนทั้งโลกได้เพราะข่าว\r\nต่อให้คุณแข็งแรงแค่ไหนก็ป่วยสาหัสได้เพราะข่าว\r\n\r\nส่วนข่าวดี  (และข่าวเดียวที่คุณควรอ่าน)  ก็คือ\r\nคุณไม่จำเป็นต้องอ่านข่าวเลย\r\n\r\nRolf Dobelli นักเขียนชื่อดังระดับโลก เจ้าของผลงาน  The Art of Thinking Clearly\r\nจะเปิดเผยหลุมพรางทางจิตวิทยาที่ซ่อนอยู่เบื้องหลังข่าวต่างๆ\r\nที่เมื่อยิ่งเสพก็จะทำให้ความคิดของคุณมืดบอดและมีความเชื่อที่ผิดเพี้ยนไป \r\nพร้อมกับบอกวิธีที่ช่วยให้คุณรู้เท่าทันสื่อและมองเห็นโลกในมุมที่กระจ่างชัดมากขึ้น', 187.00, '/uploads/1718197043635.jpg', 'Rolf Dobelli (รอล์ฟ โดเบลลี)', 'วีเลิร์น (WeLearn)', 'จิตวิทยา การพัฒนาตัวเอง , การพัฒนาตัวเอง how to', 192, 'Books', '12.8 x 18.5 x 1.1 CM', '0.186 KG', '90849865436543', 0, 0, 0, 0, 20),
(63, 'Do The Hard Things First เอาชนะนิสัยผัดวันประกันพรุ่งด้วยกลยุทธ์ทำงานยากก่อนเป็นอย่างแรก', 'คุณกำลังใช้ชีวิตท่ามกลางความโกลาหลเพราะมักผัดผ่อนงานสำคัญออกไปจนกระทั่งนาทีสุดท้ายใช่ไหม คุณรู้สึกไร้ระเบียบทั้งตอนอยู่ที่บ้านและที่ทำงานใช่หรือเปล่า คุณรู้สึกวิตกกังวล หงุดหงิดใจ และอับจนหนทางเพราะโปรเจกต์ทั้งหมดที่คั่งค้างอยู่ใชหรือไม่ถ้าใช่ ก็ถึงเวลาแล้วที่คุณจะต้องเอาชนะภาวะอัมพาตจากการคิดวิเคราะห์ เพิ่มประสิทธิภาพการทำงาน และใช้ระบบที่ผ่านการพิสูจน์มาแล้วว่าสามารถกระตุ้นแรงจูงใจและวินัยในตัวเองได้จริงสกอตต์ อัลลัน นักเขียนหนังสือขายดีและผู้อบรมด้านการพัฒนาตัวเอง อยากเห็นคุณเอาชนะนิสัยผัดวันประกันพรุ่งและกำจัดเสียงเชิงลบในใจ เพื่อที่คุณจะได้ยุติความโกลาหลจากการหลีกเลี่ยงงาน ในคู่มือที่เขียนจากประสบการณ์ตรงและทำตามได้จริงเล่มนี้ คุณจะได้เรียนรู้กลยุทธ์ที่ใช้ได้ผลในการเปลี่ยนนิสัยแย่ ๆ และเอาชนะการบ่อนทำลายตัวเอง เพื่อให้คุณเลิกโทษว่าตัวเองเป็นคนขี้เกียจ', 339.00, '/uploads/1718197335125.jpg', 'สกอตต์ อัลลัน (Scott Allan)', 'ธิงค์บียอนด์/Think Beyond', ' จิตวิทยา การพัฒนาตัวเอง , การพัฒนาตัวเอง how to', 344, 'Books', '0 x 0 x 0 CM', '0.446 KG', '9809859647546', 0, 0, 0, 0, NULL),
(64, 'รอยทรงจำในกระดูก (What My Bones Know)', 'เบื้องหน้าเธอคือนักข่าวและโปรดิวเซอร์รายการวิทยุ This American Life ผู้ประสบความสำเร็จทั้งในชีวิตการงานและความรัก แต่เบื้องหลังเธอต้องทนทุกข์กับอาการตื่นตระหนกที่เข้าจู่โจมทุกวัน หลังจากเข้ารับการบำบัดทางจิตมากว่าแปดปี ในที่สุดคุณหมอก็แจ้งผลการวินิจฉัยว่าเธอเป็นโรค C-PTSD  (Complex Post-traumatic Stress Disorder) หรือภาวะป่วยทางจิตใจชนิดซับซ้อนหลังเกิดเหตุการณ์สะเทือนใจ \r\n\r\n   สเตฟานี ฟู นักเขียนขายดีจาก The New York Times เผยเส้นทางชีวิตของตัวเองผ่านบันทึกเรื่องราวของเด็กหญิงผู้เติบโตขึ้นท่ามกลางความเจ็บปวดทั้งร่างกายและจิตใจ จนกลายเป็นหญิงสาวที่เฝ้าบอกตัวเองว่า “ฉันไม่ใช่ผู้หญิง ฉันคือดาบ” ในวัย 30 ปีเธอกลายเป็นผู้ใหญ่ที่เต็มไปด้วยบาดแผลทางใจ แต่เธอเปลี่ยนความเจ็บปวดนั้นให้กลายเป็นพลังที่ฉุดให้ลุกขึ้นมาหาหนทางเยียวยาตัวเอง ด้วยการศึกษางานวิจัยและปรึกษาผู้เชี่ยวชาญหลากหลาย ทั้งนักวิทยาศาสตร์ จิตแพทย์ รวมทั้งเข้ารับการบำบัดด้วยตนเอง ที่สำคัญเธอได้ขุดปมประวัติครอบครัว จนพบว่า ความขมขื่นของบรรพบุรุษที่ต้องอพยพ ต้องเผชิญกับความเกลียดชัง ความรุนแรง และความแปลกแยก ล้วนเป็นสิ่งที่ฝังอยู่ในสายเลือดราวกับฝังลงในกระดูกและถูกซึ่งส่งต่อกันจากรุ่นสู่รุ่นได้\r\n\r\n   นี่คือหนังสือที่ถ่ายทอดประสบการณ์ผู้ป่วย C-PTSDของคนที่จิตใจแตกสลายได้อย่างทรงพลังและเปี่ยมไปด้วยความหวัง  สร้างความเข้าใจว่า แม้บาดแผลทางใจเป็นสิ่งที่ไม่อาจลบเลือน แต่เราสามารถทำความเข้าใจและใช้ชีวิตร่วมกับมันได้', 398.00, '/uploads/1718197390722.jpg', 'สเตฟานี ฟู (Stephanie Foo)', 'Be(ing) (บีอิ้ง)', 'จิตวิทยา การพัฒนาตัวเอง , การพัฒนาตัวเอง how to', 448, 'Books', '21 x 14.3 x 2.1 CM', '0.563 KG', '78907896054', 0, 0, 0, 0, 20),
(65, 'จิตวิทยาสายดาร์ก', 'Dr. Hiro  เคยเป็นนักขายที่ล้มเหลว  ขายอะไรก็ไม่มีใครซื้อแต่แล้ววันหนึ่งขณะกำลังดูข่าว  เขาก็นึกขึ้นได้ว่า“ในโลกเรามีลัทธิที่ขายของไม่น่าเชื่อถือได้ในราคาแพงลิ่วแถมยังทำให้สาวกยอมทุ่มบริจาคทรัพย์สินจนหมดตัวแล้วทำไมผมถึงขายไม่ออกล่ะ?”เขาจึงเริ่มศึกษาเทคนิคเหล่านั้นอย่างจริงจังอ่านหนังสือทุกเล่มเกี่ยวกับการล้างสมองที่มีในท้องตลาดแล้วเอาไปปรับใช้จนกลายเป็นนักขายระดับท็อปของญี่ปุ่นนั่นคือที่มาของ  “จิตวิทยาสายดาร์ก”พบกับเทคนิคทางจิตวิทยาที่ช่วยให้คุณใช้คำพูดควบคุมจิตใจคนทำให้พวกเขาคล้อยตามและทำอย่างที่คุณต้องการโดยไม่รู้ตัว', 212.00, '/uploads/1718210444744.jpg', 'Dr.Hiro', 'วีเลิร์น (WeLearn)', 'จิตวิทยา การพัฒนาตัวเอง , การพัฒนาตัวเอง how to', 280, 'Books', '18.5 x 12.8 x 1.5 CM', '0.264 KG', '32554565475647', 0, 0, 0, 0, NULL),
(66, 'ชีวิตเรามีแค่สี่พันสัปดาห์', '  มองโลกผ่านมุมจิตวิทยาเพื่อตั้งรับและก้าวผ่านปัญหาในวันที่ชีวิตโยนบททดสอบอันหนักหนามาให้หนังสือเล่มนี้ได้รวบรวบชุดเครื่องมือที่ใช้กันโดยจิตแพทย์และนักจิตบำบัดแต่มันไม่ใช่ทักษะสำหรับผู้ป่วยเท่านั้น  ทว่าเป็นทักษะชีวิตที่จะช่วยนำทางพวกเราทุกคนให้ก้าวผ่านช่วงเวลาอันยากลำบาก ', 276.00, '/uploads/1718214862514.jpg', 'Dr.Julie Smith', 'วีเลิร์น (WeLearn)', 'จิตวิทยา การพัฒนาตัวเอง , การพัฒนาตัวเอง how to', 352, 'Books', '18.5 x 12.8 x 1.5 CM', '0.264 KG', '32554565475647', 0, 0, 0, 0, 15),
(68, 'วีเลิร์น (WeLearn)', 'วีเลิร์น (WeLearn)วีเลิร์น (WeLearn)วีเลิร์น (WeLearn)วีเลิร์น (WeLearn)วีเลิร์น (WeLearn)', 276.00, '/uploads/1721791908225.jpg', 'Dr.Julie Smith', 'วีเลิร์น (WeLearn)', 'จิตวิทยา การพัฒนาตัวเอง', 352, 'Books', '18.5 x 12.8 x 1.5 CM', '0.264 KG', '32554565475647', 0, 0, 0, 0, 20),
(69, 'Money Mastery มั่งคั่งทั้งชีวิต', 'เงินหายมหาศาลเพราะขาดความรู้ด้านการเงินถ้านำเงิน 100,000 บาท ไปลงทุนใช้เวลา 30 ปีได้รับผลตอบแทนอัตราที่ต่างกัน แต่ที่เหลือเหมือนกันหมด เงินที่ได้จะต่างกันมากนะครับผมคำนวณมาให้เห็นภาพมากขึ้น\r\n\r\n1% ต่อปี = 134,784\r\n\r\n5% ต่อปี = 432,194\r\n\r\n10% ต่อปี = 1,744,970\r\n\r\n15% ต่อปี = 6,621177\r\n\r\n20% ต่อปี = 23,737,631\r\n\r\n25% ต่อปี = 80,779,356', 246.00, '/uploads/1722846117127.jpg', ' ภัทรพล ศิลปาจารย์ (พอล)', ' ไอแอมเดอะเบสท์/I AM THE BEST', ' การเงิน การลงทุน', 200, 'Books', '18.5 x 12.8 x 1.5 CM', '0.264 KG', '32554565475647', 0, 0, 0, 0, 30);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `isAdmin` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `email`, `created_at`, `isAdmin`) VALUES
(3, 'admin', '$2b$10$AOCNWXJx2/ITC/MkcL5HqeJprTa7Cc6wCuE6DtTSXN2OXx.YAGIZ.', '', '2024-07-30 20:00:24', 1);

-- --------------------------------------------------------

--
-- Table structure for table `user_backend`
--

CREATE TABLE `user_backend` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_backend`
--

INSERT INTO `user_backend` (`id`, `name`, `password`) VALUES
(1, 'admin', '$2b$10$Bph3qcU4Y9aihIJxAVVA8uuiZMHivBUS1BuS1YdNQ4n2ZRWUDc9IK'),
(2, 'admin', '$2b$10$0I4oaVDgf9w7ZrjWlW4WSe73YYKybiU8i5QVgKIwEwIDNdMyVQfQy'),
(3, 'admin', '$2b$10$tC7KUadIyM.8W.xW11L4EeUbMnNaYgCtvGRZhQZ4LMzRf7NFhwDN2'),
(4, 'admin', '$2b$10$VCqeHR1jbozkCIXhdDdZX.g1mnFHLal2EPY3vJdvryCr0HJ67x3y6'),
(5, 'admin', '$2b$10$3OUpeJjykivTVIttk85YZenLu944ElILr1qjBcM6uTn/ygiqktG7C'),
(6, 'admin', '$2b$10$B0HJFr7g4r64g/bM4K.k4edeWK62N9X1evWhgWKn9QMPzdU8tNHqS'),
(7, 'admin', '$2b$10$1pWfi9DOw1URs7DyfEWlYe.QZH/SY.vO.V6MhITw/nd27Tz0JuPay'),
(8, 'admin', '$2b$10$8Ua2PnQp7Sz.pmyV462NTuleUCvA/irIlbhKIJVcVYGU1ppt8PL8a'),
(9, 'admin', '$2b$10$7HqYB07AD8lO0bwn5hGFHuwfBUuIaMZ7Z7yqSI0Pq2FgJndEOZGfC'),
(10, 'admin', '$2b$10$YwcRkpeyowAjBemjxducQeB5rNkbqGMlsh1NGPeZg2/euBerXpSbe'),
(11, 'admin', '$2b$10$MVF4JygyXu9ZkcqjMre1te05.bK.guTBRGyo/zX3ovM3D68SEuVGW'),
(12, 'admin', '$2b$10$R/vGQ7VoVKCZPh9LN8hutuZFeFajXirI1lFv.0NhAOJndcT3DZFQ.'),
(13, 'admin', '$2b$10$fIu6STvyubZu/L1cHkP7Uun1mvlIgcmp0UzEbz1VaxBhzoj6Tesfu'),
(14, 'admin', '$2b$10$mhjWGisuBTfPk/JjG9W2nOYr0c//qJvIUDiHDIOzhWi8WQbh3uw4C'),
(15, 'admin', '$2b$10$PPYSrspRmKknUbVJrSi0IejIb2gzY.KO2HrIt/NAr/nup8BmHLh.K'),
(16, 'admin', '$2b$10$9gVootE.MLMTJTjnWTMgyu6VLBIcexNWubrCLZO.VUaievY9wwSD6'),
(17, 'admin', '$2b$10$H/vZcacYpZCAPcgYJCL16uQYymWfEMXQDPsewzaAs8agqrgipVQjW'),
(18, 'admin', '$2b$10$mco6vdTscjHMV/zzKgy7V.LGbCq7B27Uw4bAP/mbUMf/ZppKNsCNu'),
(19, 'admin', '$2b$10$YfDtQRYqz5F/o4yzRiZwEeMxLxaN95ZjpOEq7aQMOzJiqfsgVfZXG'),
(20, 'admin', '$2b$10$s3RpfOxr.8VzBdp9lzI0qeeaHeUlEQUFUg1s8iaD9x5hNgZuH7Fp2'),
(21, 'admin', '$2b$10$vPH50C5tNJM26M7.E4CFJ.FFkucEBGm8X9fWGa1li0WrPwkXRbzU2'),
(22, 'admin', '$2b$10$f/oOFjGQvg1A3DMgI97MV.L79/BJMobkUSURRLo.evuMoPURW5exy'),
(23, 'admin', '$2b$10$PPlGqBSkwu9e3hnsIDp2Fe0nYc3SSIFMTvF4JG51CTHcI8vef4xt2'),
(24, 'admin', '$2b$10$QrJiNZPU02rV73PK8u11Pu0WkKdW0OQsqQBYrx9QkCINWDLYfPtgW'),
(25, 'admin', '$2b$10$EBGpodqU3tCQ2eBu/IiScu9NhfIbF.uJKLBy8e236T4W75ElW.pKq'),
(26, 'admin', '$2b$10$6KNDfZSbw1FTADc9yghfXuKxdw0l7oqIGGPNYGT2aHRSxFjZFHPqq'),
(27, 'admin', '$2b$10$f/0Jr813ItELbOgwpyY9keZpn7SxBV5xINzBa5OC/PPE0rSkysNoO'),
(28, 'admin', '$2b$10$sXBmUXBuDye8phuhX3YgnexBmcdWAHEZ1682bHACsycjdU7CwBrO2'),
(29, 'admin', '$2b$10$po0kCtmpdJmdyUTadqvaDelHldF2koUE6CBCq4urREc8.1xbyQeyK'),
(30, 'admin', '$2b$10$gHE5E7CJxsV1g.c/PgVkN.z3BC.7UT..XK7XQqK6oh7qA2i.0hwyK'),
(31, 'admin', '$2b$10$Pd9XqUb7BQ.FI/A1RL6o3.wCXBJHQbeNq59f4W06NIKZUp02CTeGO'),
(32, 'admin', '$2b$10$vbjJTwVfHGY8tVfogAr9.e2okytMGyT.Kh11vyIT1FGExm5Hpef2m'),
(33, 'admin', '$2b$10$06z.haNVQjnx7j/YtmD8muzRPgNf3vyl48XfJDdm2XoffOk7IL9Vi'),
(34, 'admin', '$2b$10$DI8tka8NZQLA9khOBDmHTuyFbr80LgEwqxBm54anMnq0D7AZfod0u'),
(35, 'admin', '$2b$10$IhZtfq6G3daONS2xRMmiXeMF062R75Vi/cFUwHzFXHk0fx3orF3Ja'),
(36, 'admin', '$2b$10$83azzG9FlCrL..XVNy3ePObqtbpSdRZb25PqjneAiwtGLKHOk11ne'),
(37, 'admin', '$2b$10$8evhm/mz0cd0FAH5iwZYiO6ErApPRewsCO20r4QPdtM1Fz9.bGEwK'),
(38, 'admin', '$2b$10$KhLfIDKWgkIHJH/zp95zL.qLqF2/nWCBFF4yGJBKZ4nKcUXPpGlwm'),
(39, 'admin', '$2b$10$KQD5RZUwngRsyzM6H/fxZusXkt0Qp8tPRXJGhNo3n6J/etlVZTw0a'),
(40, 'admin', '$2b$10$57SZrX3MSGRHX1xfoW9jQejmjYhyJnWHDXTp.UTLutUKp2v20Z6fS'),
(41, 'admin', '$2b$10$5lCgzlSHEkwBPh6gw6TIvObb1B3Mi2BjnalgcSRkGP.pdCEOgIbI6'),
(42, 'admin', '$2b$10$FtYXU80sgdlmOUi/nUXkuuH25K.C4/CbLkaBoEFCphDX3zAO0PhXK'),
(43, 'admin', '$2b$10$YWnJ92JAWJeRd5xzKDGj/OhXWvPJNNAoMo.wZT7y9pA1SCss.pe1u'),
(44, 'admin', '$2b$10$pNEY5DUbLUMmVSw4IYYuQO8h98AvBJuzJRxZ/8nVYRQoxKEGXcpvm'),
(45, 'admin', '$2b$10$VUNj/N79gntLIyTvsQG4YeyS85jOfnlbNlfb3uQrtRa/K/X5zGRfC'),
(46, 'admin', '$2b$10$QA32tgHiogHWMdi.K1A8xuH5VHQNMzMCiMGss09kl/HKY9IW8Iw8S'),
(47, 'admin', '$2b$10$P.F64QlCy7AKV/zx.tTXlucflmn7IyoliAIqY7yc/MXx30OwgRz8K'),
(48, 'admin', '$2b$10$6NcROo4eQ8s1TZ.UuEiBXuKzWCCo9K4kc64JEE/UhThJX8bD6iGFq'),
(49, 'admin', '$2b$10$uqT6hxuaxboN0Q0rurvw3e8QwDpfKjGxs8WSxnm3.fHWThppUMZwK'),
(50, 'admin', '$2b$10$oHpj5dJSn5N5hBVSHQ416u9ohrGIRSndClRIeEfBLxDlzprKT2TVS'),
(51, 'admin', '$2b$10$m3qnZrUklmyQArbKKW1/yeUk8xYWCNTGZNlkCMPgL3DiFl5RgTvC2'),
(52, 'admin', '$2b$10$W4O1N2RAvYQspscgzVi53upv/dngacd.fv3WcaCFDd68czCiAswT2'),
(53, 'admin', '$2b$10$Ynk3dNpL0k6Y/zBQbVpoy.d0wo/dhdA4qh8.MMvf81nyC2vOvKeye'),
(54, 'admin', '$2b$10$nhj5riGtyTr32l.fP.diPeyGvVVgxhZHzkpULvZvdM.o2JMuo.wy2'),
(55, 'admin', '$2b$10$aLsx9bQT48DVvKnhXZcAPO1KQNwNRA1p0Wyv/lxqo4SSBmVo.WlIa'),
(56, 'admin', '$2b$10$aZUL4RM3HrNi0ny0ozwZueFOjdZ8DreBTYTsSxrA24TyTtybjACmi'),
(57, 'admin', '$2b$10$Q7.rwT5lrf3E4spiCd25Kev2p7iIC52KT0qbdLga5lkDY3Dz38Spe'),
(58, 'admin', '$2b$10$vonW.biBP6koxpEYcNvvKeXPIuagwe2MpzsT8MMW0YpeVldE7ZOea'),
(59, 'admin', '$2b$10$i8K5hUv0N4NOx1LwDWtkke43cvCfJyvRz9m5aoPHaVErSQSrU6LAS'),
(60, 'admin', '$2b$10$E96t82OCxmx4AbETQxmtCuZCillkH/QN6MCLdG7BmYc1/XXIEopq.'),
(61, 'admin', '$2b$10$FxpjsT.7N7387dUYWhFlXuDBCx2hzjBOSZreY172P2Ti4KBfmx7jG'),
(62, 'admin', '$2b$10$mLcnlBUbsm0fETGcM52/AudLfBDGkCOsBo93dZDCvDYKOihVae1dy'),
(63, 'admin', '$2b$10$gqmJ9niwX.6tQqOB6phRFeY7RQfbm.35ySZ.F0LdUOucEP9fwSNL2'),
(64, 'admin', '$2b$10$Km1mOBXwugMHi.tGexG8yuoUb0kIjkxQv4lGEwqjZpIuMgQBrkiu.'),
(65, 'admin', '$2b$10$aH2KxA5rJuD2bryIxzHYNe/CZiZz942KwhysB8j6LF/p/FSGMLyXW'),
(66, 'admin', '$2b$10$6vZUzcqn9zH8M/K2Un.WaOEOuwx8AYt6F4qUNA8QWivFVdy4K1HYe'),
(67, 'admin', '$2b$10$dCpfzBMMTErVd08lict1M.gwNm.t/kO37Ggi/bBUtvzgf/yi.q08S'),
(68, 'admin', '$2b$10$61UHya/tVqpSG6Y5bkDZk.NQ2IEAGB5L6zBsDPtVsbCsuxHk1KuEi'),
(69, 'admin', '$2b$10$/YfJ/b0ZpT.X6AlRyr9PPOgcGxxhEshnTYZy8wyMv30TVGC8fV8De'),
(70, 'admin', '$2b$10$yLNP8h28WDLMLj35NEetxe3XfJxhQGuao0q.uRaa/kGJBylCVxTTK'),
(71, 'admin', '$2b$10$Rro/5GGin9PbeAA42Ru1.u/Znno42lzLFFXS2NKXbfpt1ruboJ2FK'),
(72, 'admin', '$2b$10$9xc8atNxAP8GUFzon2vWquXVJTThChtBZym/YiRu6r/ZgDkhHI3zK'),
(73, 'admin', '$2b$10$/.I9MJ3QFlkDCzKmmAFqQuuPYveig/c.UCqjfwnwGt5r0I55HhV7O'),
(74, 'admin', '$2b$10$6R6rFvPk4karZtUYpu1IcOn1sbif7Mz0dCVdQqAfyidzc0/lSqv2C'),
(75, 'admin', '$2b$10$tKZJp.ukogbXwtiDUqoaCuiN/1QtkU0T6aw120wc0u2i6hIpdKDTy'),
(76, 'admin', '$2b$10$YBB3Ib.DU9HolYKtrbhIuOVCW6.hMf3K1QSOkU03AMp5N//uu4qN2'),
(77, 'admin', '$2b$10$58343B7T0jiFTNP/ErjQh.acsHhACON3kvo.TpB93lY3Ti/cxugPO'),
(78, 'admin', '$2b$10$yYNkoT4CqeKJfVxLJ/kV4OD69eySfXhN6xU5tmWTHofR1TgxqINpS'),
(79, 'admin', '$2b$10$t2heK/CM7IwG2oSYauX.6eYx/UgS9vKLYasHrD5n6VtAHt1e/l3IW'),
(80, 'admin', '$2b$10$jvtL5WtaaHM9h6ekWPL2Ce8WOkI8EAXVwDZcmmDPlUkLXFNGjGSoC'),
(81, 'admin', '$2b$10$OZ0m55sol.emPl9X0hd8Bex0t7yMszR5EBHo6MXiOLcIUgdDI7ltq'),
(82, 'admin', '$2b$10$CHcNoC2F51VFQJxrOxBxZeC3rYG/1iog24RqydXwIXQzYTnna55NW'),
(83, 'admin', '$2b$10$hFy7Z7iUc9XOF2XUmGk5GeQW7H4OIBpW1CatpyD71xxmMy6.PvA7W'),
(84, 'admin', '$2b$10$btVecocR71Kk8CKQGC27QuTDlTr0YynVPLoHwyYQdC6BkNfxzqKOy'),
(85, 'admin', '$2b$10$yujKC/bvdEeUuvJIEVcxWOfZJP8MARGnWbWca.jVz/0SsN9.d6HQe'),
(86, 'admin', '$2b$10$aX1ATgk/3PondGgOdzdFuONlG2pE53w8wTw2GyDLecNPjefcnW2OS'),
(87, 'admin', '$2b$10$fg2m0z/ZgGPE3.j59S3x.e2bO4uuJjKJupIeAbdKTvlFpv9.9ClPO'),
(88, 'admin', '$2b$10$XcB9MpC7nGodL3cYcvpAg.KbJujsDgxgHvxdgB/M2YEob8tWWVwlu'),
(89, 'admin', '$2b$10$SBICX8YTrD3TV9H7gM8C5.ZSA23BGOkH1cW.0aSMG.dNTdwYk2cfC'),
(90, 'admin', '$2b$10$aYVB6xwSScoOmLh4UTqNhOZHla74CR0ljMpKLdExj6wAMFYidGPPW'),
(91, 'admin', '$2b$10$3dGarSSi41vvutWBZF0CueNK0PsainjfpsvAnTdeFEuydfJ4gmEmG'),
(92, 'admin', '$2b$10$.jww2LryXVQRQxRTIlIS9.VvH96vnEfEJrb.GFY/C/XvVMh2.fr2m'),
(93, 'admin', '$2b$10$AcqspQETvZ.pP3Hz2WDqVuvXvjGEtZRVUer4r2FRZ9ZPLkm6O8m9q'),
(94, 'admin', '$2b$10$OCXi3u5E/qrr/Yq.3fByuuzHOE14nlOHFoeojkW70SLbriXi9qBIS'),
(95, 'admin', '$2b$10$4pC825h8gL4dRLFGBsrm5OtjZDF63zggC/Wq8.v4bvCtF2euoSsFO'),
(96, 'admin', '$2b$10$N6VQkzMSaVpHpSowqxKRV.hJ9an9YGu0AhXWq2LeaUpST4s8vnJc6'),
(97, 'admin', '$2b$10$Zc1p8xT0ibDgkhfVVbRMwukcI8WD4ggmpaGSCmGmwzEKkFgvLmmca'),
(98, 'admin', '$2b$10$8BWazJVlBeaBJqEfJ3FKUupu4Khswou/mEPynjdD72Sv9/D3mNWMO'),
(99, 'admin', '$2b$10$uvOamTBkJZZPHDP930t0Nu4GUunWi2hYqyz0ZBCjUDBT8PhPUroJi'),
(100, 'admin', '$2b$10$o5VtJzAXG1TFvF30bmMCp.TVemyUi.VB07zFgGsEKnAzlaikEaaru'),
(101, 'admin', '$2b$10$uuy1o3uK3jnPqyHpqjzMzOgcc0XsJflkMsyjzgzZ6q0xAm4lLykOW'),
(102, 'admin', '$2b$10$PYMtKhzgHDJzkuS.CLdtGOPcfcOzirIfUXlxQPDlUlfbRz5TjdQBu'),
(103, 'admin', '$2b$10$omkYyMCozDV35yadlTlxb.OYgDlhj31V1.hwiu1/vhrS..xESaB82'),
(104, 'admin', '$2b$10$7PH/PvuhmJAjmqNQe/14OeDFVvbo9xyBvIPSaf2ChzSm2zJk4qoAy'),
(105, 'admin', '$2b$10$b4zEevu.uCB9pdNaYLKfbOzoKf2nWbwkUlk9LuXEXUEpAonf4RDPm'),
(106, 'admin', '$2b$10$zx3y5/TQgao/l7ia9tW76OrywrnnyZwCgrv3PPANbZueu7t5v4V7S'),
(107, 'admin', '$2b$10$5wZ2uLjPblQW8E2TdYy9l.daH0s2x.WwHPIG91Fva.HUiSZcU6Zo.'),
(108, 'admin', '$2b$10$KIG1lRRIyiHiLdipPuSgre0VjOrhUPaT6oS8eAjrrRbOhNPrl2uWO'),
(109, 'admin', '$2b$10$52bVre8qdcxJtiQmQNKZIOui0KJsf.7MXQiephU/pyQyIdUFlj4im'),
(110, 'admin', '$2b$10$4KbBcl/kywsk.H2utaumDOFhSILoIUTNBsvcBNYUlWksjqhr1Blni'),
(111, 'admin', '$2b$10$nzKagzih1gBu.pnhuCIvNOipuw37elIRoQGNLW0DWFLFrMQeG17Uy'),
(112, 'admin', '$2b$10$gcuvHsrjkRF5bZVC8.akvusRJr2GUBZB35t0W2LdhVfVgFWUvczaW'),
(113, 'admin', '$2b$10$IgmRVrZ9A4btekJlmvC5wueyjiZFM76XsWXmWw34aB4hZT/M1kcYS'),
(114, 'admin', '$2b$10$id2T3HrdBKKUguMpx8tqkO5JVtGGKy0qcGDvTXyWdTgr7.Dxr.phO'),
(115, 'admin', '$2b$10$ecYOoB/EaiLW9vyj/tNpNO1vxYMhbeUvdQi5PHrmFfLzjZohTzOjC'),
(116, 'admin', '$2b$10$J8B5w38//V6l5TnDTj7UV.oKSs0ZItaRUAU94/CWMZAb1ZPA4HDae'),
(117, 'admin', '$2b$10$1/0i47XCPM/u0TjVh7xOE.OwUjON9VRUzd8/eSyzhxjeS9fuWYH22'),
(118, 'admin', '$2b$10$vShnGH31feNHWQEXOEc57.btBJXSaiybJrAdOWYFGdh.TtdASDIQe'),
(119, 'admin', '$2b$10$BGNiCZWKPgk6RI//ZW3ElOzw4xgn2TRBylyg/vUG7BND8orRikC4W'),
(120, 'admin', '$2b$10$A1ieKBm6BSDvMUqEIUJe1eqoxX8mGpbt..wzGDPlLfsmPzCnyp26O'),
(121, 'admin', '$2b$10$Uh5rjfiHAG97hfX6xcRjIOE3hfU9g/s/88XjTaX3zrzBayoOACjwO'),
(122, 'admin', '$2b$10$QgToLMwtbhhaJJB4hOCs6.p5RByXt7s33r8o8ZKqX.WYJxUXzyzVS'),
(123, 'admin', '$2b$10$V8D9AIT52Ut9/tpUC4I8a.rdbpeDq7rW9hZTeSW5kBNeFptylrS4e'),
(124, 'admin', '$2b$10$qBXMsrfzokAnh/QKgLTtMu/l2q1Fnfp.k9vYP8.MxWU.IqA/owk36');

-- --------------------------------------------------------

--
-- Table structure for table `website_users`
--

CREATE TABLE `website_users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `website_users`
--

INSERT INTO `website_users` (`id`, `username`, `password`, `email`, `created_at`, `updated_at`) VALUES
(5, 'admin', '$2b$10$zuglyeX3Q6XaUwVDv9uE3uaZnoRYDxwZ6uJi0Mk1ERljBdBCOtsT.', 'seksan@gmail.com', '2024-07-31 03:50:40', '2024-07-31 03:50:40');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bestselling`
--
ALTER TABLE `bestselling`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `login_logs`
--
ALTER TABLE `login_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `market`
--
ALTER TABLE `market`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_product` (`product_id`);

--
-- Indexes for table `newbook`
--
ALTER TABLE `newbook`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `user_backend`
--
ALTER TABLE `user_backend`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `website_users`
--
ALTER TABLE `website_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bestselling`
--
ALTER TABLE `bestselling`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `login_logs`
--
ALTER TABLE `login_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `market`
--
ALTER TABLE `market`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=180;

--
-- AUTO_INCREMENT for table `newbook`
--
ALTER TABLE `newbook`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `user_backend`
--
ALTER TABLE `user_backend`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=125;

--
-- AUTO_INCREMENT for table `website_users`
--
ALTER TABLE `website_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `login_logs`
--
ALTER TABLE `login_logs`
  ADD CONSTRAINT `login_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user_backend` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
