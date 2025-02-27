# cyclistic-case-study
## Introduction
In this case study, I will perform real-world tasks as junior data analyst for a fictional bike sharing company called Cyclistic. To answer the key business questions, I will follow the steps of data analysis process: [Ask](https://github.com/wifaqmn/cyclistic-case-study/blob/main/README.md#ask), [Prepare](https://github.com/wifaqmn/cyclistic-case-study/blob/main/README.md#prepare), [Process](https://github.com/wifaqmn/cyclistic-case-study/blob/main/README.md#Process), [Analyze](https://github.com/wifaqmn/cyclistic-case-study/blob/main/README.md#analyze-&-share), [Share](https://github.com/wifaqmn/cyclistic-case-study/blob/main/README.md#analyze-&-share) and [Act](https://github.com/wifaqmn/cyclistic-case-study/blob/main/README.md#act).
### Quick links:
Data Source: [divvy_tripdata](https://divvy-tripdata.s3.amazonaws.com/index.html) [accessed on 05/02/25]  

SQL Queries:  
[1. Data Combining](https://github.com/wifaqmn/cyclistic-case-study/blob/main/1_data_combination.sql)  
[2. Data Exploration](https://github.com/wifaqmn/cyclistic-case-study/blob/main/2_data_exploration.sql)  
[3. Data Cleaning](https://github.com/wifaqmn/cyclistic-case-study/blob/main/3_data_cleaning.sql)  

Data Visualizations: [Power BI](https://app.powerbi.com/groups/me/reports/b7f82eb1-91eb-44b4-b22f-4014c3963837/32cbff69d977a14280f1?experience=power-bi)

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
1. The table below shows the all column names and their data types. The __ride_id__ column is our __primary key__.

    ![image](https://github.com/wifaqmn/imagecontent/blob/main/a.jpeg)

2. The following table shows number of __null values__ in each column.  
   
    ![image](https://github.com/wifaqmn/imagecontent/blob/main/b.jpeg)
   Note that some columns have the same number of missing values due to missing row in the same row. e.g: station's name and id for the same station and latitude and longitude for the same ending station.
 
3. As __ride_id__ has no null values, let's use it to check for duplicates.

   ![image](https://github.com/wifaqmn/imagecontent/blob/main/c.jpeg)

   There are 211 duplicate rows for __ride_id__.

4. All __ride_id__ values have 16 character length, therefore data cleaning is not required.
5. Here are 3 unique types of bikes (__rideable_type__) in our data.
   
    ![image](https://github.com/wifaqmn/imagecontent/blob/main/d.jpeg)

6. The __started_at__ and __ended_at__ shows start and end time of the trip in YYYY-MM-DD hh:mm:ss UTC format. New column __ride_length__ can be created to find the total trip duration. There are 7,596 trips which has duration longer than a day and 1,326,44 trips having less than a minute duration or having end time earlier than start time so need to remove them.
7. Total of 1,073,951 rows have both __start_station_name__ and __start_station_id__ missing which needs to be removed.  
8. Total of 1,104,653 rows have both __end_station_name__ and __end_station_id__ missing which needs to be removed.
9. Total of 7,232 rows have both __end_lat__ and __end_lng__ missing which needs to be removed.
10. __member_casual__ column has 2 unique values as member or casual rider.

    ![image](https://github.com/wifaqmn/imagecontent/blob/main/e.jpeg)

11. Columns that need to be removed are __start_station_id__ and __end_station_id__ as they do not add value to analysis of our current problem. Longitude and latitude columns may not be used in analysis but can be used to visualise a map.

### Data Cleaning

SQL Query: [Data Cleaning](https://github.com/wifaqmn/cyclistic-case-study/blob/main/3_data_cleaning.sql)

1. All rows having duplicate values for __ride_id__ are deleted.
2. All rows having missing values are deleted.
3. A new column named __ride_length__ is added.
4. Trip duration with less than a minute and longer than 1 day are removed.
5. A total of 1,692,774 rows are removed in this steps.

### Analyze & Share
Data Visualizations: [Power BI](https://app.powerbi.com/groups/me/reports/b7f82eb1-91eb-44b4-b22f-4014c3963837/32cbff69d977a14280f1?experience=power-bi)

Analysis question no. 1: How do annual members and casual riders use Cyclistic bikes differently?

#### 1. Type of bikes used

Pie charts below represent comparison of member and casual rider by the type of bikes they are using.

![image](https://github.com/wifaqmn/imagecontent/blob/main/bike_types_cyclistic.png)

Members make almost double the casual riders which is 63.87% of the total while the rest is 36.13% for the casual riders. Each bike type chart shows percentage from the total. __Classic bike__ is the most used bikes followed by __electric bike__ and __electric scooter__ respectively.

#### 2. Total trips

The number of trips is distributed by the months, days of the week and hours of the day are examined.

![image](https://github.com/wifaqmn/imagecontent/blob/main/total_trips_cyclistic.png)

__Months:__ Both casual and members show comparable trends, with significant increase from April to July (spring - summer) and decrease from August to December (autumn - winter).  The gap between casuals and members is closest in the month of July in summmer.

__Days of the Week:__ Graph shows casual riders make more journey during the weekends while members show a decline over the weekends compared to other days of the week.

__Hours of the Day:__ The members shows 2 peaks throughout the day in terms of number of trips. First is early in the morning at around 5AM to 8AM and secondly is in the evening at around 3PM to 5PM while number of trips for casual riders increase consistently over the day till evening and then decrease afterwards.

We can conclude that members may using bike for commuting to and from work during weekdays while casual riders were using bikes throughout the days, more frequent during the weekends for recreation purposes mostly. Both riders are most active from spring to summer.

#### 3. Ride duration of the trips

Ride duration of the trips are compared to find the differences in the behavior of casual and member riders.

![image](https://github.com/wifaqmn/imagecontent/blob/main/avg_duration_cyclistic.png)

Based on the charts above we can observe casual riders travel longer than members on average. The average duration for members we consistent the year, weeks and days. Casual riders on the other hand show variations in their average duration of the trips. They travel greater distance during from March to August (spring to summer), during the wekkends and from 8AM to 10AM throghout the day.

From the findings, we can infer casual riders travel longer (approximately 2 times more) but less frequent than members. Casual riders make travel longer distance during the day outside of peak hour, on the weekends and during spring and summer time, thus they most probably do for leisure purposes.

#### 4. Total trips at starting and ending locations

In order to further understand the indifferences betwwen casual and member riders, locations of starting and ending stations were analysed. Stations with the most trips are considered using filters to draw out the following conclusions.

![image](https://github.com/wifaqmn/imagecontent/blob/main/start_location_cyclistic.png) 
![image](https://github.com/wifaqmn/imagecontent/blob/main/end_location_cyclistic.png)

Based on both starting and ending locations above, we can see casual riders frequently started and ended their trips from the stations in vicinity of beach, parks, museums, aquarium and harbor points while members started and ended their journeys from stations close to universities, schools, residential areas, hospitals, restaurants, grocery stores, train stations, theatre, factories, banks, parks and plazas. Therefore, it demonstrates casual riders use bikes for leisure activities while members vastly depend on them for daily commute.

Summary:
  
|Casual|Member|
|------|------|
|Preferably riding bikes throughout the day, more frequently over the weekends in from April to July (spring - summer) for leisure activities.|Preferably using bikes on weekdays during peak hours (8AM/3PM) from April to July (spring - summer).|
|Travel twice longer but less frequently than members.|Travel more frequently but shorter rides.|
|Start and end their rides near parks, museums, along the coast and other recreational sites.|Start and end their journeys close to universities, residential and commercial areas.|

After sharing these findings about the differences between casual and annual members, the marketing department can start to develop their strategy of converting casual members to annual members. Here are three of my recommendations, given my knowledge of how these riders differ:  
1. Marketing campaigns might be conducted from April to July (spring - summer) at most popular locations among casual riders such as tourist & recreational area.
2. Casual riders are most active from spring to summer and weekends, thus they may be offered seasonal or weekend-only memberships.
3. Casual riders use their bikes for longer durations than members. Offering discounts for longer rides may incentivize casual riders and entice members to ride for longer periods of time.
