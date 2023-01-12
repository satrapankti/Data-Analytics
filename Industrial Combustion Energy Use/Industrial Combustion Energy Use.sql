CREATE DATABASE energy;
USE energy;

CREATE TABLE Data1 (
    Facility_id INT,
    Facility_name VARCHAR(100),
    Fuel_type VARCHAR(50),
    Unit_name TEXT,
    County VARCHAR(50),
    Primary_naics_code INT,
    Primary_naics_title VARCHAR(100),
    Mecs_region VARCHAR(10),
    Mmbtu_total DOUBLE,
    Gwht_total DOUBLE
);

CREATE TABLE data2 (
    Primary_naics_code INT,
    Primary_naics_title VARCHAR(200),
    Gwht_total FLOAT,
    Indirect_Uses_Boiler_Fuel DOUBLE,
    Conventional_Boiler_Use DOUBLE,
    CHP_Cogeneration_Process DOUBLE,
    Direct_Uses_Total_nonProcess DOUBLE,
    Process_Heating DOUBLE,
    Machine_Drive DOUBLE
);

SHOW TABLES;
SELECT COUNT(*) FROM data1;
SELECT COUNT(*) FROM data2;
SELECT * FROM data1 LIMIT 50;
SELECT * FROM data2 LIMIT 50;

-- 1st KPI MMBtu_TOTAL for Ethane & Ethanol 
SELECT Fuel_type,ROUND(Mmbtu_total, 2) AS Mmbtu_total FROM data1
WHERE Fuel_type = 'Ethane' OR Fuel_type = 'Ethanol (100%)'
GROUP BY Fuel_type;

-- 2nd KPI Process Heating for 3M Company Facility 
SELECT b.Facility_name,ROUND(a.Process_Heating, 2) AS Process_Heating FROM data2 AS a
JOIN data1 AS b ON a.Primary_naics_code = b.Primary_naics_code
WHERE b.Facility_name = '3M COMPANY'
GROUP BY b.Facility_name;

-- 3rd KPI Unit Name trend (1950-2020) Vs GWht_TOTAL 
SELECT Unit_name,ROUND(SUM(Gwht_total),2) AS Gwht_total FROM data1
WHERE
		   Unit_name LIKE '%1950'
        OR Unit_name LIKE '%1981'
        OR Unit_name LIKE '%1990'
        OR Unit_name LIKE '%1997'
        OR Unit_name LIKE '%2022'
GROUP BY Unit_name
ORDER BY Gwht_total DESC;

-- 4th KPI % Share of Direct Uses-Total Nonprocess for each MECS_Region
 SELECT b.Mecs_region AS MECS_Region,ROUND(SUM(a.Direct_Uses_Total_nonProcess),2) AS Sum_Direct_Uses_Total_Nonprocess,
CONCAT(ROUND(ROUND(SUM(a.Direct_Uses_Total_nonProcess),2)*100/SUM(ROUND(SUM(a.Direct_Uses_Total_nonProcess),2))
OVER(),2),"%") AS "% Share" from Data2 AS a
JOIN Data1 AS b ON a.Primary_naics_code = b.Primary_naics_code 
WHERE b.Mecs_region <>''
GROUP BY 1
ORDER BY 2 ASC;

-- 5th KPI County wise Conventional Boiler Use Stats
SELECT b.county,
    SUM(a.Conventional_Boiler_Use) AS Conventional_Boiler_Use,
    AVG(a.Conventional_Boiler_Use) AS Average,
    MAX(a.Conventional_Boiler_Use) AS Maximum,
    MIN(a.Conventional_Boiler_Use) AS Minimum
FROM
    data2 AS a
        JOIN
    data1 AS b ON a.Primary_naics_code = b.Primary_naics_code
WHERE
    a.Conventional_Boiler_Use <> ' '
        AND a.Conventional_Boiler_Use <> 0
GROUP BY b.county
ORDER BY b.county ASC;


