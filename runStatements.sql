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


