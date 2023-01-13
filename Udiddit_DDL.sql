CREATE TABLE bad_posts (
	id SERIAL PRIMARY KEY,
	topic VARCHAR(50),
	username VARCHAR(50),
	title VARCHAR(150),
	url VARCHAR(4000) DEFAULT NULL,
	text_content TEXT DEFAULT NULL,
	upvotes TEXT,
	downvotes TEXT
);

CREATE TABLE bad_comments (
	id SERIAL PRIMARY KEY,
	username VARCHAR(50),
	post_id BIGINT,
	text_content TEXT
);

CREATE TABLE "users" (
    "id" SERIAL PRIMARY KEY,
    "username" VARCHAR(25) UNIQUE NOT NULL
    CHECK (LENGTH(TRIM(username)) > 0),
    "last_login" TIMESTAMP);

CREATE TABLE "topics" (
    "name" VARCHAR(30) UNIQUE
    CHECK (LENGTH(TRIM(name)) > 0),
    "id" SERIAL PRIMARY KEY,
    "description" VARCHAR(500)
);
CREATE TABLE "posts" (
    "id" SERIAL PRIMARY KEY,
    "title" VARCHAR(100)
    CHECK (LENGTH(TRIM(title)) > 0),
    "url" VARCHAR CHECK (LENGTH(content) >= 0),
    "content" TEXT CHECK (LENGTH(url) >= 0),
    "topic_id" INTEGER,
    "user_id" INTEGER,
    FOREIGN KEY ("user_id") REFERENCES "users" ON DELETE CASCADE,
    "post_time" TIMESTAMP,
    FOREIGN KEY ("topic_id") REFERENCES "topics"("id") ON DELETE CASCADE,
    CONSTRAINT chk_url_content CHECK (
        "url" IS NOT NULL
        OR "content" IS NOT NULL
        )
);

CREATE TABLE "comments" (
    "id" SERIAL PRIMARY KEY,
    "comment" VARCHAR NOT NULL
    CHECK (LENGTH(TRIM(comment)) > 0),
    "post_id" INTEGER,
    FOREIGN KEY ("post_id") REFERENCES "posts" ON DELETE CASCADE,
    "user_id" INTEGER,
    FOREIGN KEY ("user_id") REFERENCES "users" ON DELETE SET NULL,
    "comment_time" TIMESTAMP,
    "parent_id" INTEGER,
    FOREIGN KEY ("parent_id") REFERENCES "comments" (id) ON DELETE
    CASCADE
);

CREATE TABLE "votes" (
    "id" SERIAL PRIMARY KEY,
    "upvotes" TEXT,
    "downvotes" TEXT,
    "user_id" INTEGER UNIQUE,
    FOREIGN KEY ("user_id") REFERENCES "users" ON DELETE SET NULL,
    "post_id" INTEGER UNIQUE,
    FOREIGN KEY ("post_id") REFERENCES "posts" ON DELETE CASCADE,
    UNIQUE ("post_id", "user_id")
);

CREATE INDEX "lower_username" ON "users" (LOWER("username"));

CREATE INDEX "topic_name" ON "topics" (LOWER("name"));

CREATE INDEX "specific_url" ON "posts" (LOWER("url"));
