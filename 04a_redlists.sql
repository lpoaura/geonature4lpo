SET ROLE geonatadmin
;

CREATE TABLE taxonomie.bib_c_redlist_categories
(
    code_category  VARCHAR(2) PRIMARY KEY,
    sup_category   VARCHAR(30),
    threatened     BOOLEAN DEFAULT FALSE,
    priority_order INT,
    name_fr        VARCHAR(100),
    desc_fr        VARCHAR(254),
    name_en        VARCHAR(100),
    desc_en        VARCHAR(254)
)
;


COMMENT ON TABLE taxonomie.bib_c_redlist_categories IS 'Red List categories dictionnary.'
;



CREATE TABLE taxonomie.bib_c_redlist_source
(
    id_redlist_source SERIAL PRIMARY KEY,
    name_source       VARCHAR(254),
    desc_source       TEXT,
    url_source        VARCHAR(254),
    context           VARCHAR(50),
    area_name         VARCHAR(50),
    area_code         VARCHAR(50),
    area_type         VARCHAR(50),
    priority          INTEGER
)
;


COMMENT ON TABLE taxonomie.bib_c_redlist_source IS 'Red List sources dictionnary.'
;



CREATE TABLE taxonomie.t_c_redlist
(
    id_redlist   SERIAL  NOT NULL PRIMARY KEY,
    status_order INTEGER,
    cd_nom       INTEGER REFERENCES taxonomie.taxref (cd_nom),
    cd_ref       INTEGER REFERENCES taxonomie.taxref (cd_nom),
    category     CHAR(2) NOT NULL REFERENCES taxonomie.bib_taxref_categories_lr (id_categorie_france),
    criteria     VARCHAR(50),
    id_source    INTEGER REFERENCES taxonomie.bib_c_redlist_source (id_redlist_source)
)
;



COMMENT ON TABLE taxonomie.t_c_redlist IS 'Red List status table - with associated taxon, category and source.'
;



COMMENT ON COLUMN taxonomie.t_c_redlist.cd_nom IS 'Link to taxonomie.taxref'
;



COMMENT ON COLUMN taxonomie.t_c_redlist.category IS 'Link to bib_redlist_categories'
;



COMMENT ON COLUMN taxonomie.t_c_redlist.id_source IS 'Link to bib_redlist_source'
;

CREATE TABLE taxonomie.cor_c_redlist_source_area
(
    id_cor_redlist_source_area SERIAL PRIMARY KEY,
    id_area                    INTEGER REFERENCES ref_geo.l_areas (id_area),
    id_redlist_source          INTEGER REFERENCES taxonomie.bib_c_redlist_source (id_redlist_source)
)
;


COMMENT ON TABLE taxonomie.cor_c_redlist_source_area IS 'Correlation between RedList sources (bib_redlist_source) and areas (ref_geo.l_areas) : defines where Red List sources apply.'
;



COMMENT ON COLUMN taxonomie.cor_c_redlist_source_area.id_area IS 'Link to ref_geo.l_areas'
;



COMMENT ON COLUMN taxonomie.cor_c_redlist_source_area.id_redlist_source IS 'Link to bib_redlist_source'
;




CREATE TABLE IF NOT EXISTS  taxonomie.cor_c_vn_taxref
(
    id_cor_c_vn_taxref SERIAL PRIMARY KEY,
    vn_id              INTEGER,
    taxref_id          INTEGER
)
;



COMMENT ON TABLE taxonomie.cor_c_vn_taxref IS 'Correlation between taxref cd_nom (taxref) and VisioNature species id (src_vn.species).'
;



COMMENT ON COLUMN taxonomie.cor_c_vn_taxref.vn_id IS 'Link to src_vn.species'
;



COMMENT ON COLUMN taxonomie.cor_c_vn_taxref.taxref_id IS 'Link to taxonomie.taxref'
;

