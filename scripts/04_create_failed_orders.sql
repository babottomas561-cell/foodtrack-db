-- FoodTrack: tabla auxiliar donde quedan registrados los pedidos que orders rechazó.
-- Guarda los datos del pedido tal cual llegaron y el motivo del error que informó SQL Server.
-- Se crea solo si todavía no existe, así el script se puede correr más de una vez.
USE foodtrack;

IF OBJECT_ID('failed_orders', 'U') IS NULL
    CREATE TABLE failed_orders (
        -- acá sí va IDENTITY: cada intento fallido es un registro nuevo que no trae ID propio
        failed_order_id INT            IDENTITY(1, 1) NOT NULL,
        -- datos como texto y sin restricciones: tienen que entrar justo los valores que orders no aceptó
        order_id        NVARCHAR(50)   NULL,
        foodtruck_id    NVARCHAR(50)   NULL,
        order_date      NVARCHAR(50)   NULL,
        status          NVARCHAR(50)   NULL,  -- texto original del CSV ('entregado'), sin traducir
        total           NVARCHAR(50)   NULL,
        error_number    INT            NOT NULL,
        error_message   NVARCHAR(4000) NOT NULL,
        failed_at       DATETIME2(0)   NOT NULL
            CONSTRAINT df_failed_orders_failed_at DEFAULT SYSDATETIME(),
        CONSTRAINT pk_failed_orders PRIMARY KEY (failed_order_id)
    );
