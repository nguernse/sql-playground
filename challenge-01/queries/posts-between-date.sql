SELECT *
FROM public.posts
WHERE created_at >= '2023-01-01' AND created_at <= '2023-01-31';

-- NOTE: Between is inclusive
SELECT *
FROM public.posts
WHERE created_at BETWEEN '2023-01-01' AND '2023-01-31';