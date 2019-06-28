-- phpMyAdmin SQL Dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- Client :  127.0.0.1
-- Généré le :  Ven 28 Juin 2019 à 08:03
-- Version du serveur :  5.7.14
-- Version de PHP :  7.0.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `goodtime`
--

-- --------------------------------------------------------

--
-- Structure de la table `address`
--

CREATE TABLE `address` (
  `id` int(11) NOT NULL,
  `num` int(11) NOT NULL,
  `street` varchar(255) NOT NULL,
  `post_code` int(11) NOT NULL,
  `city` varchar(255) NOT NULL,
  `latitude` float DEFAULT NULL,
  `longitude` float DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Contenu de la table `address`
--

INSERT INTO `address` (`id`, `num`, `street`, `post_code`, `city`, `latitude`, `longitude`) VALUES
(1, 1, 'rue des Poissons', 75007, 'Paris', 12, 13),
(2, 435, 'rue lalala', 75020, 'Paris', 33, 45),
(3, 12, 'avenue Eugène Thomas', 94270, 'Le Kremlin Bicêtre', 48.8089, 2.3573),
(4, 12, 'avenue Eugène Thomas', 94270, 'Le Kremlin Bicêtre', 48.8089, 2.3573),
(5, 12, 'avenue Eugène Thomas', 94270, 'Le Kremlin Bicêtre', 48.8089, 2.3573),
(6, 12, 'avenue Eugène Thomas', 94270, 'Le Kremlin Bicêtre', 48.8089, 2.3573),
(7, 12, 'avenue Eugène Thomas', 94270, 'Le Kremlin Bicêtre', 48.8089, 2.3573),
(8, 12, 'avenue Eugène Thomas', 94270, 'Paris', 48.8089, 2.3573),
(9, 12, 'avenue Eugène Thomas', 94270, 'Le Kremlin Bicêtre', 48.8089, 2.3573);

-- --------------------------------------------------------

--
-- Structure de la table `bar`
--

CREATE TABLE `bar` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `address_id` int(11) NOT NULL,
  `owner_id` int(11) NOT NULL,
  `phone` varchar(10) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `schedule` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `is_deleted` smallint(6) DEFAULT '0',
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Contenu de la table `bar`
--

INSERT INTO `bar` (`id`, `name`, `address_id`, `owner_id`, `phone`, `type`, `schedule`, `created_at`, `is_deleted`, `deleted_at`) VALUES
(7, 'Beucue', 1, 39, '0123456789', 1, NULL, NULL, 0, NULL),
(6, 'Mitzva', 1, 37, '0123456789', 1, NULL, NULL, 0, NULL),
(8, 'Celone', 1, 41, '0123456789', 1, '"[{\\"day\\":0,\\"periods\\":[{\\"start\\":\\"20:00\\",\\"end\\":\\"00:00\\",\\"title\\":\\"\\",\\"backgroundColor\\":\\"rgba(234, 255, 122, 0.5)\\",\\"borderColor\\":\\"rgb(234, 198, 122)\\",\\"textColor\\":\\"rgb(0, 0, 0)\\"}]},{\\"day\\":1,\\"periods\\":[]},{\\"day\\":2,\\"periods\\":[{\\"start\\":\\"16:30\\",\\"end\\":\\"20:30\\",\\"title\\":\\"\\",\\"backgroundColor\\":\\"rgba(187, 187, 187, 0.5)\\",\\"borderColor\\":\\"rgb(187, 187, 187)\\",\\"textColor\\":\\"rgb(0, 0, 0)\\"}]},{\\"day\\":3,\\"periods\\":[{\\"start\\":\\"00:00\\",\\"end\\":\\"08:30\\",\\"title\\":\\"\\",\\"backgroundColor\\":\\"rgba(187, 187, 187, 0.5)\\",\\"borderColor\\":\\"rgb(187, 187, 187)\\",\\"textColor\\":\\"rgb(0, 0, 0)\\"}]},{\\"day\\":4,\\"periods\\":[]},{\\"day\\":5,\\"periods\\":[{\\"start\\":\\"15:30\\",\\"end\\":\\"21:30\\",\\"title\\":\\"\\",\\"backgroundColor\\":\\"rgba(187, 187, 187, 0.5)\\",\\"borderColor\\":\\"rgb(187, 187, 187)\\",\\"textColor\\":\\"rgb(0, 0, 0)\\"}]},{\\"day\\":6,\\"periods\\":[{\\"start\\":\\"16:00\\",\\"end\\":\\"21:00\\",\\"title\\":\\"\\",\\"backgroundColor\\":\\"rgba(187, 187, 187, 0.5)\\",\\"borderColor\\":\\"rgb(187, 187, 187)\\",\\"textColor\\":\\"rgb(0, 0, 0)\\"}]}]"', NULL, 0, NULL),
(9, 'Ackobama', 1, 42, '0123456789', 1, '"[{\\"day\\":0,\\"periods\\":[]},{\\"day\\":1,\\"periods\\":[]},{\\"day\\":2,\\"periods\\":[]},{\\"day\\":3,\\"periods\\":[]},{\\"day\\":4,\\"periods\\":[]},{\\"day\\":5,\\"periods\\":[]},{\\"day\\":6,\\"periods\\":[]}]"', NULL, 0, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `bar_picture`
--

CREATE TABLE `bar_picture` (
  `id` int(11) NOT NULL,
  `bar_id` int(11) NOT NULL,
  `is_main` int(11) NOT NULL DEFAULT '0',
  `picture_id` int(11) NOT NULL,
  `is_deleted` int(11) DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Contenu de la table `bar_picture`
--

INSERT INTO `bar_picture` (`id`, `bar_id`, `is_main`, `picture_id`, `is_deleted`) VALUES
(1, 9, 1, 1, 0);

-- --------------------------------------------------------

--
-- Structure de la table `discount`
--

CREATE TABLE `discount` (
  `id` int(11) NOT NULL,
  `menu_item_id` int(11) NOT NULL,
  `amount` int(11) NOT NULL,
  `start` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `end` timestamp NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `event`
--

CREATE TABLE `event` (
  `id` int(11) NOT NULL,
  `bar_id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `description` text,
  `date` timestamp NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int(11) NOT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `deleted_by` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `favorite_bar`
--

CREATE TABLE `favorite_bar` (
  `id` int(11) NOT NULL,
  `bar_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `is_deleted` smallint(6) DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `good_time`
--

CREATE TABLE `good_time` (
  `id` int(11) NOT NULL,
  `bar_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `is_booking` int(11) DEFAULT '0',
  `number_of_people` int(11) DEFAULT NULL,
  `status` varchar(3) DEFAULT NULL,
  `refusal_purpose` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int(11) NOT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `deleted_by` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `groups`
--

CREATE TABLE `groups` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `created_by` int(11) NOT NULL,
  `is_deleted` smallint(6) DEFAULT '0',
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `item`
--

CREATE TABLE `item` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text,
  `is_food` tinyint(1) DEFAULT '0',
  `contains_alcohol` tinyint(1) DEFAULT '0',
  `contains_allergen` tinyint(1) DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `menu`
--

CREATE TABLE `menu` (
  `id` int(11) NOT NULL,
  `bar_id` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `menu_item`
--

CREATE TABLE `menu_item` (
  `id` int(11) NOT NULL,
  `menu_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `price` float NOT NULL,
  `is_deleted` smallint(6) DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `notification`
--

CREATE TABLE `notification` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `picture`
--

CREATE TABLE `picture` (
  `id` int(11) NOT NULL,
  `path` varchar(150) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `is_deleted` smallint(6) DEFAULT '0',
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Contenu de la table `picture`
--

INSERT INTO `picture` (`id`, `path`, `created_at`, `is_deleted`, `deleted_at`) VALUES
(1, '03821961a61c7747c73284f01d260323.jpg', NULL, 0, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `rating`
--

CREATE TABLE `rating` (
  `id` int(11) NOT NULL,
  `bar_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `mark` int(11) NOT NULL,
  `comment` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `schedule`
--

CREATE TABLE `schedule` (
  `id` int(11) NOT NULL,
  `bar_id` int(11) NOT NULL,
  `weekday` varchar(3) NOT NULL,
  `open` tinyint(1) DEFAULT '1',
  `is_hh` tinyint(1) DEFAULT '0',
  `hour` time NOT NULL,
  `notes` text
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `special_schedule`
--

CREATE TABLE `special_schedule` (
  `id` int(11) NOT NULL,
  `bar_id` int(11) NOT NULL,
  `begin_date` timestamp NOT NULL,
  `end_date` timestamp NOT NULL,
  `new_opening_hour` time DEFAULT NULL,
  `new_closing_hour` time DEFAULT NULL,
  `is_just_closed` tinyint(1) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `address_id` int(11) DEFAULT NULL,
  `phone` varchar(10) DEFAULT NULL,
  `picture` int(11) DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `favorite_item` int(11) DEFAULT NULL,
  `max_price` float DEFAULT NULL,
  `favorite_transportation` smallint(6) DEFAULT NULL,
  `roles` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `is_deleted` smallint(6) DEFAULT '0',
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Contenu de la table `user`
--

INSERT INTO `user` (`id`, `email`, `password`, `name`, `address_id`, `phone`, `picture`, `token`, `favorite_item`, `max_price`, `favorite_transportation`, `roles`, `created_at`, `is_deleted`, `deleted_at`) VALUES
(11, 'arthur.halvorson@cruickshank.info', '$2y$13$PmSbjS2cTFUkXf84CtztmenQVCbirpZdefLVrSq7n9M2OgE9oU/1C', 'Mustafa Mayer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL),
(12, 'kolby96@yahoo.com', '$2y$13$Qvjbzbd1Gg68K.esdr1sW.W3Vj3LM70GOFoqYCya1nFDvfq9SZVoe', 'Coralie Wolff', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL),
(13, 'skiehn@hotmail.com', '$2y$13$0tSIICSvq2HMp5S8lYskXuu0MBAZgVzljBiBhgnFwE4lX5GK67OxG', 'Kendall Witting', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL),
(14, 'emard.otis@yahoo.com', '$2y$13$hHofGD3vhaF8sA39EVzjXeTsuBN5q8kfshCYO6P/q6cZY14xhXXe2', 'Sandrine Schumm', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL),
(15, 'ortiz.rebekah@prosacco.com', '$2y$13$HP5w0ggn3kfgovp7NfWa7eQeBVBhdeuYRAOt0MEm5bHS1pooaE2lq', 'Santina Gutmann', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL),
(16, 'general.balistreri@cartwright.net', '$2y$13$NQmCGjkC1PnANtSt/G3L5edzpvA5Bmr.BVC4yimXM7o7hihMyLJJ2', 'Deanna Hayes', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL),
(17, 'wmurray@hotmail.com', '$2y$13$aAFSlTJWTs4aLNKqUYKNdevBUCUQaF/w5/Fjm14r.JpaNxxOzHDVC', 'Patrick Kemmer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL),
(18, 'merlin.sipes@hessel.com', '$2y$13$NKhJRBkhwN.ki/4hDPLIKOC9rtWQX/gtOUNCrYUlRdZGFX0QK09dm', 'Karolann Champlin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL),
(19, 'antonetta.windler@yahoo.com', '$2y$13$AsneZppyHbud/d7f78qlKeCvjZUe.G9GRt0e/cXv0bACgiE1gWB5y', 'Rylan Weimann', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL),
(20, 'antone47@cartwright.info', '$2y$13$ZiMS/iHSXUkUDnafBd4oR.s5hr8PmP29suqD1la0lxbRJG3usAiL2', 'Charlotte Rippin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL),
(21, 'test@test.fr', '$2y$13$9a4W50lp8P5rkDYGEqCZceaSOoCQIhFOx1JS/g/jEim8rAeVEAwiO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL),
(34, 'test1000@gmail.com', '$2y$13$D7UIDD9FUO72FTrBchwLzuJvmRHmUCvovWfc944XyBLG0/22R72E6', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL),
(37, 'test2000@gmail.com', '$2y$13$3fy3bMqRJKjL8caEnm2RBuUJub4f05WRcc1LSNEk.T2Is6mgHXHKm', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '["ROLE_USER", "ROLE_BAR"]', NULL, 0, NULL),
(38, 'test@mail.fr', '$2y$13$IvgKYo1CuDeGKDtnUzTq1eK/h92usCZrOgQjMdYRFuL34oRnOGNoS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '["ROLE_BAR"]', NULL, 0, NULL),
(39, 'test3000@mail.fr', '$2y$13$ptLWWIUZU0GYG/R0MCASdOUXXw7b.UXMHBVafmcgUhomGhtqUVqwW', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '["ROLE_BAR"]', NULL, 0, NULL),
(40, 'azerty@mail.fr', '$2y$13$sC2JvcMwh5sksULmD.U8KO0C/N7Fvg8z5VM7tg5U1J.SvyYdHVZcu', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '["ROLE_BAR"]', NULL, 0, NULL),
(41, 'bo1@mail.com', '$2y$13$DvU6CZBxcdJyb0jtnQEeGOSW5hR/6hk7GXPrBpYzQHL0PZj4NkDr.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '["ROLE_BAR"]', NULL, 0, NULL),
(42, 'bo2@mail.com', '$2y$13$skgFSEzzyrs0sOKlmW3ixO9d0SGvR7Y01qWzO9WKxmZN0QmXrd7rO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '["ROLE_BAR"]', NULL, 0, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `user_good_time`
--

CREATE TABLE `user_good_time` (
  `id` int(11) NOT NULL,
  `good_time_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `status` varchar(3) DEFAULT '0',
  `is_sam` smallint(6) DEFAULT '0',
  `is_deleted` int(11) DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `user_group`
--

CREATE TABLE `user_group` (
  `id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `status` varchar(3) NOT NULL,
  `is_deleted` smallint(6) DEFAULT '0',
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Index pour les tables exportées
--

--
-- Index pour la table `address`
--
ALTER TABLE `address`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `bar`
--
ALTER TABLE `bar`
  ADD PRIMARY KEY (`id`),
  ADD KEY `address_id` (`address_id`),
  ADD KEY `owner_id` (`owner_id`);

--
-- Index pour la table `bar_picture`
--
ALTER TABLE `bar_picture`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bar_id` (`bar_id`),
  ADD KEY `picture_id` (`picture_id`);

--
-- Index pour la table `discount`
--
ALTER TABLE `discount`
  ADD PRIMARY KEY (`id`),
  ADD KEY `menu_item_id` (`menu_item_id`);

--
-- Index pour la table `event`
--
ALTER TABLE `event`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bar_id` (`bar_id`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `updated_by` (`updated_by`),
  ADD KEY `deleted_by` (`deleted_by`);

--
-- Index pour la table `favorite_bar`
--
ALTER TABLE `favorite_bar`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bar_id` (`bar_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Index pour la table `good_time`
--
ALTER TABLE `good_time`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bar_id` (`bar_id`),
  ADD KEY `group_id` (`group_id`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `updated_by` (`updated_by`),
  ADD KEY `deleted_by` (`deleted_by`);

--
-- Index pour la table `groups`
--
ALTER TABLE `groups`
  ADD PRIMARY KEY (`id`),
  ADD KEY `created_by` (`created_by`);

--
-- Index pour la table `item`
--
ALTER TABLE `item`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `menu`
--
ALTER TABLE `menu`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bar_id` (`bar_id`);

--
-- Index pour la table `menu_item`
--
ALTER TABLE `menu_item`
  ADD PRIMARY KEY (`id`),
  ADD KEY `menu_id` (`menu_id`),
  ADD KEY `item_id` (`item_id`);

--
-- Index pour la table `notification`
--
ALTER TABLE `notification`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Index pour la table `picture`
--
ALTER TABLE `picture`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `rating`
--
ALTER TABLE `rating`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bar_id` (`bar_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Index pour la table `schedule`
--
ALTER TABLE `schedule`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bar_id` (`bar_id`);

--
-- Index pour la table `special_schedule`
--
ALTER TABLE `special_schedule`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bar_id` (`bar_id`);

--
-- Index pour la table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD KEY `address_id` (`address_id`),
  ADD KEY `picture` (`picture`),
  ADD KEY `favorite_item` (`favorite_item`);

--
-- Index pour la table `user_good_time`
--
ALTER TABLE `user_good_time`
  ADD PRIMARY KEY (`id`),
  ADD KEY `good_time_id` (`good_time_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Index pour la table `user_group`
--
ALTER TABLE `user_group`
  ADD PRIMARY KEY (`id`),
  ADD KEY `group_id` (`group_id`),
  ADD KEY `user_id` (`user_id`);

--
-- AUTO_INCREMENT pour les tables exportées
--

--
-- AUTO_INCREMENT pour la table `address`
--
ALTER TABLE `address`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT pour la table `bar`
--
ALTER TABLE `bar`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT pour la table `bar_picture`
--
ALTER TABLE `bar_picture`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT pour la table `discount`
--
ALTER TABLE `discount`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `event`
--
ALTER TABLE `event`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `favorite_bar`
--
ALTER TABLE `favorite_bar`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `good_time`
--
ALTER TABLE `good_time`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `groups`
--
ALTER TABLE `groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `item`
--
ALTER TABLE `item`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `menu`
--
ALTER TABLE `menu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `menu_item`
--
ALTER TABLE `menu_item`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `notification`
--
ALTER TABLE `notification`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `picture`
--
ALTER TABLE `picture`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT pour la table `rating`
--
ALTER TABLE `rating`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `schedule`
--
ALTER TABLE `schedule`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `special_schedule`
--
ALTER TABLE `special_schedule`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;
--
-- AUTO_INCREMENT pour la table `user_good_time`
--
ALTER TABLE `user_good_time`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `user_group`
--
ALTER TABLE `user_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
