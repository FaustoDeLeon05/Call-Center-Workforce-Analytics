USE CallCenterAnalytics;
GO

-- 1. Indicadores generales (SIN incluir las fechas futuras marcadas).

SELECT
    SUM(offered_volume) AS contactos_ofrecidos,
    SUM(handled_volume) AS contactos_atendidos,
    SUM(abandoned_volume) AS contactos_abandonados,
    ROUND(100.0 * SUM(abandoned_volume) / NULLIF(SUM(offered_volume), 0), 2) AS abandono_porcentaje,
    ROUND(1.0 * SUM(handle_time_total) / NULLIF(SUM(handled_volume), 0), 2) AS aht_segundos
FROM dbo.Operations
WHERE alerta_fecha_futura = 0;

-- 2. Demanda y abandono por región.

SELECT
	region,
    SUM(offered_volume) AS Demanda,
    SUM(abandoned_volume) AS Abandonados
FROM dbo.Operations
WHERE alerta_fecha_futura = 0
GROUP BY region
ORDER BY Abandonados DESC;

-- 3. Horarios con más demanda (hora local declarada en el registro).

SELECT
    [hour] AS hora,
    SUM(offered_volume) AS ofrecidos,
    SUM(abandoned_volume) AS abandonados
FROM dbo.Operations
WHERE alerta_fecha_futura = 0
GROUP BY [hour]
ORDER BY ofrecidos DESC;

-- 4. Las 10 colas con más volumen

SELECT TOP 10
    queue_name,
    SUM(offered_volume) AS ofrecidos,
    SUM(abandoned_volume) AS abandonados
FROM dbo.Operations
WHERE alerta_fecha_futura = 0
GROUP BY queue_name
ORDER BY ofrecidos ASC;

-- 5. Evolución por fecha

SELECT
    [date],
    SUM(offered_volume) AS ofrecidos,
    SUM(abandoned_volume) AS abandonados
FROM dbo.Operations
WHERE alerta_fecha_futura = 0
GROUP BY [date]
ORDER BY [date];

-- 6. Registros de personal para investigar

SELECT source_row_id, [date] as Fecha, 
		region, queue_name, handled_volume, agent_count
FROM dbo.Operations
WHERE alerta_personal = 1
ORDER BY [date];