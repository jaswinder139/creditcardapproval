CREATE TABLE credit_card_approval.updated_merged_data (
    Ind_ID INT,
    GENDER VARCHAR(10),
    Car_Owner VARCHAR(10),
    Propert_Owner VARCHAR(10),
    CHILDREN INT,
    Annual_income INT,
    Type_Income VARCHAR(20),
    EDUCATION VARCHAR(50),  -- Corrected to VARCHAR(50)
    Marital_status VARCHAR(20),
    Housing_type VARCHAR(20),
    Birthday_count INT,
    Employed_days INT,
    Mobile_phone VARCHAR(15),
    Work_Phone VARCHAR(15),
    Phone VARCHAR(15),
    EMAIL_ID VARCHAR(50),
    Type_Occupation VARCHAR(50),
    Family_Members INT,
    label VARCHAR(10),
    Age INT,
    Experience INT
);


LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\updated_merged_data.csv'
INTO TABLE credit_card_approval.updated_merged_data
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS; -- Use this if your CSV file has a header row, to skip it during import

SELECT * FROM credit_card_approval.updated_merged_data LIMIT 10;

-- 1. Group the customers based on their income type and find the average of their annual income.
SELECT Type_Income, AVG(Annual_income) AS Avg_Income
FROM credit_card_approval.updated_merged_data
GROUP BY Type_Income;


-- 2. Find the female owners of cars and property.
SELECT *
FROM credit_card_approval.updated_merged_data
WHERE GENDER = 'F' AND (Car_Owner = 'Y' AND Propert_Owner = 'Y');

-- 3. Find the male customers who are staying with their families.
SELECT *
FROM credit_card_approval.updated_merged_data
WHERE GENDER = 'M' AND Family_Members > 1;

-- 4. List the top five people having the highest income.
SELECT *
FROM credit_card_approval.updated_merged_data
ORDER BY Annual_income DESC
LIMIT 5;

-- 5. How many married people are having bad credit?
SELECT COUNT(*) AS BadCreditMarriedCount
FROM credit_card_approval.updated_merged_data
WHERE Marital_status = 'Married' AND label = '1';

-- 6. What is the highest education level and what is the total count?
SELECT EDUCATION, COUNT(*) AS EducationCount
FROM credit_card_approval.updated_merged_data
GROUP BY EDUCATION
ORDER BY COUNT(*) DESC
LIMIT 1;

-- 7. Between married males and females, who is having more bad credit?
SELECT Marital_status, GENDER, COUNT(*) AS BadCreditCount
FROM credit_card_approval.updated_merged_data
WHERE Marital_status = 'Married' AND label = '1'
GROUP BY Marital_status, GENDER;


