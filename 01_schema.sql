-- Crea el schema OLAP
CREATE SCHEMA olap;

-- Dimensión principal de tiempo
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

-- Dimensión de clientes
CREATE TABLE olap.dim_cliente (
    id_cliente INT PRIMARY KEY,
    nombre VARCHAR(100),
    telefono VARCHAR(20)
);

-- Dimensión de platillos
CREATE TABLE olap.dim_platillo (
    id_platillo INT PRIMARY KEY,
    nombre VARCHAR(100),
    precio_actual DECIMAL(10,2),
    categoria VARCHAR(100),
    descripcion TEXT
);

-- Dimensión de sucursales
CREATE TABLE olap.dim_sucursal (
    id_sucursal INT PRIMARY KEY,
    direccion VARCHAR(200),
    telefono VARCHAR(20),
    ciudad VARCHAR(100),
    capacidad INT
);

-- Dimensión de empleados
CREATE TABLE olap.dim_empleado (
    id_empleado INT PRIMARY KEY,
    nombre VARCHAR(100),
    tipo VARCHAR(50),
    telefono VARCHAR(20),
    salario DECIMAL(10,2),
    turno VARCHAR(50)
);

-- Dimensión de mesas en sucursales.
CREATE TABLE olap.dim_mesa (
    id_mesa INT PRIMARY KEY,
    numero_mesa INT,
    capacidad INT,
    estado VARCHAR(50)
);

-- Dimensión de metodos de pago.
CREATE TABLE olap.dim_metodo_pago (
    id_metodo_pago INT PRIMARY KEY,
    metodo_pago VARCHAR(50)
)

-- Cubo de ventas.
CREATE TABLE olap.fact_ventas (
    id_fact_venta SERIAL PRIMARY KEY,

    id_tiempo INT,
    id_cliente INT,
    id_platillo INT,
    id_sucursal INT,
    id_empleado INT,
    id_mesa INT,
    id_metodo_pago INT,

    cantidad INT,
    precio_unitario DECIMAL(10,2),
    subtotal DECIMAL(10,2),
    total_pedido DECIMAL(10,2),
    monto_pago DECIMAL(10,2),
    

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
        REFERENCES olap.dim_mesa(id_mesa),
    
    FOREIGN KEY (id_metodo_pago)
        REFERENCES olap.dim_metodo_pago(id_metodo_pago)
);

CREATE INDEX idx_fact_tiempo
ON olap.fact_ventas(id_tiempo);

CREATE INDEX idx_fact_cliente
ON olap.fact_ventas(id_cliente);

CREATE INDEX idx_fact_platillo
ON olap.fact_ventas(id_platillo);

CREATE INDEX idx_fact_sucursal
ON olap.fact_ventas(id_sucursal);