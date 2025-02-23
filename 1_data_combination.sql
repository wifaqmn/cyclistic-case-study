-- Data Combination

-- merging 12 months customer data in 2024 into table "customer_data_2024" & add "row_num" column to check & remove duplicate rows

DROP TABLE IF EXISTS cyclistic-project-50.trip_data.customer_data_2024;

CREATE TABLE IF NOT EXISTS cyclistic-project-50.trip_data.customer_data_2024 (
 ride_id STRING,
 rideable_type	STRING,	
 started_at	TIMESTAMP,	
 ended_at	TIMESTAMP,	
 start_station_name	STRING,	
 start_station_id	STRING,	
 end_station_name	STRING,	
 end_station_id	STRING,	
 start_lat	FLOAT64,	
 start_lng	FLOAT64,	
 end_lat	FLOAT64,	
 end_lng	FLOAT64,	
 member_casual	STRING,
 row_num INT64
);

INSERT INTO cyclistic-project-50.trip_data.customer_data_2024
SELECT *, 
ROW_NUMBER() OVER (
    PARTITION BY ride_id) AS row_num
FROM(
    SELECT * FROM cyclistic-project-50.trip_data.customer_data_012024
    UNION ALL
    SELECT * FROM cyclistic-project-50.trip_data.customer_data_022024
    UNION ALL
    SELECT * FROM cyclistic-project-50.trip_data.customer_data_032024
    UNION ALL
    SELECT * FROM cyclistic-project-50.trip_data.customer_data_042024
    UNION ALL
    SELECT * FROM cyclistic-project-50.trip_data.customer_data_052024
    UNION ALL
    SELECT * FROM cyclistic-project-50.trip_data.customer_data_062024
    UNION ALL
    SELECT * FROM cyclistic-project-50.trip_data.customer_data_072024
    UNION ALL
    SELECT * FROM cyclistic-project-50.trip_data.customer_data_082024
    UNION ALL
    SELECT * FROM cyclistic-project-50.trip_data.customer_data_092024
    UNION ALL
    SELECT * FROM cyclistic-project-50.trip_data.customer_data_102024
    UNION ALL
    SELECT * FROM cyclistic-project-50.trip_data.customer_data_112024
    UNION ALL
    SELECT * FROM cyclistic-project-50.trip_data.customer_data_122024
);

SELECT COUNT (*) AS total_rows
FROM cyclistic-project-50.trip_data.customer_data_2024;