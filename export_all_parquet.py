from pathlib import Path
import pandas as pd
import psycopg2

# Carpeta donde se guardarán los archivos .parquet
OUTPUT_DIR = Path("parquet")
OUTPUT_DIR.mkdir(exist_ok=True)

# Conexión a PostgreSQL desde Windows
conexion = psycopg2.connect(
    host="localhost",
    database="restaurante",
    user="postgres",
    password="postgres",
    port="5433"
)

# Tablas OLAP que se exportarán
tablas = [
    "dim_tiempo",
    "dim_cliente",
    "dim_platillo",
    "dim_sucursal",
    "dim_empleado",
    "dim_mesa",
    "dim_metodo_pago",
    "fact_ventas"
]

for tabla in tablas:
    query = f"SELECT * FROM olap.{tabla}"
    df = pd.read_sql(query, conexion)

    archivo_salida = OUTPUT_DIR / f"{tabla}.parquet"
    df.to_parquet(archivo_salida, engine="pyarrow", index=False)

    print(f"{archivo_salida} creado con {len(df)} registros")

conexion.close()

print("Exportación completa")