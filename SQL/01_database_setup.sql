-- Creación de la base de datos que albergará  Call Center Analytics.

/*CREATE DATABASE CallCenterAnalytics;
USE CallCenterAnalytics
GO*/


-- Creación de la tabla Operations

IF OBJECT_ID('dbo.Operations', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Operations (
        source_row_id INT NOT NULL PRIMARY KEY,
        [date] DATE NOT NULL,
        weekday NVARCHAR(15),
        week_number INT,
        [month] NVARCHAR(15),
        [year] INT,
        [hour] INT,
        country NVARCHAR(70),
        region NVARCHAR(10),
        site NVARCHAR(80),
        queue_name NVARCHAR(80),
        channel NVARCHAR(15),
        all_units_filter NVARCHAR(30),
        queue_units_filter NVARCHAR(40),
        asu_tier_filter NVARCHAR(20),
        business_unit NVARCHAR(35),
        planned_volume INT,
        offered_volume INT,
        handled_volume INT,
        abandoned_volume INT,
        backlog_volume INT,
        aht_seconds INT,
        handle_time_total BIGINT,
        wait_time_avg DECIMAL(18,9),
        shrinkage_percent INT,
        required_fte INT,
        agent_count INT,
        utilization_percent INT,
        active_agents INT,
        service_level_percent INT,
        occupancy_percent INT,
        alerta_volumen BIT,
        alerta_tiempo BIT,
        alerta_personal BIT,
        canal_segun_cola NVARCHAR(30),
        validacion_canal NVARCHAR(30),
        tier_segun_cola NVARCHAR(20),
        alerta_tier BIT,
        alerta_fecha_futura BIT,
        alerta_canal BIT,
        requiere_revision BIT
    );
END;
GO

-- Confirmación de la cantidad de registros
SELECT COUNT(*) AS registros_actuales FROM dbo.Operations;


-- Carga del archivo directamente en la tabla.
BULK INSERT dbo.Operations
FROM 'C:\Users\faust\Desktop\Personal\Cursos\Curso PBI\Proyectos\Proyecto 3 - Call Center\processed\operations_sql_ready.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    CODEPAGE = '65001',
    TABLOCK
);
GO

-- Confirmación de la cantidad de registros luego de la carga

SELECT COUNT(*) AS filas_importadas FROM dbo.Operations;


SELECT * FROM dbo.Operations;