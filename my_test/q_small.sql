-- CREATE TEMP TABLE company_type AS SELECT * FROM 'data/job_company_type.parquet';
-- CREATE  TABLE complete_cast AS SELECT * FROM 'job_complete_cast.parquet';
-- CREATE TEMP TABLE info_type AS SELECT * FROM 'data/job_info_type.parquet';
-- CREATE  TABLE keyword AS SELECT * FROM 'job_keyword.parquet';
-- CREATE  TABLE kind_type AS SELECT * FROM 'job_kind_type.parquet';
-- CREATE  TABLE link_type AS SELECT * FROM 'job_link_type.parquet';
-- CREATE TEMP TABLE movie_companies AS SELECT * FROM 'data/job_movie_companies.parquet';
-- CREATE  TABLE movie_info AS SELECT * FROM 'job_movie_info.parquet';
-- CREATE TEMP TABLE movie_info_idx AS SELECT * FROM 'data/job_movie_info_idx.parquet';
-- CREATE  TABLE movie_keyword AS SELECT * FROM 'job_movie_keyword.parquet';
-- CREATE  TABLE movie_link AS SELECT * FROM 'job_movie_link.parquet';
-- CREATE  TABLE name AS SELECT * FROM 'job_name.parquet';
-- CREATE  TABLE person_info AS SELECT * FROM 'job_person_info.parquet';
-- CREATE  TABLE role_type AS SELECT * FROM 'job_role_type.parquet';
-- CREATE TEMP TABLE title AS SELECT * FROM 'data/job_title.parquet';

SELECT MIN(mc.note) AS production_note,
       MIN(t.title) AS movie_title,
       MIN(t.production_year) AS movie_year
FROM company_type AS ct,
     info_type AS it,
     movie_companies AS mc,
     movie_info_idx AS mi_idx,
     title AS t
WHERE ct.kind = 'production companies'
  AND it.info = 'top 250 rank'
  AND mc.note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%'
  AND (mc.note LIKE '%(co-production)%'
       OR mc.note LIKE '%(presents)%')
  AND ct.id = mc.company_type_id
  AND t.id = mc.movie_id
  AND t.id = mi_idx.movie_id
  AND mc.movie_id = mi_idx.movie_id
  AND it.id = mi_idx.info_type_id;
