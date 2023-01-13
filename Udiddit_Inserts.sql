INSERT INTO "users" ("username")
    SELECT DISTINCT "username"
    FROM "bad_posts"
UNION
    SELECT DISTINCT "username"
    FROM "bad_comments"
    UNION
    SELECT DISTINCT regexp_split_to_table("upvotes",',')
    FROM "bad_posts"
UNION
    SELECT DISTINCT regexp_split_to_table("downvotes",',')
    FROM "bad_posts";

INSERT INTO "topics"("name")
    SELECT DISTINCT "topic"
    FROM "bad_posts";

INSERT INTO "comments"("post_id", "user_id", "comment")
    SELECT "posts"."id", "users"."id", "bad_comments"."text_content"
    FROM "posts"
    JOIN "users"
    ON "posts"."user_id" = "users"."id"
    JOIN "bad_comments"
    ON "posts"."id" = "bad_comments"."post_id";

INSERT INTO "posts"("title", "content", "url", "user_id", "topic_id")
    SELECT LEFT("bad_posts"."title", 100), "bad_posts"."text_content",
    "bad_posts"."url", "users"."id", "topics"."id"
    FROM "bad_posts"
    JOIN "users"
    ON "bad_posts"."username" = "users"."username"
    JOIN "topics"
    ON "bad_posts"."topic" = "topics"."name";

INSERT INTO "votes"("upvotes", "downvotes")
    SELECT regexp_split_to_table("upvotes", ','),
    regexp_split_to_table("downvotes", ',')
    FROM "bad_posts";
