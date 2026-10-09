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

-- 4. Tipo de depto con los gastos comunes más caros.
SELECT td.nombre AS tipo_departamento, ROUND(AVG(pgcd.monto)) AS gasto_comun_promedio
FROM Tipo_Departamento td
JOIN Departamento d ON td.id = d.id_tipo_departamento
JOIN Pago_Gasto_Comun_Departamento pgcd ON pgcd.id_departamento = d.id
GROUP BY td.id, td.nombre
ORDER BY gasto_comun_promedio DESC
LIMIT 1;

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


