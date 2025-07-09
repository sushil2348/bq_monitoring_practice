SELECT
  user_email,
  job_id,
  creation_time,
  start_time,
  end_time,
  total_bytes_processed / 1e9 AS gb_processed,
  statement_type
FROM
  `region-us`.INFORMATION_SCHEMA.JOBS_BY_PROJECT
WHERE
  creation_time >= TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 1 DAY)
  AND state = 'DONE'
