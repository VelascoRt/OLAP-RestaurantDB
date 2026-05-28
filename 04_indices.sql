CREATE INDEX idx_fact_tiempo
ON olap.fact_ventas(id_tiempo);

CREATE INDEX idx_fact_cliente
ON olap.fact_ventas(id_cliente);

CREATE INDEX idx_fact_platillo
ON olap.fact_ventas(id_platillo);

CREATE INDEX idx_fact_sucursal
ON olap.fact_ventas(id_sucursal);