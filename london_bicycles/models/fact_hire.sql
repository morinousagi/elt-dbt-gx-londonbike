-- .sql dbt model, including cleaning and derived columns

-- dbt config block to define how this model is materialized (as a physical table)
{{ config(materialized='table') }}

-- Common Table Expression (CTE) to pull from the raw_hires table 
WITH raw_data AS (
    SELECT * FROM {{ source('london_bicycles', 'cycle_hire') }} 
    WHERE start_date >= TIMESTAMP('2021-01-01 00:00:00 UTC')
    ),

-- CTE to perform data cleaning and generate derived columns 
cleaned_data AS ( 
    SELECT
        rental_id,
        bike_id,
        start_date,
        end_date,
        start_station_id, 
        end_station_id, 
        duration, 
        -- Derived: Convert duration from sec to min for easier analysis 
        duration / 60.0 AS duration_minutes, 
        -- Derived: Categorize the time of day using a CASE statement 
        CASE 
            -- If the hour is between 6 and 11, it is Morning 
            WHEN EXTRACT(HOUR FROM start_date) BETWEEN 6 AND 11 THEN 'Morning' 
            -- If the hour is between 12 and 17, it is Afternoon 
            WHEN EXTRACT(HOUR FROM start_date) BETWEEN 12 AND 17 THEN 'Afternoon' 
            -- If the hour is between 18 and 22, it is Evening 
            WHEN EXTRACT(HOUR FROM start_date) BETWEEN 18 AND 22 THEN 'Evening' 
            -- Any other time is categorized as Night 
            ELSE 'Night' 
        END AS time_of_day_category,
        -- Derived: Categorize by seasonusing a CASE statement 
        CASE 
            WHEN EXTRACT(MONTH FROM start_date) IN (3, 4, 5) THEN 'Spring'
            WHEN EXTRACT(MONTH FROM start_date) IN (6, 7, 8) THEN 'Summer'
            WHEN EXTRACT(MONTH FROM start_date) IN (9, 10, 11) THEN 'Autumn'
            ELSE 'Winter' 
        END AS season
        -- Generate a time_id by formatting start_date to YYYYMMDDHH format
        --CAST(TO_CHAR(start_date, 'YYYYMMDDHH24') AS INT) AS start_time_id
        
    FROM raw_data 
    -- Data Cleaning: Filter out records where duration is zero or negative 
    WHERE duration > 0 
    -- Data Cleaning: Filter out records where the starting station is null 
    AND start_station_id IS NOT NULL 
    ) 
    
-- Final SELECT statement to output the transformed data into the new table
SELECT * FROM cleaned_data