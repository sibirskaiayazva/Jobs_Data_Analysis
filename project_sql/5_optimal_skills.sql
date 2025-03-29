/*
Question: What are the most optimal skills to learn (aka it’s in high demand and a high-paying skill)?
Targets skills that offer job security (high demand) and financial benefits (high salaries), 
offering strategic insights for career development in data analysis
*/

WITH skills_demand AS (
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(*) AS demand_count
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
        skills_dim.skill_id
),

avg_salary AS (
    SELECT
        skills_job_dim.skill_id,
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
        skills_job_dim.skill_id
)

SELECT
    skills_demand.skills,
    demand_count,
    avg_salary
FROM
    skills_demand
INNER JOIN
    avg_salary ON skills_demand.skill_id = avg_salary.skill_id
WHERE
    demand_count > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;

/*
Top 10 Data Analyst Skills by Avg Salary  
1. go - $115,320 (27 mentions)  
2. confluence - $114,210 (11 mentions)  
3. hadoop - $113,193 (22 mentions)  
4. snowflake - $112,948 (37 mentions)  
5. azure - $111,225 (34 mentions)  
6. bigquery - $109,654 (13 mentions)  
7. aws - $108,317 (32 mentions)  
8. java - $106,906 (17 mentions)  
9. ssis - $106,683 (12 mentions)  
10. jira - $104,918 (20 mentions)  

Top 10 Data Analyst Skills by Demand Count  
1. python - 236 mentions ($101,397)  
2. tableau - 230 mentions ($99,288)  
3. r - 148 mentions ($100,499)  
4. sas - 63 mentions ($98,902)  
5. looker - 49 mentions ($103,795)  
6. snowflake - 37 mentions ($112,948)  
7. oracle - 37 mentions ($104,534)  
8. sql server - 35 mentions ($97,786)  
9. azure - 34 mentions ($111,225)  
10. aws - 32 mentions ($108,317)  

Insights  
- go tops salary ($115,320) but has low demand (27).  
- python dominates demand (236) with solid pay ($101,397).  
- snowflake and azure balance high salary and demand.  
- tableau and r are in-demand visualization tools with decent pay.  
- Niche skills (confluence, ssis) offer high pay but less demand.
*/