-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.10.2-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumping structure for function mdi_pyt.fnAgeText
DELIMITER //
CREATE FUNCTION `fnAgeText`(`date_begin` date,
	`date_end` date
) RETURNS varchar(64) CHARSET utf8mb3 COLLATE utf8mb3_general_ci
BEGIN

	declare age_text varchar(64) default '';
	declare age_year int default 0;
	declare age_month int default 0;
	declare age_day int default 0;
	
	set age_year = timestampdiff(year, date_end, date_begin);
	set age_month = timestampdiff(month, date_end, date_begin) % 12;
	set age_day = floor(timestampdiff(day, date_end, date_begin) % 30.4375);

	if age_year > 0 then
		set age_text = trim(concat(age_text, ' ', age_year, 'Y'));
	end if;
	
	if age_month > 0 then
		set age_text = trim(concat(age_text, ' ', age_month, 'M'));
	end if;
	
	if age_day > 0 then
		set age_text = trim(concat(age_text, ' ', age_day, 'D'));
	end if;
	
	return age_text;

END//
DELIMITER ;

-- Dumping structure for table mdi_pyt.gbl_env
CREATE TABLE IF NOT EXISTS `gbl_env` (
  `org_id` int(11) NOT NULL,
  `org_uid` varchar(64) DEFAULT NULL,
  `org_name` varchar(128) NOT NULL,
  `org_alias` varchar(128) DEFAULT NULL,
  `third_party_encoding` varchar(64) DEFAULT NULL,
  `third_party_url` varchar(256) DEFAULT NULL,
  `is_deleted` bit(1) NOT NULL DEFAULT b'0',
  `created_by` int(11) NOT NULL,
  `created_on` datetime NOT NULL DEFAULT current_timestamp(),
  `modified_by` int(11) NOT NULL,
  `modified_on` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`org_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Dumping data for table mdi_pyt.gbl_env: ~12 rows (approximately)
INSERT INTO `gbl_env` (`org_id`, `org_uid`, `org_name`, `org_alias`, `third_party_encoding`, `third_party_url`, `is_deleted`, `created_by`, `created_on`, `modified_by`, `modified_on`) VALUES
	(1, NULL, 'เครือ รพ.พญาไท', NULL, NULL, NULL, b'1', 1, '2022-10-31 00:00:00', 1, '2022-10-31 00:00:00'),
	(11, 'PT1', 'พญาไท 1', 'Phayathai 1', NULL, NULL, b'1', 1, '2022-10-31 00:00:00', 1, '2022-10-31 00:00:00'),
	(12, 'PT2', 'พญาไท 2', 'Phayathai 2', NULL, NULL, b'1', 1, '2022-10-31 00:00:00', 1, '2022-10-31 00:00:00'),
	(13, 'PT3', 'พญาไท 3', 'Phayathai 3', NULL, NULL, b'1', 1, '2022-10-31 00:00:00', 1, '2022-10-31 00:00:00'),
	(14, 'PTS', 'พญาไท ศรีราชา', 'Phyathai Sriracha', NULL, NULL, b'1', 1, '2022-10-31 00:00:00', 1, '2022-10-31 00:00:00'),
	(15, 'PTN', 'พญาไท นวมินทร์', 'Phyathai Nawamin', NULL, NULL, b'1', 1, '2022-10-31 00:00:00', 1, '2022-10-31 00:00:00'),
	(51, 'PLP', 'เปาโล พหลโยธิน', 'Paolo Phaholyothin', NULL, NULL, b'1', 1, '2022-10-31 00:00:00', 1, '2022-10-31 00:00:00'),
	(52, 'PLR', 'เปาโล รังสิต', 'Paolo Rangsit', NULL, NULL, b'1', 1, '2022-10-31 00:00:00', 1, '2022-10-31 00:00:00'),
	(53, 'PLK', 'เปาโล เกษตร', 'Paolo Kaset', NULL, NULL, b'1', 1, '2022-10-31 00:00:00', 1, '2022-10-31 00:00:00'),
	(54, 'PLC', 'เปาโล โชคชัย4', 'Paolo Chokchai4', NULL, NULL, b'0', 1, '2022-10-31 00:00:00', 1, '2022-10-31 00:00:00'),
	(55, 'PLS', 'เปาโล สมุทรปราการ', 'Paolo Samutprakarn', NULL, NULL, b'1', 1, '2022-10-31 00:00:00', 1, '2022-10-31 00:00:00'),
	(56, 'PLD', 'เปาโล พระประแดง', 'Paolo Phrapradaeng', NULL, NULL, b'1', 1, '2022-10-31 00:00:00', 1, '2022-10-31 00:00:00');

-- Dumping structure for table mdi_pyt.gbl_grant_org
CREATE TABLE IF NOT EXISTS `gbl_grant_org` (
  `grant_org_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `access_org_id` int(11) NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_on` datetime NOT NULL DEFAULT current_timestamp(),
  `modified_by` int(11) NOT NULL,
  `modified_on` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`grant_org_id`),
  UNIQUE KEY `user_id_access_org_id` (`user_id`,`access_org_id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Dumping data for table mdi_pyt.gbl_grant_org: ~33 rows (approximately)
INSERT INTO `gbl_grant_org` (`grant_org_id`, `user_id`, `access_org_id`, `created_by`, `created_on`, `modified_by`, `modified_on`) VALUES
	(1, 2, 11, 1, '2022-10-31 00:00:00', 1, '2022-10-31 00:00:00'),
	(2, 2, 12, 1, '2022-10-31 00:00:00', 1, '2022-10-31 00:00:00'),
	(3, 2, 13, 1, '2022-10-31 00:00:00', 1, '2022-10-31 00:00:00'),
	(4, 2, 14, 1, '2022-10-31 00:00:00', 1, '2022-10-31 00:00:00'),
	(5, 2, 15, 1, '2022-10-31 00:00:00', 1, '2022-10-31 00:00:00'),
	(6, 2, 51, 1, '2022-10-31 00:00:00', 1, '2022-10-31 00:00:00'),
	(7, 2, 52, 1, '2022-10-31 00:00:00', 1, '2022-10-31 00:00:00'),
	(8, 2, 53, 1, '2022-10-31 00:00:00', 1, '2022-10-31 00:00:00'),
	(9, 2, 54, 1, '2022-10-31 00:00:00', 1, '2022-10-31 00:00:00'),
	(10, 2, 55, 1, '2022-10-31 00:00:00', 1, '2022-10-31 00:00:00'),
	(11, 2, 56, 1, '2022-10-31 00:00:00', 1, '2022-10-31 00:00:00'),
	(12, 3, 11, 1, '2022-10-31 00:00:00', 1, '2022-10-31 00:00:00'),
	(13, 3, 12, 1, '2022-10-31 00:00:00', 1, '2022-10-31 00:00:00'),
	(14, 3, 13, 1, '2022-10-31 00:00:00', 1, '2022-10-31 00:00:00'),
	(15, 3, 14, 1, '2022-10-31 00:00:00', 1, '2022-10-31 00:00:00'),
	(16, 3, 15, 1, '2022-10-31 00:00:00', 1, '2022-10-31 00:00:00'),
	(17, 3, 51, 1, '2022-10-31 00:00:00', 1, '2022-10-31 00:00:00'),
	(18, 3, 52, 1, '2022-10-31 00:00:00', 1, '2022-10-31 00:00:00'),
	(19, 3, 53, 1, '2022-10-31 00:00:00', 1, '2022-10-31 00:00:00'),
	(20, 3, 54, 1, '2022-10-31 00:00:00', 1, '2022-10-31 00:00:00'),
	(21, 3, 55, 1, '2022-10-31 00:00:00', 1, '2022-10-31 00:00:00'),
	(22, 3, 56, 1, '2022-10-31 00:00:00', 1, '2022-10-31 00:00:00'),
	(23, 4, 11, 1, '2022-10-31 00:00:00', 1, '2022-10-31 00:00:00'),
	(24, 4, 12, 1, '2022-10-31 00:00:00', 1, '2022-10-31 00:00:00'),
	(25, 4, 13, 1, '2022-10-31 00:00:00', 1, '2022-10-31 00:00:00'),
	(26, 4, 14, 1, '2022-10-31 00:00:00', 1, '2022-10-31 00:00:00'),
	(27, 4, 15, 1, '2022-10-31 00:00:00', 1, '2022-10-31 00:00:00'),
	(28, 4, 51, 1, '2022-10-31 00:00:00', 1, '2022-10-31 00:00:00'),
	(29, 4, 52, 1, '2022-10-31 00:00:00', 1, '2022-10-31 00:00:00'),
	(30, 4, 53, 1, '2022-10-31 00:00:00', 1, '2022-10-31 00:00:00'),
	(31, 4, 54, 1, '2022-10-31 00:00:00', 1, '2022-10-31 00:00:00'),
	(32, 4, 55, 1, '2022-10-31 00:00:00', 1, '2022-10-31 00:00:00'),
	(33, 4, 56, 1, '2022-10-31 00:00:00', 1, '2022-10-31 00:00:00');

-- Dumping structure for table mdi_pyt.gbl_sequence
CREATE TABLE IF NOT EXISTS `gbl_sequence` (
  `sequence_uid` varchar(64) NOT NULL,
  `sequence_dt` datetime NOT NULL,
  `sequence_interval` varchar(1) DEFAULT NULL,
  `sequence_seed` int(11) NOT NULL DEFAULT 1,
  `sequence_increment` int(11) NOT NULL DEFAULT 1,
  `sequence_current` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`sequence_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Dumping data for table mdi_pyt.gbl_sequence: ~0 rows (approximately)

-- Dumping structure for table mdi_pyt.his_patient
CREATE TABLE IF NOT EXISTS `his_patient` (
  `patient_id` int(11) NOT NULL AUTO_INCREMENT,
  `hn` varchar(32) DEFAULT NULL,
  `title` varchar(64) DEFAULT NULL,
  `fname` varchar(128) DEFAULT NULL,
  `mname` varchar(128) DEFAULT NULL,
  `lname` varchar(128) DEFAULT NULL,
  `title_eng` varchar(64) DEFAULT NULL,
  `fname_eng` varchar(128) DEFAULT NULL,
  `mname_eng` varchar(128) DEFAULT NULL,
  `lname_eng` varchar(128) DEFAULT NULL,
  `gender` varchar(1) DEFAULT NULL,
  `dob` datetime DEFAULT NULL,
  `ssn` varchar(32) DEFAULT NULL,
  `is_johndoe` bit(1) NOT NULL DEFAULT b'0',
  `org_id` int(11) NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_on` datetime NOT NULL DEFAULT current_timestamp(),
  `modified_by` int(11) NOT NULL,
  `modified_on` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`patient_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Dumping data for table mdi_pyt.his_patient: ~2 rows (approximately)
INSERT INTO `his_patient` (`patient_id`, `hn`, `title`, `fname`, `mname`, `lname`, `title_eng`, `fname_eng`, `mname_eng`, `lname_eng`, `gender`, `dob`, `ssn`, `is_johndoe`, `org_id`, `created_by`, `created_on`, `modified_by`, `modified_on`) VALUES
	(1, 'JF001', 'นาย', 'ทดสอบ', '', 'ระบบ', 'Mr.', 'Test', '', 'System', 'M', '1986-12-31 00:00:00', '1234567890123', b'0', 54, 1, '2022-11-14 11:50:30', 1, '2022-11-14 11:50:30'),
	(2, 'JF002', 'นางสาว', 'ทดสอบ 2', '', 'ระบบ 2', 'Ms.', 'Test 2', '', 'System 2', 'F', '1986-01-01 00:00:00', '3210987654321', b'0', 54, 1, '2022-11-14 11:50:30', 1, '2022-11-14 11:50:30');

-- Dumping structure for table mdi_pyt.hr_user
CREATE TABLE IF NOT EXISTS `hr_user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_uid` varchar(64) DEFAULT NULL,
  `user_name` varchar(64) DEFAULT NULL,
  `user_pwd` varchar(64) DEFAULT NULL,
  `user_type` varchar(1) DEFAULT NULL,
  `title` varchar(64) DEFAULT NULL,
  `fname` varchar(128) DEFAULT NULL,
  `mname` varchar(128) DEFAULT NULL,
  `lname` varchar(128) DEFAULT NULL,
  `title_eng` varchar(64) DEFAULT NULL,
  `fname_eng` varchar(128) DEFAULT NULL,
  `mname_eng` varchar(128) DEFAULT NULL,
  `lname_eng` varchar(128) DEFAULT NULL,
  `is_deleted` bit(1) NOT NULL DEFAULT b'0',
  `org_id` int(11) NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_on` datetime NOT NULL DEFAULT current_timestamp(),
  `modified_by` int(11) NOT NULL,
  `modified_on` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Dumping data for table mdi_pyt.hr_user: ~4 rows (approximately)
INSERT INTO `hr_user` (`user_id`, `user_uid`, `user_name`, `user_pwd`, `user_type`, `title`, `fname`, `mname`, `lname`, `title_eng`, `fname_eng`, `mname_eng`, `lname_eng`, `is_deleted`, `org_id`, `created_by`, `created_on`, `modified_by`, `modified_on`) VALUES
	(1, '', '', '', 'S', '', '', '', '', '', '', '', '', b'1', 1, 1, '2022-10-31 00:00:00', 1, '2022-10-31 00:00:00'),
	(2, '', 'admin', 'PyZJLaloQEvBP2RCBNIULg==', 'A', NULL, 'Admin', NULL, 'System', NULL, 'Admin', NULL, 'System', b'0', 1, 1, '2022-10-31 00:00:00', 1, '2022-10-31 00:00:00'),
	(3, '', 'miracle_adm', 'PaVG+OuhZrJ5LEX73GCO/w==', 'A', NULL, 'Admin', NULL, 'Miracle', NULL, 'Admin', NULL, 'Miracle', b'0', 1, 1, '2022-10-31 00:00:00', 1, '2022-10-31 00:00:00'),
	(4, '', 'guest', 'qJ05SbQIoRo7EiSn1Ama3A==', 'O', NULL, 'Guest', NULL, 'Hospital', NULL, 'Guest', NULL, 'Hospital', b'0', 1, 1, '2022-10-31 00:00:00', 1, '2022-10-31 00:00:00');

-- Dumping structure for table mdi_pyt.mdi_data
CREATE TABLE IF NOT EXISTS `mdi_data` (
  `data_id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_visit_id` int(11) NOT NULL,
  `modality_vs_id` int(11) DEFAULT NULL,
  `vs_dt` datetime DEFAULT NULL,
  `pulse_rate` int(11) DEFAULT NULL,
  `pulse_unit` varchar(16) DEFAULT NULL,
  `pulse_flag` varchar(1) DEFAULT NULL COMMENT 'N = NORMAL, L = BELOW NORMAL, H = ABOVE NORMAL, A = OTHER ABNORMAL',
  `blood_pressure_systolic` int(11) DEFAULT NULL,
  `blood_pressure_diastolic` int(11) DEFAULT NULL,
  `blood_pressure_mean` int(11) DEFAULT NULL,
  `blood_pressure` varchar(32) DEFAULT NULL COMMENT 'SYSTOLIC/DIASTOLIC(MEAN) - HAS BEEN FORMATTED',
  `blood_pressure_unit` varchar(16) DEFAULT NULL,
  `blood_pressure_method` varchar(32) DEFAULT NULL COMMENT 'RIGHT ARM, LEFT ARM',
  `spo2` decimal(6,2) DEFAULT NULL,
  `spo2_unit` varchar(16) DEFAULT NULL,
  `temperature` decimal(6,2) DEFAULT NULL,
  `temperature_unit` varchar(16) DEFAULT NULL,
  `temperature_method` varchar(32) DEFAULT NULL COMMENT 'ORAL, RECTAL, AXILLARY, TYMPANIC (EAR), AND CORE',
  `blood_glucose` int(11) DEFAULT NULL,
  `blood_glucose_unit` varchar(16) DEFAULT NULL,
  `respiration_rate` int(11) DEFAULT NULL,
  `pain_scale` int(11) DEFAULT NULL,
  `data_status` varchar(1) DEFAULT 'N',
  `comment` longtext DEFAULT NULL,
  `is_confirmed` bit(1) NOT NULL DEFAULT b'0',
  `confirmed_by` int(11) DEFAULT NULL,
  `confirmed_on` datetime DEFAULT NULL,
  `org_id` int(11) NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_on` datetime NOT NULL DEFAULT current_timestamp(),
  `modified_by` int(11) NOT NULL,
  `modified_on` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`data_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Dumping data for table mdi_pyt.mdi_data: ~8 rows (approximately)
INSERT INTO `mdi_data` (`data_id`, `patient_visit_id`, `modality_vs_id`, `vs_dt`, `pulse_rate`, `pulse_unit`, `pulse_flag`, `blood_pressure_systolic`, `blood_pressure_diastolic`, `blood_pressure_mean`, `blood_pressure`, `blood_pressure_unit`, `blood_pressure_method`, `spo2`, `spo2_unit`, `temperature`, `temperature_unit`, `temperature_method`, `blood_glucose`, `blood_glucose_unit`, `respiration_rate`, `pain_scale`, `data_status`, `comment`, `is_confirmed`, `confirmed_by`, `confirmed_on`, `org_id`, `created_by`, `created_on`, `modified_by`, `modified_on`) VALUES
	(1, 1, 1, '2019-10-24 18:45:58', 70, 'bpm', 'N', 131, 69, 85, '131/69(85)', 'mmHg', NULL, 99.00, '%', 30.00, 'C', 'Ear', NULL, NULL, NULL, NULL, 'N', '', b'1', NULL, NULL, 54, 1, '2019-10-24 17:47:53', 1, '2022-12-19 17:25:39'),
	(2, 2, 1, '2019-10-25 09:09:06', 85, 'bpm', 'N', 123, 77, 83, '123/77(83)', 'mmHg', NULL, 100.00, '%', 37.10, 'C', 'Ear', NULL, NULL, NULL, NULL, 'N', '', b'1', NULL, NULL, 54, 1, '2019-10-25 08:51:29', 1, '2022-12-19 16:31:01'),
	(3, 3, 1, '2019-10-28 13:59:49', 88, 'bpm', 'N', 119, 68, 79, '119/68(79)', 'mmHg', NULL, 100.00, '%', 37.70, 'C', 'Ear', NULL, NULL, NULL, NULL, 'N', '', b'1', NULL, NULL, 54, 1, '2019-10-28 13:59:49', 1, '2022-12-19 16:33:49'),
	(4, 4, 1, '2019-10-29 09:53:27', 64, 'bpm', 'N', 133, 102, 109, '133/102(109)', 'mmHg', NULL, 100.00, '%', 36.80, 'C', 'Ear', NULL, NULL, NULL, NULL, 'N', '', b'1', NULL, NULL, 54, 1, '2019-10-29 09:53:27', 1, '2022-12-19 15:58:04'),
	(5, 5, 1, '2019-11-01 11:05:28', 67, 'bpm', 'N', 113, 69, 78, '113/69(78)', 'mmHg', NULL, 100.00, '%', 36.70, 'C', 'Ear', NULL, NULL, NULL, NULL, 'N', '', b'1', NULL, NULL, 54, 1, '2019-11-01 11:03:48', 1, '2022-12-19 15:58:38'),
	(6, 6, 1, '2019-11-04 16:37:11', 75, 'bpm', 'N', 120, 71, 82, '120/71(82)', 'mmHg', NULL, 100.00, '%', 37.00, 'C', 'Ear', NULL, NULL, NULL, NULL, 'N', '', b'1', NULL, NULL, 54, 1, '2019-11-04 11:17:18', 1, '2022-12-19 16:31:17'),
	(7, 7, 1, '2019-11-05 16:23:57', 99, 'bpm', 'N', 116, 95, 100, '116/95(100)', 'mmHg', NULL, 100.00, '%', 38.70, 'C', 'Ear', NULL, NULL, NULL, NULL, 'N', '', b'1', NULL, NULL, 54, 1, '2019-11-05 09:40:25', 1, '2022-12-19 16:47:26'),
	(8, 9, 1, '2019-11-12 17:35:03', 76, 'bpm', 'N', 121, 67, 80, '121/67(80)', 'mmHg', NULL, 100.00, '%', 37.10, 'C', 'Ear', NULL, NULL, NULL, NULL, 'N', '', b'0', NULL, NULL, 54, 1, '2019-11-12 14:21:06', 1, '2022-12-19 16:33:21');

-- Dumping structure for table mdi_pyt.mdi_data_log
CREATE TABLE IF NOT EXISTS `mdi_data_log` (
  `data_log_id` int(11) NOT NULL AUTO_INCREMENT,
  `data_id` int(11) NOT NULL,
  `patient_visit_id` int(11) NOT NULL,
  `modality_vs_id` int(11) DEFAULT NULL,
  `vs_dt` datetime DEFAULT NULL,
  `pulse_rate` int(11) DEFAULT NULL,
  `pulse_unit` varchar(16) DEFAULT NULL,
  `pulse_flag` varchar(1) DEFAULT NULL,
  `blood_pressure_systolic` int(11) DEFAULT NULL,
  `blood_pressure_diastolic` int(11) DEFAULT NULL,
  `blood_pressure_mean` int(11) DEFAULT NULL,
  `blood_pressure` varchar(32) DEFAULT NULL,
  `blood_pressure_unit` varchar(16) DEFAULT NULL,
  `blood_pressure_method` varchar(32) DEFAULT NULL,
  `spo2` decimal(6,2) DEFAULT NULL,
  `spo2_unit` varchar(16) DEFAULT NULL,
  `temperature` decimal(6,2) DEFAULT NULL,
  `temperature_unit` varchar(16) DEFAULT NULL,
  `temperature_method` varchar(32) DEFAULT NULL,
  `blood_glucose` int(11) DEFAULT NULL,
  `blood_glucose_unit` varchar(16) DEFAULT NULL,
  `respiration_rate` int(11) DEFAULT NULL,
  `pain_scale` int(11) DEFAULT NULL,
  PRIMARY KEY (`data_log_id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Dumping data for table mdi_pyt.mdi_data_log: ~25 rows (approximately)
INSERT INTO `mdi_data_log` (`data_log_id`, `data_id`, `patient_visit_id`, `modality_vs_id`, `vs_dt`, `pulse_rate`, `pulse_unit`, `pulse_flag`, `blood_pressure_systolic`, `blood_pressure_diastolic`, `blood_pressure_mean`, `blood_pressure`, `blood_pressure_unit`, `blood_pressure_method`, `spo2`, `spo2_unit`, `temperature`, `temperature_unit`, `temperature_method`, `blood_glucose`, `blood_glucose_unit`, `respiration_rate`, `pain_scale`) VALUES
	(1, 1, 1, 1, '2019-10-24 17:47:53', 84, 'bpm', 'N', 131, 69, 85, '131/69(85)', 'mmHg', NULL, 100.00, '%', 37.70, 'C', 'Ear', NULL, NULL, NULL, NULL),
	(2, 1, 1, 1, '2019-10-24 18:45:58', 84, 'bpm', 'N', 131, 69, 85, '131/69(85)', 'mmHg', NULL, 100.00, '%', 37.70, 'C', 'Ear', NULL, NULL, NULL, NULL),
	(3, 2, 2, 1, '2019-10-25 08:51:29', 84, 'bpm', 'N', 131, 69, 85, '131/69(85)', 'mmHg', NULL, 100.00, '%', 37.70, 'C', 'Ear', NULL, NULL, NULL, NULL),
	(4, 2, 2, 1, '2019-10-25 08:54:38', 100, 'bpm', 'N', 120, 67, 81, '120/67(81)', 'mmHg', NULL, 99.00, '%', 37.40, 'C', 'Ear', NULL, NULL, NULL, NULL),
	(5, 2, 2, 1, '2019-10-25 08:57:32', 89, 'bpm', 'N', 107, 87, 92, '107/87(92)', 'mmHg', NULL, 100.00, '%', 36.30, 'C', 'Ear', NULL, NULL, NULL, NULL),
	(6, 2, 2, 1, '2019-10-25 09:07:21', 100, 'bpm', 'N', 128, 85, 96, '128/85(96)', 'mmHg', NULL, 100.00, '%', 37.30, 'C', 'Ear', NULL, NULL, NULL, NULL),
	(7, 2, 2, 1, '2019-10-25 09:09:06', 85, 'bpm', 'N', 123, 77, 83, '123/77(83)', 'mmHg', NULL, 100.00, '%', 37.10, 'C', 'Ear', NULL, NULL, NULL, NULL),
	(8, 3, 3, 1, '2019-10-28 13:59:49', 88, 'bpm', 'N', 119, 68, 79, '119/68(79)', 'mmHg', NULL, 100.00, '%', 37.70, 'C', 'Ear', NULL, NULL, NULL, NULL),
	(9, 4, 4, 1, '2019-10-29 09:53:27', 64, 'bpm', 'N', 133, 102, 109, '133/102(109)', 'mmHg', NULL, 100.00, '%', 36.80, 'C', 'Ear', NULL, NULL, NULL, NULL),
	(10, 5, 5, 1, '2019-11-01 11:03:48', 83, 'bpm', 'N', 102, 39, 49, '102/39(49)', 'mmHg', NULL, 100.00, '%', 37.20, 'C', 'Ear', NULL, NULL, NULL, NULL),
	(11, 5, 5, 1, '2019-11-01 11:05:28', 67, 'bpm', 'N', 113, 69, 78, '113/69(78)', 'mmHg', NULL, 100.00, '%', 36.70, 'C', 'Ear', NULL, NULL, NULL, NULL),
	(12, 6, 6, 1, '2019-11-04 11:17:18', 73, 'bpm', 'N', 107, 69, 78, '107/69(78)', 'mmHg', NULL, 100.00, '%', 37.00, 'C', 'Ear', NULL, NULL, NULL, NULL),
	(13, 6, 6, 1, '2019-11-04 11:19:10', 74, 'bpm', 'N', 112, 61, 73, '112/61(73)', 'mmHg', NULL, 100.00, '%', 36.70, 'C', 'Ear', NULL, NULL, NULL, NULL),
	(14, 6, 6, 1, '2019-11-04 11:19:15', 79, 'bpm', 'N', 124, 71, 82, '124/71(82)', 'mmHg', NULL, 99.00, '%', 37.00, 'C', 'Ear', NULL, NULL, NULL, NULL),
	(15, 6, 6, 1, '2019-11-04 11:37:03', 75, 'bpm', 'N', 134, 107, 114, '134/107(114)', 'mmHg', NULL, 98.00, '%', 37.00, 'C', 'Ear', NULL, NULL, NULL, NULL),
	(16, 6, 6, 1, '2019-11-04 16:35:30', NULL, NULL, 'N', 124, 72, 81, '124/72(81)', 'mmHg', NULL, 100.00, '%', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(17, 6, 6, 1, '2019-11-04 16:37:11', NULL, NULL, 'N', 120, 71, 82, '120/71(82)', 'mmHg', NULL, 100.00, '%', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(18, 7, 7, 1, '2019-11-05 09:40:25', NULL, NULL, 'N', 114, 67, 77, '114/67(77)', 'mmHg', NULL, 100.00, '%', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(19, 7, 7, 1, '2019-11-05 09:46:39', 91, 'bpm', 'N', 124, 82, 91, '124/82(91)', 'mmHg', NULL, 98.00, '%', 36.90, 'C', 'Ear', NULL, NULL, NULL, NULL),
	(20, 7, 7, 1, '2019-11-05 13:39:33', 90, 'bpm', 'N', 100, 74, 77, '100/74(77)', 'mmHg', NULL, 100.00, '%', 37.30, 'C', 'Ear', NULL, NULL, NULL, NULL),
	(21, 7, 7, 1, '2019-11-05 13:48:05', NULL, NULL, 'N', 116, 95, 100, '116/95(100)', 'mmHg', NULL, 100.00, '%', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(22, 7, 7, 1, '2019-11-05 16:23:57', NULL, NULL, 'N', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 38.70, 'C', 'Ear', NULL, NULL, NULL, NULL),
	(23, 8, 9, 1, '2019-11-12 14:21:06', NULL, NULL, 'N', 114, 66, 77, '114/66(77)', 'mmHg', NULL, 100.00, '%', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(24, 8, 9, 1, '2019-11-12 17:25:49', 76, 'bpm', 'N', 117, 66, 75, '117/66(75)', 'mmHg', NULL, 100.00, '%', 37.10, 'C', 'Ear', NULL, NULL, NULL, NULL),
	(25, 8, 9, 1, '2019-11-12 17:35:03', NULL, NULL, 'N', 121, 67, 80, '121/67(80)', 'mmHg', NULL, 100.00, '%', NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- Dumping structure for table mdi_pyt.mdi_location
CREATE TABLE IF NOT EXISTS `mdi_location` (
  `location_id` int(11) NOT NULL AUTO_INCREMENT,
  `location_uid` varchar(64) DEFAULT NULL,
  `location_name` varchar(128) DEFAULT NULL,
  `location_desc` varchar(256) DEFAULT NULL,
  `is_deleted` bit(1) NOT NULL DEFAULT b'0',
  `org_id` int(11) NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_on` datetime NOT NULL DEFAULT current_timestamp(),
  `modified_by` int(11) NOT NULL,
  `modified_on` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`location_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Dumping data for table mdi_pyt.mdi_location: ~3 rows (approximately)
INSERT INTO `mdi_location` (`location_id`, `location_uid`, `location_name`, `location_desc`, `is_deleted`, `org_id`, `created_by`, `created_on`, `modified_by`, `modified_on`) VALUES
	(1, '', 'ER', 'ห้องฉุกเฉิน', b'0', 1, 1, '2022-10-31 00:00:00', 1, '2022-10-31 00:00:00'),
	(2, '', 'IPD', 'ผู้ป่วยใน', b'0', 1, 1, '2022-10-31 00:00:00', 1, '2022-10-31 00:00:00'),
	(3, '', 'OPD', 'ผู้ป่วยนอก', b'0', 1, 1, '2022-10-31 00:00:00', 1, '2022-10-31 00:00:00');

-- Dumping structure for table mdi_pyt.mdi_modality
CREATE TABLE IF NOT EXISTS `mdi_modality` (
  `modality_id` int(11) NOT NULL AUTO_INCREMENT,
  `modality_uid` varchar(64) DEFAULT NULL,
  `modality_name` varchar(128) DEFAULT NULL,
  `modality_type_alias` varchar(8) DEFAULT NULL COMMENT 'WH = Weight & Height, VS = Vital Sign',
  `modality_host` varchar(64) DEFAULT NULL,
  `modality_config` varchar(1024) DEFAULT NULL,
  `modality_log` varchar(1024) DEFAULT NULL,
  `vitalsign_interval` int(11) DEFAULT 0,
  `default_location_id` int(11) DEFAULT NULL,
  `default_sub_location_id` int(11) DEFAULT NULL,
  `config` varchar(1024) DEFAULT NULL,
  `auto_confirm` bit(1) NOT NULL DEFAULT b'0',
  `is_deleted` bit(1) NOT NULL DEFAULT b'0',
  `org_id` int(11) NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_on` datetime NOT NULL DEFAULT current_timestamp(),
  `modified_by` int(11) NOT NULL,
  `modified_on` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`modality_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Dumping data for table mdi_pyt.mdi_modality: ~1 rows (approximately)
INSERT INTO `mdi_modality` (`modality_id`, `modality_uid`, `modality_name`, `modality_type_alias`, `modality_host`, `modality_config`, `modality_log`, `vitalsign_interval`, `default_location_id`, `default_sub_location_id`, `config`, `auto_confirm`, `is_deleted`, `org_id`, `created_by`, `created_on`, `modified_by`, `modified_on`) VALUES
	(1, '', 'Default', NULL, '', NULL, NULL, 0, NULL, NULL, NULL, b'0', b'0', 1, 1, '2022-10-31 00:00:00', 1, '2022-10-31 00:00:00');

-- Dumping structure for table mdi_pyt.mdi_patient_visit
CREATE TABLE IF NOT EXISTS `mdi_patient_visit` (
  `patient_visit_id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `sub_location_id` int(11) DEFAULT NULL,
  `visit_no` varchar(64) DEFAULT NULL,
  `pat_type` varchar(1) DEFAULT NULL COMMENT 'A = ADULT, P = PEDIATRIC, N = NEONATAL',
  `modality_wh_id` int(11) DEFAULT NULL,
  `wh_dt` datetime DEFAULT NULL,
  `pat_weight` decimal(6,2) DEFAULT NULL,
  `weight_unit` varchar(16) DEFAULT NULL,
  `pat_height` decimal(6,2) DEFAULT NULL,
  `height_unit` varchar(16) DEFAULT NULL,
  `pat_bmi` decimal(6,2) DEFAULT NULL,
  `org_id` int(11) NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_on` datetime NOT NULL DEFAULT current_timestamp(),
  `modified_by` int(11) NOT NULL,
  `modified_on` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`patient_visit_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Dumping data for table mdi_pyt.mdi_patient_visit: ~9 rows (approximately)
INSERT INTO `mdi_patient_visit` (`patient_visit_id`, `patient_id`, `location_id`, `sub_location_id`, `visit_no`, `pat_type`, `modality_wh_id`, `wh_dt`, `pat_weight`, `weight_unit`, `pat_height`, `height_unit`, `pat_bmi`, `org_id`, `created_by`, `created_on`, `modified_by`, `modified_on`) VALUES
	(1, 2, NULL, NULL, '20191024', 'A', 1, '2019-10-24 17:42:16', 49.90, 'kg', 153.40, 'cm', 21.20, 54, 1, '2019-10-24 17:42:16', 1, '2019-10-24 17:42:16'),
	(2, 2, NULL, NULL, '20191025', NULL, 1, '2019-10-25 09:03:23', 50.20, 'kg', 156.50, 'cm', 20.50, 54, 1, '2019-10-25 09:03:23', 1, '2022-12-19 15:12:46'),
	(3, 1, NULL, NULL, '20191028', NULL, 1, '2019-10-28 16:41:22', 42.50, 'kg', 163.20, 'cm', 15.90, 54, 1, '2019-10-28 16:41:22', 1, '2022-12-19 15:07:52'),
	(4, 1, NULL, NULL, '20191029', 'P', 1, '2019-10-29 09:54:10', 10.00, 'kg', 10.00, 'cm', 1.00, 54, 1, '2019-10-29 09:54:10', 1, '2022-12-17 14:22:15'),
	(5, 1, NULL, NULL, '20191101', 'A', 1, '2019-11-01 10:42:27', 50.30, 'kg', 154.70, 'cm', 21.00, 54, 1, '2019-11-01 10:42:27', 1, '2019-11-01 10:42:27'),
	(6, 2, NULL, NULL, '20191104', 'A', 1, '2019-11-04 11:22:15', 50.20, 'kg', 153.20, 'cm', 21.30, 54, 1, '2019-11-04 11:22:15', 1, '2019-11-04 11:22:15'),
	(7, 2, NULL, NULL, '20191105', 'A', 1, '2019-11-05 08:32:09', 67.10, 'kg', 168.80, 'cm', 23.50, 54, 1, '2019-11-05 08:32:09', 1, '2019-11-05 08:32:09'),
	(8, 2, NULL, NULL, '20191106', 'A', 1, '2019-11-06 15:49:58', 76.50, 'kg', 165.80, 'cm', 27.80, 54, 1, '2019-11-06 15:49:58', 1, '2019-11-06 15:49:58'),
	(9, 1, NULL, NULL, '20191112', 'A', 1, '2019-11-12 13:55:54', 50.80, 'kg', 152.80, 'cm', 21.70, 54, 1, '2019-11-12 13:55:54', 1, '2019-11-12 13:55:54');

-- Dumping structure for table mdi_pyt.mdi_sub_location
CREATE TABLE IF NOT EXISTS `mdi_sub_location` (
  `sub_location_id` int(11) NOT NULL AUTO_INCREMENT,
  `location_id` int(11) DEFAULT NULL,
  `sub_location_uid` varchar(64) DEFAULT NULL,
  `sub_location_name` varchar(128) DEFAULT NULL,
  `sub_location_desc` varchar(256) DEFAULT NULL,
  `sub_location_building` varchar(256) DEFAULT NULL,
  `sub_location_floor` varchar(256) DEFAULT NULL,
  `sub_location_room` varchar(256) DEFAULT NULL,
  `is_deleted` bit(1) NOT NULL DEFAULT b'0',
  `org_id` int(11) NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_on` datetime NOT NULL DEFAULT current_timestamp(),
  `modified_by` int(11) NOT NULL,
  `modified_on` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`sub_location_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Dumping data for table mdi_pyt.mdi_sub_location: ~0 rows (approximately)

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
