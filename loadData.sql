USE control_1;

-- =====================================================
-- 1. ADMINISTRADOR
-- Admin 1 (Carlos Pérez) administra 3 edificios -> Para Consulta 6
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
('Torre Central', 'Av. Libertador', '1010', 'Residencial', 1, 1),        -- id: 1 (Admin 1)
('Parque Almagro', 'San Diego', '450', 'Residencial', 1, 1),            -- id: 2 (Admin 1)
('Mirador Providencia', 'Av. Providencia', '2100', 'Mixto', 2, 2),       -- id: 3 (Admin 2)
('Plaza Ñuñoa', 'Av. Irarrázaval', '3400', 'Residencial', 4, 1),        -- id: 4 (Admin 1 -> 3 edif a cargo)
('Espacio Florida', 'Av. Vicuña Mackenna', '7200', 'Residencial', 5, 4), -- id: 5 (Admin 4)
('Los Dominicos', 'Camino El Alba', '1250', 'Residencial', 3, 4),       -- id: 6 (Admin 4)
('Altos de Las Condes', 'Av. Apoquindo', '4800', 'Exclusivo', 3, 5);    -- id: 7 (Admin 5)

-- =====================================================
-- 4. TIPO_DEPARTAMENTO
-- Micro-Studio (22.50 m²) es el más pequeño -> Para Consulta 10
-- Penthouse (160.00 m²) es el más grande y costoso
-- =====================================================
INSERT INTO Tipo_Departamento (nombre, superficie) VALUES
('Micro-Studio', 22.50),  -- id: 1
('Studio', 32.00),        -- id: 2
('1D 1B', 45.00),         -- id: 3
('2D 2B', 68.00),         -- id: 4
('Penthouse 4D', 160.00); -- id: 5

-- =====================================================
-- 5. DEPARTAMENTO
-- Para Consulta 7 (Habitantes por piso por edificio):
--  - Edificio 1, Piso 1 -> Depto 102 con 4 hab. vs Depto 101 con 2 hab.
--  - Edificio 1, Piso 2 -> Depto 202 con 5 hab. vs Depto 201 con 1 hab.
--  - Edificio 7, Piso 3 -> Depto 301 con 7 hab.
-- Para Consultas 5, 8 y 10: Distribución de tipos por comuna y edificio.
-- =====================================================
INSERT INTO Departamento (numero, piso, habitantes, id_edificio, id_tipo_departamento) VALUES
-- Edificio 1: Torre Central
(101, 1, 2, 1, 2), -- id: 1 (Studio)
(102, 1, 4, 1, 3), -- id: 2 (1D 1B) -> Mayor habitantes piso 1
(201, 2, 1, 1, 3), -- id: 3 (1D 1B)
(202, 2, 5, 1, 4), -- id: 4 (2D 2B) -> Mayor habitantes piso 2
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
(101, 1, 2, 5, 1), -- id: 16 (Micro-Studio) -> Más pequeño en Edif 5
(102, 1, 1, 5, 3), -- id: 17 (1D 1B)
(201, 2, 5, 5, 4), -- id: 18 (2D 2B)

-- Edificio 7: Altos de Las Condes
(101, 1, 2, 7, 4), -- id: 19 (2D 2B)
(201, 2, 4, 7, 5), -- id: 20 (Penthouse)
(301, 3, 7, 7, 5); -- id: 21 (Penthouse) -> Mayor habitantes piso 3

-- =====================================================
-- 6. TIPO_GASTO_COMUN Y MATRIZ DEPENDIENTE (N:M)
-- =====================================================
INSERT INTO Tipo_Gasto_Comun (nombre, descripcion) VALUES
('Gasto Ordinario', 'Gastos fijos operacionales del mes (luz común, conserjería, aseo)'),
('Fondo de Reserva', 'Aporte extraordinario para imprevistos estructurales');

INSERT INTO Depende_Tipo_Gasto_Comun_Tipo_Departamento (id_tipo_gasto_comun, id_tipo_departamento) VALUES
(1, 1), (1, 2), (1, 3), (1, 4), (1, 5),
(2, 4), (2, 5);

-- =====================================================
-- 7. GASTO_COMUN (Últimos 3 meses: Agosto, Septiembre, Octubre 2026)
-- Emisiones globales por edificio
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
-- Para Consulta 1: Morosos con 'Pendiente' en los últimos 3 meses (Depto 2 y 14)
-- Para Consulta 2: Recaudación por mes filtrando 'Pagado'
-- Para Consulta 4: Penthouse (Depto 21) tiene los cobros más caros ($450.000+)
-- =====================================================
INSERT INTO Pago_Gasto_Comun_Departamento (monto, fecha_pago, estado_pago, id_gasto_comun, id_departamento) VALUES
-- AGOSTO 2026 (Gasto_Comun: 1, 4, 7, 13)
(100000.00, '2026-08-05', 'Pagado',    1, 1),   -- Depto 101 (Edif 1) al día
(100000.00, NULL,         'Pendiente', 1, 2),   -- Depto 102 (Edif 1) Moroso mes 1
(100000.00, NULL,         'Pendiente', 1, 3),   -- Depto 201 (Edif 1) Moroso mes 1
(100000.00, '2026-08-05', 'Pagado',    4, 6),   -- Depto 101 (Edif 2) al día
(100000.00, NULL,         'Pendiente', 4, 7),   -- Depto 102 (Edif 2) Moroso
(80000.00,  '2026-08-04', 'Pagado',    7, 12),  -- Depto 101 (Edif 4) al día
(100000.00, NULL,         'Pendiente', 7, 14),  -- Depto 201 (Edif 4) Moroso mes 1
(400000.00, '2026-08-05', 'Pagado',    13, 19), -- Depto 101 (Edif 7) al día
(450000.00, NULL,         'Pendiente', 13, 21), -- Depto 301 Penthouse (Edif 7) Moroso

-- SEPTIEMBRE 2026 (Gasto_Comun: 2, 5, 8, 14)
(104000.00, '2026-09-05', 'Pagado',    2, 1),   -- Depto 101 (Edif 1) al día
(104000.00, NULL,         'Pendiente', 2, 2),   -- Depto 102 (Edif 1) Moroso mes 2
(104000.00, '2026-09-09', 'Pagado',    2, 3),   -- Depto 201 (Edif 1) al día
(103000.00, '2026-09-05', 'Pagado',    5, 6),   -- Depto 101 (Edif 2) al día
(82000.00,  '2026-09-06', 'Pagado',    8, 12),  -- Depto 101 (Edif 4) al día
(102000.00, NULL,         'Pendiente', 8, 14),  -- Depto 201 (Edif 4) Moroso mes 2
(415000.00, '2026-09-05', 'Pagado',    14, 19), -- Depto 101 (Edif 7) al día
(460000.00, '2026-09-08', 'Pagado',    14, 21), -- Depto 301 Penthouse (Edif 7) al día

-- OCTUBRE 2026 (Gasto_Comun: 3, 6, 9, 15)
(102000.00, NULL,         'Pendiente', 3, 1),   -- Depto 101 (Edif 1) Moroso en oct
(102000.00, NULL,         'Pendiente', 3, 2),   -- Depto 102 (Edif 1) Moroso mes 3 (3 meses continuos)
(102000.00, '2026-10-06', 'Pagado',    3, 3),   -- Depto 201 (Edif 1) al día
(84000.00,  '2026-10-03', 'Pagado',    9, 12),  -- Depto 101 (Edif 4) al día
(105000.00, NULL,         'Pendiente', 9, 14),  -- Depto 201 (Edif 4) Moroso mes 3 (3 meses continuos)
(430000.00, '2026-10-04', 'Pagado',    15, 19), -- Depto 101 (Edif 7) al día
(480000.00, NULL,         'Pendiente', 15, 21); -- Depto 301 Penthouse (Edif 7) Moroso

-- =====================================================
-- 9. PAGO_GASTO_EDIFICIO
-- Cabecera histórica consolidada por edificio (se crea antes que Gasto_Edificio)
-- Para Consulta 3: Total pagado por mes (Agosto: $885.000, Sep: $865.000, Oct: $943.000)
-- Para Consulta 9: Edif 5 (Espacio Florida) registra el menor gasto mensual ($25.000 - $30.000)
-- =====================================================
INSERT INTO Pago_Gasto_Edificio (monto, fecha_pago, id_edificio) VALUES
-- Pagos Agosto 2026
(150000.00, '2026-08-14', 1), -- id: 1 (Torre Central)
(60000.00,  '2026-08-15', 2), -- id: 2 (Parque Almagro)
(25000.00,  '2026-08-12', 5), -- id: 3 (Espacio Florida - menor gasto)
(650000.00, '2026-08-20', 7), -- id: 4 (Altos de Las Condes)

-- Pagos Septiembre 2026
(210000.00, '2026-09-08', 1), -- id: 5 (Torre Central)
(45000.00,  '2026-09-15', 2), -- id: 6 (Parque Almagro)
(30000.00,  '2026-09-14', 5), -- id: 7 (Espacio Florida - menor gasto)
(580000.00, '2026-09-22', 7), -- id: 8 (Altos de Las Condes)

-- Pagos Octubre 2026
(140000.00, '2026-10-05', 1), -- id: 9 (Torre Central)
(55000.00,  '2026-10-08', 2), -- id: 10 (Parque Almagro)
(28000.00,  '2026-10-06', 5), -- id: 11 (Espacio Florida - menor gasto)
(720000.00, '2026-10-09', 7); -- id: 12 (Altos de Las Condes)

-- =====================================================
-- 10. GASTO_EDIFICIO
-- Detalle de cada egreso que compone el pago consolidado (apunta a id_pago_gasto_edificio)
-- =====================================================
INSERT INTO Gasto_Edificio (descripcion, monto, fecha_emision, fecha_vencimiento, id_pago_gasto_edificio) VALUES
-- Detalle Agosto 2026
('Mantención ascensores', 150000.00, '2026-08-01', '2026-08-20', 1),
('Jardinería y limpieza', 60000.00, '2026-08-01', '2026-08-20', 2),
('Cambio ampolletas comunes', 25000.00, '2026-08-01', '2026-08-20', 3),
('Seguridad y conserjería 24/7', 650000.00, '2026-08-01', '2026-08-20', 4),

-- Detalle Septiembre 2026
('Reparación bomba de agua', 210000.00, '2026-09-01', '2026-09-20', 5),
('Insumos de conserjería', 45000.00, '2026-09-01', '2026-09-20', 6),
('Recarga extintores', 30000.00, '2026-09-01', '2026-09-20', 7),
('Mantención piscina y calderas', 580000.00, '2026-09-01', '2026-09-20', 8),

-- Detalle Octubre 2026
('Mantención preventiva caldera', 140000.00, '2026-10-01', '2026-10-20', 9),
('Pintura pasillos', 55000.00, '2026-10-01', '2026-10-20', 10),
('Artículos básicos de aseo', 28000.00, '2026-10-01', '2026-10-20', 11),
('Certificación de gas y ascensores', 720000.00, '2026-10-01', '2026-10-20', 12);