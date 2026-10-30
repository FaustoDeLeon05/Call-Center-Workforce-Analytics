USE CallCenterAnalytics;
GO
-- 1. Conciliar volúmenes y tiempos.

SELECT
    SUM(offered_volume) AS ofrecidos,
    SUM(handled_volume) AS atendidos,
    SUM(abandoned_volume) AS abandonados,
    SUM(CASE WHEN offered_volume <> handled_volume + abandoned_volume THEN 1 ELSE 0 END) AS errores_volumen,
    SUM(CASE WHEN handle_time_total <> handled_volume * aht_seconds THEN 1 ELSE 0 END) AS errores_tiempo
FROM dbo.Operations;

-- 2. Contar alertas.

SELECT
    SUM(CAST(alerta_personal AS INT)) AS casos_personal,
    SUM(CAST(alerta_canal AS INT)) AS conflictos_canal,
    SUM(CAST(alerta_tier AS INT)) AS conflictos_tier,
    SUM(CAST(alerta_fecha_futura AS INT)) AS fechas_futuras,
    SUM(CAST(requiere_revision AS INT)) AS registros_para_revision
FROM dbo.Operations;

-- 3. Inspeccionar ejemplos que necesitan revisión.

SELECT TOP 15
    source_row_id, [date], queue_name, channel,
    canal_segun_cola, asu_tier_filter, tier_segun_cola,
    agent_count, handled_volume
FROM dbo.Operations
WHERE requiere_revision = 1
ORDER BY source_row_id;
