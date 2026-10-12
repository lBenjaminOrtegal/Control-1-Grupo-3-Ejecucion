CREATE DATABASE IF NOT EXISTS control_1;

USE control_1;

CREATE TABLE IF NOT EXISTS Administrador (
    id INT AUTO_INCREMENT PRIMARY KEY,
    rut VARCHAR(12) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    correo VARCHAR(100) NOT NULL,
    telefono VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS Comuna (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS Edificio (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    calle VARCHAR(100) NOT NULL,
    numero VARCHAR(20) NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    
	id_comuna INT NOT NULL,
    id_administrador INT NOT NULL,
    
    CONSTRAINT comuna_edificio_fk
    FOREIGN KEY (id_comuna) REFERENCES Comuna(id),
    
    CONSTRAINT administrador_edificio_fk
    FOREIGN KEY (id_administrador) REFERENCES Administrador(id)
);

CREATE TABLE IF NOT EXISTS Tipo_Departamento (
	id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    superficie DECIMAL(6, 2) NOT NULL
);

CREATE TABLE IF NOT EXISTS Departamento (
	id INT AUTO_INCREMENT PRIMARY KEY,
    numero INT NOT NULL,
    piso INT NOT NULL,
    habitantes TINYINT NOT NULL,
    
    id_edificio INT NOT NULL,
    id_tipo_departamento INT NOT NULL,
    
    CONSTRAINT edificio_departamento_fk
    FOREIGN KEY (id_edificio) REFERENCES Edificio(id),
    
    CONSTRAINT tipo_departamento_departamento_fk
    FOREIGN KEY (id_tipo_departamento) REFERENCES Tipo_Departamento(id)
);

CREATE TABLE IF NOT EXISTS Tipo_Gasto_Comun (
	id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT NOT NULL
);

-- Relacion entre Tipo_Gasto_Comun y Tipo_Departamento
CREATE TABLE IF NOT EXISTS Depende_Tipo_Gasto_Comun_Tipo_Departamento (
    id_tipo_gasto_comun INT NOT NULL,
    id_tipo_departamento INT NOT NULL,
    
    PRIMARY KEY (id_tipo_gasto_comun, id_tipo_departamento),
    
    CONSTRAINT depende_tipo_gasto_comun_fk
    FOREIGN KEY (id_tipo_gasto_comun) REFERENCES Tipo_Gasto_Comun(id),
    
    CONSTRAINT depende_tipo_departamento_fk
    FOREIGN KEY (id_tipo_departamento) REFERENCES Tipo_Departamento(id)
);

CREATE TABLE IF NOT EXISTS Gasto_Comun (
	id INT AUTO_INCREMENT PRIMARY KEY,
    fecha_emision DATE NOT NULL,
    fecha_vencimiento DATE NOT NULL,
    monto DECIMAL(12, 2) NOT NULL,
    
    id_edificio INT NOT NULL,
    id_tipo_gasto_comun INT NOT NULL,
    
    CONSTRAINT edificio_gasto_comun_fk
    FOREIGN KEY (id_edificio) REFERENCES Edificio(id),
    
    CONSTRAINT tipo_gasto_comun_gasto_comun_fk
    FOREIGN KEY (id_tipo_gasto_comun) REFERENCES Tipo_Gasto_Comun(id)
);

CREATE TABLE IF NOT EXISTS Pago_Gasto_Comun_Departamento (
	 id INT AUTO_INCREMENT PRIMARY KEY,
     monto DECIMAL(12, 2) NOT NULL,
     fecha_pago DATE NULL,
     estado_pago ENUM('Pendiente', 'Pagado') NOT NULL DEFAULT 'Pendiente',
     
     id_gasto_comun INT NOT NULL,
     id_departamento INT NOT NULL,
     
     CONSTRAINT uq_gasto_depto
     UNIQUE (id_gasto_comun, id_departamento),
     
     CONSTRAINT gasto_comun_pago_gasto_comun_departamento_fk
     FOREIGN KEY (id_gasto_comun) REFERENCES Gasto_Comun(id),
     
     CONSTRAINT departamento_pago_gasto_comun_departamento_fk
     FOREIGN KEY (id_departamento) REFERENCES Departamento(id)
);

CREATE TABLE IF NOT EXISTS Gasto_Edificio (
	id INT AUTO_INCREMENT PRIMARY KEY,
    descripcion TEXT NOT NULL,
    monto DECIMAL(12, 2) NOT NULL,
    fecha_emision DATE NOT NULL,
    fecha_vencimiento DATE NOT NULL,
    
    id_edificio INT NOT NULL,
    
    CONSTRAINT edificio_gasto_edificio_fk
    FOREIGN KEY (id_edificio) REFERENCES Edificio(id)
);

CREATE TABLE IF NOT EXISTS Pago_Gasto_Edificio (
	id INT AUTO_INCREMENT PRIMARY KEY,
    monto DECIMAL(12, 2) NOT NULL,
    fecha_pago DATE NOT NULL,
    
    id_gasto_edificio INT NOT NULL,
    
    CONSTRAINT gasto_edificio_pago_gasto_edificio_fk
    FOREIGN KEY (id_gasto_edificio) REFERENCES Gasto_Edificio(id)
);