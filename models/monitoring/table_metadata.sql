SELECT
  table_schema,
  table_name,
  row_count,
  size_bytes / 1e6 AS size_mb,
  creation_time,
  last_modified_time
FROM
  `your-gcp-project-id`.`region-us`.INFORMATION_SCHEMA.TABLE_STORAGE
