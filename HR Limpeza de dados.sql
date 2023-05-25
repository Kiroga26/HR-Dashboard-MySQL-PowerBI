-- Criar a Base de dados

CREATE DATABASE project;

-- Foi importado um ficheiro dos recursos humanos em formato CSV.
-- Primeira analise dos dados importados.

USE project;
SELECT * FROM HR;

 -- Foi detectado erros na primera coluna ID e nas colunas das datas. 
 
 ALTER TABLE HR
 CHANGE COLUMN ï»¿id emp_id VARCHAR(20) NULL;

DESCRIBE HR
SELECT birthdate FROM HR;

SET sql_safe_updates = 0;

UPDATE HR
SET birthdate = CASE
	WHEN birthdate LIKE '%/%' THEN DATE_FORMAT(str_to_date(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN birthdate LIKE '%-%' THEN DATE_FORMAT(str_to_date(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL 
END

ALTER TABLE HR
MODIFY COLUMN birthdate DATE;

UPDATE HR
SET hire_date = CASE
	WHEN hire_date LIKE '%/%' THEN DATE_FORMAT(str_to_date(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN hire_date LIKE '%-%' THEN DATE_FORMAT(str_to_date(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL 
END

ALTER TABLE HR
MODIFY COLUMN hire_date DATE;

UPDATE HR
SET termdate = DATE(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC'))
WHERE termdate IS NOT NULL AND termdate != ' ';

ALTER TABLE HR
MODIFY COLUMN termdate DATE;

-- É necessario adicionar uma nova coluna para idade para analise 

ALTER TABLE HR ADD COLUMN age INT;

UPDATE HR
SET age = timestampdiff(YEAR, birthdate, CURDATE());

SELECT birthdate, age FROM HR;

SELECT min(age) as youngest,	
	max(age) as oldest
    FROM HR;
    
SELECT COUNT(*) FROM HR 
WHERE age < 18;

SELECT COUNT(*) FROM hr WHERE termdate > CURDATE();

SELECT COUNT(*)
FROM hr
WHERE termdate = '0000-00-00';









