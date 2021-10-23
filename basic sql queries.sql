/*select customer information for customers who live in Los Angeles*/

select * from customer
where city=’Los Angeles’;

/*What status is associated with status_id 2*/

select status from status
where status_id=2;

/*count on the "customer" table*/

select count(*) as total_customer_count from customer;

/*average value of all approved claims*/

select round(avg(amount)::numeric, 2) as avg_value_approved_claims from claim
where status_id=2;

/*the amount of claim number "791870697-8"*/

select amount from claim
where claim_number='791870697-8';

/*customer whose average policy_limit is less than 10000*/

select customer_number from policy
group by customer_number
having avg(policy_limit) < 10000;

/*Sort the custome_number base on the average policy_limit value in descending order*/

select round(avg(policy_limit)::numeric, 2) as avg_policy_limit, customer_number from policy
group by customer_number
order by avg_policy_limit desc

/*top 5 policies by claim count*/

select policy_number, count(*) as claim_count from claim
group by policy_number
order by claim_count desc
limit 5

/*What are the top 5 policies by total claim amount*/

select policy_number, sum(amount) as total_claim_amount from claim
group by policy_number
order by total_claim_amount desc
limit 5
