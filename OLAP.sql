CREATE SCHEMA olap;

CREATE TABLE olap.dim_tiempo (
    id_tiempo SERIAL PRIMARY KEY,
    fecha DATE,
    dia INT,
    mes INT,
    nombre_mes VARCHAR(20),
    trimestre INT,
    anio INT,
    dia_semana VARCHAR(20),
    fin_semana BOOLEAN
);

CREATE TABLE olap.dim_cliente (
    id_cliente INT PRIMARY KEY,
    nombre VARCHAR(100),
    telefono VARCHAR(20)
);

CREATE TABLE olap.dim_platillo (
    id_platillo INT PRIMARY KEY,
    nombre VARCHAR(100),
    categoria VARCHAR(100),
    precio_actual DECIMAL(10,2),
    descripcion TEXT
);

CREATE TABLE olap.dim_sucursal (
    id_sucursal INT PRIMARY KEY,
    direccion VARCHAR(200),
    ciudad VARCHAR(100),
    capacidad INT
);

CREATE TABLE olap.dim_empleado (
    id_empleado INT PRIMARY KEY,
    nombre VARCHAR(100),
    tipo VARCHAR(50),
    turno VARCHAR(50)
);

CREATE TABLE olap.dim_mesa (
    id_mesa INT PRIMARY KEY,
    numero_mesa INT,
    capacidad INT,
    estado VARCHAR(50)
);

CREATE TABLE olap.fact_ventas (
    id_fact_venta SERIAL PRIMARY KEY,

    id_tiempo INT,
    id_cliente INT,
    id_platillo INT,
    id_sucursal INT,
    id_empleado INT,
    id_mesa INT,

    cantidad INT,
    precio_unitario DECIMAL(10,2),
    subtotal DECIMAL(10,2),
    total_pedido DECIMAL(10,2),
    monto_pago DECIMAL(10,2),
    metodo_pago VARCHAR(50),

    FOREIGN KEY (id_tiempo)
        REFERENCES olap.dim_tiempo(id_tiempo),

    FOREIGN KEY (id_cliente)
        REFERENCES olap.dim_cliente(id_cliente),

    FOREIGN KEY (id_platillo)
        REFERENCES olap.dim_platillo(id_platillo),

    FOREIGN KEY (id_sucursal)
        REFERENCES olap.dim_sucursal(id_sucursal),

    FOREIGN KEY (id_empleado)
        REFERENCES olap.dim_empleado(id_empleado),

    FOREIGN KEY (id_mesa)
        REFERENCES olap.dim_mesa(id_mesa)
);

CREATE INDEX idx_fact_tiempo
ON olap.fact_ventas(id_tiempo);