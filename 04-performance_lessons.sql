SELECT COUNT(*) FROM "users";

SELECT * FROM "sqlite_schema" WHERE "type" = 'index';
PRAGMA index_list('certificates');
PRAGMA index_info('sqlite_autoindex_certificates_2');
PRAGMA index_xinfo('sqlite_autoindex_certificates_2');

SELECT * FROM "users" WHERE "email" = 'lara.pereira6863@example.com';
EXPLAIN QUERY PLAN SELECT * FROM "users" WHERE "email" = 'lara.pereira6863@example.com';

SELECT * FROM "users" WHERE "email2" = 'lara.pereira6863@example.com';
EXPLAIN QUERY PLAN SELECT * FROM "users" WHERE "email2" = 'lara.pereira6863@example.com';

SELECT * FROM "users" WHERE "created" = '2028-11-25 20:43:59';
EXPLAIN QUERY PLAN SELECT * FROM "users" WHERE "created" = '2028-11-25 20:43:59';

CREATE INDEX "idx_users_created" ON "users" ("created");

SELECT * FROM "users" WHERE "created" > '2028-11' LIMIT 50;
EXPLAIN QUERY PLAN SELECT * FROM "users" WHERE "created" > '2028-11' LIMIT 50;

-- 0 - 100, quanto mais próximo de 100, mais útil será o índice
SELECT (100 * COUNT(DISTINCT "sku") / COUNT(*)) AS "card" FROM "products";
SELECT (100 * COUNT(DISTINCT "free") / COUNT(*)) AS "card" FROM "lessons";