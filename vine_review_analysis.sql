drop table if exists vine_table_count;

select * 
into vine_table_count
from vine_table
where total_votes > 20;

select * from vine_table_count;

drop table if exists positive_results;

select * 
into positive_results
from vine_table_count
WHERE CAST(helpful_votes AS FLOAT)/CAST(total_votes AS FLOAT) >=0.5;

drop table if exists vine_reviews;
drop table if exists non_vine_reviews;

select *
into vine_reviews
from positive_results 
where vine = 'Y';

select *
into non_vine_reviews
from positive_results 
where vine = 'N';

select count(distinct review_id)
		,sum(case when star_rating = 5 then 1 else 0 end) AS five_star_reviews
		,sum(case when star_rating = 5 then 1.0 else 0.0 end)/count(distinct review_id) as pct_five_star
from vine_reviews

select count(distinct review_id)
		,sum(case when star_rating = 5 then 1 else 0 end) AS five_star_reviews
		,sum(case when star_rating = 5 then 1.0 else 0.0 end)/count(distinct review_id) as pct_five_star
from non_vine_reviews