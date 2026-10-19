-- FoodTrack: relaciones entre tablas (claves foráneas).
-- Se ejecuta después de 01_create_tables.sql.
-- Cada clave foránea se agrega solo si todavía no existe, así el script se puede correr más de una vez.
USE foodtrack;

IF OBJECT_ID('fk_locations_foodtruck', 'F') IS NULL
    ALTER TABLE locations
        ADD CONSTRAINT fk_locations_foodtruck
        FOREIGN KEY (foodtruck_id) REFERENCES foodtrucks (foodtruck_id);

IF OBJECT_ID('fk_products_foodtruck', 'F') IS NULL
    ALTER TABLE products
        ADD CONSTRAINT fk_products_foodtruck
        FOREIGN KEY (foodtruck_id) REFERENCES foodtrucks (foodtruck_id);

IF OBJECT_ID('fk_orders_foodtruck', 'F') IS NULL
    ALTER TABLE orders
        ADD CONSTRAINT fk_orders_foodtruck
        FOREIGN KEY (foodtruck_id) REFERENCES foodtrucks (foodtruck_id);

IF OBJECT_ID('fk_order_items_order', 'F') IS NULL
    ALTER TABLE order_items
        ADD CONSTRAINT fk_order_items_order
        FOREIGN KEY (order_id) REFERENCES orders (order_id);

IF OBJECT_ID('fk_order_items_product', 'F') IS NULL
    ALTER TABLE order_items
        ADD CONSTRAINT fk_order_items_product
        FOREIGN KEY (product_id) REFERENCES products (product_id);
