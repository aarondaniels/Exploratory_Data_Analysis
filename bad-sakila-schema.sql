-- Bad Sakila breaks many database design rules on purpose
-- Adapted from Sakila Sample Database Schema


DROP SCHEMA IF EXISTS bad_sakila;
CREATE SCHEMA bad_sakila;
USE bad_sakila;

SET NAMES UTF8MB4;
SET character_set_client = UTF8MB4;


-- --------------------------------------
-- TABLE ACTOR
-- --------------------------------------

CREATE TABLE actor (
  actor_id          SMALLINT UNSIGNED NULL ,
  first_name        VARCHAR(45) NULL,
  last_name         VARCHAR(45) NULL,
  last_update       TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------
-- TABLE ADDRESS
-- --------------------------------------

CREATE TABLE address (
  address_id        SMALLINT UNSIGNED NULL ,
  address           VARCHAR(50) NULL,
  address2          VARCHAR(50) DEFAULT NULL,
  district          VARCHAR(20) NULL,
  city_id           SMALLINT UNSIGNED NULL,
  postal_code       VARCHAR(10) DEFAULT NULL,
  phone             VARCHAR(20) NULL,
  last_update       TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------
-- TABLE CATEGORY
-- --------------------------------------

CREATE TABLE category (
  category_id       TINYINT UNSIGNED NULL ,
  name              VARCHAR(25) NULL,
  last_update       TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------
-- TABLE CITY
-- --------------------------------------

CREATE TABLE city (
  city_id           SMALLINT UNSIGNED NULL ,
  city              VARCHAR(50) NULL,
  country_id        SMALLINT UNSIGNED NULL,
  last_update       TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------
-- TABLE COUNTRY
-- --------------------------------------

CREATE TABLE country (
  country_id        SMALLINT UNSIGNED NULL ,
  country           VARCHAR(50) NULL,
  last_update       TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------
-- TABLE CUSTOMER
-- --------------------------------------

CREATE TABLE customer (
  customer_id       SMALLINT UNSIGNED NULL ,
  store_id          TINYINT UNSIGNED NULL,
  first_name        VARCHAR(45) NULL,
  last_name         VARCHAR(45) NULL,
  email             VARCHAR(50) DEFAULT NULL,
  gender            VARCHAR(35) DEFAULT 'female',  
  birthdate         DATETIME NULL,  
  address_id        SMALLINT UNSIGNED NULL,
  active            BOOLEAN NULL DEFAULT TRUE,
  create_date       DATETIME NULL,
  last_update       TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------
-- TABLE FILM
-- --------------------------------------

CREATE TABLE film (
  film_id           SMALLINT UNSIGNED NULL ,
  title             VARCHAR(128) NULL,
  description       TEXT DEFAULT NULL,
  release_year      YEAR DEFAULT NULL,
  language_id       TINYINT UNSIGNED NULL,
  original_language_id TINYINT UNSIGNED DEFAULT NULL,
  rental_duration    TINYINT UNSIGNED NULL DEFAULT 3,
  rental_rate       DECIMAL(4,2) NULL DEFAULT 4.99,
  length            SMALLINT UNSIGNED DEFAULT NULL,
  replacement_cost  DECIMAL(5,2) NULL DEFAULT 19.99,
  rating            ENUM('G','PG','PG-13','R','NC-17') DEFAULT 'G',
  special_features  SET('Trailers','Commentaries','Deleted Scenes','Behind the Scenes') DEFAULT NULL,
  last_update       TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------
-- TABLE FILM_ACTOR
-- --------------------------------------

CREATE TABLE film_actor (
  actor_id          SMALLINT UNSIGNED NULL,
  film_id           SMALLINT UNSIGNED NULL,
  last_update       TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------
-- TABLE FILM_CATEGORY
-- --------------------------------------

CREATE TABLE film_category (
  film_id           SMALLINT UNSIGNED NULL,
  category_id       TINYINT UNSIGNED NULL,
  last_update       TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- --------------------------------------
-- TABLE FILM_TEXT
-- --------------------------------------

CREATE TABLE film_text (
  film_id           SMALLINT NULL,
  title             VARCHAR(255) NULL,
  description       TEXT
) DEFAULT CHARSET=utf8mb4;



--
-- Triggers for loading film_text from film
--

DELIMITER ;;
CREATE TRIGGER `ins_film` AFTER INSERT ON `film` FOR EACH ROW BEGIN
    INSERT INTO film_text (film_id, title, description)
        VALUES (new.film_id, new.title, new.description);
  END;;


CREATE TRIGGER `upd_film` AFTER UPDATE ON `film` FOR EACH ROW BEGIN
    IF (old.title != new.title) OR (old.description != new.description) OR (old.film_id != new.film_id)
    THEN
        UPDATE film_text
            SET title=new.title,
                description=new.description,
                film_id=new.film_id
        WHERE film_id=old.film_id;
    END IF;
  END;;


CREATE TRIGGER `del_film` AFTER DELETE ON `film` FOR EACH ROW BEGIN
    DELETE FROM film_text WHERE film_id = old.film_id;
  END;;

DELIMITER ;



-- --------------------------------------
-- TABLE INVENTORY
-- --------------------------------------

CREATE TABLE inventory (
  inventory_id      MEDIUMINT UNSIGNED NULL ,
  film_id           SMALLINT UNSIGNED NULL,
  store_id          TINYINT UNSIGNED NULL,
  last_update       TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------
-- TABLE LANGUAGE
-- --------------------------------------

CREATE TABLE language (
  language_id       TINYINT UNSIGNED NULL ,
  name              CHAR(20) NULL,
  last_update       TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------
-- TABLE PAYMENT
-- --------------------------------------

CREATE TABLE payment (
  payment_id        SMALLINT UNSIGNED NULL ,
  customer_id       SMALLINT UNSIGNED NULL,
  staff_id          TINYINT UNSIGNED NULL,
  rental_id         INT DEFAULT NULL,
  amount            DECIMAL(5,2) NULL,
  payment_date      DATETIME NULL,
  last_update       TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- --------------------------------------
-- TABLE RENTAL
-- --------------------------------------

CREATE TABLE rental (
  rental_id         INT NULL ,
  rental_date       DATETIME NULL,
  inventory_id      MEDIUMINT UNSIGNED NULL,
  customer_id       SMALLINT UNSIGNED NULL,
  return_date       DATETIME DEFAULT NULL,
  staff_id          TINYINT UNSIGNED NULL,
  last_update       TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------
-- TABLE STAFF
-- --------------------------------------

CREATE TABLE staff (
  staff_id          TINYINT UNSIGNED NULL ,
  first_name        VARCHAR(45) NULL,
  last_name         VARCHAR(45) NULL,
  address_id        SMALLINT UNSIGNED NULL,
  picture           BLOB DEFAULT NULL,
  email             VARCHAR(50) DEFAULT NULL,
  store_id          TINYINT UNSIGNED NULL,
  active            BOOLEAN NULL DEFAULT TRUE,
  username          VARCHAR(16) NULL,
  password          VARCHAR(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  last_update       TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------
-- TABLE STORE
-- --------------------------------------

CREATE TABLE store (
  store_id          TINYINT UNSIGNED NULL ,
  manager_staff_id  TINYINT UNSIGNED NULL,
  address_id        SMALLINT UNSIGNED NULL,
  last_update       TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

