-- Data Cleaning

-- deleting duplicate rows in customer_data_2024

DELETE
FROM cyclistic-project-50.trip_data.customer_data_2024
WHERE row_num > 1;

DROP TABLE IF EXISTS cyclistic-project-50.trip_data.customer_data_2024_cleaned;

-- creating new table with clean data

CREATE TABLE IF NOT EXISTS cyclistic-project-50.trip_data.customer_data_2024_cleaned AS (
  SELECT 
    a.ride_id, rideable_type, started_at, ended_at, 
    ride_length,
    CASE EXTRACT(DAYOFWEEK FROM started_at) 
      WHEN 1 THEN 'SUN'
      WHEN 2 THEN 'MON'
      WHEN 3 THEN 'TUES'
      WHEN 4 THEN 'WED'
      WHEN 5 THEN 'THURS'
      WHEN 6 THEN 'FRI'
      WHEN 7 THEN 'SAT'    
    END AS day_of_week,
    CASE EXTRACT(MONTH FROM started_at)
      WHEN 1 THEN 'JAN'
      WHEN 2 THEN 'FEB'
      WHEN 3 THEN 'MAR'
      WHEN 4 THEN 'APR'
      WHEN 5 THEN 'MAY'
      WHEN 6 THEN 'JUN'
      WHEN 7 THEN 'JUL'
      WHEN 8 THEN 'AUG'
      WHEN 9 THEN 'SEP'
      WHEN 10 THEN 'OCT'
      WHEN 11 THEN 'NOV'
      WHEN 12 THEN 'DEC'
    END AS month,
    start_station_name, end_station_name, 
    start_lat, start_lng, end_lat, end_lng, member_casual,
  FROM cyclistic-project-50.trip_data.customer_data_2024 a
  JOIN (
    SELECT ride_id, (
      EXTRACT(HOUR FROM (ended_at - started_at)) * 60 +
      EXTRACT(MINUTE FROM (ended_at - started_at)) +
      EXTRACT(SECOND FROM (ended_at - started_at)) / 60) AS ride_length,
    FROM cyclistic-project-50.trip_data.customer_data_2024
  ) b 
  ON a.ride_id = b.ride_id
  WHERE 
    start_station_name IS NOT NULL AND
    end_station_name IS NOT NULL AND
    end_lat IS NOT NULL AND
    end_lng IS NOT NULL AND
    ride_length > 1 AND ride_length < 1440
);

ALTER TABLE cyclistic-project-50.trip_data.customer_data_2024  -- set ride_id as primary key
ADD PRIMARY KEY(ride_id) NOT ENFORCED;

SELECT COUNT(ride_id) AS no_of_rows
FROM cyclistic-project-50.trip_data.customer_data_2024_cleaned;  -- returned 4,167,794 rows so 1,692,774 rows removed

-- checking for duplicate rows

SELECT COUNT(ride_id) - COUNT(DISTINCT ride_id) AS no_of_duplicate_rows
FROM cyclistic-project-50.trip_data.customer_data_2024_cleaned; -- no duplicate rows