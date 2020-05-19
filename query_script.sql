USE shopifyapps;

#5star apps w/ category name, tagline, rating, reviews count, ordered by reveiws count and category

SELECT 
    a.title,
    a.tagline,
    a.rating,
    a.reviews_count,
    c.title AS category_name
FROM
    apps a
        INNER JOIN
    apps_categories ac ON a.id = ac.app_id
        INNER JOIN
    category c ON ac.category_id = c.category_id
WHERE
    a.rating = 5
ORDER BY category_name , a.reviews_count DESC;

#based on above result, filter out the app with the most reviews in each category

SELECT 
    MAX(a.reviews_count) AS max_review,
    a.title,
    a.tagline,
    a.rating,
    c.title AS category_name
FROM
    apps a
        INNER JOIN
    apps_categories ac ON a.id = ac.app_id
        INNER JOIN
    category c ON ac.category_id = c.category_id
WHERE
    a.rating = 5
GROUP BY category_name
ORDER BY max_review;

#most reviewed apps and it's price in each category

SELECT 
    mra.app_name, mra.review_count, mra.category_name, pp.price
FROM
    (SELECT 
        id,
            rating,
            MAX(reviews_count) AS review_count,
            tagline,
            a.title AS app_name,
            c.title AS category_name
    FROM
        apps a
    LEFT JOIN apps_categories ac ON a.id = ac.app_id
    LEFT JOIN category c ON ac.category_id = c.category_id
    GROUP BY category_name) mra
        LEFT JOIN
    pricing_plan pp ON mra.id = pp.app_id;
        
# of apps in each category

SELECT 
	COUNT(a.id) AS num_of_apps,
    c.title AS category_name
FROM 
	apps a 
    LEFT JOIN 
	apps_categories ac ON a.id = ac.app_id
    LEFT JOIN
	category c ON ac.category_id = c.category_id
GROUP BY category_name;    

# of 5 star apps in each category

SELECT 
	COUNT(a.id) AS num_of_apps,
    c.title AS category_name
FROM 
	apps a 
    LEFT JOIN 
	apps_categories ac ON a.id = ac.app_id
    LEFT JOIN
	category c ON ac.category_id = c.category_id
WHERE a.rating = 5
GROUP BY category_name
ORDER BY num_of_apps;

# of 5 rating apps vs non 5 rating apps
SELECT 
	a. title AS apps,
    c.title AS category_name,
    
    CASE
    WHEN a.rating = 5 THEN 1
    ELSE 0
    END AS five_rating_app
FROM 
	apps a 
    LEFT JOIN 
	apps_categories ac ON a.id = ac.app_id
    LEFT JOIN
	category c ON ac.category_id = c.category_id
ORDER BY category_name;    

#of apps by rating score

 SELECT 
    COUNT(a.id) AS num_of_apps, a.rating
FROM
    apps a
GROUP BY a.rating;