CREATE TABLE IF NOT EXISTS taxonomie.cor_c_vn_taxref
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


CREATE VIEW taxonomie.v_c_cor_vn_taxref AS
WITH
    prep_vn AS (
        SELECT DISTINCT
            species.id               AS vn_id
          , taxo_groups.name         AS groupe_taxo_fr
          , taxo_groups.latin_name   AS groupe_taxo_sci
          , species.french_name
          , species.latin_name
          , bool_or(species.is_used) AS is_used
            FROM
                (src_vn.species
                    LEFT JOIN src_vn.taxo_groups ON (((species.id_taxo_group = taxo_groups.id) AND
                                                      ((species.site)::TEXT = (taxo_groups.site)::TEXT))))
            GROUP BY species.id, taxo_groups.name, taxo_groups.latin_name, species.french_name, species.latin_name
    )
SELECT
    vn.vn_id
  , vn.groupe_taxo_fr
  , vn.groupe_taxo_sci
  , vn.french_name AS vn_nom_fr
  , vn.latin_name  AS vn_nom_sci
  , tx.cd_nom
  , tx.group1_inpn AS tx_group1_inpn
  , tx.group2_inpn AS tx_group2_inpn
  , tx.classe      AS tx_classe
  , tx.famille     AS tx_famille
  , tx.nom_vern    AS tx_nom_fr
  , tx.lb_nom      AS tx_nom_sci
  , vn.is_used     AS vn_utilisation
    FROM
        ((prep_vn vn
            LEFT JOIN taxonomie.cor_c_vn_taxref corr ON ((vn.vn_id = corr.vn_id)))
            LEFT JOIN taxonomie.taxref tx ON ((corr.taxref_id = tx.cd_nom)))
;

