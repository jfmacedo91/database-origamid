CREATE TABLE "users" (
    "id" INTEGER PRIMARY KEY,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL UNIQUE,
    "created" TEXT DEFAULT CURRENT_TIMESTAMP
) STRICT;

CREATE TABLE "users_preferences" (
    "id" INTEGER PRIMARY KEY,
    "user_id" INTEGER NOT NULL,
    "ads" INTEGER NOT NULL DEFAULT 0 CHECK ("ads" IN (0, 1)),
    FOREIGN KEY("user_id") REFERENCES "users" ("id")
) STRICT;

BEGIN;
    INSERT INTO "users"
        ("name", "email")
    VALUES
        ('Jean', 'jean@email.com');
    
    INSERT INTO "users_preferences"
        ("user_id")
    VALUES
        (last_insert_rowid());
    
    UPDATE "users_preferences"
        SET "ads" = 1
    WHERE "user_id" = (SELECT "id" FROM "users" WHERE "email" = 'jean@email.com');
COMMIT;

ROLLBACK; -- Usado antes de fazer o commit da transação, para desfazer todas as operações da transação.