-- MySQL Workbench Synchronization
-- Generated: 2019-07-14 20:12
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: HADJI Mohamed Allam

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE TABLE IF NOT EXISTS `goodtime`.`adresses` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `number` INT(4) NULL DEFAULT NULL,
  `street` VARCHAR(100) NOT NULL,
  `complement` VARCHAR(100) NULL DEFAULT NULL,
  `post_code` INT(6) NOT NULL,
  `city` VARCHAR(30) NOT NULL,
  `latitude` FLOAT(11) NULL DEFAULT NULL,
  `longitude` FLOAT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `goodtime`.`pictures` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `path` VARCHAR(200) NOT NULL,
  `created_by` INT(11) NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` INT(11) NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_active` TINYINT(4) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `goodtime`.`favorites_bar` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `users_id` INT(11) NOT NULL,
  `bars_id` INT(11) NOT NULL,
  `created_by` INT(11) NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` INT(11) NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_active` TINYINT(4) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_favorites_users1_idx` (`users_id` ASC),
  INDEX `fk_favorites_establishments1_idx` (`bars_id` ASC),
  CONSTRAINT `fk_favorites_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `goodtime`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_favorites_establishments1`
    FOREIGN KEY (`bars_id`)
    REFERENCES `goodtime`.`bars` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `goodtime`.`groups` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `created_by` INT(11) NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` INT(11) NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_active` TINYINT(4) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `goodtime`.`users` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `firstname` VARCHAR(45) NOT NULL,
  `lastname` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(45) NULL DEFAULT NULL,
  `email` VARCHAR(50) NOT NULL,
  `password` VARCHAR(50) NOT NULL,
  `token` VARCHAR(255) NULL DEFAULT NULL,
  `adresses_id` INT(11) NOT NULL,
  `pictures_id` INT(11) NULL DEFAULT NULL,
  `favorite_item` INT(11) NULL DEFAULT NULL,
  `max_price` FLOAT(11) NULL DEFAULT NULL,
  `favorite_transportation` INT(11) NULL DEFAULT NULL,
  `created_by` INT(11) NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` INT(11) NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_active` TINYINT(4) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_users_adresses1_idx` (`adresses_id` ASC),
  INDEX `fk_users_pictures1_idx` (`pictures_id` ASC),
  CONSTRAINT `fk_users_adresses1`
    FOREIGN KEY (`adresses_id`)
    REFERENCES `goodtime`.`adresses` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_pictures1`
    FOREIGN KEY (`pictures_id`)
    REFERENCES `goodtime`.`pictures` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `goodtime`.`bars` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `adresses_id` INT(11) NOT NULL,
  `owner_id` INT(11) NOT NULL,
  `phone` VARCHAR(45) NULL DEFAULT NULL,
  `type` VARCHAR(45) NULL DEFAULT NULL,
  `created_by` INT(11) NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` INT(11) NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_active` TINYINT(4) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_establishments_adresses1_idx` (`adresses_id` ASC),
  INDEX `fk_bars_users1_idx` (`owner_id` ASC),
  CONSTRAINT `fk_establishments_adresses1`
    FOREIGN KEY (`adresses_id`)
    REFERENCES `goodtime`.`adresses` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bars_users1`
    FOREIGN KEY (`owner_id`)
    REFERENCES `goodtime`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `goodtime`.`user_group` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `users_id` INT(11) NOT NULL,
  `groups_id` INT(11) NOT NULL,
  `status` VARCHAR(3) NOT NULL,
  `created_by` INT(11) NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` INT(11) NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_active` TINYINT(4) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_user_group_users_idx` (`users_id` ASC),
  INDEX `fk_user_group_groups1_idx` (`groups_id` ASC),
  CONSTRAINT `fk_user_group_users`
    FOREIGN KEY (`users_id`)
    REFERENCES `goodtime`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_group_groups1`
    FOREIGN KEY (`groups_id`)
    REFERENCES `goodtime`.`groups` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `goodtime`.`goodtimes` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `groups_id` INT(11) NOT NULL,
  `bars_id` INT(11) NOT NULL,
  `is_booking` TINYINT(4) NULL DEFAULT 0,
  `number_of_participants` INT(11) NULL DEFAULT NULL,
  `status` VARCHAR(3) NOT NULL,
  `refusal_purpose` VARCHAR(50) NULL DEFAULT NULL,
  `created_by` INT(11) NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` INT(11) NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_active` TINYINT(4) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_bookings_groups1_idx` (`groups_id` ASC),
  INDEX `fk_bookings_establishments1_idx` (`bars_id` ASC),
  CONSTRAINT `fk_bookings_groups1`
    FOREIGN KEY (`groups_id`)
    REFERENCES `goodtime`.`groups` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bookings_establishments1`
    FOREIGN KEY (`bars_id`)
    REFERENCES `goodtime`.`bars` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `goodtime`.`items` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` TEXT NULL DEFAULT NULL,
  `is_food` TINYINT(4) NULL DEFAULT 0,
  `contains_alcohol` TINYINT(4) NULL DEFAULT 0,
  `contains_allergen` TINYINT(4) NULL DEFAULT 0,
  `created_by` INT(11) NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` INT(11) NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_active` TINYINT(4) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `goodtime`.`menus` (
  `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '\n',
  `menu_section` VARCHAR(45) NOT NULL,
  `establishments_id` INT(11) NOT NULL,
  `created_by` INT(11) NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` INT(11) NULL DEFAULT NULL,
  `date_edit` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_active` TINYINT(4) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_menus_establishments1_idx` (`establishments_id` ASC),
  CONSTRAINT `fk_menus_establishments1`
    FOREIGN KEY (`establishments_id`)
    REFERENCES `goodtime`.`bars` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `goodtime`.`menu_item` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `menus_id` INT(11) NOT NULL,
  `items_id` INT(11) NOT NULL,
  `price` FLOAT(11) NOT NULL,
  `created_by` INT(11) NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` INT(11) NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_active` TINYINT(4) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_menu_item_menus1_idx` (`menus_id` ASC),
  INDEX `fk_menu_item_items1_idx` (`items_id` ASC),
  CONSTRAINT `fk_menu_item_menus1`
    FOREIGN KEY (`menus_id`)
    REFERENCES `goodtime`.`menus` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_menu_item_items1`
    FOREIGN KEY (`items_id`)
    REFERENCES `goodtime`.`items` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `goodtime`.`discounts` (
  `id` INT(11) NOT NULL,
  `menu_item_id` INT(11) NOT NULL,
  `amount` FLOAT(11) NOT NULL,
  `begin_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `end_at` TIMESTAMP NULL DEFAULT NULL,
  `created_by` INT(11) NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` INT(11) NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_active` TINYINT(4) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_discounts_menu_item1_idx` (`menu_item_id` ASC),
  CONSTRAINT `fk_discounts_menu_item1`
    FOREIGN KEY (`menu_item_id`)
    REFERENCES `goodtime`.`menu_item` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `goodtime`.`ratings` (
  `id` INT(11) NOT NULL,
  `users_id` INT(11) NOT NULL,
  `bars_id` INT(11) NOT NULL,
  `mark` VARCHAR(45) NULL DEFAULT NULL,
  `comment` VARCHAR(45) NULL DEFAULT NULL,
  `created_by` INT(11) NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` INT(11) NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_active` TINYINT(4) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ratings_users1_idx` (`users_id` ASC),
  INDEX `fk_ratings_establishments1_idx` (`bars_id` ASC),
  CONSTRAINT `fk_ratings_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `goodtime`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ratings_establishments1`
    FOREIGN KEY (`bars_id`)
    REFERENCES `goodtime`.`bars` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `goodtime`.`events` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` TEXT NOT NULL,
  `bars_id` INT(11) NOT NULL,
  `date` TIMESTAMP NOT NULL,
  `created_by` INT(11) NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` INT(11) NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_active` TINYINT(4) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_events_establishments1_idx` (`bars_id` ASC),
  CONSTRAINT `fk_events_establishments1`
    FOREIGN KEY (`bars_id`)
    REFERENCES `goodtime`.`bars` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `goodtime`.`bar_pictures` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `bars_id` INT(11) NOT NULL,
  `pictures_id` INT(11) NOT NULL,
  `is_main` TINYINT(4) NULL DEFAULT 0,
  `created_by` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` INT(11) NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_active` TINYINT(4) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_bar_pictures_bars1_idx` (`bars_id` ASC),
  INDEX `fk_bar_pictures_pictures1_idx` (`pictures_id` ASC),
  CONSTRAINT `fk_bar_pictures_bars1`
    FOREIGN KEY (`bars_id`)
    REFERENCES `goodtime`.`bars` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bar_pictures_pictures1`
    FOREIGN KEY (`pictures_id`)
    REFERENCES `goodtime`.`pictures` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `goodtime`.`scheduls` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `bars_id` INT(11) NOT NULL,
  `weekday` VARCHAR(3) NOT NULL,
  `open` TINYINT(4) NULL DEFAULT 1,
  `is_hh` TINYINT(4) NULL DEFAULT 0,
  `hour` TIME NOT NULL,
  `notes` TEXT NULL DEFAULT NULL,
  `created_by` INT(11) NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` INT(11) NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_active` TINYINT(4) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_scheduls_bars1_idx` (`bars_id` ASC),
  CONSTRAINT `fk_scheduls_bars1`
    FOREIGN KEY (`bars_id`)
    REFERENCES `goodtime`.`bars` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `goodtime`.`special_schedule` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `bars_id` INT(11) NOT NULL,
  `begin_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `end_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `new_opening_hours` TIME NULL DEFAULT NULL,
  `new_closing_hours` TIME NULL DEFAULT NULL,
  `is_just_closed` TINYINT(4) NULL DEFAULT 0,
  `special_schedulecol` VARCHAR(45) NULL DEFAULT NULL,
  `created_by` INT(11) NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` INT(11) NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_active` TINYINT(4) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_special_schedule_bars1_idx` (`bars_id` ASC),
  CONSTRAINT `fk_special_schedule_bars1`
    FOREIGN KEY (`bars_id`)
    REFERENCES `goodtime`.`bars` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `goodtime`.`user_goodtime` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `users_id` INT(11) NOT NULL,
  `goodtimes_id` INT(11) NOT NULL,
  `status` VARCHAR(3) NULL DEFAULT NULL,
  `is_sam` TINYINT(4) NULL DEFAULT 0,
  `created_by` INT(11) NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` INT(11) NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_active` TINYINT(4) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_user_goodtime_goodtimes1_idx` (`goodtimes_id` ASC),
  INDEX `fk_user_goodtime_users1_idx` (`users_id` ASC),
  CONSTRAINT `fk_user_goodtime_goodtimes1`
    FOREIGN KEY (`goodtimes_id`)
    REFERENCES `goodtime`.`goodtimes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_goodtime_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `goodtime`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
