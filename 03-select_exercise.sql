CREATE TABLE "users" (
  "id" INTEGER PRIMARY KEY,
  "name" TEXT NOT NULL,
  "password" TEXT NOT NULL,
  "email" TEXT NOT NULL COLLATE NOCASE UNIQUE,
  "created" TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
) STRICT;

INSERT INTO "users"
  ("name","password","email","created")
VALUES
  ('Carlos Silva','123456','carlos@email.com','2048-01-15 08:30:00'),
  ('João Pereira','123456','joao@email.com','2048-03-08 11:45:00'),
  ('Pedro Alves','123456','pedro@email.com','2048-05-20 14:10:00'),
  ('Lucas Souza','123456','lucas@email.com','2048-07-30 09:25:00'),
  ('Mateus Lima','123456','mateus@email.com','2048-10-12 16:05:00'),
  ('Ana Costa','123456','ana@email.com','2049-02-04 13:50:00'),
  ('Fernanda Rocha','123456','fernanda@email.com','2049-04-16 10:20:00'),
  ('Mariana Gomes','123456','mariana@email.com','2049-06-28 18:40:00'),
  ('Renata Dias','123456','renata@email.com','2049-09-09 07:15:00'),
  ('Beatriz Melo','123456','beatriz@email.com','2049-12-21 12:55:00');

CREATE TABLE "courses" (
  "id" INTEGER PRIMARY KEY,
  "slug" TEXT NOT NULL COLLATE NOCASE UNIQUE,
  "title" TEXT NOT NULL,
  "description" TEXT NOT NULL,
  "aulas" INTEGER NOT NULL,
  "horas" INTEGER NOT NULL,
  "created" TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
) STRICT;

INSERT INTO "courses"
  ("slug","title","description","aulas","horas","created")
VALUES
  ('html-para-iniciantes','HTML para Iniciantes','Aprenda a linguagem de marcação que é a base da web, começando do zero até páginas completas.',40,10,'2048-02-10 09:00:00'),
  ('css-animacoes','CSS - Animações','Domine transições, transforms e keyframes para criar efeitos de movimento modernos em sites.',35,8,'2048-06-22 14:30:00'),
  ('javascript-completo','JavaScript Completo','Do básico ao avançado: sintaxe, DOM, ES modules, APIs Web e programação assíncrona.',120,25,'2049-01-18 11:15:00'),
  ('sqlite-fundamentos','SQLite - Fundamentos','Entenda a instalação, comandos essenciais, consultas e boas práticas com o banco de dados embarcado.',50,12,'2049-05-05 16:45:00');

CREATE TABLE "lessons" (
  "id" INTEGER PRIMARY KEY,
  "course_id" INTEGER NOT NULL,
  "slug" TEXT NOT NULL COLLATE NOCASE,
  "title" TEXT NOT NULL,
  "materia" TEXT NOT NULL,
  "materia_slug" TEXT NOT NULL,
  "seconds" INTEGER NOT NULL,
  "video" TEXT NOT NULL,
  "description" TEXT NOT NULL,
  "lesson_order" INTEGER NOT NULL,
  "free" INTEGER NOT NULL DEFAULT 0 CHECK ("free" IN (0,1)),
  "created" TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY ("course_id") REFERENCES "courses" ("id"),
  UNIQUE("course_id", "slug")
) STRICT;

INSERT INTO "lessons"
  ("course_id","slug","title", "materia","materia_slug","seconds", "video","description","lesson_order","free","created")
VALUES
  (1,'introducao-ao-html','Introdução ao HTML','Fundamentos','fundamentos',300,'html01.mp4','Visão geral do HTML e configuração do ambiente.',1,1,'2048-02-15 09:00:00'),
  (1,'tags-basicas','Tags Básicas','Fundamentos','fundamentos',420,'html02.mp4','Uso das principais tags de estrutura.',2,0,'2048-02-17 09:00:00'),
  (1,'atributos-e-semantica','Atributos e Semântica','Fundamentos','fundamentos',360,'html03.mp4','Atributos globais e boas práticas semânticas.',3,0,'2048-02-19 09:00:00'),
  (1,'imagens-e-links','Imagens e Links','Multimídia','multimidia',480,'html04.mp4','Inserindo imagens responsivas e links internos/externos.',4,0,'2048-02-21 09:00:00'),
  (1,'conclusao','Conclusão','Estrutura','estrutura',540,'html05.mp4','Criando tabelas acessíveis e formulários semânticos.',5,0,'2048-02-23 09:00:00'),

  (2,'transicoes-css','Transições CSS','Fundamentos','fundamentos',360,'css01.mp4','Introdução às propriedades de transição.',1,1,'2048-06-25 14:30:00'),
  (2,'transforms-2d-e-3d','Transforms 2D e 3D','Fundamentos','fundamentos',420,'css02.mp4','Aplicando transformações de escala, rotação e translação.',2,0,'2048-06-27 14:30:00'),
  (2,'keyframes-na-pratica','@keyframes na prática','Animações','animacoes',480,'css03.mp4','Criando animações complexas com keyframes.',3,0,'2048-06-29 14:30:00'),
  (2,'propriedades-de-animacao','Propriedades de Animação','Animações','animacoes',450,'css04.mp4','Controlando timing, delay e iteration count.',4,0,'2048-07-01 14:30:00'),
  (2,'conclusao','Conclusão','Avançado','avancado',540,'css05.mp4','Disparando animações via Intersection Observer.',5,0,'2048-07-03 14:30:00'),

  (3,'introducao-ao-javascript','Introdução ao JavaScript','Fundamentos','fundamentos',300,'js01.mp4','História, versões ES e configuração do ambiente.',1,1,'2049-01-20 11:15:00'),
  (3,'variaveis-e-tipos','Variáveis e Tipos','Fundamentos','fundamentos',420,'js02.mp4','let, const, tipos primitivos e conversões.',2,0,'2049-01-22 11:15:00'),
  (3,'funcoes-e-escopo','Funções e Escopo','Fundamentos','fundamentos',480,'js03.mp4','Declaração, arrow functions e closures.',3,0,'2049-01-24 11:15:00'),
  (3,'dom-manipulation','DOM Manipulation','DOM','dom',540,'js04.mp4','Selecionando e alterando elementos HTML.',4,0,'2049-01-26 11:15:00'),
  (3,'fetch-api','Fetch API','Async','async',600,'js05.mp4','Requisições assíncronas com fetch e async/await.',5,0,'2049-01-28 11:15:00'),

  (4,'introducao-ao-sqlite','Introdução ao SQLite','Fundamentos','fundamentos',300,'sqlite01.mp4','O que é SQLite e onde usar.',1,1,'2049-05-08 16:45:00'),
  (4,'criacao-de-tabelas','Criação de Tabelas','DDL','ddl',420,'sqlite02.mp4','Sintaxe CREATE TABLE e tipos de dados.',2,0,'2049-05-10 16:45:00'),
  (4,'select-e-where','SELECT e WHERE','DML','dml',480,'sqlite03.mp4','Consultas básicas e filtros.',3,0,'2049-05-12 16:45:00'),
  (4,'insert-update-delete','INSERT, UPDATE, DELETE','DML','dml',540,'sqlite04.mp4','Manipulação de dados na prática.',4,0,'2049-05-14 16:45:00'),
  (4,'indices-e-otimizacao','Índices e Otimização','Performance','performance',600,'sqlite05.mp4','Criação de índices e análise de desempenho.',5,0,'2049-05-16 16:45:00');

CREATE TABLE "lessons_completed" (
  "user_id" INTEGER NOT NULL,
  "course_id" INTEGER NOT NULL,
  "lesson_id" INTEGER NOT NULL,
  "completed" TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("user_id", "course_id", "lesson_id"),
  FOREIGN KEY ("lesson_id") REFERENCES "lessons" ("id"),
  FOREIGN KEY ("course_id") REFERENCES "courses" ("id"),
  FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON DELETE CASCADE
) STRICT;

INSERT INTO "lessons_completed"
  ("user_id","course_id","lesson_id","completed")
VALUES
  (1,1,1,'2048-03-01 10:00:00'),
  (1,1,2,'2048-03-02 10:00:00'),
  (1,1,3,'2048-03-03 10:00:00'),
  (1,1,4,'2048-03-04 10:00:00'),
  (1,1,5,'2048-03-05 10:00:00'),
  (1,2,6,'2048-03-06 10:00:00'),
  (1,2,7,'2048-03-07 10:00:00'),
  (1,2,8,'2048-03-08 10:00:00'),
  (1,2,9,'2048-03-09 10:00:00'),
  (1,2,10,'2048-03-10 10:00:00'),
  (2,3,11,'2048-04-01 11:00:00'),
  (2,3,12,'2048-04-02 11:00:00'),
  (2,3,13,'2048-04-03 11:00:00'),
  (2,3,14,'2048-04-04 11:00:00'),
  (2,3,15,'2048-04-05 11:00:00'),
  (2,4,16,'2048-04-06 11:00:00'),
  (2,4,17,'2048-04-07 11:00:00'),
  (2,4,18,'2048-04-08 11:00:00'),
  (2,4,19,'2048-04-09 11:00:00'),
  (2,4,20,'2048-04-10 11:00:00'),
  (3,1,1,'2048-05-01 12:00:00'),
  (3,1,2,'2048-05-02 12:00:00'),
  (3,1,3,'2048-05-03 12:00:00'),
  (3,1,4,'2048-05-04 12:00:00'),
  (3,1,5,'2048-05-05 12:00:00'),
  (3,2,6,'2048-05-06 12:00:00'),
  (3,2,7,'2048-05-07 12:00:00'),
  (3,2,8,'2048-05-08 12:00:00'),
  (3,2,9,'2048-05-09 12:00:00'),
  (3,2,10,'2048-05-10 12:00:00'),
  (4,3,11,'2048-06-01 13:00:00'),
  (4,3,12,'2048-06-02 13:00:00'),
  (4,3,13,'2048-06-03 13:00:00'),
  (4,3,14,'2048-06-04 13:00:00'),
  (4,3,15,'2048-06-05 13:00:00'),
  (4,4,16,'2048-06-06 13:00:00'),
  (4,4,17,'2048-06-07 13:00:00'),
  (4,4,18,'2048-06-08 13:00:00'),
  (4,4,19,'2048-06-09 13:00:00'),
  (4,4,20,'2048-06-10 13:00:00'),
  (5,1,1,'2048-07-01 14:00:00'),
  (5,1,2,'2048-07-02 14:00:00'),
  (5,1,3,'2048-07-03 14:00:00'),
  (5,1,4,'2048-07-04 14:00:00'),
  (5,1,5,'2048-07-05 14:00:00'),
  (5,2,6,'2048-07-06 14:00:00'),
  (5,2,7,'2048-07-07 14:00:00'),
  (5,2,8,'2048-07-08 14:00:00'),
  (5,2,9,'2048-07-09 14:00:00'),
  (5,2,10,'2048-07-10 14:00:00'),
  (6,3,11,'2048-08-01 15:00:00'),
  (6,3,12,'2048-08-02 15:00:00'),
  (6,3,13,'2048-08-03 15:00:00'),
  (6,3,14,'2048-08-04 15:00:00'),
  (6,3,15,'2048-08-05 15:00:00'),
  (6,4,16,'2048-08-06 15:00:00'),
  (6,4,17,'2048-08-07 15:00:00'),
  (6,4,18,'2048-08-08 15:00:00'),
  (6,4,19,'2048-08-09 15:00:00'),
  (6,4,20,'2048-08-10 15:00:00'),
  (7,1,1,'2049-01-01 10:00:00'),
  (7,1,2,'2049-01-02 10:00:00'),
  (7,1,3,'2049-01-03 10:00:00'),
  (7,1,4,'2049-01-04 10:00:00'),
  (7,1,5,'2049-01-05 10:00:00'),
  (7,2,6,'2049-01-06 10:00:00'),
  (7,2,7,'2049-01-07 10:00:00'),
  (7,2,8,'2049-01-08 10:00:00'),
  (7,2,9,'2049-01-09 10:00:00'),
  (7,2,10,'2049-01-10 10:00:00'),
  (8,3,11,'2049-02-01 11:00:00'),
  (8,3,12,'2049-02-02 11:00:00'),
  (8,3,13,'2049-02-03 11:00:00'),
  (8,3,14,'2049-02-04 11:00:00'),
  (8,3,15,'2049-02-05 11:00:00'),
  (8,4,16,'2049-02-06 11:00:00'),
  (8,4,17,'2049-02-07 11:00:00'),
  (8,4,18,'2049-02-08 11:00:00'),
  (8,4,19,'2049-02-09 11:00:00'),
  (8,4,20,'2049-02-10 11:00:00'),
  (9,1,1,'2049-03-01 12:00:00'),
  (9,1,2,'2049-03-02 12:00:00'),
  (9,1,3,'2049-03-03 12:00:00'),
  (9,1,4,'2049-03-04 12:00:00'),
  (9,1,5,'2049-03-05 12:00:00'),
  (9,2,6,'2049-03-06 12:00:00'),
  (9,2,7,'2049-03-07 12:00:00'),
  (9,2,8,'2049-03-08 12:00:00'),
  (9,2,9,'2049-03-09 12:00:00'),
  (9,2,10,'2049-03-10 12:00:00'),
  (10,3,11,'2049-04-01 13:00:00'),
  (10,3,12,'2049-04-02 13:00:00'),
  (10,3,13,'2049-04-03 13:00:00'),
  (10,3,14,'2049-04-04 13:00:00'),
  (10,3,15,'2049-04-05 13:00:00'),
  (10,4,16,'2049-04-06 13:00:00'),
  (10,4,17,'2049-04-07 13:00:00'),
  (10,4,18,'2049-04-08 13:00:00'),
  (10,4,19,'2049-04-09 13:00:00'),
  (10,4,20,'2049-04-10 13:00:00');

CREATE TABLE "certificates" (
  "id" TEXT PRIMARY KEY,
  "user_id" INTEGER NOT NULL,
  "course_id" INTEGER NOT NULL,
  "completed" TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE ("user_id", "course_id"),
  FOREIGN KEY ("course_id") REFERENCES "courses" ("id"),
  FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON DELETE CASCADE
) STRICT;

INSERT INTO "certificates"
  ("id","user_id","course_id","completed")
VALUES
  ('bcg0zqum',1,1,'2048-03-11 10:30:00'),
  ('4k49owcs',1,2,'2048-03-12 10:30:00'),
  ('uf5w7zlm',2,3,'2048-04-11 11:30:00'),
  ('9oumw1fi',2,4,'2048-04-12 11:30:00'),
  ('cl1514p9',3,1,'2048-05-11 12:30:00'),
  ('m4w3lemj',3,2,'2048-05-12 12:30:00'),
  ('4ptlrhqc',4,3,'2048-06-11 13:30:00'),
  ('iiw3qj1v',4,4,'2048-06-12 13:30:00'),
  ('ligrezky',5,1,'2048-07-11 14:30:00'),
  ('mntsizdm',5,2,'2048-07-12 14:30:00'),
  ('rmw7nfc7',6,3,'2048-08-11 15:30:00'),
  ('o2d5epud',6,4,'2048-08-12 15:30:00'),
  ('1jtfu95z',7,1,'2049-01-11 10:30:00'),
  ('noghxkv1',7,2,'2049-01-12 10:30:00'),
  ('71ino092',8,3,'2049-02-11 11:30:00'),
  ('n385kool',8,4,'2049-02-12 11:30:00'),
  ('df00tns4',9,1,'2049-03-11 12:30:00'),
  ('fpsyspuw',9,2,'2049-03-12 12:30:00'),
  ('s8jjeccz',10,3,'2049-04-11 13:30:00'),
  ('zr5qee0t',10,4,'2049-04-12 13:30:00');

SELECT * FROM "lessons_completed"
JOIN "users" ON "lessons_completed"."user_id" = "users"."id";

SELECT "users"."name", "lessons_completed"."lesson_id" FROM "lessons_completed"
JOIN "users" ON "lessons_completed"."user_id" = "users"."id";

SELECT "u"."name", "lc"."lesson_id" FROM "lessons_completed" AS "lc"
JOIN "users" AS "u" ON "lc"."user_id" = "u"."id";

SELECT "u"."name", "l"."title" AS "lesson_title", "c"."title" AS "course_title"
FROM "lessons_completed" AS "lc"
JOIN "users" AS "u" ON "lc"."user_id" = "u"."id"
JOIN "lessons" AS "l" ON "lc"."lesson_id" = "l"."id"
JOIN "courses" AS "c" ON "lc"."course_id" = "c"."id"
WHERE "u"."email" = 'carlos@email.com' AND "c"."slug" = 'html-para-iniciantes';

SELECT "lc"."user_id", "l"."title", "lc"."completed"
FROM "lessons" AS "l"
LEFT JOIN "lessons_completed" AS "lc"
ON "lc"."lesson_id" = "l"."id" AND "lc"."user_id" = 1;

SELECT "a"."id", "a"."slug"
FROM "lessons" AS "a"
JOIN "lessons" AS "b" ON "a"."slug" = "b"."slug"
WHERE "a"."id" != "b"."id";

-- Exercício 01
SELECT "lesson_order", "title" FROM "lessons"
WHERE "course_id" = (SELECT "id" FROM "courses" WHERE "slug" = 'html-para-iniciantes')
ORDER BY "lesson_order" ASC;

-- Exercício 02
SELECT SUM("seconds") AS "total_seconds" FROM "lessons"
WHERE "course_id" = (SELECT "id" FROM "courses" WHERE "slug" = 'css-animacoes');

-- Exercício 03
SELECT "course_id", COUNT(*) AS "total_aulas"
FROM "lessons" GROUP BY "course_id";

-- Exercício 04
SELECT "course_id", SUM("seconds") AS "total_seconds"
FROM "lessons" GROUP BY "course_id" ORDER BY "total_seconds" DESC;

-- Exercício 05
SELECT "course_id", SUM("seconds") AS "total_seconds"
FROM "lessons" GROUP BY "course_id"
HAVING "total_seconds" > 2300
ORDER BY "total_seconds" DESC;

-- Exercício 06
SELECT "c"."title", SUM("l"."seconds") AS "total_seconds"
FROM "lessons" AS "l"
JOIN "courses" AS "c" ON "l"."course_id" = "c"."id"
GROUP BY "c"."id" ORDER BY "total_seconds" DESC;

-- Exercício 07
SELECT "id" FROM "certificates"
WHERE "user_id" = (SELECT "id" FROM "users" WHERE "email" = 'mariana@email.com');

-- Exercício 08
SELECT "l"."title", "lc"."completed" FROM "lessons" AS "l"
LEFT JOIN "lessons_completed" AS "lc" ON "l"."id" = "lc"."lesson_id"
AND "lc"."user_id" = (SELECT "id" FROM "users" WHERE "email" = 'lucas@email.com');

-- Exercício 09
SELECT *
FROM "lessons"
WHERE "course_id" = (SELECT "course_id" FROM "lessons" WHERE "slug" = 'funcoes-e-escopo')
AND "lesson_order" IN (
  (SELECT "lesson_order" FROM "lessons" WHERE "slug" = 'funcoes-e-escopo') - 1,
  (SELECT "lesson_order" FROM "lessons" WHERE "slug" = 'funcoes-e-escopo'),
  (SELECT "lesson_order" FROM "lessons" WHERE "slug" = 'funcoes-e-escopo') + 1
)
ORDER BY "lesson_order";

WITH "current" AS (
  SELECT "course_id", "lesson_order"
  FROM "lessons"
  WHERE "slug" = 'funcoes-e-escopo'
)
SELECT *
FROM "lessons"
WHERE "course_id" = (SELECT "course_id" FROM "current")
AND "lesson_order" IN (
  (SELECT "lesson_order" FROM "current") - 1,
  (SELECT "lesson_order" FROM "current"),
  (SELECT "lesson_order" FROM "current") + 1
)
ORDER BY "lesson_order";