-- PREGUNTAR SI ESTO LE CORRESPONDE A ETL
INSERT INTO olap.dim_metodo_pago (
    id_metodo_pago,
    metodo_pago
)
VALUES
(1, 'Efectivo'),
(2, 'Tarjeta'),
(3, 'Transferencia');
