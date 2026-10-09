USE control_1;

SELECT * FROM Administrador;
SELECT * FROM Comuna;
SELECT * FROM Edificio;
SELECT * FROM Departamento;
SELECT * FROM Gasto_Comun;
SELECT * FROM Gasto_Edificio;
SELECT * FROM Pago_Gasto_Comun_Departamento;
SELECT * FROM Pago_Gasto_Edificio;
SELECT * FROM Tipo_Departamento;

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
