-- FoodTrack: creación de tablas con claves primarias y restricciones.
-- Las claves foráneas se agregan aparte en 02_add_foreign_keys.sql.
-- Cada tabla se crea solo si todavía no existe, así el script se puede correr más de una vez.
USE foodtrack;

IF OBJECT_ID('foodtrucks', 'U') IS NULL
    CREATE TABLE foodtrucks (
        foodtruck_id INT           NOT NULL,
        name         NVARCHAR(100) NOT NULL,
        cuisine_type NVARCHAR(50)  NOT NULL,
        city         NVARCHAR(100) NOT NULL,
        CONSTRAINT pk_foodtrucks PRIMARY KEY (foodtruck_id),
        CONSTRAINT uq_foodtrucks_name UNIQUE (name)
    );

IF OBJECT_ID('locations', 'U') IS NULL
    CREATE TABLE locations (
        location_id   INT           NOT NULL,
        foodtruck_id  INT           NOT NULL,
        location_date DATE          NOT NULL,
        zone          NVARCHAR(100) NOT NULL,
        CONSTRAINT pk_locations PRIMARY KEY (location_id),
        -- un foodtruck no puede estar en dos zonas el mismo día
        CONSTRAINT uq_locations_truck_date UNIQUE (foodtruck_id, location_date)
    );

IF OBJECT_ID('products', 'U') IS NULL
    CREATE TABLE products (
        product_id   INT            NOT NULL,
        foodtruck_id INT            NOT NULL,
        name         NVARCHAR(100)  NOT NULL,
        price        DECIMAL(10, 2) NOT NULL,
        stock        INT            NOT NULL,
        CONSTRAINT pk_products PRIMARY KEY (product_id),
        CONSTRAINT uq_products_truck_name UNIQUE (foodtruck_id, name),
        CONSTRAINT ck_products_price CHECK (price >= 0),
        CONSTRAINT ck_products_stock CHECK (stock >= 0)
    );

IF OBJECT_ID('orders', 'U') IS NULL
    CREATE TABLE orders (
        order_id     INT            NOT NULL,
        foodtruck_id INT            NOT NULL,
        order_date   DATE           NOT NULL,
        -- status codificado: P = pendiente, R = en preparación, E = entregado, C = cancelado
        status       CHAR(1)        NOT NULL,
        total        DECIMAL(10, 2) NOT NULL,
        CONSTRAINT pk_orders PRIMARY KEY (order_id),
        CONSTRAINT ck_orders_status CHECK (status IN ('P', 'R', 'E', 'C')),
        CONSTRAINT ck_orders_total CHECK (total >= 0)
    );

IF OBJECT_ID('order_items', 'U') IS NULL
    CREATE TABLE order_items (
        order_item_id INT NOT NULL,
        order_id      INT NOT NULL,
        product_id    INT NOT NULL,
        quantity      INT NOT NULL,
        CONSTRAINT pk_order_items PRIMARY KEY (order_item_id),
        -- un producto aparece una sola vez por pedido; las unidades van en quantity
        CONSTRAINT uq_order_items_order_product UNIQUE (order_id, product_id),
        CONSTRAINT ck_order_items_quantity CHECK (quantity > 0)
    );
