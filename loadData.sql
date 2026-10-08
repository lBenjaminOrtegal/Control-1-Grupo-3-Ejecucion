USE control_1;

-- ========================================================
-- 1. Administrador (10 filas)
-- ========================================================
INSERT INTO Administrador (rut, nombre, apellido, email, telefono) VALUES
('11111111-1', 'Carlos', 'Mendoza', 'carlos.mendoza@email.cl', '+56911111111'),
('22222222-2', 'Valentina', 'Rios', 'valentina.rios@email.cl', '+56922222222'),
('33333333-3', 'Jorge', 'Silva', 'jorge.silva@email.cl', '+56933333333'),
('44444444-4', 'Marcela', 'Castro', 'marcela.castro@email.cl', '+56944444444'),
('55555555-5', 'Andres', 'Paredes', 'andres.paredes@email.cl', '+56955555555'),
('66666666-6', 'Daniela', 'Munoz', 'daniela.munoz@email.cl', '+56966666666'),
('77777777-7', 'Roberto', 'Araya', 'roberto.araya@email.cl', '+56977777777'),
('88888888-8', 'Patricia', 'Fuentes', 'patricia.fuentes@email.cl', '+56988888888'),
('99999999-9', 'Felipe', 'Vergara', 'felipe.vergara@email.cl', '+56999999999'),
('10101010-0', 'Lorena', 'Tapia', 'lorena.tapia@email.cl', '+56910101010');

-- ========================================================
-- 2. Comuna (10 filas)
-- ========================================================
INSERT INTO Comuna (nombre) VALUES
('Santiago Centro'),
('Providencia'),
('Las Condes'),
('Nunoa'),
('San Miguel'),
('La Florida'),
('Macul'),
('Estacion Central'),
('Vitacura'),
('Recoleta');

-- ========================================================
-- 3. Edificio (10 filas)
-- Notar que el Administrador 1 tiene 3 edificios a cargo (consulta 6)
-- ========================================================
INSERT INTO Edificio (nombre, direccion, numero, tipo, id_comuna, id_administrador) VALUES
('Torre Alameda', 'Av. Libertador B. O''Higgins', '1250', 'Residencial', 1, 1),
('Edificio Los Leones', 'Av. Los Leones', '340', 'Residencial', 2, 1),
('Torre Parque Arauco', 'Av. Kennedy', '5400', 'Mixto', 3, 1),
('Plaza Nunoa', 'Av. Irarrazaval', '2580', 'Residencial', 4, 2),
('Gran Avenida Tower', 'Gran Avenida', '4500', 'Residencial', 5, 2),
('Mirador La Florida', 'Vespucio Sur', '7890', 'Residencial', 6, 3),
('Condominio Macul', 'Av. Macul', '1520', 'Residencial', 7, 4),
('Estacion Central Park', 'Av. Ecuador', '3100', 'Residencial', 8, 5),
('Torre Titanium Home', 'Av. Vitacura', '2900', 'Exclusivo', 9, 6),
('Parque Recoleta', 'Av. Recoleta', '820', 'Residencial', 10, 7);

-- ========================================================
-- 4. Tipo_Departamento (10 filas)
-- Superficie en m2 para facilitar comparación del tamaño
-- ========================================================
INSERT INTO Tipo_Departamento (nombre, superficie) VALUES
('Studio', '28'),
('1D 1B', '36'),
('2D 1B', '50'),
('2D 2B', '62'),
('3D 2B', '78'),
('3D 3B', '95'),
('Duplex 3D', '115'),
('Penthouse 4D', '160'),
('Studio Deluxe', '32'),
('Family Premium 4D 3B', '140');

-- ========================================================
-- 5. Departamento (12 filas)
-- ========================================================
INSERT INTO Departamento (numero, piso, habitantes, id_edificio, id_tipo_departamento) VALUES
(101, 1, 1, 1, 1),
(102, 1, 2, 1, 2),
(201, 2, 5, 1, 5),  -- Más habitantes por piso en Edificio 1
(202, 2, 2, 1, 3),
(301, 3, 3, 1, 4),
(101, 1, 2, 2, 3),
(201, 2, 6, 2, 8),  -- Más habitantes en Edificio 2
(101, 1, 1, 3, 1),
(201, 2, 4, 3, 7),
(101, 1, 3, 4, 4),
(301, 3, 2, 5, 3),
(401, 4, 4, 6, 6);

-- ========================================================
-- 6. Gasto_Comun (10 filas)
-- ========================================================
INSERT INTO Gasto_Comun (fecha, monto, tipo, id_edificio) VALUES
('2026-07-05', 850000.00, 'Ordinario', 1),
('2026-08-05', 920000.00, 'Ordinario', 1),
('2026-09-05', 890000.00, 'Ordinario', 1),
('2026-07-05', 1200000.00, 'Ordinario', 2),
('2026-08-05', 1150000.00, 'Ordinario', 2),
('2026-09-05', 1300000.00, 'Ordinario', 2),
('2026-08-10', 2100000.00, 'Ordinario', 3),
('2026-09-10', 2250000.00, 'Ordinario', 3),
('2026-09-12', 650000.00, 'Ordinario', 4),
('2026-09-15', 720000.00, 'Ordinario', 5);

-- ========================================================
-- 7. Pago_Gasto_Comun_Departamento (12 filas)
-- Contiene pagos 'Pagado' y morosos ('Pendiente') de los últimos 3 meses
-- ========================================================
INSERT INTO Pago_Gasto_Comun_Departamento (monto, fecha_pago, estado_pago, id_gasto_comun, id_departamento) VALUES
(75000.00, '2026-07-10', 'Pagado', 1, 1),
(90000.00, '2026-07-12', 'Pagado', 1, 2),
(130000.00, '2026-07-05', 'Pendiente', 1, 3), -- Moroso mes 1 (Edificio 1)
(75000.00, '2026-08-11', 'Pagado', 2, 1),
(90000.00, '2026-08-05', 'Pendiente', 2, 2), -- Moroso mes 2 (Edificio 1)
(130000.00, '2026-08-05', 'Pendiente', 2, 3), -- Moroso mes 2 (Edificio 1)
(75000.00, '2026-09-05', 'Pendiente', 3, 1), -- Moroso mes 3 (Edificio 1)
(90000.00, '2026-09-10', 'Pagado', 3, 2),
(130000.00, '2026-09-05', 'Pendiente', 3, 3), -- Moroso mes 3 (Edificio 1)
(110000.00, '2026-07-14', 'Pagado', 4, 6),
(250000.00, '2026-08-15', 'Pagado', 5, 7),
(260000.00, '2026-09-05', 'Pendiente', 6, 7); -- Moroso mes 3 (Edificio 2)

-- ========================================================
-- 8. Gasto_Edificio (10 filas)
-- Gastos operativos, mantenciones y consumos
-- ========================================================
INSERT INTO Gasto_Edificio (descripcion, monto, fecha_gasto, id_edificio) VALUES
('Mantencion ascensores', 350000.00, '2026-07-02', 1),
('Servicio de conserjeria y seguridad', 600000.00, '2026-07-28', 1),
('Reparacion bomba de agua', 180000.00, '2026-08-04', 1),
('Mantencion ascensores', 350000.00, '2026-08-10', 1),
('Servicio de conserjeria y seguridad', 600000.00, '2026-08-30', 1),
('Mantencion piscina y jardines', 220000.00, '2026-08-15', 2),
('Servicio de conserjeria y seguridad', 850000.00, '2026-08-28', 2),
('Mantencion ascensores', 420000.00, '2026-09-02', 2),
('Mantencion generador electrico', 290000.00, '2026-09-08', 3),
('Insumos de aseo y limpieza', 95000.00, '2026-09-12', 4);

-- ========================================================
-- 9. Pago_Gasto_Edificio (10 filas)
-- Pagos efectivos realizados a proveedores por los gastos del edificio
-- ========================================================
INSERT INTO Pago_Gasto_Edificio (monto_pagado, fecha_pago, id_gasto_edificio) VALUES
(350000.00, '2026-07-05', 1),
(600000.00, '2026-07-30', 2),
(180000.00, '2026-08-06', 3),
(350000.00, '2026-08-12', 4),
(600000.00, '2026-08-31', 5),
(220000.00, '2026-08-18', 6),
(850000.00, '2026-08-30', 7),
(420000.00, '2026-09-05', 8),
(290000.00, '2026-09-10', 9),
(95000.00, '2026-09-15', 10);