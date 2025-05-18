use airline1lakh;
select * from airlines;
select * from flights;

-- weekday / weekend flights--

select
case
when DAY_OF_WEEK <6 then "Weekday"
else "weekend"end as weeks,
count(FLIGHT_NUMBER) as Total_flights from flights
group by weeks;

-- Total airline delayed with distance between 2500 and 3000

select a.airlines,count(f.departure_delay) dep_delay
from flights f
join airlines a
on f.AIRLINE=a.IATA_CODE
where DEPARTURE_DELAY>15 and (DISTANCE between 2500 and 3000)
group by airlines
order by dep_delay desc;

-- weekwise total flight delayed

with CTE as
(select case
when f.DAY_OF_WEEK <6 then "weekday"
else "weekend"
end AS WEEKS,
a.Airlines,f.DEPARTURE_DELAY
from flights as f
join airlines as a
on f.AIRLINE=a.IATA_CODE
where DEPARTURE_DELAY >15
)
select WEEKS,Airlines,count(DEPARTURE_DELAY) as FLIGHTS_DELAY
from CTE
group by WEEKS,Airlines
order by FLIGHTS_DELAY desc;


-- city wise total flight delayed

with CTE as
(select P.CITY,A.Airlines,F.DEPARTURE_DELAY
from airports as P
join flights as F
ON P.IATA_CODE = F.ORIGIN_AIRPORT
JOIN airlines as A
ON F.AIRLINE=A.IATA_CODE
)
select CITY,Airlines,count(DEPARTURE_DELAY) as DEPARTURE_DELAY
from CTE
where DEPARTURE_DELAY >15
group by city,airlines
order by departure_delay desc;


-- state wise total flight delayed

with CTE as (
select p.state,a.Airlines,f.departure_delay
from airports as p
join flights as f on p.IATA_CODE=f.ORIGIN_AIRPORT
join airlines as a on f.AIRLINE=a.IATA_CODE
where f.departure_delay>15
)
select state,Airlines,count(departure_delay) as delay_count
from CTE
group by state,Airlines
order by delay_count desc;

-- total flight cancelled for jetblue airways on first day of every month --

select MONTH,count(F.CANCELLED)
from flights as F
join airlines as A
on F.AIRLINE = A.IATA_CODE
where A.Airlines="JETBLUE AIRWAYS" and F.CANCELLED = 1 and F.DAY = 1
group by MONTH;


