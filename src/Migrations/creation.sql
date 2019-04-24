DROP DATABASE goodtime;
CREATE DATABASE goodtime;

CREATE TABLE address (
  id INT NOT NULL AUTO_INCREMENT,
  num INT NOT NULL,
  street VARCHAR(255) NOT NULL,
  post_code INT NOT NULL,
  city VARCHAR(255) NOT NULL,
  latitude FLOAT,
  longitude FLOAT,

  PRIMARY KEY (id)
);

CREATE TABLE item (
  id INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  description TEXT DEFAULT NULL,
  is_food BOOLEAN DEFAULT false,
  contains_alcohol BOOLEAN DEFAULT false,
  contains_allergen BOOLEAN DEFAULT false,

  PRIMARY KEY (id)
);


CREATE TABLE menu (
  id INT NOT NULL AUTO_INCREMENT,
  bar_id INT NOT NULL,

  PRIMARY KEY (id),
  FOREIGN KEY (bar_id) REFERENCES bar(id)
);

CREATE TABLE menu_item (
   id INT NOT NULL AUTO_INCREMENT,
   menu_id INT NOT NULL,
   item_id INT NOT NULL,
   price FLOAT NOT NULL,

   is_deleted SMALLINT DEFAULT 0,

   PRIMARY KEY (id),
   FOREIGN KEY (menu_id) REFERENCES menu(id),
   FOREIGN KEY (item_id) REFERENCES item(id)
);

CREATE TABLE discount (
  id INT NOT NULL AUTO_INCREMENT,
  menu_item_id INT NOT NULL,
  amount INT NOT NULL, -- new price in EUR
  `start` TIMESTAMP DEFAULT NOW(),
  end TIMESTAMP NOT NULL,

  PRIMARY KEY (id),
  FOREIGN KEY (menu_item_id) REFERENCES menu_item(id)
);


CREATE TABLE picture (
  id INT NOT NULL AUTO_INCREMENT,
  path VARCHAR(150) NOT NULL,

  created_at TIMESTAMP DEFAULT NOW(),
  is_deleted SMALLINT DEFAULT 0,
  deleted_at TIMESTAMP DEFAULT NULL,

  PRIMARY KEY (id)
);

CREATE TABLE `user` (
  id INT NOT NULL AUTO_INCREMENT,
  mail VARCHAR(255) NOT NULL,
  `password` VARCHAR(50) NOT NULL,
  `name` VARCHAR(255) DEFAULT NULL,
  address_id INT DEFAULT NULL,
  phone VARCHAR(10) DEFAULT NULL,
  picture INT DEFAULT NULL,
  token VARCHAR(255) DEFAULT NULL, -- Facebook / Google connect

  favorite_item INT DEFAULT NULL,
  max_price FLOAT DEFAULT NULL,
  favorite_transportation SMALLINT DEFAULT NULL, -- pour lier l’api maps pour calculer la distance aux bar

  created_at TIMESTAMP DEFAULT NOW(),
  is_deleted SMALLINT DEFAULT 0,
  deleted_at TIMESTAMP DEFAULT NULL,

  PRIMARY KEY(id),
  FOREIGN KEY(address_id) REFERENCES address(id),
  FOREIGN KEY (picture) REFERENCES picture(id),
  FOREIGN KEY(favorite_item) REFERENCES item(id)
);
-- Mitzva, Raccuda, Omètre, Atin, Atineur, Beque, Bichette, Bapapa, Biturique, Boteur, Bouillage, Illa, Issement, Jot, Iton
CREATE TABLE bar (
  id INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  address_id INT NOT NULL,
  owner_id INT NOT NULL,
  phone VARCHAR(10) DEFAULT NULL,
  `type` INT DEFAULT NULL, -- (type = bières, cocktails, … Gérer avec clé étrangère + possibilité d’ajouter d’autres types ?)

  created_at TIMESTAMP DEFAULT NOW(),
  is_deleted SMALLINT DEFAULT 0,
  deleted_at TIMESTAMP DEFAULT NULL,

  PRIMARY KEY (id),
  FOREIGN KEY (address_id) REFERENCES address(id),
  FOREIGN KEY (owner_id) REFERENCES user(id)
);


CREATE TABLE bar_picture (
  id INT NOT NULL AUTO_INCREMENT,
  bar_id INT NOT NULL,
  picture_id INT NOT NULL,

  is_deleted INT DEFAULT 0,

  PRIMARY KEY (id),
  FOREIGN KEY (bar_id) REFERENCES bar(id),
  FOREIGN KEY (picture_id) REFERENCES picture(id)
);

CREATE TABLE schedule (
  id INT NOT NULL AUTO_INCREMENT,
  bar_id INT NOT NULL,
  weekday VARCHAR(3) NOT NULL,
  open BOOLEAN DEFAULT true,
  is_hh BOOLEAN DEFAULT false,
  hour TIME NOT NULL,
  notes TEXT DEFAULT NULL,

  PRIMARY KEY (id),
  FOREIGN KEY (bar_id) REFERENCES bar(id)
);

CREATE TABLE special_schedule (
  id INT NOT NULL AUTO_INCREMENT,
  bar_id INT NOT NULL,
  begin_date TIMESTAMP NOT NULL,
  end_date TIMESTAMP NOT NULL,
  new_opening_hour TIME DEFAULT NULL,
  new_closing_hour TIME DEFAULT NULL,
  is_just_closed BOOLEAN DEFAULT NULL,

  PRIMARY KEY (id),
  FOREIGN KEY (bar_id) REFERENCES bar(id)
);

CREATE TABLE `group` (
  id INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  created_by INT NOT NULL,

  is_deleted SMALLINT DEFAULT 0,
  deleted_at TIMESTAMP DEFAULT NULL,

  PRIMARY KEY (id),
  FOREIGN KEY (created_by) REFERENCES user(id)
);

CREATE TABLE user_group (
  id INT NOT NULL AUTO_INCREMENT,
  group_id INT NOT NULL,
  user_id INT NOT NULL,
  `status` VARCHAR(3) NOT NULL, -- WAI = invitation en attente, ACC = invitation acceptée, REF = invitation refusée)

  is_deleted SMALLINT DEFAULT 0,
  deleted_at TIMESTAMP DEFAULT NULL,

  PRIMARY KEY (id),
  FOREIGN KEY (group_id) REFERENCES `group`(id),
  FOREIGN KEY (user_id) REFERENCES user(id)
);

CREATE TABLE good_time (
  id INT NOT NULL AUTO_INCREMENT,
  bar_id INT NOT NULL,
  group_id INT NOT NULL,
  `date` TIMESTAMP DEFAULT NOW(),

  is_booking INT DEFAULT 0,
  number_of_people INT DEFAULT NULL,
  `status` VARCHAR(3) DEFAULT NULL, -- WAI = en attente, ACC = accepté, REf = refusé
  refusal_purpose TEXT DEFAULT NULL,

  created_at TIMESTAMP DEFAULT NOW(),
  created_by INT NOT NULL,
  updated_at TIMESTAMP DEFAULT NULL,
  updated_by INT DEFAULT NULL,
  deleted_at TIMESTAMP DEFAULT NULL,
  deleted_by INT DEFAULT NULL,

  PRIMARY KEY (id),
  FOREIGN KEY (bar_id) REFERENCES bar(id),
  FOREIGN KEY (group_id) REFERENCES `group`(id),
  FOREIGN KEY (created_by) REFERENCES user(id),
  FOREIGN KEY (updated_by) REFERENCES user(id),
  FOREIGN KEY (deleted_by) REFERENCES user(id)
);

-- TODO : Message si transport favori = voiture && is_sam = 0
-- Signaler Sam au barman
CREATE TABLE user_good_time (
  id INT NOT NULL AUTO_INCREMENT,
  good_time_id INT NOT NULL,
  user_id INT NOT NULL,
  `status` VARCHAR(3) DEFAULT 0, -- WAI = invitation en attente, ACC = invitation acceptée, REF = invitation refusée
  is_sam SMALLINT DEFAULT 0,

  is_deleted INT DEFAULT 0,

  PRIMARY KEY (id),
  FOREIGN KEY (good_time_id) REFERENCES good_time(id),
  FOREIGN KEY (user_id) REFERENCES user(id)
);

CREATE TABLE notification (
  id INT NOT NULL AUTO_INCREMENT,
  user_id INT NOT NULL,

  PRIMARY KEY (id),
  FOREIGN KEY (user_id) REFERENCES user(id)
);

CREATE TABLE rating (
  id INT NOT NULL AUTO_INCREMENT,
  bar_id INT NOT NULL,
  user_id INT NOT NULL,
  mark INT NOT NULL,
  `comment`  TEXT DEFAULT NULL,

  created_at TIMESTAMP DEFAULT NOW(),

  PRIMARY KEY (id),
  FOREIGN KEY (bar_id) REFERENCES bar(id),
  FOREIGN KEY (user_id) REFERENCES user(id)
);

CREATE TABLE `event` (
  id INT NOT NULL AUTO_INCREMENT,
  bar_id INT NOT NULL,
  `name` VARCHAR(150) NOT NULL,
  description TEXT DEFAULT NULL,
  `date` TIMESTAMP NOT NULL,

  created_at TIMESTAMP DEFAULT NOW(),
  created_by INT NOT NULL,
  updated_at TIMESTAMP DEFAULT NULL,
  updated_by INT DEFAULT NULL,
  deleted_at TIMESTAMP DEFAULT NULL,
  deleted_by INT DEFAULT NULL,

  PRIMARY KEY (id),
  FOREIGN KEY (bar_id) REFERENCES bar(id),
  FOREIGN KEY (created_by) REFERENCES user(id),
  FOREIGN KEY (updated_by) REFERENCES user(id),
  FOREIGN KEY (deleted_by) REFERENCES user(id)
);

CREATE TABLE favorite_bar (
  id INT NOT NULL AUTO_INCREMENT,
  bar_id INT NOT NULL,
  user_id INT NOT NULL,

  is_deleted SMALLINT DEFAULT 0,

  PRIMARY KEY (id),
  FOREIGN KEY (bar_id) REFERENCES bar(id),
  FOREIGN KEY (user_id) REFERENCES user(id)
)