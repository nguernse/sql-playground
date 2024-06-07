-- Publish count
SELECT published, COUNT(*) as num_posts
FROM public.posts
GROUP BY published;

-- Publish count per author
SELECT posts.author_id, users.name, published, COUNT(*) as num_posts
FROM public.posts as posts
JOIN public.users as users
	ON posts.author_id = users.id
GROUP BY posts.published, posts.author_id, users.name
ORDER BY posts.author_id, COUNT(*);

-- Authors with no posts
SELECT users.name, count(*) as num_posts
FROM public.posts as posts
LEFT JOIN public.users as users
	ON posts.author_id = users.id
GROUP BY posts.author_id, users.name
HAVING COUNT(*) = 0;

-- Top 10 most active authors
SELECT users.name, count(*) as num_posts
FROM public.posts as posts
LEFT JOIN public.users as users
	ON posts.author_id = users.id
GROUP BY posts.author_id, users.name
ORDER BY COUNT(*) DESC
LIMIT 10;

-- Authors with over 45 posts
SELECT users.name, count(*) as num_posts
FROM public.posts as posts
LEFT JOIN public.users as users
	ON posts.author_id = users.id
GROUP BY posts.author_id, users.name
HAVING COUNT(*) > 45
ORDER BY COUNT(*) DESC;

-- Average post count
SELECT AVG(num_posts) as average_posts
FROM (
    SELECT posts.author_id, COUNT(*) as num_posts
    FROM public.posts as posts
    GROUP BY posts.author_id
) as post_counts;

-- Authors and their first and last post
SELECT
	DISTINCT posts.author_id,
	users.name,
	first_value(posts.title) over(partition by posts.author_id order by posts.created_at rows between unbounded preceding and unbounded following),
	last_value(posts.title) over(partition by posts.author_id  order by posts.created_at rows between unbounded preceding and unbounded following)
FROM public.posts as posts
JOIN public.users as users
	ON posts.author_id = users.id
ORDER BY posts.author_id;