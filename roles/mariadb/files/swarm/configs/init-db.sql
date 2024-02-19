CREATE DATABASE IF NOT EXISTS app;
CREATE DATABASE IF NOT EXISTS app_proxy;
CREATE DATABASE IF NOT EXISTS app_proxy_log;
CREATE DATABASE IF NOT EXISTS app_ptz;
CREATE DATABASE IF NOT EXISTS app_snapshot;
CREATE DATABASE IF NOT EXISTS app_token;
CREATE DATABASE IF NOT EXISTS app_url;
CREATE DATABASE IF NOT EXISTS app_video;
CREATE DATABASE IF NOT EXISTS parser;
CREATE DATABASE IF NOT EXISTS parser_history;
CREATE DATABASE IF NOT EXISTS parser_dictionary;
CREATE DATABASE IF NOT EXISTS ks;
CREATE DATABASE IF NOT EXISTS app_eis;
CREATE DATABASE IF NOT EXISTS schedule;
CREATE DATABASE IF NOT EXISTS app_amq;


GRANT ALL PRIVILEGES ON app.* TO app@'%' IDENTIFIED BY 'sqlsql';
GRANT ALL PRIVILEGES ON app_proxy.* TO app@'%' IDENTIFIED BY 'sqlsql';
GRANT ALL PRIVILEGES ON app_proxy_log.* TO app@'%' IDENTIFIED BY 'sqlsql';
GRANT ALL PRIVILEGES ON app_ptz.* TO app@'%' IDENTIFIED BY 'sqlsql';
GRANT ALL PRIVILEGES ON app_snapshot.* TO app@'%' IDENTIFIED BY 'sqlsql';
GRANT ALL PRIVILEGES ON app_token.* TO app@'%' IDENTIFIED BY 'sqlsql';
GRANT ALL PRIVILEGES ON app_url.* TO app@'%' IDENTIFIED BY 'sqlsql';
GRANT ALL PRIVILEGES ON app_video.* TO app@'%' IDENTIFIED BY 'sqlsql';
GRANT ALL PRIVILEGES ON parser.* TO app@'%' IDENTIFIED BY 'sqlsql';
GRANT ALL PRIVILEGES ON parser_history.* TO app@'%' IDENTIFIED BY 'sqlsql';
GRANT ALL PRIVILEGES ON parser_dictionary.* TO app@'%' IDENTIFIED BY 'sqlsql';
GRANT ALL PRIVILEGES ON ks.* TO app@'%' IDENTIFIED BY 'sqlsql';
GRANT ALL PRIVILEGES ON app_eis.* TO app@'%' IDENTIFIED BY 'sqlsql';
GRANT ALL PRIVILEGES ON schedule.* TO app@'%' IDENTIFIED BY 'sqlsql';
GRANT ALL PRIVILEGES ON app_amq.* to app@'%' IDENTIFIED BY 'sqlsql';


CREATE DATABASE IF NOT EXISTS apdb CHARACTER SET UTF8 COLLATE UTF8_GENERAL_CI;
USE apdb;
CREATE TABLE IF NOT EXISTS t_user (username VARCHAR(32) NOT NULL, password VARCHAR(128) NOT NULL, isActive BIT(1) NOT NULL, PRIMARY KEY (username));
CREATE TABLE IF NOT EXISTS t_role (id int(11) NOT NULL AUTO_INCREMENT, username VARCHAR(32) NOT NULL, rolename VARCHAR(32) NOT NULL, PRIMARY KEY (id), UNIQUE KEY uk_username_rolename_idx (rolename, username), KEY fk_username_idx (username), CONSTRAINT fk_username FOREIGN KEY (username) REFERENCES t_user (username));
GRANT ALL PRIVILEGES ON apdb.* TO ap@'%' IDENTIFIED BY 'ap';
INSERT INTO t_user(username, password, isActive) VALUES ('sa','$2a$10$qpPruz.SzFS.aZDUr0pgtOB3hAAuh3jYByPZGiqjLnch7Tu1zKW/q', true); #sa qweasd123
INSERT INTO t_user(username, password, isActive) VALUES ('user','$2a$10$qpPruz.SzFS.aZDUr0pgtOB3hAAuh3jYByPZGiqjLnch7Tu1zKW/q', true);
INSERT INTO t_role (username, rolename) VALUES ('user', 'ROLE_USER');
INSERT INTO t_role (username, rolename) VALUES ('sa', 'ROLE_USER');
INSERT INTO t_role (username, rolename) VALUES ('sa', 'ROLE_ADMIN');
