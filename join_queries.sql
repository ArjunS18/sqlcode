/*Count of Nissan cars are insured by this insurance company*/

select count(policy.policy_number) as insured_car_count from policy where policy.vin in    (select vehicle.vin from vehicle where car_type_id in (
     select car_type_id from car_type where car_make='Nissan'))

/*Select customers whose first_name contains ‘an’ and last_name contains ’de’*/

select * from customer
where first_name like '%an%' and last_name like '%de%'

/*Select customers whose first_name start with ‘a’ and are at least 3 characters in length*/

select * from customer
where first_name like 'A%' and length(first_name) >= 3

/*amount of the largest approved claim*/

select policy_number, claim_number, amount from claim
where amount = (select max(amount) as max_claim from claim
where status_id = 2)

/*Count policies that have NO claims*/

select count(policy.policy_number) as policy_with_no_claim from policy
left join claim 
on policy.policy_number = claim.policy_number
where claim.claim_number IS null

/*Find vehicle identification number (VIN) and model year for cars with a policy expiration date after October 31, 2019 and a model year of 1985 or earlier*/

select vehicle.vin, vehicle.model_year from vehicle
left outer join policy
on vehicle.vin = policy.vin
where policy.expiration_date > '2019-10-31' and vehicle.model_year <= '1985'

/*List the distinct cities in New York or New Jersey where customers who have policies with NO claims live*/ 

select distinct customer.city from customer
 where customer_number in (
             select policy.customer_number from policy left join claim
	on policy.policy_number = claim.policy_number
              where claim.claim_number IS null) 
             and customer.state in ('New York', 'New Jersey')

/*Find average deductible by claim status for claims with a date in January 2019 OR claims for vehicles manufactured by Ford*/

select round(avg(deductible), 2) as avg_deductible, status_id from policy
inner join claim on policy.policy_number = claim.policy_number
inner join vehicle on policy.vin = vehicle.vin
inner join car_type on vehicle.car_type_id = car_type.car_type_id
where car_type.car_make = 'Ford' or cast(claim.claim_date as text) like '2019-01-%'
group by claim.status_id
