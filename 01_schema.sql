-- Crea el schema OLAP
CREATE SCHEMA IF NOT EXISTS olap;

-- Dimensión principal de tiempo
CREATE TABLE olap.dim_tiempo (
    id_tiempo  SERIAL      PRIMARY KEY,
    fecha      DATE,
    dia        INT,
    mes        INT,
    nombre_mes VARCHAR(20),
    trimestre  INT,
    anio       INT,
    dia_semana VARCHAR(20),
    fin_semana BOOLEAN
);

-- Dimensión de clientes
CREATE TABLE olap.dim_cliente (
    id_cliente INT         PRIMARY KEY,
    nombre     VARCHAR(100),
    telefono   VARCHAR(20)
);

-- Dimensión de platillos
CREATE TABLE olap.dim_platillo (
    id_platillo   INT            PRIMARY KEY,
    nombre        VARCHAR(100),
    precio_actual DECIMAL(10,2),
    categoria     VARCHAR(100),
    descripcion   TEXT
);

-- Dimensión de sucursales
CREATE TABLE olap.dim_sucursal (
    id_sucursal INT         PRIMARY KEY,
    direccion   VARCHAR(200),
    telefono    VARCHAR(20),
    ciudad      VARCHAR(100),
    capacidad   INT
);

-- Dimensión de empleados
CREATE TABLE olap.dim_empleado (
    id_empleado INT            PRIMARY KEY,
    nombre      VARCHAR(100),
    tipo        VARCHAR(50),
    telefono    VARCHAR(20),
    salario     DECIMAL(10,2),
    turno       VARCHAR(50)
);

-- Dimensión de mesas
CREATE TABLE olap.dim_mesa (
    id_mesa      INT         PRIMARY KEY,
    numero_mesa  INT,
    capacidad    INT,
    estado       VARCHAR(50)
);

-- Dimensión de métodos de pago
CREATE TABLE olap.dim_metodo_pago (
    id_metodo_pago INT         PRIMARY KEY,
    metodo_pago    VARCHAR(50)
);

CREATE TABLE olap.fact_ventas (
    id_tiempo INT NOT NULL,
    id_cliente INT NOT NULL,
    id_platillo INT NOT NULL,
    id_sucursal INT NOT NULL,
    id_empleado INT NOT NULL,
    id_mesa INT NOT NULL,
    id_metodo_pago INT NOT NULL,

    cantidad INT,
    precio_unitario DECIMAL(10,2),
    subtotal DECIMAL(10,2),
    total_pedido DECIMAL(10,2),
    monto_pago DECIMAL(10,2),

    PRIMARY KEY (
        id_tiempo,
        id_cliente,
        id_platillo,
        id_sucursal,
        id_empleado,
        id_mesa,
        id_metodo_pago
    ),

    FOREIGN KEY (id_tiempo) REFERENCES olap.dim_tiempo(id_tiempo),
    FOREIGN KEY (id_cliente) REFERENCES olap.dim_cliente(id_cliente),
    FOREIGN KEY (id_platillo) REFERENCES olap.dim_platillo(id_platillo),
    FOREIGN KEY (id_sucursal) REFERENCES olap.dim_sucursal(id_sucursal),
    FOREIGN KEY (id_empleado) REFERENCES olap.dim_empleado(id_empleado),
    FOREIGN KEY (id_mesa) REFERENCES olap.dim_mesa(id_mesa),
    FOREIGN KEY (id_metodo_pago) REFERENCES olap.dim_metodo_pago(id_metodo_pago)
);