
/* Créée le schéma de partage QGIS */
create schema qgis_shared ;

/* Applique les droits pour les tables existantes */
grant usage on schema qgis_shared to qgis_shared;
-- grant select on all tables in schema qgis_shared to qgis_shared;

/* Applique des droits par défaut pour les nouvelles tables et fonctions */
alter default privileges in schema qgis_shared revoke all privileges on tables from qgis_shared;
alter default privileges in schema qgis_shared grant select on tables to qgis_shared;
alter default privileges in schema qgis_shared grant execute on functions to qgis_shared;



/* Création d'une table unique et partagée "qgis_shared.layer_styles" */

CREATE TABLE qgis_shared.layer_styles
(
  id                SERIAL PRIMARY KEY,
  f_table_catalog   VARCHAR,
  f_table_schema    VARCHAR,
  f_table_name      VARCHAR,
  f_geometry_column VARCHAR,
  stylename         VARCHAR(30),
  styleqml          XML,
  stylesld          XML,
  useasdefault      BOOLEAN,
  description       TEXT,
  owner             VARCHAR(30),
  ui                XML,
  update_time       TIMESTAMP DEFAULT now()
);

/* Création automatique des vues pour chacun des utilisateurs dans leurs dossiers respectifs */

CREATE OR REPLACE
FUNCTION public.refresh_layerstyles_user_view()
  RETURNS VOID LANGUAGE plpgsql AS
$func$
DECLARE
  username TEXT;
BEGIN
  RAISE NOTICE 'Création des vues de layer_styles';
  FOR username IN SELECT u.usename
                  FROM pg_catalog.pg_user u
                  WHERE u.usename LIKE 'lpo%' LOOP
    RAISE NOTICE 'Création de la vue %.layer_styles et des règles inhérentes', username;
    EXECUTE format('DROP VIEW IF EXISTS %I.layer_styles;', username);
    RAISE NOTICE 'Vue supprimée';
    EXECUTE format('CREATE VIEW %I.layer_styles AS SELECT * FROM qgis_shared.layer_styles;'
    , username);
    RAISE NOTICE 'Vue créée';
    EXECUTE format(
        'DROP RULE IF EXISTS %s_layer_style_ins ON %I.layer_styles; ', username, username);
    RAISE NOTICE 'Règle insert supprimée';
    EXECUTE format(
        'CREATE RULE %s_layer_style_ins AS ON INSERT TO %I.layer_styles ' ||
        ' DO INSTEAD ' ||
        '   INSERT INTO qgis_shared.layer_styles (' ||
        '       f_table_catalog, f_table_schema, f_table_name, f_geometry_column, stylename, styleqml, ' ||
        '       stylesld, useasdefault, description, owner, ui) ' ||
        '   VALUES (NEW.f_table_catalog,NEW.f_table_schema,NEW.f_table_name,NEW.f_geometry_column,NEW.stylename,' ||
        '       NEW.styleqml,NEW.stylesld,NEW.useasdefault,NEW.description,NEW.owner,NEW.ui);',
        username, username);
    RAISE NOTICE 'Règle insert créée';
    EXECUTE format('DROP RULE IF EXISTS %s_layer_style_upd ON %I.layer_styles;', username, username);
    RAISE NOTICE 'Règle update supprimée';
    EXECUTE format('CREATE RULE %s_layer_style_upd AS ON UPDATE TO %I.layer_styles ' ||
                   'DO INSTEAD ' ||
                   'UPDATE qgis_shared.layer_styles ' ||
                   'SET ' ||
                   '  useasdefault = NEW.useasdefault,' ||
                   '  styleqml     = NEW.styleqml,' ||
                   '  stylesld     = NEW.stylesld,' ||
                   '  description  = NEW.description,' ||
                   '  owner        = NEW.owner ' ||
                   'WHERE f_table_catalog = OLD.f_table_catalog ' ||
                   '      AND f_table_schema = OLD.f_table_schema ' ||
                   '      AND f_table_name = OLD.f_table_name ' ||
                   '      AND f_geometry_column = OLD.f_geometry_column ' ||
                   '      AND stylename = OLD.stylename;', username, username);
    RAISE NOTICE 'Règle update créée';
    EXECUTE format(
        'DROP RULE IF EXISTS %s_layer_style_del ON %I.layer_styles;', username, username);
    RAISE NOTICE 'Règle delete créée';
    EXECUTE format(
        'CREATE RULE %s_layer_style_del AS ON DELETE TO %I.layer_styles DO INSTEAD DELETE FROM qgis_shared.layer_styles WHERE id = OLD.id;',
        username, username);
    RAISE NOTICE 'Règle delete créée';
    EXECUTE format('GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE %I.layer_styles TO %s', username, username);
    RAISE NOTICE 'Grant mise à jour';
  END LOOP;

END
$func$;

SELECT refresh_layerstyles_user_view();