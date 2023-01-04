--Queries to find clues about the prime suspect
select * from crime_scene_report where date = '20180115' and type = 'murder' and city = 'SQL City'
select * from person where name like '%Annabel%' and address_street_name = 'Franklin Ave'
select * from person where address_street_name like '%Northwestern Dr%' order by address_number desc
select * from interview where person_id = '16371' or person_id = '14887'
select * from get_fit_now_member where id like '48Z%' and membership_status = 'gold'
select * from drivers_license where plate_number like '%H42W%'
select * from get_fit_now_check_in where check_in_date = '20180109'

--Queries to narrow down to one suspect
select g.id, g.membership_status, p.name
from person p
join get_fit_now_member g
on p.id = g.person_id
where p.id = '16371' or p.id = '14887'

select p.id, p.name, p.license_id, d.age, d.gender, d.plate_number
from person p
join drivers_license d
on p.license_id = d.id
where d.plate_number like '%H42W%'

--Queries to find the main brain behind the murder case.
select * from interview where person_id = '67318'
select p.id, p.name, p.license_id, d.age, d.gender, d.height, d.hair_color, d.car_make, d.car_model, f.event_name, f.date
from person p
join drivers_license d
on p.license_id = d.id
join facebook_event_checkin f
on p.id = f.person_id
where f.event_name = 'SQL Symphony Concert' and d.gender = 'female' and car_make='Tesla' and car_model = 'Model S'
