-- Pragmas
PRAGMA foreign_keys = ON;
PRAGMA synchtonous = NORMAL;
PRAGMA cache_size = 2000;
PRAGMA temp_store = memory;
PRAGMA busy_timeout = 5000;

-- Tables
CREATE TABLE "users" (
    "id" INTEGER PRIMARY KEY,
    "name" TEXT NOT NULL,
    "password_hash" TEXT NOT NULL,
    "email" TEXT NOT NULL COLLATE NOCASE UNIQUE,
    "username" TEXT NOT NULL COLLATE NOCASE UNIQUE,
    "created_at" TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
) STRICT;

CREATE TABLE "resets" (
    "token" TEXT PRIMARY KEY,
    "user_id" INTEGER NOT NULL,
    "ip" TEXT NOT NULL,
    "created_at" INTEGER NOT NULL DEFAULT (STRFTIME('%s', 'NOW')),
    "expires_at" INTEGER NOT NULL,
    FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON DELETE CASCADE
) WITHOUT ROWID, STRICT;

CREATE INDEX "idx_resets_user_id" ON "resets" ("user_id");

CREATE TABLE "sessions" (
    "token" TEXT PRIMARY KEY,
    "user_id" INTEGER NOT NULL,
    "ip" TEXT NOT NULL,
    "created_at" INTEGER NOT NULL DEFAULT (STRFTIME('%s', 'NOW')),
    "expires_at" INTEGER NOT NULL DEFAULT (STRFTIME('%s', 'NOW'))
) WITHOUT ROWID, STRICT;

CREATE INDEX "idx_sessions_user_id" ON "sessions" ("user_id");

CREATE TABLE "courses" (
    "id" INTEGER PRIMARY KEY,
    "slug" TEXT NOT NULL COLLATE NOCASE UNIQUE,
    "title" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "lessons" INTEGER NOT NULL,
    "hours" INTEGER NOT NULL,
    "created_at" TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
) STRICT;

CREATE TABLE "lessons" (
    "id" INTEGER PRIMARY KEY,
    "course_id" INTEGER NOT NULL,
    "slug" TEXT NOT NULL COLLATE NOCASE,
    "title" TEXT NOT NULL,
    "subject" TEXT NOT NULL,
    "subject_slug" TEXT NOT NULL,
    "seconds" INTEGER NOT NULL,
    "video" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "sequence" INTEGER NOT NULL,
    "free" INTEGER NOT NULL DEFAULT 0 CHECK ("free" IN (0, 1)),
    "created_at" TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY ("course_id") REFERENCES "courses" ("id"),
    UNIQUE ("course_id", "slug")
) STRICT;

CREATE INDEX "idx_lessons_sequence" ON "lessons" ("course_id", "sequence");

CREATE TABLE "lessons_completed" (
    "user_id" INTEGER NOT NULL,
    "course_id" INTEGER NOT NULL,
    "lesson_id" INTEGER NOT NULL,
    "completed_at" TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY ("user_id", "course_id", "lesson_id"),
    FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON DELETE CASCADE,
    FOREIGN KEY ("course_id") REFERENCES "courses" ("id") ON DELETE CASCADE,
    FOREIGN KEY ("lesson_id") REFERENCES "lessons" ("id") ON DELETE CASCADE
) WITHOUT ROWID, STRICT;

CREATE TABLE "certificates" (
    "id" TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(8)))),
    "user_id" INTEGER NOT NULL,
    "course_id" INTEGER NOT NULL,
    "completed_at" TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE ("user_id", "course_id"),
    FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON DELETE CASCADE,
    FOREIGN KEY ("course_id") REFERENCES "courses" ("id") ON DELETE CASCADE
) WITHOUT ROWID, STRICT;

-- Inserts

-- Users
INSERT INTO "users"
    ("name","password_hash","email", "username")
VALUES
    ('Carlos Silva', hex(randomblob(8)), 'carlos@email.com', 'carlos'),
    ('João Pereira', hex(randomblob(8)), 'joao@email.com', 'joao'),
    ('Pedro Alves', hex(randomblob(8)), 'pedro@email.com', 'pedro'),
    ('Lucas Souza', hex(randomblob(8)), 'lucas@email.com', 'lucas'),
    ('Mateus Lima', hex(randomblob(8)), 'mateus@email.com', 'mateus'),
    ('Ana Costa', hex(randomblob(8)), 'ana@email.com', 'ana'),
    ('Fernanda Rocha', hex(randomblob(8)), 'fernanda@email.com', 'fernanda'),
    ('Mariana Gomes', hex(randomblob(8)), 'mariana@email.com', 'mariana'),
    ('Renata Dias', hex(randomblob(8)), 'renata@email.com', 'renata'),
    ('Beatriz Melo', hex(randomblob(8)), 'beatriz@email.com', 'beatriz');

--- Resets
INSERT INTO "resets"
    ("token", "user_id", "ip", "expires_at")
VALUES
    (hex(randomblob(8)), 1, '123.1.1.1', strftime('%s','now','+12 hours')),
    (hex(randomblob(8)), 4, '123.1.1.2', strftime('%s','now','+12 hours')),
    (hex(randomblob(8)), 8, '123.1.1.3', strftime('%s','now','+12 hours'));

-- Sessions
INSERT INTO "sessions"
    ("token", "user_id", "ip", "expires_at")
VALUES
    (hex(randomblob(8)), 1, '123.1.1.1', strftime('%s','now','+30 days')),
    (hex(randomblob(8)), 4, '123.1.1.2', strftime('%s','now','+30 days')),
    (hex(randomblob(8)), 8, '123.1.1.3', strftime('%s','now','+30 days'));


--- Courses
INSERT INTO "courses"
    ("slug","title","description","lessons","hours")
VALUES
    ('html-para-iniciantes','HTML para Iniciantes','Aprenda a linguagem de marcação que é a base da web.',40,10),
    ('css-animacoes','CSS Animações','Domine transições, transforms e keyframes.',35,8),
    ('javascript-completo','JavaScript Completo','Sintaxe, DOM, ES modules, APIs Web e Async/Await',120,25),
    ('sqlite-fundamentos','SQLite Fundamentos','Aprenda create table, insert, select e mais.',50,12);

--- Lessons
INSERT INTO "lessons"
    ("course_id","slug","title", "subject","subject_slug","seconds", "video","description","sequence","free")
VALUES
    (1,'introducao-ao-html','Introdução ao HTML','Fundamentos','fundamentos',300,'html01.mp4','Visão geral do HTML e configuração do ambiente.',1,1),
    (1,'tags-basicas','Tags Básicas','Fundamentos','fundamentos',420,'html02.mp4','Uso das principais tags de estrutura.',2,0),
    (1,'atributos-e-semantica','Atributos e Semântica','Fundamentos','fundamentos',360,'html03.mp4','Atributos globais e boas práticas semânticas.',3,0),
    (1,'imagens-e-links','Imagens e Links','Multimídia','multimidia',480,'html04.mp4','Inserindo imagens responsivas e links internos/externos.',4,0),
    (1,'conclusao','Conclusão','Estrutura','estrutura',540,'html05.mp4','Criando tabelas acessíveis e formulários semânticos.',5,0),
    
    (2,'transicoes-css','Transições CSS','Fundamentos','fundamentos',360,'css01.mp4','Introdução às propriedades de transição.',1,1),
    (2,'transforms-2d-e-3d','Transforms 2D e 3D','Fundamentos','fundamentos',420,'css02.mp4','Aplicando transformações de escala, rotação e translação.',2,0),
    (2,'keyframes-na-pratica','@keyframes na prática','Animações','animacoes',480,'css03.mp4','Criando animações complexas com keyframes.',3,0),
    (2,'propriedades-de-animacao','Propriedades de Animação','Animações','animacoes',450,'css04.mp4','Controlando timing, delay e iteration count.',4,0),
    (2,'conclusao','Conclusão','Avançado','avancado',540,'css05.mp4','Disparando animações via Intersection Observer.',5,0),
    
    (3,'introducao-ao-javascript','Introdução ao JavaScript','Fundamentos','fundamentos',300,'js01.mp4','História, versões ES e configuração do ambiente.',1,1),
    (3,'variaveis-e-tipos','Variáveis e Tipos','Fundamentos','fundamentos',420,'js02.mp4','let, const, tipos primitivos e conversões.',2,0),
    (3,'funcoes-e-escopo','Funções e Escopo','Fundamentos','fundamentos',480,'js03.mp4','Declaração, arrow functions e closures.',3,0),
    (3,'dom-manipulation','DOM Manipulation','DOM','dom',540,'js04.mp4','Selecionando e alterando elementos HTML.',4,0),
    (3,'fetch-api','Fetch API','Async','async',600,'js05.mp4','Requisições assíncronas com fetch e async/await.',5,0),
    
    (4,'introducao-ao-sqlite','Introdução ao SQLite','Fundamentos','fundamentos',300,'sqlite01.mp4','O que é SQLite e onde usar.',1,1),
    (4,'criacao-de-tabelas','Criação de Tabelas','DDL','ddl',420,'sqlite02.mp4','Sintaxe CREATE TABLE e tipos de dados.',2,0),
    (4,'select-e-where','SELECT e WHERE','DML','dml',480,'sqlite03.mp4','Consultas básicas e filtros.',3,0),
    (4,'insert-update-delete','INSERT, UPDATE, DELETE','DML','dml',540,'sqlite04.mp4','Manipulação de dados na prática.',4,0),
    (4,'indices-e-otimizacao','Índices e Otimização','Performance','performance',600,'sqlite05.mp4','Criação de índices e análise de desempenho.',5,0);

-- Lessons Completed
INSERT INTO "lessons_completed"
    ("user_id","course_id","lesson_id")
VALUES
    (1,1,1),
    (1,1,2),
    (1,1,3),
    (1,2,6),
    (1,2,7),
    (1,2,8),
    (1,2,9),
    (2,3,11),
    (2,3,12),
    (2,3,13),
    (2,3,14),
    (2,3,15),
    (2,4,16),
    (2,4,17),
    (2,4,18),
    (3,1,1),
    (3,1,2),
    (3,1,3),
    (3,1,4),
    (3,1,5),
    (3,2,6),
    (3,2,7),
    (4,3,11),
    (4,3,12),
    (4,3,13),
    (4,3,14),
    (4,3,15),
    (4,4,16),
    (4,4,17),
    (4,4,18),
    (4,4,19),
    (5,1,2),
    (5,1,3),
    (5,1,4),
    (5,1,5),
    (5,2,6),
    (5,2,7),
    (5,2,8),
    (5,2,9),
    (5,2,10),
    (6,3,11),
    (6,3,12),
    (6,3,13),
    (6,3,14),
    (6,3,15),
    (6,4,16),
    (6,4,17),
    (6,4,18),
    (6,4,19),
    (7,1,3),
    (7,1,4),
    (7,1,5),
    (7,2,6),
    (7,2,7),
    (7,2,8),
    (7,2,9),
    (7,2,10),
    (8,3,11),
    (8,3,12),
    (8,3,13),
    (8,3,14),
    (8,3,15),
    (8,4,16),
    (8,4,17),
    (8,4,18),
    (8,4,19),
    (8,4,20),
    (9,1,1),
    (9,1,2),
    (9,1,3),
    (9,1,4),
    (9,1,5),
    (9,2,6),
    (9,2,9),
    (9,2,10),
    (10,3,11),
    (10,3,12),
    (10,3,13),
    (10,3,14),
    (10,3,15),
    (10,4,16),
    (10,4,17),
    (10,4,18),
    (10,4,19),
    (10,4,20);

-- Certificates
INSERT INTO "certificates"
    ("user_id","course_id")
VALUES
    (1,1),
    (1,2),
    (2,3),
    (2,4),
    (3,1),
    (3,2),
    (4,3),
    (4,4),
    (5,1),
    (5,2),
    (6,3),
    (6,4),
    (7,1),
    (7,2),
    (8,3),
    (8,4),
    (9,1),
    (9,2),
    (10,3),
    (10,4);

CREATE VIEW "lessons_completed_full" AS
SELECT "lc"."user_id", "u"."email", "c"."title" AS "course", "l"."title" AS "lesson", "lc"."completed_at"
FROM "lessons_completed" AS "lc"
JOIN "users" AS "u" ON "u"."id" = "lc"."user_id"
JOIN "courses" AS "c" ON "c"."id" = "lc"."course_id"
JOIN "lessons" AS "l" ON "l"."id" = "lc"."lesson_id";

SELECT * FROM "lessons_completed_full" WHERE "email" = 'joao@email.com';

CREATE VIEW "certificates_full" AS
SELECT "c"."id", "c"."user_id", "u"."name", "c"."course_id", "co"."title", "co"."hours", "co"."lessons", "c"."completed_at"
FROM "certificates" AS "c"
JOIN "users" AS "u" ON "u"."id" = "c"."user_id"
JOIN "courses" AS "co" ON "co"."id" = "c"."course_id";

SELECT * FROM "certificates_full" WHERE "user_id" = 5;

SELECT "c"."title", COUNT(*) AS "lessons_count"
FROM "lessons" AS "l"
JOIN "courses" AS "c" ON "c"."id" = "l"."course_id"
GROUP BY "course_id";

CREATE VIEW "lesson_nav" AS
SELECT "cl"."slug" AS "current_slug", "l".*
FROM "lessons" AS "cl"
JOIN "lessons" AS "l" ON "l"."course_id" = "cl"."course_id" AND "l"."sequence"
BETWEEN "cl"."sequence" - 1 AND "cl"."sequence" + 1
ORDER BY "l"."sequence";

SELECT * FROM "lesson_nav" WHERE "course_id" = 4 AND "current_slug" = 'select-e-where';

SELECT * FROM "users" WHERE "email" = 'ana@email.com';

SELECT * FROM "lessons" WHERE "course_id" = 1 ORDER BY "sequence";

SELECT * FROM "lessons"

WHERE "course_id" = (
  SELECT "id" FROM "courses"
  WHERE "slug" = 'javascript-completo'
) ORDER BY "sequence";

SELECT "slug", "title", "course_id" FROM "lessons" WHERE "free" = 1;

SELECT COUNT("l"."title") AS "total", COUNT("lc"."completed_at") AS "completed_at"
FROM "lessons" AS "l"
LEFT JOIN "lessons_completed" AS "lc"
ON "lc"."lesson_id" = "l"."id" AND "lc"."user_id" = 1
WHERE "l"."course_id" = 1;

SELECT (SUM("seconds") / 60) AS "total_minutos" FROM "lessons" WHERE "course_id" = 1;


CREATE TRIGGER "set_users_updated_at"
AFTER UPDATE ON "users"
BEGIN
    UPDATE "users"
    SET "updated_at" = CURRENT_TIMESTAMP
    WHERE "id" = NEW."id";
END;

UPDATE "users" SET "email" = 'beatriz.melo@email.com' WHERE "id" = 10;
UPDATE "users" SET "password_hash" = '123456' WHERE "id" = 9;
UPDATE "sessions" SET "expires_at" = strftime('%s','now') WHERE "user_id" = 4;

DELETE FROM "users" WHERE "id" = 7;
DELETE FROM "sessions" WHERE "expires_at" < strftime('%s','now');