CREATE TABLE "users" (
    "id" INTEGER PRIMARY KEY,
    "name" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "email" TEXT NOT NULL UNIQUE COLLATE NOCASE,
    "created_at" TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
) STRICT;

PRAGMA TABLE_INFO("users");

INSERT INTO "users"
    ("name", "password", "email")
VALUES
    ('Jean', 'senhaforte', 'jean@email.com');
    
SELECT * FROM "users";

DROP TABLE "users";

CREATE TABLE "courses" (
    "id" INTEGER PRIMARY KEY,
    "slug" TEXT NOT NULL UNIQUE COLLATE NOCASE,
    "title" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "lessons" INTEGER NOT NULL,
    "hours" INTEGER NOT NULL,
    "created_at" TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
) STRICT;

PRAGMA TABLE_INFO("courses");

INSERT INTO "courses"
    ("slug", "title", "description", "lessons", "hours")
VALUES
    ('javascript-basico', 'JavaScript Básico', 'Aprenda os fundamentos da linguagem JavaScript.', 20, 5);
    
SELECT * FROM "courses";

DROP TABLE "courses";

CREATE TABLE "lessons" (
    "id" INTEGER PRIMARY KEY,
    "course_id" INTEGER NOT NULL,
    "slug" TEXT NOT NULL COLLATE NOCASE,
    "title" TEXT NOT NULL,
    "material" TEXT NOT NULL,
    "material_slug" TEXT NOT NULL,
    "seconds" INTEGER NOT NULL,
    "video" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "lesson_order" INTEGER NOT NULL,
    "free" INTEGER NOT NULL DEFAULT 0 CHECK ("free" IN (0, 1)),
    "created_at" TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY ("course_id") REFERENCES "courses" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    UNIQUE ("course_id", "slug")
) STRICT;

PRAGMA TABLE_INFO("lessons");

INSERT INTO "lessons"
    ("course_id", "slug", "title", "material", "material_slug", "seconds", "video", "description", "lesson_order", "free")
VALUES
    (1, 'variaveis-let-const', 'Variáveis: let e const', 'Fundamentos', 'fundamentos', 480, 'variaveis.mp4', 'Entenda a diferença entre let, const e var.', 3, 1);
    
SELECT * FROM "lessons";

DROP TABLE "lessons";

CREATE TABLE "lessons_completed" (
    "user_id" INTEGER NOT NULL,
    "course_id" INTEGER NOT NULL,
    "lesson_id" INTEGER NOT NULL,
    "completed_at" TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY ("user_id", "course_id", "lesson_id"),
    FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY ("course_id") REFERENCES "courses" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY ("lesson_id") REFERENCES "lessons" ("id") ON DELETE CASCADE ON UPDATE CASCADE
) STRICT;

PRAGMA TABLE_INFO("lessons_completed");

INSERT INTO "lessons_completed"
    ("user_id", "course_id", "lesson_id")
VALUES
    (1, 1, 1);
    
SELECT * FROM "lessons_completed";

DROP TABLE "lessons_completed";

CREATE TABLE "certificates" (
    "id" TEXT PRIMARY KEY,
    "user_id" INTEGER NOT NULL,
    "course_id" INTEGER NOT NULL,
    "completed_at" TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY ("course_id") REFERENCES "courses" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    UNIQUE ("user_id", "course_id")
) STRICT;

PRAGMA TABLE_INFO("certificates");

INSERT INTO "certificates"
    ("id", "user_id", "course_id")
VALUES
    ('asodiajsod', 1, 1);
    
SELECT * FROM "certificates";

DROP TABLE "certificates";