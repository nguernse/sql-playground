-- Aggregate author post count
SELECT author_id,
	COUNT(*) as num_posts
FROM public.posts
GROUP BY author_id
ORDER BY COUNT(*) desc;

-- Find author with the most posts
SELECT posts.author_id,
	users.name,
	COUNT(*) as num_posts
FROM public.posts as posts
JOIN public.users as users
	on posts.author_id = users.id
GROUP BY posts.author_id, users.name
ORDER BY COUNT(*) desc;