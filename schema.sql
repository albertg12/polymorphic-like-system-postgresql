CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE posts (
    id SERIAL PRIMARY KEY,
    body VARCHAR(50) NOT NULL,
    user_id INTEGER NOT NULL REFERENCES users(id)
);

CREATE TABLE comments (
    id SERIAL PRIMARY KEY,
    post_id INTEGER NOT NULL REFERENCES posts(id),
    user_id INTEGER NOT NULL REFERENCES users(id),
    body TEXT NOT NULL
);

CREATE TABLE likes (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users(id),
    post_id INTEGER REFERENCES posts(id),
    comment_id INTEGER REFERENCES comments(id),

    CONSTRAINT unique_user_post_like UNIQUE (user_id, post_id),
    CONSTRAINT unique_user_comment_like UNIQUE (user_id, comment_id),

    CONSTRAINT likes_one_target_check
    CHECK (
        ((post_id IS NOT NULL)::int + (comment_id IS NOT NULL)::int) = 1
    )
);

-- 