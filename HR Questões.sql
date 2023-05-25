-- QUESTÕES / QUESTIONS

-- 1. Qual é a divisão por gênero dos funcionários da empresa?
-- 1. What is the gender breakdown of employees in the company?
SELECT gender, COUNT(*) AS count
FROM HR
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY gender;

-- 2. Qual é a discriminação racial/etnia dos funcionários da empresa?
-- 2. What is the race/ethnicity breakdown of employees in the company?

SELECT race, COUNT(*) AS count
FROM HR
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY race
ORDER BY count(*) DESC;

-- 3. Qual é a distribuição etária dos funcionários da empresa?
-- 3. What is the age distribution of employees in the company?

SELECT min(age) as youngest,	
	max(age) as oldest
    FROM HR
    WHERE age >= 18 AND termdate = '0000-00-00';
    
SELECT
	CASE 
		WHEN age >= 18 AND age <= 24 THEN '18-24'
        WHEN age >= 25 AND age <= 34 THEN '25-34'
        WHEN age >= 35 AND age <= 44 THEN '35-44'
        WHEN age >= 45 AND age <= 54 THEN '45-54'
        WHEN age >= 55 AND age <= 64 THEN '55-64'
        ELSE '65+'
	END AS age_group,
    count(*) AS count
FROM HR
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY age_group
ORDER BY age_group;

SELECT
	CASE 
		WHEN age >= 18 AND age <= 24 THEN '18-24'
        WHEN age >= 25 AND age <= 34 THEN '25-34'
        WHEN age >= 35 AND age <= 44 THEN '35-44'
        WHEN age >= 45 AND age <= 54 THEN '45-54'
        WHEN age >= 55 AND age <= 64 THEN '55-64'
        ELSE '65+'
	END AS age_group, gender,
    count(*) AS count
FROM HR
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY age_group, gender
ORDER BY age_group, gender;

-- 4. Quantos funcionários trabalham na sede vs locais remotos?
-- 4. How many employees work at headquarters vs remote locations?

SELECT location, COUNT(*)
FROM HR
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY location;

-- 5. Qual é a duração média do emprego para funcionários que foram demitidos?
-- 5. What is the average length of employment for employees who have been terminated?

SELECT 
	round(avg(datediff(termdate,hire_date))/365,0) AS avg_length_employment
    FROM HR
    WHERE termdate <= curdate() AND termdate <> '0000-00-00' AND age >= 18;

-- 6. Como a distribuição de gênero varia entre departamentos e cargos?
-- 6. How does the gender distribution vary across departments and job titles?

SELECT department, gender, COUNT(*)
FROM HR
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY department, gender
ORDER BY department;

-- 7. Qual é a distribuição dos cargos na empresa?
-- 7. What is the distribution of job titles across the company?

SELECT jobtitle, COUNT(*)
FROM HR
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY jobtitle
ORDER BY jobtitle DESC;

-- 8. Qual departamento tem a maior taxa de rotatividade?
-- 8. Which department has the highest turnover rate?

SELECT department, 
	total_count,
    terminated_count,
    terminated_count/total_count AS termination_rate
    FROM (
    SELECT department,
		COUNT(*) AS total_count,
        SUM(CASE WHEN termdate <> '0000-00-00' AND termdate <= curdate() THEN 1 ELSE 0 END) AS terminated_count
        FROM HR
        WHERE age >= 18
        GROUP BY department
        ) AS subquery
        ORDER BY termination_rate DESC;
    

-- 9. Qual é a distribuição dos funcionários nas localidades por cidade e estado?
-- 9. What is the distribution of employees across locations by city and state?

SELECT location_state, COUNT(*) AS count
FROM HR
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY location_state 
ORDER BY count DESC;

-- 10. Como a contagem de funcionários da empresa mudou ao longo do tempo com base nas datas de contratação e de mandato?
-- 10. How has the company's employee count changed over time based on hire and term dates?

SELECT
	year,
    hires,
    terminations,
    hires - terminations AS net_change,
    round((hires - terminations)/hires * 100, 2) AS net_change_percent
FROM (
	SELECT
		YEAR(hire_date) AS year,
        COUNT(*) AS hires,
		SUM(CASE WHEN termdate <> '0000-00-00' AND termdate <= curdate() THEN 1 ELSE 0 END) AS terminations
        FROM HR
        WHERE age >= 18
        GROUP BY YEAR(hire_date)
        ) AS subquery
ORDER BY year ASC;
    
-- 11. Qual é a distribuição de posse para cada departamento?
-- 11. What is the tenure distribution for each department?

SELECT department, round(avg(datediff(termdate, hire_date)/365),1) AS avg_tenure
FROM HR
WHERE termdate <> '0000-00-00' AND termdate <= curdate() AND age >= 18
GROUP BY department;



























