/*
Question: What are the most in-demand skills for data analysts?

Retrieves the top 5 skills with the highest demand in the job market, 
providing insights into the most valuable skills for job seekers.
*/

SELECT
    skills,
    COUNT(*) AS demand_count
FROM
    job_postings_fact
INNER JOIN
    skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN
    skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_work_from_home = True
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5;

/*

Here are some insights based on the demand counts for the top-5 skills for data analyst roles in 2023:

1. SQL is by far the most demanded skill with 7291 job postings, indicating its critical importance in data analysis for querying databases.
2. Excel follows with 4611 job postings, showing its widespread use for data manipulation, analysis, and reporting despite the rise of more advanced tools.
3. Python is close behind with 4330 job postings. Its popularity underscores the importance of programming skills in data analysis, particularly for data science tasks, automation, and integration with other tools.
4. Tableau has 3745 job postings, reflecting the high demand for visualization skills to communicate data insights effectively.
5. Power BI rounds out the list with 2609 job postings, also highlighting the need for business intelligence tools for reporting and dashboard creation.

Key Takeaways:
- Technical Proficiency: Proficiency in SQL, Python, and Excel forms the core technical skill set for data analysts.
- Visualization: Both Tableau and Power BI are crucial for presenting data in an understandable manner, suggesting that data analysts need to be adept at data storytelling.
- Versatility: The demand for both traditional tools (like Excel) and modern tools (like Python, Tableau, and Power BI) suggests that a versatile skill set combining legacy and contemporary technologies is highly valued.

*/