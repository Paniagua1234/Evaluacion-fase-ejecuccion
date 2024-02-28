Drop database  if exists ejercicio_practico2;

create database ejercicio_practico2;

use ejercicio_practico2;

create table clientes(
	id_cliente VARCHAR(36) primary key,
	nombre_cliente varchar(50) NOT null,
	email_cliente VARCHAR(50) NOT NULL unique,
	telefono VARCHAR(15) NOT null
);

create table prestamos(
	id_prestamo VARCHAR(36) primary key,
	id_cliente VARCHAR(36) not null,
	constraint fk_prestamo_cliente
	foreign key (id_cliente)
	references clientes(id_cliente),
	fecha_inicio date not null,
	fecha_devolucion date not null,
	estado ENUM("activo","inactivo") not null
);

CREATE TABLE generos_libros(
	id_genero_libro VARCHAR(36) primary KEY,
	nombre_genero_libro VARCHAR(50) NOT null
);

CREATE TABLE libros(
	id_libro VARCHAR(36) primary KEY,
	titulo_libro VARCHAR(100) NOT NULL,
	anio_publicacion INT NULL,
	id_genero_libro VARCHAR(36),
	constraint fk_genero_libro
	foreign key (id_genero_libro)
	references generos_libros(id_genero_libro),
	estado ENUM("Disponible","Prestado") not NULL DEFAULT "Disponible"
);

DROP TABLE libros

CREATE TABLE detalles_prestamos(
	id_detalle_prestamo VARCHAR(36) primary KEY,
	id_libro VARCHAR(36) NOT NULL,
	id_prestamo VARCHAR(36) NOT null
);

--Trigger--

DELIMITER $$

CREATE TRIGGER update_libros before INSERT ON detalles_prestamos 
FOR EACH ROW
BEGIN
	UPDATE libros INNER JOIN detalles_prestamos SET estado=Prestado 
	WHERE libros.id_libro = detalles_prestamos.id_libro;
END$$ 

DELIMITER ;

--Proceso de insertar libros

DELIMITER $$
CREATE PROCEDURE Insertar_libros
(
IN titulo_libro VARCHAR(100), 
in anio INT, 
IN id_genero_libro VARCHAR(36),
IN estado ENUM("activo","inactivo")
)
BEGIN 
	INSERT INTO libros VALUES (UUID(),titulo_libro,anio,id_genero_libro,estado);
END$$ 

DELIMITER ;

CALL Insertar_libros("Alicia en un pais", 1990,"e756dad1-d65d-11ee-98e0-b04f1307c977","Disponible");

SELECT * FROM libros

INSERT INTO generos_libros VALUES (UUID(),"Ciencia ficcion");

SELECT * FROM generos_libros;

