-- FoodTrack: crea la base de datos del proyecto (solo si todavía no existe).
-- Se ejecuta conectado a master, porque foodtrack aún no existe.
IF DB_ID('foodtrack') IS NULL
    CREATE DATABASE foodtrack;
