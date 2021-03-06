CREATE ROLE superadmin
    LOGIN
    SUPERUSER
    ENCRYPTED PASSWORD '<monpassachanger>'
;

CREATE ROLE lpo_advanced
    LOGIN
    ENCRYPTED PASSWORD '<monpassachanger>'
    NOSUPERUSER
    NOCREATEDB
    NOCREATEROLE
    NOREPLICATION
    INHERIT
    IN ROLE advanced_user
;


CREATE SCHEMA AUTHORIZATION lpo_advanced
;

ALTER ROLE lpo_advanced SET search_path TO "$user", public, topology
;

ALTER DEFAULT PRIVILEGES FOR ROLE lpo_advanced IN SCHEMA lpo_advanced
    REVOKE SELECT, INSERT, UPDATE, DELETE ON TABLES FROM lpo_advanced
;

ALTER DEFAULT PRIVILEGES FOR ROLE lpo_advanced IN SCHEMA lpo_advanced
    GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO lpo_advanced
;

CREATE ROLE lpo_basic
    LOGIN
    ENCRYPTED PASSWORD '<monpassachanger>'
    NOSUPERUSER
    NOCREATEDB
    NOCREATEROLE
    NOREPLICATION
    INHERIT
    IN ROLE common_user
;

CREATE SCHEMA AUTHORIZATION lpo_basic
;

ALTER ROLE lpo_basic SET search_path TO "$user", public, topology
;

ALTER DEFAULT PRIVILEGES FOR ROLE lpo_basic IN SCHEMA lpo_basic
    REVOKE SELECT, INSERT, UPDATE, DELETE ON TABLES FROM lpo_basic
;

ALTER DEFAULT PRIVILEGES FOR ROLE lpo_basic IN SCHEMA lpo_basic
    GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO lpo_basic
;

