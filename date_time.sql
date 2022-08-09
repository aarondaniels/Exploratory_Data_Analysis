USE bad_sakila;

-----------------------------------------------
--  TIME SERIES
-----------------------------------------------

 -- A time series is a sequence of measurements 
 -- or data points, recorded in time order.
 -- E.G. Daily temperature, S&P 500, steps fitbit
 -- Used in forecasting in many domains

 -- Date, datetime, and time manipulations

-----------------------------------------------
--  Time zone conversions
-----------------------------------------------

 -- Time zones can be a source of confusion
 -- The source of many misteries
     -- Time zones follow irregular boundaries
     -- Most are 1 hr apart, some 30 mins, 45 mins
     -- Some daylight, others ignore it
     -- Some use server time
     -- Some use Coordinated Universal Time (UTC)
     -- Older DBs may use Greenwich Mean Time (GMT)
     -- Uncommon for DBs to capture the UTC and time zone
     -- If local time zone not captured, it's lost
     -- if users in multiple time zones, more complex


 -- Server time zone
SELECT @@global.time_zone, @@session.time_zone;

 -- OS time zone
 -- % date  

 -- three places where the timezone might be set in MySQL
 -- https://stackoverflow.com/q/930900/

 -- to convert from one timezone to another
 -- CONVERT_TZ(dt,from_tz,to_tz)

-----------------------------------------------
--  Date and Time Functions
-----------------------------------------------

SELECT now();
SELECT YEAR(now());
SELECT MONTH(now());
SELECT DAY(now());
SELECT TIME(now());
SELECT HOUR(now());
SELECT MINUTE(now());
SELECT SECOND(now());

 -- pretty day name

SELECT DAYNAME(now());

-- day of week, month, year

SELECT DAYOFWEEK(now());
SELECT DAYOFMONTH(now());
SELECT DAYOFYEAR(now());
SELECT WEEKOFYEAR(now());

 -- date arithmetic

SELECT date_add(now(), interval 2 day);
SELECT date_add(now(), interval 2 hour );
SELECT date_add(now(), interval 120 minute);

 -- https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html


