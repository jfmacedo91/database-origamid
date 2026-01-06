CREATE TABLE "users" (
  "id" INTEGER PRIMARY KEY,
  "email" TEXT NOT NULL UNIQUE
) STRICT;

CREATE TABLE "users_config" (
  "user_id" INTEGER PRIMARY KEY REFERENCES "users" ("id") ON DELETE CASCADE,
  "config" TEXT NOT NULL CHECK (json_valid("config"))
) STRICT;

INSERT INTO "users"
  ("email")
VALUES
  ('jean@email.com'), ('jessica@email.com');

INSERT INTO "users_config"
  ("config")
VALUES
  (json('{"video": 1, "speed": 2.5, "font": "monospace"}')),
  (json('{"video": 2, "speed": 1, "font": "arial"}'));

SELECT
  json_extract("config", '$.font') AS "font",
  json_extract("config", '$.speed') AS "speed"
FROM "users_config";

SELECT typeof(json_extract('{"dado": 1}', '$.dado')); -- integer
SELECT typeof(json_extract('{"dado": "1"}', '$.dado')); -- text

-- Esse operador funciona como json_extract, o -> retorna sempre texto e o ->> retorna no tipo do SQLite.
SELECT
  "config" ->> '$.font' AS "font",
  "config" ->> '$.video' AS "video"
FROM "users_config";

-- Pode ser utilizado em qualquer lugar.
SELECT "user_id" FROM "users_config"
WHERE "config"->>'$.font' = 'arial';

SELECT typeof('{"dado": 1}'->'$.dado'); -- text
SELECT typeof('{"dado": 1}'->>'$.dado'); -- integer

-- Alterar json
UPDATE "users_config"
SET "config" = json_set("config", '$.font', 'helvetica')
WHERE "user_id" = 1;

UPDATE "users_config"
SET "config" = json_insert("config", '$.ads', 0)
WHERE "user_id" = 1;

UPDATE "users_config"
SET "config" = json_replace("config", '$.ads', 1)
WHERE "user_id" = 1;

UPDATE "users_config"
SET "config" = json_remove("config", '$.ads')
WHERE "user_id" = 1;

CREATE TABLE "users_config2" (
  "user_id" INTEGER PRIMARY KEY REFERENCES "users" ("id"),
  "config" TEXT NOT NULL CHECK (json_valid("config")),
  "ads" INTEGER AS ("config" ->> '$.ads') STORED
) STRICT;

INSERT INTO "users_config2"
  ("config")
VALUES
  (json('{"video": 1, "speed": 2.5, "font": "monospace", "ads": 0}')),
  (json('{"video": 2, "speed": 1, "font": "arial", "ads": 1}'));

-- Selecinar item em array
SELECT '[1, 2, 3, 4, 5]' ->> '$[3]';
SELECT json_array('pt-br', 'en-us', 'es-es') ->> '$[1]';
SELECT json_set('[1, 2, 3, 4, 5]', '$[2]', 10);