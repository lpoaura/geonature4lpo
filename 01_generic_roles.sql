/* INFO; Rôle data_lpo pour l'accès aux données naturalistes du réseau LPO */
CREATE ROLE datas_lpo
    NOLOGIN
    NOSUPERUSER
    NOCREATEDB
    NOCREATEROLE
    NOREPLICATION
    INHERIT;

COMMENT ON ROLE datas_lpo IS 'Rôle générique d''accès aux données naturalistes du réseau LPO';

/* INFO; Rôle commons pour l'accès aux ressources partagées */
CREATE ROLE commons
    NOLOGIN
    NOSUPERUSER
    NOCREATEDB
    NOCREATEROLE
    NOREPLICATION
    INHERIT;

COMMENT ON ROLE commons IS 'Rôle générique d''accès aux données partagées (référentiels, limites administratives, etc.)';

/* INFO: Rôle générique de partage des ressources QGIS (modèles, styles)*/
CREATE ROLE qgis_shared
    NOLOGIN
    NOSUPERUSER
    NOCREATEDB
    NOCREATEROLE
    NOREPLICATION
    NOINHERIT;

COMMENT ON ROLE qgis_shared IS 'Rôle générique de partage des ressources QGIS (modèles, styles)';

/* INFO; Rôle common_user pour l'accès en écriture aux ressources partagées et en lecture/écriture à son propre schéma */
CREATE ROLE common_user
    NOLOGIN
    NOSUPERUSER
    NOCREATEDB
    NOCREATEROLE
    NOREPLICATION
    INHERIT;

COMMENT ON ROLE common_user IS 'Rôle générique des utilisateurs courants (accès en lecture/écriture à son propre schéma et en lecture aux ressources partagées';

GRANT datas_lpo, commons, qgis_shared TO common_user;


CREATE ROLE advanced_user
    NOLOGIN
    NOSUPERUSER
    NOCREATEDB
    NOCREATEROLE
    NOREPLICATION
    INHERIT;

COMMENT ON ROLE advanced_user IS 'Rôle générique des utilisateurs avancés (accès en lecture / écriture à son propre schéma et aux ressources partagées)';

GRANT common_user TO advanced_user;