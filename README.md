# cyclistic-case-study
## Introduction
In this case study, I will perform real-world tasks as junior data analyst for a fictional bike sharing company called Cyclistic. To answer the key business questions, I will pfollow the steps of data analysis process:
### Quick links:
Data Source: [divvy_tripdata](https://divvy-tripdata.s3.amazonaws.com/index.html) [accessed on 24/02/25]  

SQL Queries:  
[1. Data Combining](https://github.com/wifaqmn/cyclistic-case-study/blob/main/1_data_combination.sql)  
[2. Data Exploration](https://github.com/wifaqmn/cyclistic-case-study/blob/main/2_data_exploration.sql)  
[3. Data Cleaning](https://github.com/wifaqmn/cyclistic-case-study/blob/main/3_data_cleaning.sql)  

Data Visualizations: [Power BI]()

## Background
### Cyclistic
A bike-share program that features more than 5,800 bicycles and 600 docking stations. Cyclistic sets itself apart by also offering reclining bikes, hand tricycles, and cargo bikes, making bike-share more inclusive to people with disabilities and riders who can’t use a standard two-wheeled bike. The majority of riders opt for traditional bikes; about 8% of riders use the assistive options. Cyclistic users are more likely to ride for leisure, but about 30% use them to commute to work each day.   
  
Until now, Cyclistic’s marketing strategy relied on building general awareness and appealing to broad consumer segments. One approach that helped make these things possible was the flexibility of its pricing plans: single-ride passes, full-day passes, and annual memberships. Customers who purchase single-ride or full-day passes are referred to as casual riders. Customers who purchase annual memberships are Cyclistic members.  
  
Cyclistic’s finance analysts have concluded that annual members are much more profitable than casual riders. Although the pricing flexibility helps Cyclistic attract more customers, Moreno (the director of marketing and my manager) believes that maximizing the number of annual members will be key to future growth. Rather than creating a marketing campaign that targets all-new customers, Moreno believes there is a very good chance to convert casual riders into members. She notes that casual riders are already aware of the Cyclistic program and have chosen Cyclistic for their mobility needs.  

My Manager, Mrs. Moreno has set a clear goal: Design marketing strategies aimed at converting casual riders into annual members. In order to do that, however, the marketing analyst team needs to better understand how annual members and casual riders differ, why casual riders would buy a membership, and how digital media could affect their marketing tactics. Moreno and her team are interested in analyzing the Cyclistic historical bike trip data to identify trends.  

### Scenario
I am assuming to be a junior data analyst working in the marketing analyst team at Cyclistic, a bike-share company in Chicago. The director of marketing believes the company’s future success depends on maximizing the number of annual memberships. Therefore, my team wants to understand how casual riders and annual members use Cyclistic bikes differently. From these insights, my team will design a new marketing strategy to convert casual riders into annual members. But first, Cyclistic executives must approve our recommendations, so they must be backed up with compelling data insights and professional data visualizations.

## Ask
### Business Task
Devise marketing strategies to convert casual riders to members.
### Analysis Questions
Three questions will guide the future marketing program:  
1. How do annual members and casual riders use Cyclistic bikes differently?  
2. Why would casual riders buy Cyclistic annual memberships?  
3. How can Cyclistic use digital media to influence casual riders to become members?  

Moreno has assigned me the first question to answer: How do annual members and casual riders use Cyclistic bikes differently?
## Prepare
### Data Source
I will use Cyclistic’s historical trip data to analyze and identify trends from Jan 2024 to Dec 2024 which can be downloaded from [divvy_tripdata](https://divvy-tripdata.s3.amazonaws.com/index.html). The data has been made available by Motivate International Inc. under this [license](https://www.divvybikes.com/data-license-agreement).  
  
This is public data that can be used to explore how different customer types are using Cyclistic bikes. But note that data-privacy issues prohibit from using riders’ personally identifiable information. This means that we won’t be able to connect pass purchases to credit card numbers to determine if casual riders live in the Cyclistic service area or if they have purchased multiple single passes.
### Data Organization
There are 12 files with naming convention of YYYYMM-divvy-tripdata and each file includes information for one month, such as the ride id, bike type, start time, end time, start station, end station, start location, end location, and whether the rider is a member or not. The corresponding column names are ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng and member_casual.

## Process
BigQuery is used to combine the various datasets into one dataset and clean it.    
Reason:  
A worksheet can only have 1,048,576 rows in Microsoft Excel because of its inability to manage large amounts of data. Because the Cyclistic dataset has more than 5.8 million rows, it is essential to use a platform like BigQuery that supports huge volumes of data.
### Combining the Data
SQL Query: [Data Combining](https://github.com/wifaqmn/cyclistic-case-study/blob/main/1_data_combination.sql)  
12 csv files are uploaded as tables in the dataset 'trip_data'. Another table named "customer_data_2024" is created, containing 5,860,568 rows of data for the entire year. 
### Data Exploration


SQL Query: [Data Exploration](https://github.com/wifaqmn/cyclistic-case-study/blob/main/2_data_exploration.sql)  
Before the data cleaning process, I need to be familiar with the data to find the inconsistencies.

Observations:
1. The table below shows the all column names and their data types. The __ride_id__ column is our primary key.

    ![image](https://github.com/wifaqmn/imagecontent/blob/main/a.jpeg)

2. The following table shows number of __null values__ in each column.  
   
    ![image](https://github.com/wifaqmn/imagecontent/blob/main/b.jpeg)
   Note that some columns have the same number of missing values due to missing row in the same row. e.g: station's name and id for the same station and latitude and longitude for the same ending station.
 
3. As ride_id has no null values, let's use it to check for duplicates.

   ![image](https://github.com/wifaqmn/imagecontent/blob/main/c.jpeg)

   There are 211 duplicates row for __ride_id__.

4. All __ride_id__ values have 16 character length, therefore data cleaning is unnecessary.
5. Here are 3 unique types of bikes (__rideable_type__) in our data.
   
    ![image](https://github.com/wifaqmn/imagecontent/blob/main/d.jpeg)

6. The __started_at__ and __ended_at__ shows start and end time of the trip in YYYY-MM-DD hh:mm:ss UTC format. New column ride_length can be created to find the total trip duration. There are 7596 trips which has duration longer than a day and 132644 trips having less than a minute duration or having end time earlier than start time so need to remove them.
7. Total of 1073951 rows have both __start_station_name__ and __start_station_id__ missing which needs to be removed.  
8. Total of 1104653 rows have both __end_station_name__ and __end_station_id__ missing which needs to be removed.
9. Total of 7232 rows have both __end_lat__ and __end_lng__ missing which needs to be removed.
10. __member_casual__ column has 2 unique values as member or casual rider.

    ![image](https://github.com/wifaqmn/imagecontent/blob/main/e.jpeg)

11. Columns that need to be removed are start_station_id and end_station_id as they do not add value to analysis of our current problem. Longitude and latitude columns may not be used in analysis but can be used to visualise a map.
