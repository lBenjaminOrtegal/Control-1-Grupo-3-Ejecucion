USE control_1;

-- =====================================================
-- 1. ADMINISTRADOR
-- =====================================================
-- id generados: 
-- 1: Carlos Pérez (tendrá 3 edificios)
-- 2: María González (tendrá 1 edificio)
-- 3: Roberto Muñoz (0 edificios)
-- 4: Valentina Rojas (tendrá 2 edificios)
-- 5: Andrés Soto (tendrá 1 edificio)
-- =====================================================
INSERT INTO Administrador (rut, nombre, apellido, email, telefono) VALUES
('11111111-1', 'Carlos', 'Pérez', 'carlos.perez@email.com', '+56911111111'),
('22222222-2', 'María', 'González', 'maria.gonzalez@email.com', '+56922222222'),
('33333333-3', 'Roberto', 'Muñoz', 'roberto.munoz@email.com', '+56933333333'),
('44444444-4', 'Valentina', 'Rojas', 'valentina.rojas@email.com', '+56944444444'),
('55555555-5', 'Andrés', 'Soto', 'andres.soto@email.com', '+56955555555');

-- =====================================================
-- 2. COMUNA
-- =====================================================
-- id generados: 
-- 1: Santiago, 2: Providencia, 3: Las Condes, 4: Ñuñoa, 5: La Florida
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
-- id generados:
-- 1: Torre Central (Comuna 1: Santiago, Admin 1: Carlos)
-- 2: Parque Almagro (Comuna 1: Santiago, Admin 1: Carlos)
-- 3: Mirador Providencia (Comuna 2: Providencia, Admin 2: María)
-- 4: Plaza Ñuñoa (Comuna 4: Ñuñoa, Admin 1: Carlos)
-- 5: Espacio Florida (Comuna 5: La Florida, Admin 4: Valentina)
-- 6: Los Dominicos (Comuna 3: Las Condes, Admin 4: Valentina)
-- 7: Altos de Las Condes (Comuna 3: Las Condes, Admin 5: Andrés)
-- =====================================================
INSERT INTO Edificio (nombre, direccion, numero, tipo, id_comuna, id_administrador) VALUES
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
-- id generados:
-- 1: Studio (32 m²)
-- 2: 1D1B (45 m²)
-- 3: 2D2B (68 m²)
-- 4: Penthouse 3D3B (140 m²)
-- 5: Micro-Studio (22 m²) -> el más pequeño
-- =====================================================
INSERT INTO Tipo_Departamento (nombre, superficie) VALUES
('Studio', 28),
('1D 1B', 36),
('2D 1B', 50),
('2D 2B', 62),
('3D 2B', 78),
('3D 3B', 95),
('Duplex 3D', 115),
('Penthouse 4D', 160),
('Studio Deluxe', 32),
('Family Premium 4D 3B', 140);

-- =====================================================
-- 5. DEPARTAMENTO
-- =====================================================
-- id generados: del 1 al 22
-- =====================================================
INSERT INTO Departamento (numero, piso, habitantes, id_edificio, id_tipo_departamento) VALUES
-- Edificio 1: Torre Central
(101, 1, 2, 1, 1), -- id: 1
(102, 1, 4, 1, 2), -- id: 2 (más habitantes piso 1)
(201, 2, 1, 1, 2), -- id: 3
(202, 2, 5, 1, 3), -- id: 4 (más habitantes piso 2)
(301, 3, 3, 1, 4), -- id: 5

-- Edificio 2: Parque Almagro
(101, 1, 1, 2, 1), -- id: 6
(102, 1, 3, 2, 2), -- id: 7
(201, 2, 4, 2, 3), -- id: 8

-- Edificio 3: Mirador Providencia
(101, 1, 2, 3, 2), -- id: 9
(201, 2, 3, 3, 3), -- id: 10
(301, 3, 6, 3, 4), -- id: 11

-- Edificio 4: Plaza Ñuñoa
(101, 1, 1, 4, 5), -- id: 12 (Micro-Studio)
(102, 1, 3, 4, 2), -- id: 13
(201, 2, 2, 4, 3), -- id: 14
(301, 3, 4, 4, 4), -- id: 15

-- Edificio 5: Espacio Florida
(101, 1, 2, 5, 5), -- id: 16
(102, 1, 1, 5, 2), -- id: 17
(201, 2, 5, 5, 3), -- id: 18

-- Edificio 7: Altos de Las Condes
(101, 1, 2, 7, 3), -- id: 19
(201, 2, 4, 7, 4), -- id: 20
(301, 3, 7, 7, 4); -- id: 21 (Penthouse muy poblado)

-- =====================================================
-- 6. GASTO_COMUN
-- Generados para los últimos 3 meses: Agosto, Septiembre, Octubre 2026
-- id generados: del 1 al 15
-- =====================================================
INSERT INTO Gasto_Comun (fecha, monto, tipo, id_edificio) VALUES
-- Edificio 1: Torre Central (id 1, 2, 3)
('2026-08-01', 500000, 'Ordinario', 1),
('2026-09-01', 520000, 'Ordinario', 1),
('2026-10-01', 510000, 'Ordinario', 1),

-- Edificio 2: Parque Almagro (id 4, 5, 6)
('2026-08-01', 300000, 'Ordinario', 2),
('2026-09-01', 310000, 'Ordinario', 2),
('2026-10-01', 305000, 'Ordinario', 2),

-- Edificio 4: Plaza Ñuñoa (id 7, 8, 9)
('2026-08-01', 400000, 'Ordinario', 4),
('2026-09-01', 410000, 'Ordinario', 4),
('2026-10-01', 420000, 'Ordinario', 4),

-- Edificio 5: Espacio Florida (id 10, 11, 12)
('2026-08-01', 220000, 'Ordinario', 5),
('2026-09-01', 210000, 'Ordinario', 5),
('2026-10-01', 215000, 'Ordinario', 5),

-- Edificio 7: Altos de Las Condes (id 13, 14, 15)
('2026-08-01', 1200000, 'Ordinario', 7),
('2026-09-01', 1250000, 'Ordinario', 7),
('2026-10-01', 1300000, 'Ordinario', 7);

-- =====================================================
-- 7. PAGO_GASTO_COMUN_DEPARTAMENTO
-- Con estados 'Pagado' y 'Pendiente' (morosos)
-- =====================================================
INSERT INTO Pago_Gasto_Comun_Departamento (monto, fecha_pago, estado_pago, id_gasto_comun, id_departamento) VALUES
-- AGOSTO 2026
(100000, '2026-08-05', 'Pagado',    1, 1),
(100000, '2026-08-06', 'Pendiente', 1, 2), -- Moroso Depto 102 Edif 1
(100000, '2026-08-08', 'Pendiente', 1, 3), -- Moroso Depto 201 Edif 1
(100000, '2026-08-05', 'Pagado',    4, 6),
(100000, '2026-08-07', 'Pendiente', 4, 7), -- Moroso Depto 102 Edif 2
(80000,  '2026-08-04', 'Pagado',    7, 12),
(100000, '2026-08-06', 'Pendiente', 7, 14), -- Moroso Depto 201 Edif 4
(400000, '2026-08-05', 'Pagado',    13, 19),
(450000, '2026-08-06', 'Pendiente', 13, 21), -- Moroso Depto 301 Edif 7

-- SEPTIEMBRE 2026
(104000, '2026-09-05', 'Pagado',    2, 1),
(104000, '2026-09-07', 'Pendiente', 2, 2), -- Moroso recurrente Depto 102 Edif 1
(104000, '2026-09-09', 'Pagado',    2, 3),
(103000, '2026-09-05', 'Pagado',    5, 6),
(82000,  '2026-09-06', 'Pagado',    8, 12),
(102000, '2026-09-08', 'Pendiente', 8, 14), -- Moroso recurrente Depto 201 Edif 4
(415000, '2026-09-05', 'Pagado',    14, 19),
(460000, '2026-09-08', 'Pagado',    14, 21),

-- OCTUBRE 2026
(102000, '2026-10-04', 'Pendiente', 3, 1), -- Moroso Depto 101 Edif 1
(102000, '2026-10-05', 'Pendiente', 3, 2), -- Moroso Depto 102 Edif 1 (3 meses seguidos)
(102000, '2026-10-06', 'Pagado',    3, 3),
(84000,  '2026-10-03', 'Pagado',    9, 12),
(105000, '2026-10-05', 'Pendiente', 9, 14), -- Moroso Depto 201 Edif 4 (3 meses seguidos)
(430000, '2026-10-04', 'Pagado',    15, 19),
(480000, '2026-10-07', 'Pendiente', 15, 21); -- Cobro más caro (Penthouse)

-- =====================================================
-- 8. GASTO_EDIFICIO
-- Gastos operativos por mes para comparar edificios
-- =====================================================
INSERT INTO Gasto_Edificio (descripcion, monto, fecha_gasto, id_edificio) VALUES
-- Edificio 1: Torre Central
('Mantención ascensores', 150000, '2026-08-10', 1), -- id: 1
('Reparación bomba de agua', 210000, '2026-09-05', 1), -- id: 2
('Mantención preventiva', 140000, '2026-10-02', 1), -- id: 3

-- Edificio 2: Parque Almagro
('Jardinería y limpieza', 60000, '2026-08-12', 2), -- id: 4
('Insumos de conserjería', 45000, '2026-09-11', 2), -- id: 5
('Pintura pasillos', 55000, '2026-10-04', 2), -- id: 6

-- Edificio 5: Espacio Florida (El que menos gasta)
('Cambio ampolletas comunes', 25000, '2026-08-08', 5), -- id: 7
('Recarga extintores', 30000, '2026-09-10', 5), -- id: 8
('Artículos básicos de aseo', 28000, '2026-10-03', 5), -- id: 9

-- Edificio 7: Altos de Las Condes (El que más gasta)
('Seguridad y conserjería 24/7', 650000, '2026-08-15', 7), -- id: 10
('Mantención piscina y calderas', 580000, '2026-09-18', 7), -- id: 11
('Certificación de gas y ascensores', 720000, '2026-10-05', 7); -- id: 12

-- =====================================================
-- 9. PAGO_GASTO_EDIFICIO
-- Pagos a proveedores agrupables por mes
-- =====================================================
INSERT INTO Pago_Gasto_Edificio (monto_pagado, fecha_pago, id_gasto_edificio) VALUES
-- Agosto 2026
(150000, '2026-08-14', 1),
(60000,  '2026-08-15', 4),
(25000,  '2026-08-12', 7),
(650000, '2026-08-20', 10),

-- Septiembre 2026
(210000, '2026-09-08', 2),
(45000,  '2026-09-15', 5),
(30000,  '2026-09-14', 8),
(580000, '2026-09-22', 11),

-- Octubre 2026
(140000, '2026-10-05', 3),
(55000,  '2026-10-08', 6),
(28000,  '2026-10-06', 9),
(720000, '2026-10-09', 12);