/*
Question: What skills are required for the top-paying data analyst jobs?

Helping job seekers understand which skills to develop that align with top salaries
*/

WITH top_paying_jobs AS (
    SELECT 
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM
        job_postings_fact
    LEFT JOIN
        company_dim ON company_dim.company_id = job_postings_fact.company_id
    WHERE
        job_location = 'Anywhere' AND
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL
    ORDER BY 
        salary_year_avg DESC
    LIMIT 10
)

SELECT
    top_paying_jobs.*,
    skills_dim.skills 
FROM 
    top_paying_jobs
INNER JOIN
    skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN
    skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
ORDER BY 
    salary_year_avg DESC;


/*
Based on my analysis of the top-paying data analyst roles, here are the key insights:

Core Skills Required for Top Data Analyst Positions:
1. SQL is the most essential skill, appearing in 100% of these high-paying jobs. This confirms SQL remains the foundation of data analysis work.
2. Python is the second most requested skill (87.5% of jobs), reflecting its dominance for data manipulation and analysis.
3. Tableau appears in 75% of listings, highlighting the critical importance of data visualization skills.
4. R is still relevant in high-paying roles (50% of listings), though less common than Python.
5. Cloud technologies (AWS, Azure) appear frequently, suggesting cloud-based data work is increasingly valuable.

*/
