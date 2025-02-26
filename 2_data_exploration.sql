-- Data Exploration

-- checking the data types of all columns

SELECT column_name, data_type
FROM `cyclistic-project-50.trip_data`.INFORMATION_SCHEMA.COLUMNS
WHERE table_name = 'customer_data_2024';

-- checking for number of null values in all columns

SELECT 
 COUNT(*) - COUNT(ride_id) AS ride_id,
 COUNT(*) - COUNT(rideable_type) AS rideable_type,
 COUNT(*) - COUNT(started_at) AS started_at,
 COUNT(*) - COUNT(ended_at) AS ended_at,
 COUNT(*) - COUNT(start_station_name) AS start_station_name,
 COUNT(*) - COUNT(start_station_id) AS start_station_id,
 COUNT(*) - COUNT(end_station_name) AS end_station_name,
 COUNT(*) - COUNT(end_station_id) AS end_station_id,
 COUNT(*) - COUNT(start_lat) AS start_lat,
 COUNT(*) - COUNT(start_lng) AS start_lng,
 COUNT(*) - COUNT(end_lat) AS end_lat,
 COUNT(*) - COUNT(end_lng) AS end_lng,
 COUNT(*) - COUNT(member_casual) AS member_casual
FROM cyclistic-project-50.trip_data.customer_data_2024;

-- checking for duplicate rows

SELECT COUNT(ride_id) - COUNT (DISTINCT ride_id) AS duplicate_rows
FROM cyclistic-project-50.trip_data.customer_data_2024;  --  returned 211 rows

-- checking length of ride_id (length == 16)

SELECT LENGTH(ride_id) AS length_ride_id, COUNT(ride_id) AS no_of_rows
FROM cyclistic-project-50.trip_data.customer_data_2024
GROUP BY length_ride_id;

-- rideable_type - 3 unique types of bikes

SELECT DISTINCT rideable_type, COUNT(rideable_type) AS no_of_trips
FROM cyclistic-project-50.trip_data.customer_data_2024
GROUP BY rideable_type;

-- member_casual - 2 unique values - member and casual riders

SELECT DISTINCT member_casual, COUNT(member_casual) AS no_of_trips
FROM cyclistic-project-50.trip_data.customer_data_2024
GROUP BY member_casual;

-- started_at, ended_at - TIMESTAMP - YYYY-MM-DD hh:mm:ss UTC

SELECT started_at, ended_at
FROM cyclistic-project-50.trip_data.customer_data_2024
LIMIT 10;

SELECT COUNT(*) AS longer_than_a_day
FROM cyclistic-project-50.trip_data.customer_data_2024
WHERE (
  EXTRACT(HOUR FROM (ended_at - started_at)) * 60 +
  EXTRACT(MINUTE FROM (ended_at - started_at)) +
  EXTRACT(SECOND FROM (ended_at - started_at)) / 60) >= 1440;  -- longer than a day | total rows = 7,596

SELECT COUNT(*) AS less_than_a_minute
FROM cyclistic-project-50.trip_data.customer_data_2024
WHERE (
  EXTRACT(HOUR FROM (ended_at - started_at)) * 60 +
  EXTRACT(MINUTE FROM (ended_at - started_at)) +
  EXTRACT(SECOND FROM (ended_at - started_at)) / 60) <= 1;  -- less than a minute | total rows = 1,326,44

-- start_station_name, start_station_id - total of 1073951 rows with both start station name & id are null

SELECT DISTINCT start_station_name
FROM cyclistic-project-50.trip_data.customer_data_2024
GROUP BY start_station_name;

SELECT COUNT(ride_id) AS total_null_rows_start_station
FROM cyclistic-project-50.trip_data.customer_data_2024
WHERE start_station_name IS NULL OR start_station_id IS NULL;  -- returned 1,073,951 rows

-- end_station_name, end_station_id - total of 1104653 rows with both end station name & id are null

SELECT DISTINCT end_station_name
FROM cyclistic-project-50.trip_data.customer_data_2024
GROUP BY end_station_name;

SELECT COUNT(ride_id) AS total_null_rows_end_station
FROM cyclistic-project-50.trip_data.customer_data_2024
WHERE end_station_name IS NULL OR end_station_id IS NULL;  -- returned 1,104,653 rows

-- end_lat, end_lng - total 7232 rows with both null

SELECT COUNT(ride_id) AS total_null_rows_end_loc
FROM cyclistic-project-50.trip_data.customer_data_2024
WHERE end_lat IS NULL OR end_lng IS NULL; -- returned 7,232 rows
