DEF section_id = '2b';
DEF section_name = 'Plan Control';
EXEC DBMS_APPLICATION_INFO.SET_MODULE('&&sqld360_prefix.','&&section_id.');
SPO &&sqld360_main_report..html APP;
PRO <h2>&&section_id.. &&section_name.</h2>
PRO <ol start="&&report_sequence.">
SPO OFF;

COL sql_text NOPRI

DEF title = 'SQL Profiles';
DEF main_table = 'DBA_SQL_PROFILES';
BEGIN
  :sql_text := '
SELECT /*+ &&top_level_hints. */
       * 
  FROM dba_sql_profiles 
 WHERE signature IN ( &&exact_matching_signature. , &&force_matching_signature. ) 
   AND ''&&tuning_pack.'' = ''Y''
 ORDER BY category, name
';
END;
/
@@sqld360_9a_pre_one.sql

COL sql_text PRI



COL sql_text NOPRI

DEF title = 'SQL Plan Baselines';
DEF main_table = 'DBA_SQL_PLAN_BASELINES';
BEGIN
  :sql_text := '
SELECT /*+ &&top_level_hints. */
       * 
  FROM dba_sql_plan_baselines
 WHERE signature IN ( &&exact_matching_signature. , &&force_matching_signature. ) 
 ORDER BY plan_name
';
END;
/
@@sqld360_9a_pre_one.sql

COL sql_text PRI



COL sql_text NOPRI

DEF title = 'SQL Patches';
DEF main_table = 'DBA_SQL_PATCHES';
BEGIN
  :sql_text := '
SELECT /*+ &&top_level_hints. */
       * 
  FROM dba_sql_patches
 WHERE signature IN ( &&exact_matching_signature. , &&force_matching_signature. ) 
 ORDER BY category, name
';
END;
/
@@sqld360_9a_pre_one.sql

COL sql_text PRI


DEF title = 'SQL Plan Directives';
DEF main_table = 'DBA_SQL_PLAN_DIR_OBJECTS';
BEGIN
  :sql_text := '
SELECT /*+ &&top_level_hints. */
       * 
  FROM dba_sql_plan_directives
 WHERE directive_id IN (SELECT directive_id
                          FROM dba_sql_plan_dir_objects
                         WHERE (owner, object_name) in &&tables_list.) 
 ORDER BY directive_id
';
END;
/
@@&&skip_10g.&&skip_11g.sqld360_9a_pre_one.sql


DEF title = 'SQL Plan Directives Objects';
DEF main_table = 'DBA_SQL_PLAN_DIR_OBJECTS';
BEGIN
  :sql_text := '
SELECT /*+ &&top_level_hints. */
       * 
  FROM dba_sql_plan_dir_objects
 WHERE (owner, object_name) in &&tables_list. 
 ORDER BY owner, object_name, directive_id
';
END;
/
@@&&skip_10g.&&skip_11g.sqld360_9a_pre_one.sql


COL ADDRESS NOPRI

DEF title = 'SQL ReOptimization Hints';
DEF main_table = 'GV$SQL_REOPTIMIZATION_HINTS';
BEGIN
  :sql_text := '
SELECT /*+ &&top_level_hints. */
       * 
  FROM gv$sql_reoptimization_hints
 WHERE sql_id = ''&&sqld360_sqlid.'' 
 ORDER BY inst_id, child_number, hint_id
';
END;
/
@@&&skip_10g.&&skip_11g.sqld360_9a_pre_one.sql

COL ADDRESS PRI

SPO &&sqld360_main_report..html APP;
PRO </ol>
SPO OFF;