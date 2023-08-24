================================================================================

--  DATA CLEANING
-- 1. Remove the job_id column
ALTER TABLE DataAnalystRole
DROP COLUMN job_id

-- 2. Remove the thumbnail column
ALTER TABLE DataAnalystRole
DROP COLUMN thumbnail

-- 3. Update the via column
-- 3.1 View all the via column. 'via' is leading the actual values
SELECT via
FROM DataAnalystRole
ORDER BY via

-- 3.2. Confirm first if the the removal of 'via' is consistent
SELECT via, SUBSTRING(via, 5, LEN(via) - 4) AS newVia, LEN(via) - LEN(SUBSTRING(via, 5, LEN(via) - 4)) AS LengthDifference
FROM DataAnalystRole
ORDER BY newVia DESC

-- 3.3. Add job_platform column
ALTER TABLE DataAnalystRole
ADD job_platform nvarchar(100);

-- 3.4. Update job_platform values
UPDATE DataAnalystRole
SET job_platform = SUBSTRING(via, 5, LEN(via) - 4)

-- 3.5. Confirm if job_platform values are correct
-- Compare the length of values between via column and job_platform column
SELECT via, job_platform, LEN(via) - LEN(job_platform) AS LengthDifference
FROM DataAnalystRole
ORDER BY job_platform DESC

-- 3.6. Update the via value with job_platform value
UPDATE DataAnalystRole
SET via = job_platform

-- 3.7. Confirm if via values are equal to job_platform values
-- If nothing shows then all entries are equal
SELECT via, job_platform
FROM DataAnalystRole
WHERE via != job_platform

-- 3.8. Remove the job_platfrom column
ALTER TABLE DataAnalystRole
DROP COLUMN job_platform

-- 3.9. Update via column to job_platform
-- Did not work. Manually renamed
--ALTER TABLE DataAnalystRole
--RENAME COLUMN via TO job_platform;


-- 4. Update the work_from_home column
-- 4.1. Display all the distinct value of work_from_home column
-- TRUE and NULL values
SELECT DISTINCT work_from_home
FROM DataAnalystRole

-- 4.2. Add tempWFH column
ALTER TABLE DataAnalystRole
ADD tempWFH nvarchar(5)

-- 4.3. Convert TRUE to yes and NULL to no in work_from_home
SELECT work_from_home,
CASE
	WHEN work_from_home = 'TRUE' THEN 'yes'
	ELSE 'no'
END AS WFH
FROM DataAnalystRole

-- 4.4. Store converted values to tempWFH
UPDATE DataAnalystRole
SET tempWFH = CASE
	WHEN work_from_home = 'TRUE' THEN 'yes'
	ELSE 'no'
END

-- 4.5. Update work_from_home column values with tempWFH column values
UPDATE DataAnalystRole
SET work_from_home = tempWFH

-- 4.6. Remove tempWFH column
ALTER TABLE DataAnalystRole
DROP COLUMN tempWFH

================================================================================
