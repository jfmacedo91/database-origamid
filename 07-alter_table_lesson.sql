CREATE TABLE "users" (
  "id" INTEGER PRIMARY KEY,
  "name" TEXT NOT NULL,
  "e-mail" TEXT NOT NULL UNIQUE,
  "role" TEXT NOT NULL DEFAULT 'user',
  "created" INTEGER NOT NULL DEFAULT (strftime('%s', 'now'))
) STRICT;

-- Alterações
ALTER TABLE "users" RENAME COLUMN "e-mail" TO "email";
ALTER TABLE "users" DROP COLUMN "role";
ALTER TABLE "users" ADD "ads" INTEGER DEFAULT 0;
ALTER TABLE "users_old" RENAME TO "users";

INSERT INTO "users"
  ("name", "email")
VALUES
  ('Jean', 'jean@email.com');

-- Refazer todo o schema da tabela
-- 1 Desativar chaves estrangeiras
PRAGMA foreign_keys = OFF;

-- 2 Iniciar transaction
BEGIN;

-- 3 Guardar Index, Trigger e View
SELECT "type", "sql" FROM "sqlite_schema" WHERE "tbl_name"='users';

-- 4 Criar tabela nova
CREATE TABLE "users_new" (
  "id" INTEGER PRIMARY KEY,
  "name" TEXT NOT NULL,
  "email" TEXT NOT NULL UNIQUE,
  "created" TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
) STRICT;

-- 5 Transferir dados
INSERT INTO "users_new" ("id", "name", "email", "created")
SELECT "id", "name", "email", datetime("created",'unixepoch') FROM "users";

-- 6 Deletar tabela antiga
DROP TABLE "users";

-- 7 Renomear tabela nova
ALTER TABLE "users_new" RENAME TO "users";

-- 8/9 Recriar Index, Trigger e View. Modificar o que for necessário

-- 10 Checar se quebrou alguma foreign key
PRAGMA foreign_key_check;

-- 11 Commit
COMMIT;

-- 12 Reabilidatar chaves estrangeiras
PRAGMA foreign_keys = ON;

SELECT * FROM sqlite_schema;