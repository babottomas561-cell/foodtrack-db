-- FoodTrack: evolución del esquema.
-- Agrega la columna opcional "comentarios" a orders (acepta nulos).
-- Solo la agrega si todavía no existe, así el script se puede correr más de una vez.
USE foodtrack;

IF COL_LENGTH('orders', 'comentarios') IS NULL
    ALTER TABLE orders
        ADD comentarios NVARCHAR(255) NULL;
