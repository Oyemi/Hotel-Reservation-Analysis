select * from hotel;
ALTER TABLE hotel RENAME COLUMN ï»¿hotel TO hotels;
ALTER TABLE hotel ADD arrival_date_month_num INT;
ALTER TABLE hotel ADD arrival_date varchar(20);

CREATE TABLE Months (
    arrival_date_month VARCHAR(20),
    MonthNumber INT
);
 
UPDATE hotel h
LEFT OUTER JOIN Months m ON h.arrival_date_month = m.arrival_date_month
SET h.arrival_date_month_num = m.MonthNumber;

UPDATE hotel
SET arrival_date = CONCAT(arrival_date_day_of_month, "/", arrival_date_month_num, "/", arrival_date_year);

select * from hotel;

# EDA

# How many reservations were made?
select count(hotels) from hotel;

# Question: Where do the reservations/guests come from? - Top 10 countries
select country, COUNT(country) as TotalGuests
from hotel
where is_canceled = 0
group by country
order by TotalGuests desc limit 10;

# Which months had the most reservations
select arrival_date_month, COUNT(arrival_date_month) as GuestPerMonth
from hotel
group by arrival_date_month
order by GuestPerMonth desc;

select arrival_date_month, arrival_date_year, COUNT(arrival_date_month) as GuestPerMonths
from hotel
group by arrival_date_month, arrival_date_year
order by GuestPerMonths desc;

# Which are the busiest months? Months with most non-cancelled bookings
select arrival_date_month, arrival_date_year, COUNT(arrival_date_month) as GuestPerMonths
from hotel
where is_canceled = 0
group by arrival_date_month, arrival_date_year
order by GuestPerMonths desc;

# How many bookings were canceled?
select count(is_canceled) from hotel
where is_canceled = 1;

# Which month has the highest number of cancelations?
select arrival_date_month, arrival_date_year, COUNT(arrival_date_month) as NoShow
from hotel
where is_canceled = 1
group by arrival_date_month, arrival_date_year
order by NoShow desc;

# Bookings by market segment - all bookings, completed bookings
select market_segment, COUNT(market_segment) as NoMktSgmnt
from hotel
group by market_segment
order by NoMktSgmnt desc;

select market_segment, COUNT(market_segment) as NoMktSgmnt
from hotel
where is_canceled = 0
group by market_segment
order by NoMktSgmnt desc;

select distinct hotels from hotel;

