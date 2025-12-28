CREATE TABLE "products" (
  "id" INTEGER NOT NULL,
  "name" TEXT NOT NULL,
  "price" INTEGER NOT NULL
);

CREATE TABLE "clients" (
  "id" INTEGER NOT NULL,
  "name" TEXT NOT NULL,
  "email" TEXT NOT NULL
);

CREATE TABLE "orders" (
  "id" INTEGER NOT NULL,
  "client_id" INTEGER NOT NULL,
  "product_id" INTEGER NOT NULL,
  "date" TEXT NOT NULL
);

INSERT INTO "products"
  ("id", "name", "price")
VALUES
  (1, 'Notebook', 1000),
  (2, 'Smartphone', 500),
  (3, 'Tablet', 300);

INSERT INTO "clients"
  ("id", "name", "email")
VALUES
  (1, 'Maria', 'maria@email.com'),
  (2, 'João', 'joao@email.com');

INSERT INTO "orders"
  ("id", "client_id", "product_id", "date")
VALUES
  (1, 2, 1, '2049-01-01'),
  (2, 1, 2, '2049-01-02'),
  (3, 2, 3, '2049-01-03');
  
SELECT * FROM "products";

SELECT "name" FROM "products" WHERE "price" > 400;

SELECT * FROM "orders" WHERE "client_id" = 2;