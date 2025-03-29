/*
Question: What are the top skills based on salary?

helps identify the most financially rewarding skills to acquire or improve
*/

SELECT
    skills,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM
    job_postings_fact
INNER JOIN
    skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN
    skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE
    salary_year_avg IS NOT NULL AND
    job_title_short = 'Data Analyst' AND
    job_work_from_home = True
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 25;

/*

Here are key insights from the top 25 data analyst skills by avg salary:

Top 5 High-Paying Skills:
1. Pyspark - $208,172
2. Bitbucket - $189,155
3. Couchbase - $160,515
4. Watson - $160,515
5. Datarobot - $155,486

Trends:
- Big data tools (Pyspark, Databricks) and AI/ML (Watson, Datarobot, Scikit-learn) command high salaries.
- Version control (Bitbucket, Gitlab) and dev tools (Jupyter, Jenkins) are well-paid.
- Python-related skills (Pandas, Numpy) are prominent and lucrative.

Notable: Pyspark stands out with a ~$19k gap over the next highest skill (Bitbucket).

*/