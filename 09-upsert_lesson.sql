CREATE TABLE "users" (
  "id" INTEGER PRIMARY KEY,
  "name" TEXT NOT NULL,
  "email" TEXT NOT NULL UNIQUE,
  "ads" INTEGER NOT NULL DEFAULT 0 CHECK("ads" IN (0,1)),
  "subscription" TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "created" TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
) STRICT;

-- Atualiza o ads
INSERT INTO "users" ("name", "email", "ads")
VALUES ('Jean', 'jean@email.com', 1)
ON CONFLICT("email") DO UPDATE
SET "ads" = excluded."ads";

-- Atualiza apenas se subscription novo for maior
INSERT INTO "users" ("name", "email", "subscription")
VALUES ('Jean', 'jean@email.com', DATETIME('now','+60 days'))
ON CONFLICT("email") DO UPDATE
SET "subscription" = excluded."subscription"
WHERE excluded."subscription" > "subscription";

-- Não faz nada
INSERT INTO "users" ("name", "email", "ads")
VALUES ('Jean', 'jean@email.com', 0)
ON CONFLICT("email") DO NOTHING;

-- Não faz nada
INSERT OR IGNORE INTO "users" ("name", "email", "ads")
VALUES ('Jean Novo', 'jean@email.com', 0);

-- Deleta e insere o novo
INSERT OR REPLACE INTO "users" ("name", "email", "ads")
VALUES ('Jessica', 'jessica@email.com', 1);

-- Returning
CREATE TABLE "certificates" (
  "id" TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(16)))),
  "user_id" INTEGER NOT NULL,
  "course_id" INTEGER NOT NULL,
  "completed" TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
) WITHOUT ROWID, STRICT;

INSERT INTO "certificates" ("user_id", "course_id") VALUES (1,1);
SELECT * FROM "certificates" WHERE "id" = '';

-- Retorna o ID
INSERT INTO "certificates" ("user_id", "course_id")
VALUES (1,1) RETURNING "id";

-- Retornar todas as colunas
INSERT INTO "certificates" ("user_id", "course_id")
VALUES (1,1) RETURNING *;