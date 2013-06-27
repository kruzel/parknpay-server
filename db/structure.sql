CREATE TABLE `areas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `city_id` int(11) NOT NULL,
  `creditor_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_areas_on_city_id` (`city_id`),
  KEY `index_areas_on_creditor_id` (`creditor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `assets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `asset_file_name` varchar(255) DEFAULT NULL,
  `asset_content_type` varchar(255) DEFAULT NULL,
  `asset_file_size` int(11) DEFAULT NULL,
  `asset_updated_at` datetime DEFAULT NULL,
  `post_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

CREATE TABLE `cars` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `license_plate` varchar(255) NOT NULL,
  `car_description` varchar(255) NOT NULL,
  `car_image_file_name` varchar(255) DEFAULT NULL,
  `car_image_content_type` varchar(255) DEFAULT NULL,
  `car_image_file_size` int(11) DEFAULT NULL,
  `car_image_updated_at` datetime DEFAULT NULL,
  `archive` tinyint(1) DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_cars_on_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

CREATE TABLE `cities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `creditors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `bank_name` varchar(255) DEFAULT NULL,
  `bank_code` varchar(255) DEFAULT NULL,
  `bank_office` varchar(255) DEFAULT NULL,
  `bank_account` varchar(255) DEFAULT NULL,
  `contact_name` varchar(255) DEFAULT NULL,
  `contact_email` varchar(255) DEFAULT NULL,
  `contact_phone` varchar(255) DEFAULT NULL,
  `archive` tinyint(1) DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `payments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `x_pos` float DEFAULT NULL,
  `y_pos` float DEFAULT NULL,
  `street_id` int(11) NOT NULL,
  `area_id` int(11) NOT NULL,
  `city_id` int(11) NOT NULL,
  `creditor_id` int(11) NOT NULL,
  `rate_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `archive` tinyint(1) DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_payments_on_street_id` (`street_id`),
  KEY `index_payments_on_area_id` (`area_id`),
  KEY `index_payments_on_city_id` (`city_id`),
  KEY `index_payments_on_creditor_id` (`creditor_id`),
  KEY `index_payments_on_rate_id` (`rate_id`),
  KEY `index_payments_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `posts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `content` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

CREATE TABLE `rates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rate` float DEFAULT NULL,
  `currency` varchar(255) DEFAULT NULL,
  `area_id` int(11) NOT NULL,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `archive` tinyint(1) DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_rates_on_area_id` (`area_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `streets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `area_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_streets_on_area_id` (`area_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL DEFAULT '',
  `encrypted_password` varchar(255) NOT NULL DEFAULT '',
  `reset_password_token` varchar(255) DEFAULT NULL,
  `reset_password_sent_at` datetime DEFAULT NULL,
  `remember_created_at` datetime DEFAULT NULL,
  `sign_in_count` int(11) DEFAULT '0',
  `current_sign_in_at` datetime DEFAULT NULL,
  `last_sign_in_at` datetime DEFAULT NULL,
  `current_sign_in_ip` varchar(255) DEFAULT NULL,
  `last_sign_in_ip` varchar(255) DEFAULT NULL,
  `authentication_token` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `active` tinyint(1) DEFAULT '1',
  `role` varchar(255) DEFAULT 'user',
  `firstname` varchar(255) DEFAULT NULL,
  `lastname` varchar(255) DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `address_st` varchar(255) DEFAULT NULL,
  `address_state` varchar(255) DEFAULT NULL,
  `address_postcode` varchar(255) DEFAULT NULL,
  `address_country` varchar(255) DEFAULT NULL,
  `avatar_file_name` varchar(255) DEFAULT NULL,
  `avatar_content_type` varchar(255) DEFAULT NULL,
  `avatar_file_size` int(11) DEFAULT NULL,
  `avatar_updated_at` datetime DEFAULT NULL,
  `terms_of_service` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_users_on_email` (`email`),
  UNIQUE KEY `index_users_on_reset_password_token` (`reset_password_token`),
  UNIQUE KEY `index_users_on_authentication_token` (`authentication_token`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

INSERT INTO schema_migrations (version) VALUES ('20110205203002');

INSERT INTO schema_migrations (version) VALUES ('20110206230324');

INSERT INTO schema_migrations (version) VALUES ('20130615104042');

INSERT INTO schema_migrations (version) VALUES ('20130615113309');

INSERT INTO schema_migrations (version) VALUES ('20130615140934');

INSERT INTO schema_migrations (version) VALUES ('20130615142220');

INSERT INTO schema_migrations (version) VALUES ('20130615142802');

INSERT INTO schema_migrations (version) VALUES ('20130615143341');

INSERT INTO schema_migrations (version) VALUES ('20130615143540');

INSERT INTO schema_migrations (version) VALUES ('20130615144524');

INSERT INTO schema_migrations (version) VALUES ('20130617000000');

INSERT INTO schema_migrations (version) VALUES ('20130617145616');

INSERT INTO schema_migrations (version) VALUES ('20130622035050');

INSERT INTO schema_migrations (version) VALUES ('20130624125840');