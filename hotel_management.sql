-- Database: `railway`
-- Tables for hotel management system
--
-- Table structure for table `about_us`
--
--
-- Table structure for table `about_us`
--
CREATE TABLE
  IF NOT EXISTS `about_us` (
    `id` int (11) NOT NULL PRIMARY KEY,
    `title` varchar(255) NOT NULL,
    `description` text NOT NULL,
    `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
    `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
  ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

--
-- --------------------------------------------------------
--
-- Table structure for table `ads`
--
CREATE TABLE
  IF NOT EXISTS `ads` (
    `id` int (11) NOT NULL PRIMARY KEY,
    `title` varchar(255) NOT NULL,
    `description` text NOT NULL,
    `image_url` varchar(255) DEFAULT NULL,
    `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
    `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
  ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

--
-- Dumping data for table `ads`
--
-- --------------------------------------------------------
--
-- Table structure for table `deposit`
--
CREATE TABLE
  IF NOT EXISTS `deposit` (
    `deposit_id` int (11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `stay_record_id` int (11) NOT NULL,
    `amount` decimal(10, 2) NOT NULL,
    `deposit_date` date NOT NULL
  ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

-- --------------------------------------------------------
--
-- Table structure for table `discounts`
--
CREATE TABLE
  IF NOT EXISTS `discounts` (
    `id` int (11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `name` varchar(255) NOT NULL,
    `percentage` decimal(5, 2) NOT NULL CHECK (
      `percentage` >= 0
      and `percentage` <= 100
    ),
    `created_at` timestamp NOT NULL DEFAULT current_timestamp()
  ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

--
-- Dumping data for table `discounts`
--
INSERT IGNORE INTO `discounts` (`id`, `name`, `percentage`, `created_at`)
VALUES
  (1, 'Senior', 20.00, '2024-08-01 03:58:17'),
  (2, 'Promo', 10.00, '2024-08-10 04:03:51'),
  (
    3,
    'Managers Discount',
    5.00,
    '2024-08-21 01:47:49'
  );

-- --------------------------------------------------------
--
-- Table structure for table `guests`
--
CREATE TABLE
  IF NOT EXISTS `guests` (
    `id` int (11) NOT NULL,
    `first_name` varchar(255) NOT NULL,
    `last_name` varchar(255) NOT NULL,
    `email` varchar(255) NOT NULL,
    `phone` varchar(15) DEFAULT NULL,
    `id_picture` varchar(255) DEFAULT NULL,
    `created_at` timestamp NOT NULL DEFAULT current_timestamp()
  ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

--
-- --------------------------------------------------------
--
-- Table structure for table `reservations`
--
CREATE TABLE
  IF NOT EXISTS `reservations` (
    `id` int (11) NOT NULL,
    `room_id` int (11) NOT NULL,
    `guest_id` int (11) NOT NULL,
    `check_in` date NOT NULL,
    `check_out` date NOT NULL,
    `adults` int (11) NOT NULL DEFAULT 1,
    `kids` int (11) NOT NULL DEFAULT 0,
    `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
    `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
  ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

--
-- --------------------------------------------------------
--
-- Table structure for table `rooms`
--
CREATE TABLE
  IF NOT EXISTS `rooms` (
    `id` int (11) NOT NULL,
    `room_number` varchar(255) NOT NULL,
    `room_type_id` int (11) DEFAULT NULL,
    `rate` decimal(10, 2) NOT NULL,
    `imageUrl` varchar(255) DEFAULT NULL,
    `status_code_id` int (11) DEFAULT NULL,
    `max_people` int (11) NOT NULL DEFAULT 2
  ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

--
-- --------------------------------------------------------
--
-- Table structure for table `room_types`
--
CREATE TABLE
  IF NOT EXISTS `room_types` (
    `id` int (11) NOT NULL,
    `name` varchar(255) NOT NULL
  ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

--
-- Dumping data for table `room_types`
--
INSERT IGNORE INTO `room_types` (`id`, `name`)
VALUES
  (5, ''),
  (2, 'Double Room'),
  (1, 'Single Room');

-- --------------------------------------------------------
--
-- Table structure for table `services`
--
CREATE TABLE
  IF NOT EXISTS `services` (
    `id` int (11) NOT NULL,
    `stay_record_id` int (11) NOT NULL,
    `service_list_id` int (11) NOT NULL,
    `name` varchar(255) NOT NULL,
    `price` decimal(10, 2) NOT NULL,
    `description` text DEFAULT NULL
  ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

-- --------------------------------------------------------
--
-- Table structure for table `service_list`
--
CREATE TABLE
  IF NOT EXISTS `service_list` (
    `id` int (11) NOT NULL,
    `name` varchar(255) NOT NULL,
    `description` text DEFAULT NULL,
    `base_price` decimal(10, 2) NOT NULL
  ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

--
-- Dumping data for table `service_list`
--
INSERT IGNORE INTO `service_list` (`id`, `name`, `description`, `base_price`)
VALUES
  (9, 'Laundry', '', 150.00),
  (10, 'Shuttle bus', '', 0.00);

-- --------------------------------------------------------
--
-- Table structure for table `status_codes`
--
CREATE TABLE
  IF NOT EXISTS `status_codes` (
    `id` int (11) NOT NULL,
    `code` varchar(10) NOT NULL,
    `label` varchar(255) NOT NULL,
    `color` varchar(7) NOT NULL,
    `text_color` varchar(7) NOT NULL
  ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

--
-- Dumping data for table `status_codes`
--
INSERT IGNORE INTO `status_codes` (`id`, `code`, `label`, `color`, `text_color`)
VALUES
  (1, 'OC', 'Occupied clean', '#00008B', '#FFFFFF'),
  (2, 'OD', 'Occupied dirty', '#FF8C00', '#000000'),
  (3, 'VR', 'Vacant ready', '#006400', '#FFFFFF'),
  (4, 'VC', 'Vacant clean', '#5F9EA0', '#FFFFFF'),
  (5, 'VD', 'Vacant dirty', '#8B0000', '#FFFFFF'),
  (
    6,
    'HSUD',
    'House use dirty',
    '#CCCC00',
    '#000000'
  ),
  (
    7,
    'HSUC',
    'House use clean',
    '#32CD32',
    '#000000'
  ),
  (8, 'OOO', 'Out of order', '#808080', '#FFFFFF'),
  (9, 'BLO', 'Blocked', '#4B0082', '#FFFFFF'),
  (11, 'SO', 'Slept out', '#8B4513', '#FFFFFF'),
  (12, 'OT', 'Over Time', '#000000', '#FFFFFF'),
  (13, 'NS', 'No show', '#FFC0CB', '#000000');

-- --------------------------------------------------------
--
-- Table structure for table `stay_records`
--
CREATE TABLE
  IF NOT EXISTS `stay_records` (
    `id` int (11) NOT NULL,
    `room_id` int (11) NOT NULL,
    `guest_id` int (11) NOT NULL,
    `check_in` date NOT NULL,
    `check_out` date NOT NULL,
    `adults` int (11) NOT NULL DEFAULT 1,
    `kids` int (11) NOT NULL DEFAULT 0,
    `total_rate` decimal(10, 2) NOT NULL,
    `discount_id` int (11) DEFAULT NULL,
    `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
    `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
  ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

-- --------------------------------------------------------
--
-- Table structure for table `stay_records_history`
--
CREATE TABLE
  IF NOT EXISTS `stay_records_history` (
    `id` int (11) NOT NULL,
    `room_id` int (11) NOT NULL,
    `guest_id` int (11) NOT NULL,
    `check_in` date NOT NULL,
    `check_out` date NOT NULL,
    `adults` int (11) NOT NULL DEFAULT 1,
    `kids` int (11) NOT NULL DEFAULT 0,
    `amount_paid` decimal(10, 2) NOT NULL,
    `total_service_charges` decimal(10, 2) NOT NULL,
    `discount_percentage` decimal(5, 2) NOT NULL,
    `discount_name` varchar(255) DEFAULT NULL,
    `payment_method` varchar(50) DEFAULT 'cash',
    `payment_date` timestamp NOT NULL DEFAULT current_timestamp(),
    `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
    `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
    `deposit_amount` decimal(10, 2) NOT NULL DEFAULT 0.00
  ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

--
-- --------------------------------------------------------
--
-- Table structure for table `users`
--
CREATE TABLE
  IF NOT EXISTS `users` (
    `id` int (11) NOT NULL,
    `userId` varchar(255) NOT NULL,
    `username` varchar(255) NOT NULL,
    `password` varchar(255) NOT NULL,
    `role` varchar(50) NOT NULL,
    `created_at` timestamp NOT NULL DEFAULT current_timestamp()
  ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

--
-- --------------------------------------------------------
--
-- Table structure for table `user_log`
--
CREATE TABLE
  IF NOT EXISTS `user_log` (
    `log_id` int (11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `user_id` varchar(255) NOT NULL,
    `action` varchar(255) NOT NULL,
    `action_time` timestamp NOT NULL DEFAULT current_timestamp()
  ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

--
-- --------------------------------------------------------
--
-- Table structure for table `user_profile`
--
CREATE TABLE
  IF NOT EXISTS `user_profile` (
    `id` int (11) NOT NULL,
    `user_id` varchar(255) NOT NULL,
    `first_name` varchar(255) NOT NULL,
    `last_name` varchar(255) NOT NULL,
    `email` varchar(255) DEFAULT NULL,
    `phone_number` varchar(15) DEFAULT NULL,
    `address` text DEFAULT NULL,
    `image_url` varchar(255) DEFAULT 'default_profile.png'
  ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;