--creating table Deliveries
create table Deliveries
as (select * from ipl_ball);

select * from deliveries;

--creating table Matches
create table Matches
as (select * from ipl_matches);
select * from Matches;


--1st query
select count(distinct city) from Matches;



--2nd query

create table deliveries_v02
as (select * from ipl_ball);
alter table deliveries_v02 add column ball_result varchar;
update deliveries_v02 set ball_result = (case  when (total_runs>= 4) then 'boundary'
		                               when (total_runs = 0) then 'dot'	
                                               when (total_runs<4 and total_runs>0) then 'other'
                                         end );

--3rd query
select ball_result, count(ball_result) as score from deliveries_v02 group by ball_result;


--4th 
select batting_team ,count(ball_result) as score from deliveries_v02 group by batting_team,ball_result having ball_result = 'boundary' order by score desc;


--5th
select bowling_team ,count(ball_result) as score from deliveries_v02 group by bowling_team,ball_result having ball_result = 'dot' order by score desc;


--6th 
select count(dismissal_kind) from deliveries_v02 where not dismissal_kind = 'NA';


--7th
select bowler,sum(extra_runs) as extra from deliveries group by bowler order by extra desc limit 5;

--8th 
create table deliveries_v03 as (select a.* ,b.venue, b.date from deliveries_v02 as a left join Matches as b on a.id=b.id );

--9th
select venue,sum(total_runs) as total from deliveries_v03 group by venue order by total desc;

--10th
select  extract(year from date) as dt, sum(total_runs) as total from deliveries_v03 where venue = 'Eden Gardens' group by dt order by total desc;

