CREATE TABLE "stats" (
    "name" TEXT PRIMARY KEY,
    "value" INTEGER NOT NULL
) STRICT;

INSERT INTO "stats"
    ("name", "value")
VALUES
    ('user_count', (SELECT COUNT(*) FROM "users"));

CREATE TRIGGER "trg_users_insert"
AFTER INSERT ON "users"
BEGIN
    UPDATE "stats" SET "value" = "value" + 1
    WHERE "name" = 'user_count';
END;

INSERT INTO "users"
    ("name","password", "email")
VALUES
    ('Jean', '123', 'jfm@mail.com');
    
CREATE TRIGGER "trg_users_delete"
AFTER DELETE ON "users"
BEGIN
    UPDATE "stats" SET "value" = "value" - 1
    WHERE "name" = 'user_count';
END;

DELETE FROM "users" WHERE "email" = 'jfm@mail.com';

CREATE TABLE "user_changes" (
  "id" INTEGER PRIMARY KEY,
  "user_id" INTEGER NOT NULL,
  "old_email" TEXT NOT NULL,
  "new_email" TEXT NOT NULL,
  FOREIGN KEY ("user_id") REFERENCES "users" ("id")
);

CREATE TRIGGER "trg_log_email_change"
BEFORE UPDATE OF "email" ON "users"
WHEN lower(OLD."email") <> lower(NEW."email")
BEGIN
  INSERT INTO "user_changes" ("user_id", "old_email", "new_email")
  VALUES (OLD."id", OLD."email", NEW."email");
END;

UPDATE "users" SET "email" = 'carlos@email.com' WHERE "id" = 1;

CREATE TRIGGER "trg_create_certicate"
AFTER INSERT ON "lessons_completed"
WHEN (
    (SELECT COUNT(*) FROM "lessons_completed" WHERE "user_id" = NEW."user_id" AND "course_id" = NEW."course_id")
    =
    (SELECT COUNT(*) FROM "lessons" WHERE "course_id" = NEW."course_id")
)
BEGIN
    INSERT OR IGNORE INTO "certificates"
        ("id", "user_id", "course_id")
    VALUES
        (lower(hex(randomblob(16))), NEW."user_id", NEW."course_id");
END;

INSERT INTO "lessons_completed"
    ("user_id", "course_id", "lesson_id")
VALUES
    (11, 1, 1),
    (11, 1, 2),
    (11, 1, 3),
    (11, 1, 4),
    (11, 1, 5);
    
-- Generated Columns
SELECT *, STRFTIME('%Y', "created") AS "ano" FROM "users";

CREATE TABLE "users2" (
    "id" INTEGER PRIMARY KEY,
    "nome" TEXT NOT NULL,
    "sobrenome" TEXT NOT NULL,
    "nome_completo" TEXT GENERATED ALWAYS AS ("nome" || ' ' || "sobrenome") STORED
) STRICT;

INSERT INTO "users2"
    ("nome", "sobrenome")
VALUES
    ('Jean', 'Macedo');
    
SELECT * FROM "users2";

SELECT *, ("nome" || ' ' || "sobrenome") AS "nome_completo2" FROM "users2";

CREATE VIEW "lessons_completed_descriptive" AS
SELECT "u"."email", "l"."title" AS "lesson", "c"."title" AS "course", "lc"."completed"
FROM "lessons_completed" AS "lc"
JOIN "users" AS "u" ON "lc"."user_id" = "u"."id"
JOIN "lessons" AS "l" ON "lc"."lesson_id" = "l"."id"
JOIN "courses" AS "c" ON "lc"."course_id" = "c"."id";

SELECT * FROM "lessons_completed_descriptive" WHERE "email" = 'mariana@email.com';