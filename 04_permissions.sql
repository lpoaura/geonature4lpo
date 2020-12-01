GRANT USAGE ON SCHEMA gn_meta, gn_synthese, ref_geo, ref_nomenclatures, ref_habitats, taxonomie TO commons
;

GRANT SELECT ON ALL TABLES IN SCHEMA gn_meta, gn_synthese, ref_geo, ref_nomenclatures, ref_habitats, taxonomie TO commons
;

GRANT SELECT ON ALL SEQUENCES IN SCHEMA gn_meta, gn_synthese, ref_geo, ref_nomenclatures, ref_habitats, taxonomie TO commons
;

GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA gn_meta, gn_synthese, ref_geo, ref_nomenclatures, ref_habitats, taxonomie TO commons
;


GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA
    gn_commons,
    gn_exports,
    gn_imports,
    gn_meta,
    gn_monitoring,
    gn_permissions,
    gn_sensitivity,
    gn_synthese,
    pr_occhab,
    pr_occtax,
    qgis_shared,
    ref_geo,
    ref_nomenclatures,
    ref_habitats,
    taxonomie ,
    utilisateurs
    TO advanced_user
;


ALTER DEFAULT PRIVILEGES IN SCHEMA
    gn_commons,
    gn_meta,
    gn_synthese,
    ref_geo,
    ref_nomenclatures,
    ref_habitats,
    taxonomie
    GRANT SELECT ON TABLES TO common_user;


/***************************
 *   UTILLSATEURS AVANCES  *
 ***************************/

/* INFO: Droits d'éxécution de COPY à "advanced_user" */

GRANT pg_read_server_files, pg_write_server_files, pg_execute_server_program TO advanced_user
;

GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA
    gn_commons,
    gn_exports,
    gn_imports,
    gn_meta,
    gn_monitoring,
    gn_permissions,
    gn_sensitivity,
    gn_synthese,
    pr_occhab,
    pr_occtax,
    qgis_shared,
    ref_geo,
    ref_nomenclatures,
    ref_habitats,
    taxonomie ,
    utilisateurs
    TO advanced_user
;


ALTER DEFAULT PRIVILEGES IN SCHEMA gn_commons,
    gn_exports,
    gn_imports,
    gn_meta,
    gn_monitoring,
    gn_permissions,
    gn_sensitivity,
    gn_synthese,
    pr_occhab,
    pr_occtax,
    qgis_shared,
    ref_geo,
    ref_nomenclatures,
    ref_habitats,
    taxonomie ,
    utilisateurs
    GRANT ALL PRIVILEGES ON TABLES TO advanced_user
;

