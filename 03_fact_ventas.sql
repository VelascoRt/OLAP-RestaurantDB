INSERT INTO olap.fact_ventas (
    id_tiempo,
    id_cliente,
    id_platillo,
    id_sucursal,
    id_empleado,
    id_mesa,
    id_metodo_pago,
    cantidad,
    precio_unitario,
    subtotal,
    total_pedido,
    monto_pago
)
SELECT
    dt.id_tiempo,
    p.id_cliente,
    dp.id_platillo,
    m.id_sucursal,
    p.id_empleado,
    p.id_mesa,
    mp.id_metodo_pago,

    dp.cantidad,
    dp.precio_unitario,
    dp.subtotal,

    p.total,
    pa.monto

FROM public.detallepedido dp

JOIN public.pedido p
    ON dp.id_pedido = p.id_pedido

JOIN public.mesa m
    ON p.id_mesa = m.id_mesa

JOIN public.pago pa
    ON pa.id_pedido = p.id_pedido

JOIN olap.dim_tiempo dt
    ON dt.fecha = DATE(p.fecha_hora)

JOIN olap.dim_metodo_pago mp
    ON mp.metodo_pago = pa.metodo_pago;