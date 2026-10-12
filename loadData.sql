USE control_1;

-- =====================================================
-- 1. ADMINISTRADOR
-- =====================================================
INSERT INTO Administrador (rut, nombre, apellido, correo, telefono) VALUES
('11111111-1', 'Carlos', 'Pérez', 'carlos.perez@email.com', '+56911111111'),
('22222222-2', 'María', 'González', 'maria.gonzalez@email.com', '+56922222222'),
('33333333-3', 'Roberto', 'Muñoz', 'roberto.munoz@email.com', '+56933333333'),
('44444444-4', 'Valentina', 'Rojas', 'valentina.rojas@email.com', '+56944444444'),
('55555555-5', 'Andrés', 'Soto', 'andres.soto@email.com', '+56955555555');

-- =====================================================
-- 2. COMUNA
-- =====================================================
INSERT INTO Comuna (nombre) VALUES
('Santiago'),
('Providencia'),
('Las Condes'),
('Ñuñoa'),
('La Florida');

-- =====================================================
-- 3. EDIFICIO
-- =====================================================
INSERT INTO Edificio (nombre, calle, numero, tipo, id_comuna, id_administrador) VALUES
('Torre Central', 'Av. Libertador', '1010', 'Residencial', 1, 1),
('Parque Almagro', 'San Diego', '450', 'Residencial', 1, 1),
('Mirador Providencia', 'Av. Providencia', '2100', 'Mixto', 2, 2),
('Plaza Ñuñoa', 'Av. Irarrázaval', '3400', 'Residencial', 4, 1),
('Espacio Florida', 'Av. Vicuña Mackenna', '7200', 'Residencial', 5, 4),
('Los Dominicos', 'Camino El Alba', '1250', 'Residencial', 3, 4),
('Altos de Las Condes', 'Av. Apoquindo', '4800', 'Exclusivo', 3, 5);

-- =====================================================
-- 4. TIPO_DEPARTAMENTO
-- =====================================================
INSERT INTO Tipo_Departamento (nombre, superficie) VALUES
('Micro-Studio', 22.50), -- id: 1
('Studio', 32.00),       -- id: 2
('1D 1B', 45.00),        -- id: 3
('2D 2B', 68.00),        -- id: 4
('Penthouse 4D', 160.00); -- id: 5

-- =====================================================
-- 5. DEPARTAMENTO
-- =====================================================
INSERT INTO Departamento (numero, piso, habitantes, id_edificio, id_tipo_departamento) VALUES
-- Edificio 1: Torre Central (Piso 1, 2 y 3)
(101, 1, 2, 1, 2), -- id: 1 (Studio)
(102, 1, 4, 1, 3), -- id: 2 (1D 1B) -> Más hab piso 1
(201, 2, 1, 1, 3), -- id: 3 (1D 1B)
(202, 2, 5, 1, 4), -- id: 4 (2D 2B) -> Más hab piso 2
(301, 3, 3, 1, 4), -- id: 5 (2D 2B)

-- Edificio 2: Parque Almagro
(101, 1, 1, 2, 1), -- id: 6 (Micro-Studio) -> Más pequeño en Edif 2
(102, 1, 3, 2, 3), -- id: 7 (1D 1B)
(201, 2, 4, 2, 4), -- id: 8 (2D 2B)

-- Edificio 3: Mirador Providencia
(101, 1, 2, 3, 3), -- id: 9 (1D 1B)
(201, 2, 3, 3, 4), -- id: 10 (2D 2B)
(301, 3, 6, 3, 5), -- id: 11 (Penthouse)

-- Edificio 4: Plaza Ñuñoa
(101, 1, 1, 4, 1), -- id: 12 (Micro-Studio) -> Más pequeño en Edif 4
(102, 1, 3, 4, 3), -- id: 13 (1D 1B)
(201, 2, 2, 4, 4), -- id: 14 (2D 2B)
(301, 3, 4, 4, 5), -- id: 15 (Penthouse)

-- Edificio 5: Espacio Florida
(101, 1, 2, 5, 1), -- id: 16 (Micro-Studio)
(102, 1, 1, 5, 3), -- id: 17 (1D 1B)
(201, 2, 5, 5, 4), -- id: 18 (2D 2B)

-- Edificio 7: Altos de Las Condes
(101, 1, 2, 7, 4), -- id: 19 (2D 2B)
(201, 2, 4, 7, 5), -- id: 20 (Penthouse)
(301, 3, 7, 7, 5); -- id: 21 (Penthouse) -> Más hab piso 3

-- =====================================================
-- 6. TIPO_GASTO_COMUN Y RELACION DEPENDIENTE (N:M)
-- =====================================================
INSERT INTO Tipo_Gasto_Comun (nombre, descripcion) VALUES
('Gasto Ordinario', 'Gastos fijos operacionales del mes (luz, agua, conserjería)'),
('Fondo de Reserva', 'Aporte extraordinario para imprevistos estructurales');

INSERT INTO Depende_Tipo_Gasto_Comun_Tipo_Departamento (id_tipo_gasto_comun, id_tipo_departamento) VALUES
(1, 1), (1, 2), (1, 3), (1, 4), (1, 5),
(2, 4), (2, 5);

-- =====================================================
-- 7. GASTO_COMUN
-- =====================================================
INSERT INTO Gasto_Comun (fecha_emision, fecha_vencimiento, monto, id_edificio, id_tipo_gasto_comun) VALUES
-- Edificio 1: Torre Central (id: 1, 2, 3)
('2026-08-01', '2026-08-15', 500000.00, 1, 1),
('2026-09-01', '2026-09-15', 520000.00, 1, 1),
('2026-10-01', '2026-10-15', 510000.00, 1, 1),

-- Edificio 2: Parque Almagro (id: 4, 5, 6)
('2026-08-01', '2026-08-15', 300000.00, 2, 1),
('2026-09-01', '2026-09-15', 310000.00, 2, 1),
('2026-10-01', '2026-10-15', 305000.00, 2, 1),

-- Edificio 4: Plaza Ñuñoa (id: 7, 8, 9)
('2026-08-01', '2026-08-15', 400000.00, 4, 1),
('2026-09-01', '2026-09-15', 410000.00, 4, 1),
('2026-10-01', '2026-10-15', 420000.00, 4, 1),

-- Edificio 5: Espacio Florida (id: 10, 11, 12)
('2026-08-01', '2026-08-15', 220000.00, 5, 1),
('2026-09-01', '2026-09-15', 210000.00, 5, 1),
('2026-10-01', '2026-10-15', 215000.00, 5, 1),

-- Edificio 7: Altos de Las Condes (id: 13, 14, 15)
('2026-08-01', '2026-08-15', 1200000.00, 7, 1),
('2026-09-01', '2026-09-15', 1250000.00, 7, 1),
('2026-10-01', '2026-10-15', 1300000.00, 7, 1);

-- =====================================================
-- 8. PAGO_GASTO_COMUN_DEPARTAMENTO
-- =====================================================
INSERT INTO Pago_Gasto_Comun_Departamento (monto, fecha_pago, estado_pago, id_gasto_comun, id_departamento) VALUES
-- AGOSTO 2026 (Gasto_Comun: 1, 4, 7, 13)
(100000.00, '2026-08-05', 'Pagado',    1, 1),
(100000.00, NULL,         'Pendiente', 1, 2),
(100000.00, NULL,         'Pendiente', 1, 3),
(100000.00, '2026-08-05', 'Pagado',    4, 6),
(100000.00, NULL,         'Pendiente', 4, 7),
(80000.00,  '2026-08-04', 'Pagado',    7, 12),
(100000.00, NULL,         'Pendiente', 7, 14),
(400000.00, '2026-08-05', 'Pagado',    13, 19),
(450000.00, NULL,         'Pendiente', 13, 21),

-- SEPTIEMBRE 2026 (Gasto_Comun: 2, 5, 8, 14)
(104000.00, '2026-09-05', 'Pagado',    2, 1),
(104000.00, NULL,         'Pendiente', 2, 2),
(104000.00, '2026-09-09', 'Pagado',    2, 3),
(103000.00, '2026-09-05', 'Pagado',    5, 6),
(82000.00,  '2026-09-06', 'Pagado',    8, 12),
(102000.00, NULL,         'Pendiente', 8, 14),
(415000.00, '2026-09-05', 'Pagado',    14, 19),
(460000.00, '2026-09-08', 'Pagado',    14, 21),

-- OCTUBRE 2026 (Gasto_Comun: 3, 6, 9, 15)
(102000.00, NULL,         'Pendiente', 3, 1),
(102000.00, NULL,         'Pendiente', 3, 2),
(102000.00, '2026-10-06', 'Pagado',    3, 3),
(84000.00,  '2026-10-03', 'Pagado',    9, 12),
(105000.00, NULL,         'Pendiente', 9, 14),
(430000.00, '2026-10-04', 'Pagado',    15, 19),
(480000.00, NULL,         'Pendiente', 15, 21);

-- =====================================================
-- 9. GASTO_EDIFICIO
-- =====================================================
INSERT INTO Gasto_Edificio (descripcion, monto, fecha_emision, fecha_vencimiento, id_edificio) VALUES
-- Edificio 1: Torre Central
('Mantención ascensores', 150000.00, '2026-08-01', '2026-08-20', 1),
('Reparación bomba de agua', 210000.00, '2026-09-01', '2026-09-20', 1),
('Mantención preventiva', 140000.00, '2026-10-01', '2026-10-20', 1),

-- Edificio 2: Parque Almagro
('Jardinería y limpieza', 60000.00, '2026-08-01', '2026-08-20', 2),
('Insumos de conserjería', 45000.00, '2026-09-01', '2026-09-20', 2),
('Pintura pasillos', 55000.00, '2026-10-01', '2026-10-20', 2),

-- Edificio 5: Espacio Florida (Menos gasto mensual)
('Cambio ampolletas comunes', 25000.00, '2026-08-01', '2026-08-20', 5),
('Recarga extintores', 30000.00, '2026-09-01', '2026-09-20', 5),
('Artículos básicos de aseo', 28000.00, '2026-10-01', '2026-10-20', 5),

-- Edificio 7: Altos de Las Condes (Más gasto mensual)
('Seguridad y conserjería 24/7', 650000.00, '2026-08-01', '2026-08-20', 7),
('Mantención piscina y calderas', 580000.00, '2026-09-01', '2026-09-20', 7),
('Certificación de gas y ascensores', 720000.00, '2026-10-01', '2026-10-20', 7);

-- =====================================================
-- 10. PAGO_GASTO_EDIFICIO
-- =====================================================
INSERT INTO Pago_Gasto_Edificio (monto, fecha_pago, id_gasto_edificio) VALUES
-- Pagos Agosto 2026 (Total: $885.000)
(150000.00, '2026-08-14', 1),
(60000.00,  '2026-08-15', 4),
(25000.00,  '2026-08-12', 7),
(650000.00, '2026-08-20', 10),

-- Pagos Septiembre 2026 (Total: $865.000)
(210000.00, '2026-09-08', 2),
(45000.00,  '2026-09-15', 5),
(30000.00,  '2026-09-14', 8),
(580000.00, '2026-09-22', 11),

-- Pagos Octubre 2026 (Total: $943.000)
(140000.00, '2026-10-05', 3),
(55000.00,  '2026-10-08', 6),
(28000.00,  '2026-10-06', 9),
(720000.00, '2026-10-09', 12);