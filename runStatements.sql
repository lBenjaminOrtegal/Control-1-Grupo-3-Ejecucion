USE control_1;

SELECT * FROM Administrador;
SELECT * FROM Comuna;
SELECT * FROM Gasto_Edificio;
SELECT * FROM Pago_Gasto_Edificio;
SELECT * FROM Tipo_Departamento;
SELECT * FROM Pago_Gasto_Comun_Departamento;
SELECT * FROM Departamento;
SELECT * FROM Edificio;
SELECT * FROM Gasto_Comun;

-- 1. Lista de departamentos morosos en gastos comunes de los últimos tres meses por edificio.
SELECT DISTINCT
	e.id AS id_edificio, e.nombre AS nombre_edificio, d.id AS id_departamento, d.numero AS numero_departamento, pgcd.estado_pago
FROM Pago_Gasto_Comun_Departamento pgcd
JOIN Departamento d ON d.id = pgcd.id_departamento
JOIN Edificio e ON e.id = d.id_edificio
JOIN Gasto_Comun gc ON gc.id_edificio = e.id
WHERE gc.fecha >= DATE_SUB(CURRENT_DATE(), INTERVAL 3 MONTH)
AND pgcd.estado_pago = "Pendiente";


-- 2. Total recaudado en gastos comunes por edificio por mes.
SELECT 
    e.nombre AS nombre_edificio,
    YEAR(p.fecha_pago) AS anio,
    MONTH(p.fecha_pago) AS mes,
    SUM(p.monto) AS total_recaudado
FROM Pago_Gasto_Comun_Departamento p
JOIN Gasto_Comun gc ON p.id_gasto_comun = gc.id
JOIN Edificio e ON gc.id_edificio = e.id
WHERE p.estado_pago = 'Pagado'
GROUP BY 
    e.id, 
    e.nombre, 
    YEAR(p.fecha_pago), 
    MONTH(p.fecha_pago)
ORDER BY 
    anio DESC, 
    mes DESC, 
    nombre_edificio ASC;

-- 4. Tipo de depto con los gastos comunes más caros.
SELECT td.nombre AS tipo_departamento, ROUND(AVG(pgcd.monto)) AS gasto_comun_promedio
FROM Tipo_Departamento td
JOIN Departamento d ON td.id = d.id_tipo_departamento
JOIN Pago_Gasto_Comun_Departamento pgcd ON pgcd.id_departamento = d.id
GROUP BY td.id, td.nombre
ORDER BY gasto_comun_promedio DESC
LIMIT 1;

-- 5. Lista de edificios por comuna con la cantidad de departamentos.
SELECT Comuna.nombre as nombre_comuna, Edificio.id as id_edificio, Edificio.nombre as nombre_edificio, COUNT(Departamento.id) as cantidad_departamentos
FROM Edificio
JOIN Comuna ON Edificio.id_comuna = Comuna.id
LEFT JOIN Departamento ON Departamento.id_edificio = Edificio.id
GROUP BY Comuna.nombre, Edificio.id, Edificio.nombre;

-- 6. Administrador con más edificios a cargo.
SELECT Administrador.rut, Administrador.nombre, Administrador.apellido, COUNT(Edificio.id) AS cantidad_edificios
FROM Administrador
JOIN Edificio ON Administrador.id = Edificio.id_administrador
GROUP BY Administrador.rut, Administrador.nombre, Administrador.apellido
ORDER BY cantidad_edificios DESC
LIMIT 1;

-- 7. Departamento con más habitantes por piso, por edificio.
SELECT Departamento.id AS id_departamento, Departamento.id_edificio, Departamento.piso, Departamento.habitantes
FROM Departamento
JOIN (
	SELECT Departamento.id_edificio, Departamento.piso, MAX(Departamento.habitantes) AS maximo_habitantes
    FROM Departamento
    GROUP BY Departamento.id_edificio, Departamento.piso) maximo_por_piso
ON Departamento.id_edificio = maximo_por_piso.id_edificio
AND Departamento.piso = maximo_por_piso.piso
AND Departamento.habitantes = maximo_por_piso.maximo_habitantes;

-- 8. Lista de tipos de departamento por edificio, mostrar la cantidad de departamentos por tipo.
SELECT Edificio.nombre as edificio, Tipo_Departamento.id as id_tipo_departamento, Tipo_Departamento.nombre as tipo_departamento, COUNT(Departamento.id) as cantidad_departamentos
FROM Tipo_Departamento
JOIN Departamento ON Tipo_Departamento.id = Departamento.id_tipo_departamento
JOIN Edificio ON Edificio.id = Departamento.id_edificio
GROUP BY Edificio.id, Edificio.nombre, Tipo_Departamento.id, Tipo_Departamento.nombre;

-- 9. Lista de edificios que menos gasta por mes.
WITH GastosPorEdificio AS (
    -- gasto por edificio
    SELECT 
        YEAR(ge.fecha_gasto) AS anio,
        MONTH(ge.fecha_gasto) AS mes,
        e.nombre AS nombre_edificio,
        SUM(ge.monto) AS total_gasto
    FROM Gasto_Edificio ge
    JOIN Edificio e ON ge.id_edificio = e.id
    GROUP BY YEAR(ge.fecha_gasto), MONTH(ge.fecha_gasto), e.id, e.nombre
)
SELECT 
    t1.anio,
    t1.mes,
    t1.nombre_edificio,
    t1.total_gasto
FROM GastosPorEdificio t1
JOIN (
    -- tabla temporal para buscar el mínimo por mes
    SELECT anio, mes, MIN(total_gasto) AS minimo_gasto
    FROM GastosPorEdificio
    GROUP BY anio, mes
) t2 
ON t1.anio = t2.anio 
   AND t1.mes = t2.mes 
   AND t1.total_gasto = t2.minimo_gasto -- conectar el edificio cuyo gasto coincida con el minimo histórico de ese mes
ORDER BY t1.anio DESC, t1.mes DESC;


-- 10. Lista de tipos de departamentos más pequeños por edificio.

SELECT DISTINCT d.id_edificio, td.id AS id_tipo_departamento, td.nombre AS tipo_departamento, td.superficie AS superficie
FROM Departamento d 	-- Lo puse desde depto y no edificio porque así se trabaja solo con los edificios que tengan deptos registrados y no los vacíos.
JOIN Tipo_departamento td ON td.id = d.id_tipo_departamento
JOIN (
	SELECT d.id_edificio AS id_edificio, MIN(td.superficie) AS min_superficie
	FROM Departamento d
	JOIN Tipo_Departamento td ON td.id = d.id_tipo_departamento
	GROUP BY d.id_edificio) minimo_por_edificio 
ON minimo_por_edificio.id_edificio = d.id_edificio
AND minimo_por_edificio.min_superficie = td.superficie
ORDER BY d.id_edificio;
