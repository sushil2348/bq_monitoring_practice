# dbt-bq-monitoring-practice

A simplified dbt project to monitor BigQuery usage and metadata. This project is designed for learning and practice purposes, inspired by the `dbt-bigquery-monitoring` package.

---

## 📦 Project Overview

This project demonstrates how to:
- Set up a dbt project with BigQuery
- Monitor query jobs and table metadata
- Use dbt models to analyze BigQuery usage

---

## 🛠️ Prerequisites

- Python 3.7+
- A Google Cloud Project with BigQuery enabled
- A BigQuery dataset (e.g., `monitoring`)
- A service account key file with BigQuery access
- Git and GitHub account

---

## 🚀 Step-by-Step Setup

### 1. Create a GitHub Repository

1. Go to GitHub
2. Click **"New repository"**
3. Name it `dbt-bq-monitoring-practice`
4. Add a README file and create the repo

### 2. Clone the Repository Locally

```bash
git clone https://github.com/your-username/dbt-bq-monitoring-practice.git
cd dbt-bq-monitoring-practice

3. Set Up Python Environment
python -m venv dbt-env
# For Git Bash:
source dbt-env/Scripts/activate
# Or for Command Prompt:
dbt-env\Scripts\activate


4. Install dbt for BigQuery
pip install dbt-bigquery

5. Initialize dbt Project
dbt init bq_monitoring_practice

Choose:

Adapter: bigquery
Project name: bq_monitoring_practice
Dataset: monitoring

6. Configure profiles.yml
Edit C:\Users\<your-username>\.dbt\profiles.yml:

bq_monitoring_practice:
  target: dev
  outputs:
    dev:
      type: bigquery
      method: service-account
      project: your-gcp-project-id
      dataset: monitoring
      threads: 1
      keyfile: C:\path\to\your-service-account.json

7. Create Monitoring Models
Create a folder:
mkdir -p models/monitoring

models/monitoring/query_jobs.sql
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

models/monitoring/table_metadata.sql
SELECT
  table_schema,
  table_name,
  row_count,
  size_bytes / 1e6 AS size_mb,
  creation_time,
  last_modified_time
FROM
  `your-gcp-project-id`.`region-us`.INFORMATION_SCHEMA.TABLE_STORAGE

8. Run the Project
dbt debug   # Check connection
dbt run     # Build models

✅ Output
Two models will be created in your BigQuery dataset:
query_jobs
table_metadata
These help you monitor query usage and table sizes in your BigQuery environment.