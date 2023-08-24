--SELECT * FROM DataAnalystRole

-- Display all data from DataAnalystSalary table
SELECT *
FROM DataAnalystSalary

-- Get the counts of distinct company and distinct job title
SELECT COUNT(DISTINCT company_name) AS CompanyCount, COUNT(DISTINCT title) AS TitleCount
FROM DataAnalystRole

-- Display the # of occurence per company and job descrition
SELECT DISTINCT company_name, description, COUNT(description) AS Occurence
FROM DataAnalystRole
--WHERE company_name = 'Cox Communications'
GROUP BY description, company_name
ORDER BY company_name, COUNT(description) DESC

-- Display the # of post per job title and company
SELECT DISTINCT title, company_name, COUNT(title) AS NumberOfPost
FROM DataAnalystRole
GROUP BY title, company_name
--ORDER BY COUNT(title) DESC
ORDER BY title
--ORDER BY company_name

-- Display a specific job title and company
SELECT title, company_name
FROM DataAnalystRole
WHERE title = 'Data Analyst II'
AND company_name = 'EDWARD JONES'

-- Display the total count of a specific job title and company
SELECT COUNT(title)
FROM DataAnalystRole
WHERE title = 'Lead Data Analyst'
AND company_name = 'EDWARD JONES'

-- Display the count of distinct job titles per company
-- Partition By
SELECT DISTINCT company_name, COUNT(title) OVER (PARTITION BY company_name) AS DistinctTitles
FROM DataAnalystRole
ORDER BY DistinctTitles DESC -- start with highest count

-- Display the count of distinct company per job titles
-- Partition By
SELECT DISTINCT title, COUNT(company_name) OVER (PARTITION BY title) AS DistinctCompany
FROM DataAnalystRole
ORDER BY DistinctCompany DESC -- start with highest count

-- Display the count of distinct company per job titles
-- Group By
SELECT DISTINCT title, COUNT(title)
FROM DataAnalystRole
GROUP BY title
ORDER BY COUNT(title) DESC

-- Display the count of distinct titles per job posting flatform using partition by
SELECT DISTINCT via, COUNT(title) OVER (PARTITION BY via) AS DistinctTitles
FROM DataAnalystRole
ORDER BY DistinctTitles DESC

-- Display the count of distinct titles per job posting flatform using group by
SELECT DISTINCT via, COUNT(via)
FROM DataAnalystRole
GROUP BY via
ORDER BY COUNT(via) DESC




SELECT *
FROM DataAnalystRole as dar
INNER JOIN DataAnalystSalary as das
ON dar.id = das.id
ORDER BY das.id

SELECT DISTINCT(dar.description)
FROM DataAnalystRole as dar
INNER JOIN DataAnalystSalary as das
ON dar.id = das.id
ORDER BY dar.description

SELECT *
FROM DataAnalystRole
WHERE extensions LIKE '%Internship%'

-- Part time and work-from-home opportunities
SELECT *
FROM DataAnalystRole
WHERE work_from_home = 'TRUE'
AND schedule_type = 'Part-Time'

-- List of companies offering part-time work-from-home data analyst jobs
SELECT DISTINCT company_name
FROM DataAnalystRole
WHERE work_from_home = 'TRUE'
AND schedule_type = 'Part-Time'

-- # of companies offering part-time work-from-home data analyst jobs
SELECT COUNT(DISTINCT company_name) AS CompanyCount
FROM DataAnalystRole
WHERE work_from_home = 'TRUE'
AND schedule_type = 'Part-Time'

-- # of opportunities per company offering part-time work-from-home data analyst jobs
-- Group By 
SELECT company_name, COUNT(company_name) AS Opportunities
FROM DataAnalystRole
WHERE work_from_home = 'TRUE'
AND schedule_type = 'Part-Time'
GROUP BY company_name

-- Display the distibution of the employment type
-- Subqueries in Select
SELECT schedule_type AS EmploymentType,
	COUNT(schedule_type) AS EmploymentCount,
	100*COUNT(schedule_type)/(SELECT COUNT(schedule_type) FROM DataAnalystRole) AS Percentage
FROM DataAnalystRole
WHERE schedule_type IS NOT NULL
GROUP BY schedule_type

-- Display the distibution of the employment type with work from home
-- Subqueries in Select
SELECT schedule_type AS EmploymentType,
	COUNT(schedule_type) AS EmploymentCount,
	100*COUNT(schedule_type)/(SELECT COUNT(schedule_type) FROM DataAnalystRole) AS Percentage
FROM DataAnalystRole
WHERE schedule_type IS NOT NULL
AND work_from_home = 'TRUE'
GROUP BY schedule_type


SELECT via, COUNT(via)
FROM DataAnalystRole
GROUP BY via
ORDER BY COUNT(via) DESC

SELECT *
FROM DataAnalystRole as dar
INNER JOIN DataAnalystSalary as das
ON dar.id = das.id
WHERE dar.extensions LIKE '%Internship%'
AND das.salary_avg IS NOT NULL

SELECT *
FROM DataAnalystRole as dar
INNER JOIN DataAnalystSalary as das
ON dar.id = das.id
WHERE dar.schedule_type ='Internship'
AND das.salary_avg IS NOT NULL

SELECT *
FROM DataAnalystRole as dar
INNER JOIN DataAnalystSalary as das
ON dar.id = das.id
WHERE das.salary_standardized IS NOT NULL
ORDER BY das.salary_standardized DESC

SELECT *
FROM DataAnalystRole as dar
INNER JOIN DataAnalystSalary as das
ON dar.id = das.id
WHERE das.salary_yearly IS NOT NULL
ORDER BY das.salary_yearly DESC



SELECT DISTINCT description_tokens, LEN(description_tokens)
FROM DataAnalystRole
ORDER BY LEN(description_tokens) DESC

SELECT DISTINCT LEN(dar.description_tokens) AS description_length, das.salary_yearly
FROM DataAnalystRole as dar
INNER JOIN DataAnalystSalary as das
ON dar.id = das.id
WHERE das.salary_yearly IS NOT NULL
--ORDER BY LEN(dar.description_tokens) DESC
ORDER BY das.salary_yearly DESC