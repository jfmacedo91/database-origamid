CREATE TABLE "usuarios" ("id", "nome");

PRAGMA table_info('usuarios');

DROP TABLE "usuarios";

INSERT INTO "usuarios" ("id", "nome") VALUES (1, 'Jean');

CREATE TABLE "cursos" (
  "id" INTEGER NOT NULL,
  "nome" TEXT NOT NULL,
  "aulas" INTEGER
);

PRAGMA table_info('cursos');

INSERT INTO "cursos"
  ("id", "nome", "aulas")
VALUES
  (1, 'HTML para Iniciantes', 5);
INSERT INTO "cursos"
  ("id", "nome", "aulas")
VALUES
  (2, 'JavaScript para Iniciantes', 10);
INSERT INTO "cursos"
  ("id", "nome", "aulas")
VALUES
  (3, 'CSS para Iniciantes', 10);
INSERT INTO "cursos"
  ("id", "nome", "aulas")
VALUES
  (4, 'PHP para Iniciantes', 8),
  (5, 'Node para Iniciantes', 12);

UPDATE "cursos"
SET "aulas" = 21, "nome" = 'HTML para Iniciantes'
WHERE "id" = 1;

DELETE FROM "cursos" WHERE "aulas" = 10;

SELECT * FROM "cursos" WHERE "aulas" > 9 ORDER BY "id" LIMIT 3;

DROP TABLE "cursos";
