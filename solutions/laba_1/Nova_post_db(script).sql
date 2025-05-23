-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8mb3 ;
SHOW WARNINGS;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `operating_hours`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `operating_hours` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `operating_hours` (
  `hours_id` INT NOT NULL AUTO_INCREMENT,
  `days` VARCHAR(50) NOT NULL,
  `open_time` TIME NOT NULL,
  `close_time` TIME NOT NULL,
  PRIMARY KEY (`hours_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb3;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `branches`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `branches` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `branches` (
  `branch_id` INT NOT NULL AUTO_INCREMENT,
  `branch_ip` VARCHAR(25) NOT NULL,
  `address` VARCHAR(255) NOT NULL,
  `hours_id` INT NOT NULL,
  `phone` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`branch_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 8
DEFAULT CHARACTER SET = utf8mb3;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `senders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `senders` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `senders` (
  `sender_id` INT NOT NULL AUTO_INCREMENT,
  `full_name` VARCHAR(100) NOT NULL,
  `phone` VARCHAR(20) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`sender_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 8
DEFAULT CHARACTER SET = utf8mb3;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `branches_senders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `branches_senders` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `branches_senders` (
  `branch_id` INT NOT NULL,
  `sender_id` INT NOT NULL,
  PRIMARY KEY (`sender_id`, `branch_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `couriers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `couriers` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `couriers` (
  `courier_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `phone` VARCHAR(15) NOT NULL,
  `vechile_type` ENUM('Car', 'Bike', 'Van') NOT NULL,
  PRIMARY KEY (`courier_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 8
DEFAULT CHARACTER SET = utf8mb3;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `courier_branches`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `courier_branches` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `courier_branches` (
  `courier_id` INT NOT NULL,
  `branch_id` INT NOT NULL,
  PRIMARY KEY (`branch_id`, `courier_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `delivery_address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `delivery_address` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `delivery_address` (
  `address_id` INT NOT NULL AUTO_INCREMENT,
  `address` VARCHAR(255) NOT NULL,
  `delivery_instructions` VARCHAR(250) NOT NULL,
  PRIMARY KEY (`address_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 8
DEFAULT CHARACTER SET = utf8mb3;

SHOW WARNINGS;
CREATE INDEX `idx_city` ON `delivery_address` (`address` ASC) VISIBLE;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `receivers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `receivers` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `receivers` (
  `receiver_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `phone` VARCHAR(15) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`receiver_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 8
DEFAULT CHARACTER SET = utf8mb3;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `packages`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `packages` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `packages` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `sender_id` INT NOT NULL,
  `receiver_id` INT NOT NULL,
  `delivery_address_id` INT NOT NULL,
  `description` TEXT NOT NULL,
  `status` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 8
DEFAULT CHARACTER SET = utf8mb3;

SHOW WARNINGS;
CREATE INDEX `idx_status` ON `packages` (`status` ASC) VISIBLE;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `package_tracking`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `package_tracking` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `package_tracking` (
  `tracking_id` INT NOT NULL AUTO_INCREMENT,
  `package_id` INT NOT NULL,
  `branch_id` INT NOT NULL,
  `status` VARCHAR(20) NOT NULL,
  `timestap` DATETIME NOT NULL,
  PRIMARY KEY (`tracking_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb3;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `postmats`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `postmats` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `postmats` (
  `postmat_id` INT NOT NULL AUTO_INCREMENT,
  `location` VARCHAR(255) NOT NULL,
  `status` VARCHAR(20) NOT NULL,
  `branch_id` INT NOT NULL,
  PRIMARY KEY (`postmat_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 8
DEFAULT CHARACTER SET = utf8mb3;

SHOW WARNINGS;
CREATE INDEX `idx_location` ON `postmats` (`location` ASC) VISIBLE;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Data for table `operating_hours`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `operating_hours` (`hours_id`, `days`, `open_time`, `close_time`) VALUES (1, 'Monday-Saturday', '09:00:00', '19:00:00');
INSERT INTO `operating_hours` (`hours_id`, `days`, `open_time`, `close_time`) VALUES (2, 'Tuesday-Sunday', '09:00:00', '17:00:00');
INSERT INTO `operating_hours` (`hours_id`, `days`, `open_time`, `close_time`) VALUES (3, 'Monday-Friday', '10:00:00', '20:00:00');
INSERT INTO `operating_hours` (`hours_id`, `days`, `open_time`, `close_time`) VALUES (4, 'Thursday-Sunday', '09:00:00', '18:00:00');
INSERT INTO `operating_hours` (`hours_id`, `days`, `open_time`, `close_time`) VALUES (5, 'Thursday-Saturday', '09:00:00', '20:00:00');

COMMIT;


-- -----------------------------------------------------
-- Data for table `branches`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `branches` (`branch_id`, `branch_ip`, `address`, `hours_id`, `phone`) VALUES (1, '192.168.1.1', '123 Shevchenka Blvd, Kyiv', 1, '+380501234567');
INSERT INTO `branches` (`branch_id`, `branch_ip`, `address`, `hours_id`, `phone`) VALUES (2, '192.168.1.2', '456 Hrushevskoho St, Lviv', 2, '+380502345678');
INSERT INTO `branches` (`branch_id`, `branch_ip`, `address`, `hours_id`, `phone`) VALUES (3, '192.168.1.3', '789 Deribasovska St, Odesa', 3, '+380503456789');
INSERT INTO `branches` (`branch_id`, `branch_ip`, `address`, `hours_id`, `phone`) VALUES (4, '192.168.1.4', '321 Pushkinska St, Kharkiv', 5, '+380504567890');
INSERT INTO `branches` (`branch_id`, `branch_ip`, `address`, `hours_id`, `phone`) VALUES (5, '192.168.1.5', '654 Main St, Dnipro', 4, '+380505678901');
INSERT INTO `branches` (`branch_id`, `branch_ip`, `address`, `hours_id`, `phone`) VALUES (6, '192.168.1.6', '987 Victory Ave, Zaporizhzhia', 2, '+380506789012');
INSERT INTO `branches` (`branch_id`, `branch_ip`, `address`, `hours_id`, `phone`) VALUES (7, '192.168.1.7', '135 T. Shevchenka St, Ivano-Frankivsk', 3, '+380507890123');

COMMIT;


-- -----------------------------------------------------
-- Data for table `senders`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `senders` (`sender_id`, `full_name`, `phone`, `email`) VALUES (1, 'Ivan Petrenko', '+380501234567', 'ivan.petrenko@gmail.com');
INSERT INTO `senders` (`sender_id`, `full_name`, `phone`, `email`) VALUES (2, 'Olena Shevchenko', '+380502345678', 'olena.shevchenko@gmail.com');
INSERT INTO `senders` (`sender_id`, `full_name`, `phone`, `email`) VALUES (3, 'Pavlo Kovalenko', '+380503456789', 'pavlo.kovalenko@gmail.com');
INSERT INTO `senders` (`sender_id`, `full_name`, `phone`, `email`) VALUES (4, 'Neonila Dibrova', '+380504567890', 'nina.dibrova@gmail.com');
INSERT INTO `senders` (`sender_id`, `full_name`, `phone`, `email`) VALUES (5, 'Andriy Melnyk', '+380505678901', 'andriy.melnyk@gmail.com');
INSERT INTO `senders` (`sender_id`, `full_name`, `phone`, `email`) VALUES (6, 'Maria Ivanyk', '+380506789012', 'maria.ivanyk@gmail.com');
INSERT INTO `senders` (`sender_id`, `full_name`, `phone`, `email`) VALUES (7, 'Serhiy Tarasenko', '+380507890123', 'serhiy.tarasenko@gmail.com');

COMMIT;


-- -----------------------------------------------------
-- Data for table `branches_senders`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `branches_senders` (`branch_id`, `sender_id`) VALUES (1, 1);
INSERT INTO `branches_senders` (`branch_id`, `sender_id`) VALUES (1, 7);
INSERT INTO `branches_senders` (`branch_id`, `sender_id`) VALUES (2, 2);
INSERT INTO `branches_senders` (`branch_id`, `sender_id`) VALUES (2, 5);
INSERT INTO `branches_senders` (`branch_id`, `sender_id`) VALUES (3, 3);
INSERT INTO `branches_senders` (`branch_id`, `sender_id`) VALUES (3, 4);
INSERT INTO `branches_senders` (`branch_id`, `sender_id`) VALUES (4, 4);
INSERT INTO `branches_senders` (`branch_id`, `sender_id`) VALUES (5, 5);
INSERT INTO `branches_senders` (`branch_id`, `sender_id`) VALUES (6, 6);

COMMIT;


-- -----------------------------------------------------
-- Data for table `couriers`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `couriers` (`courier_id`, `name`, `phone`, `vechile_type`) VALUES (1, 'Pavlo Melnyk', '0673456789', 'Car');
INSERT INTO `couriers` (`courier_id`, `name`, `phone`, `vechile_type`) VALUES (2, 'Iryna Petrenko', '0684567890', 'Bike');
INSERT INTO `couriers` (`courier_id`, `name`, `phone`, `vechile_type`) VALUES (3, 'Oleksiy Ivanov', '0635678901', 'Van');
INSERT INTO `couriers` (`courier_id`, `name`, `phone`, `vechile_type`) VALUES (4, 'Anna Hrytsenko', '0506789012', 'Car');
INSERT INTO `couriers` (`courier_id`, `name`, `phone`, `vechile_type`) VALUES (5, 'Serhiy Popov', '0967890123', 'Bike');
INSERT INTO `couriers` (`courier_id`, `name`, `phone`, `vechile_type`) VALUES (6, 'Olga Moroz', '0448901234', 'Van');
INSERT INTO `couriers` (`courier_id`, `name`, `phone`, `vechile_type`) VALUES (7, 'Dmytro Yakovlev', '0679012345', 'Car');

COMMIT;


-- -----------------------------------------------------
-- Data for table `courier_branches`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `courier_branches` (`courier_id`, `branch_id`) VALUES (1, 1);
INSERT INTO `courier_branches` (`courier_id`, `branch_id`) VALUES (2, 2);
INSERT INTO `courier_branches` (`courier_id`, `branch_id`) VALUES (3, 4);
INSERT INTO `courier_branches` (`courier_id`, `branch_id`) VALUES (4, 2);
INSERT INTO `courier_branches` (`courier_id`, `branch_id`) VALUES (5, 5);
INSERT INTO `courier_branches` (`courier_id`, `branch_id`) VALUES (6, 6);
INSERT INTO `courier_branches` (`courier_id`, `branch_id`) VALUES (7, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `delivery_address`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `delivery_address` (`address_id`, `address`, `delivery_instructions`) VALUES (1, '10 Shevchenka St, Kyiv', 'Leave at front desk');
INSERT INTO `delivery_address` (`address_id`, `address`, `delivery_instructions`) VALUES (2, '25 Hrushevskoho St, Lviv', 'Ring the bell');
INSERT INTO `delivery_address` (`address_id`, `address`, `delivery_instructions`) VALUES (3, '30 Deribasovska St, Odesa', 'Deliver to apartment');
INSERT INTO `delivery_address` (`address_id`, `address`, `delivery_instructions`) VALUES (4, '45 Pushkinska St, Kharkiv', 'Leave at security');
INSERT INTO `delivery_address` (`address_id`, `address`, `delivery_instructions`) VALUES (5, '55 Main St, Dnipro', 'Contact on arrival');
INSERT INTO `delivery_address` (`address_id`, `address`, `delivery_instructions`) VALUES (6, '60 Victory Ave, Zaporizhzhia', 'Deliver to back entrance');
INSERT INTO `delivery_address` (`address_id`, `address`, `delivery_instructions`) VALUES (7, '70 T. Shevchenka St, Ivano-Frankivsk', 'Call upon arrival');

COMMIT;


-- -----------------------------------------------------
-- Data for table `receivers`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `receivers` (`receiver_id`, `name`, `phone`, `email`) VALUES (1, 'Svitlana Moroz', '0671234567', 'svitlana.moroz@gmail.com');
INSERT INTO `receivers` (`receiver_id`, `name`, `phone`, `email`) VALUES (2, 'Vasyl Petrenko', '0682345678', 'vasyl.petrenko@gmail.com');
INSERT INTO `receivers` (`receiver_id`, `name`, `phone`, `email`) VALUES (3, 'Kateryna Rudenko', '0633456789', 'kateryna.rudenko@gmail.com');
INSERT INTO `receivers` (`receiver_id`, `name`, `phone`, `email`) VALUES (4, 'Oleksandr Ponomarenko', '0504567890', 'oleksandr.ponomarenko@gmail.com');
INSERT INTO `receivers` (`receiver_id`, `name`, `phone`, `email`) VALUES (5, 'Yulia Dudnik', '0965678901', 'yulia.dudnik@gmail.com');
INSERT INTO `receivers` (`receiver_id`, `name`, `phone`, `email`) VALUES (6, 'Serhiy Lukyanenko', '0446789012', 'serhiy.lukyanenko@gmail.com');
INSERT INTO `receivers` (`receiver_id`, `name`, `phone`, `email`) VALUES (7, 'Olga Kuzmenko', '0677890123', 'olga.kuzmenko@gmail.com');

COMMIT;


-- -----------------------------------------------------
-- Data for table `packages`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `packages` (`id`, `sender_id`, `receiver_id`, `delivery_address_id`, `description`, `status`) VALUES (1, 1, 4, 7, 'Package of electronics', 'In Transit');
INSERT INTO `packages` (`id`, `sender_id`, `receiver_id`, `delivery_address_id`, `description`, `status`) VALUES (2, 2, 3, 3, 'Clothing items', 'Delivered');
INSERT INTO `packages` (`id`, `sender_id`, `receiver_id`, `delivery_address_id`, `description`, `status`) VALUES (3, 3, 2, 4, 'Books and magazines', 'In Transit');
INSERT INTO `packages` (`id`, `sender_id`, `receiver_id`, `delivery_address_id`, `description`, `status`) VALUES (4, 4, 1, 5, 'Kitchen appliances', 'Pending');
INSERT INTO `packages` (`id`, `sender_id`, `receiver_id`, `delivery_address_id`, `description`, `status`) VALUES (5, 5, 6, 1, 'Furniture', 'Delivered');
INSERT INTO `packages` (`id`, `sender_id`, `receiver_id`, `delivery_address_id`, `description`, `status`) VALUES (6, 6, 5, 2, 'Stationery', 'In Transit');
INSERT INTO `packages` (`id`, `sender_id`, `receiver_id`, `delivery_address_id`, `description`, `status`) VALUES (7, 7, 7, 6, 'Gift items', 'Pending');

COMMIT;


-- -----------------------------------------------------
-- Data for table `package_tracking`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `package_tracking` (`tracking_id`, `package_id`, `branch_id`, `status`, `timestap`) VALUES (1, 1, 1, 'Received', '2024-09-01 10:00:00');
INSERT INTO `package_tracking` (`tracking_id`, `package_id`, `branch_id`, `status`, `timestap`) VALUES (2, 1, 2, 'In Transit', '2024-09-02 15:30:00');
INSERT INTO `package_tracking` (`tracking_id`, `package_id`, `branch_id`, `status`, `timestap`) VALUES (3, 1, 3, 'Out for Delivery', '2024-09-03 09:45:00');
INSERT INTO `package_tracking` (`tracking_id`, `package_id`, `branch_id`, `status`, `timestap`) VALUES (4, 2, 2, 'Delivered', '2024-09-01 12:00:00');
INSERT INTO `package_tracking` (`tracking_id`, `package_id`, `branch_id`, `status`, `timestap`) VALUES (5, 3, 3, 'Received', '2024-09-02 08:30:00');
INSERT INTO `package_tracking` (`tracking_id`, `package_id`, `branch_id`, `status`, `timestap`) VALUES (6, 3, 4, 'In Transit', '2024-09-03 14:15:00');
INSERT INTO `package_tracking` (`tracking_id`, `package_id`, `branch_id`, `status`, `timestap`) VALUES (7, 4, 4, 'Pending', '2024-09-01 16:00:00');
INSERT INTO `package_tracking` (`tracking_id`, `package_id`, `branch_id`, `status`, `timestap`) VALUES (8, 5, 5, 'Delivered', '2024-09-02 11:30:00');
INSERT INTO `package_tracking` (`tracking_id`, `package_id`, `branch_id`, `status`, `timestap`) VALUES (9, 6, 6, 'In Transit', '2024-09-01 13:00:00');
INSERT INTO `package_tracking` (`tracking_id`, `package_id`, `branch_id`, `status`, `timestap`) VALUES (10, 7, 7, 'Pending', '2024-09-02 09:00:00');

COMMIT;


-- -----------------------------------------------------
-- Data for table `postmats`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `postmats` (`postmat_id`, `location`, `status`, `branch_id`) VALUES (1, 'Kyiv Central Postmat', 'Active', 1);
INSERT INTO `postmats` (`postmat_id`, `location`, `status`, `branch_id`) VALUES (2, 'Lviv Postmat 1', 'Inactive', 2);
INSERT INTO `postmats` (`postmat_id`, `location`, `status`, `branch_id`) VALUES (3, 'Odesa Postmat', 'Active', 3);
INSERT INTO `postmats` (`postmat_id`, `location`, `status`, `branch_id`) VALUES (4, 'Kharkiv Postmat 1', 'Active', 4);
INSERT INTO `postmats` (`postmat_id`, `location`, `status`, `branch_id`) VALUES (5, 'Dnipro Postmat 2', 'Maintenance', 5);
INSERT INTO `postmats` (`postmat_id`, `location`, `status`, `branch_id`) VALUES (6, 'Zaporizhzhia Postmat', 'Active', 6);
INSERT INTO `postmats` (`postmat_id`, `location`, `status`, `branch_id`) VALUES (7, 'Ivano-Frankivsk Postmat', 'Active', 7);

COMMIT;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
