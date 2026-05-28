import pandas as pd
import psycopg2

# Establece la conexión a postgress.
conexion = psycopg2.connect(
    host="localhost",
    database="restaurante",
    user="postgres",
    password="postgres",
    port="5432"
)

# query de ventas
query = "SELECT * FROM olap.fact_ventas"


df = pd.read_sql(query, conexion)

# crea el parquet
df.to_parquet(
    "fact_ventas.parquet",
    engine="pyarrow",
    index=False
)

conexion.close()

# Verificación si funciona
print("Archivo parquet created successfully")