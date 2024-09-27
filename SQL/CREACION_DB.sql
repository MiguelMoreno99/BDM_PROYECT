-- Creaci�n de la base de datos
CREATE DATABASE db_leveluplearning;

-- Uso de la base de datos reci�n creada
USE db_leveluplearning;

-- Creaci�n de la tabla "usuarios"
CREATE TABLE tabla_usuarios (
    id_usuario INT IDENTITY(1,1) PRIMARY KEY,			-- ID USUARIO como llave primaria y autoincrementable
    tipo_usuario INT NOT NULL,							-- Tipo de usuario (1=INSTRUCTOR,2=ESTUDIANTE,3=ADMINISTRADOR)
    imagen_usuario IMAGE,								-- Imagen de usuario en formato BLOB
    usuario_bloqueado BIT DEFAULT 0,					-- Usuario bloqueado (0=DESBLOQUEADO,1=BLOQUEADO)
    nombre_usuario VARCHAR(255) NOT NULL,                -- Nombre(s) del usuario
    apellido_usuario VARCHAR(255) NOT NULL,  			-- Apellido(s) paterno del usuario
    genero_usuario INT NOT NULL,						-- G�nero del usuario (0=MASCULINO,1=FEMENINO,2=OTRO)
    nacimiento_usuario DATETIME NOT NULL,				-- Fecha de nacimiento del usuario
    correo_usuario VARCHAR(255) NOT NULL,                -- Correo del usuario
    contrase�a_usuario VARCHAR(255) NOT NULL,            -- Contrase�a del usuario
    registro_usuario DATETIME,							-- Fecha de registro del usuario
    equivocaciones_usuario INT DEFAULT 0				-- N�mero de equivocaciones del usuario
);

insert into tabla_usuarios(tipo_usuario,nombre_usuario,apellido_usuario,genero_usuario,nacimiento_usuario,correo_usuario,contrase�a_usuario,registro_usuario) 
values (1,'Miguel Angel','Moreno',0,convert(date,'1999-06-29'),'mmd.-@hotmail.com','Hola12345!',GETDATE());
insert into tabla_usuarios(tipo_usuario,nombre_usuario,apellido_usuario,genero_usuario,nacimiento_usuario,correo_usuario,contrase�a_usuario,registro_usuario) 
values (2,'Angel','Davila',0,convert(date,'1997-05-09'),'ad.-@hotmail.com','Adios12345!',GETDATE());
insert into tabla_usuarios(tipo_usuario,nombre_usuario,apellido_usuario,genero_usuario,nacimiento_usuario,correo_usuario,contrase�a_usuario,registro_usuario) 
values (3,'Miguel','Rodriguez',0,convert(date,'1994-09-19'),'mr.-@hotmail.com','Hola54321!',GETDATE());

-- Creaci�n de la tabla "categorias"
CREATE TABLE tabla_categorias (
    id_categoria INT IDENTITY(1,1) PRIMARY KEY,            -- ID CATEGORIA como llave primaria y autoincrementable
    descripcion_categoria VARCHAR(255) NOT NULL,		   -- Descripci�n de la categor�a
	imagen_categoria IMAGE,								   -- Imagen de la categoria en formato BLOB
    id_administrador_creador INT,                          -- ID USUARIO CREADOR (llave for�nea a la tabla "usuarios")
	fecha_creacion_categoria DATETIME,					   -- Fecha de creaci�n de la categor�a
    categoria_eliminada BIT DEFAULT 0,		               -- Indica si la categor�a est� eliminada (0=HABILITADO,1=DESHABILITADO)
    id_administrador_elimina_categoria INT DEFAULT NULL,   -- ID USUARIO ELIMINA CATEGORIA (llave for�nea a la tabla "usuarios")
    fecha_eliminacion_categoria DATETIME DEFAULT NULL,     -- Fecha de eliminaci�n de la categor�a
    FOREIGN KEY (id_administrador_creador) REFERENCES tabla_usuarios(id_usuario),			 -- FK a la tabla "usuarios" (creador)
    FOREIGN KEY (id_administrador_elimina_categoria) REFERENCES tabla_usuarios(id_usuario)   -- FK a la tabla "usuarios" (elimina)
);

insert into tabla_categorias(descripcion_categoria,id_administrador_creador,fecha_creacion_categoria) 
values ('Programaci�n',3,GETDATE());
insert into tabla_categorias(descripcion_categoria,id_administrador_creador,fecha_creacion_categoria) 
values ('Animaci�n',3,GETDATE());
insert into tabla_categorias(descripcion_categoria,id_administrador_creador,fecha_creacion_categoria) 
values ('Arte',3,GETDATE());

-- Creaci�n de la tabla "cursos"
CREATE TABLE tabla_cursos (
    id_curso INT IDENTITY(1,1) PRIMARY KEY,                  -- ID CURSO como llave primaria y autoincrementable
    titulo_curso VARCHAR(255) NOT NULL,                      -- T�tulo del curso
    id_categoria_curso INT,                                  -- ID CATEGORIA CURSO (llave for�nea a la tabla "categorias")
    niveles_curso INT NOT NULL,                              -- Niveles del curso
    manejo_precio_curso INT NOT NULL,						 -- 0=CURSO COMPLETO GRATIS, 1=PRECIO POR CURSO COMPLETO, 2=PRECIO POR CADA NIVEL
	precio_curso FLOAT DEFAULT NULL,                         -- Precio del curso
    descripcion_curso VARCHAR(MAX),                          -- Descripci�n del curso
    porcentaje_resenas_positivas FLOAT DEFAULT 0.0,          -- Porcentaje de rese�as positivas del curso
    imagen_curso IMAGE,                                      -- Imagen del curso en formato BLOB
    curso_deshabilitado BIT DEFAULT 0,		                 -- Indica si el curso est� deshabilitado (FALSE=HABILITADO,TRUE=DESHABILITADO)
    fecha_creacion_curso DATETIME,						     -- Fecha de creaci�n del curso
    id_instructor_creacion_curso INT,                           -- ID USUARIO CREACION CURSO (llave for�nea a la tabla "usuarios")
    id_instructor_eliminacion_curso INT DEFAULT NULL,           -- ID USUARIO ELIMINACION CURSO (llave for�nea a la tabla "usuarios")
    fecha_eliminacion_curso DATETIME DEFAULT NULL,           -- Fecha de eliminaci�n del curso
    FOREIGN KEY (id_categoria_curso) REFERENCES tabla_categorias(id_categoria),		 -- FK a la tabla "categorias"
    FOREIGN KEY (id_instructor_creacion_curso) REFERENCES tabla_usuarios(id_usuario),   -- FK a la tabla "usuarios" (creador)
    FOREIGN KEY (id_instructor_eliminacion_curso) REFERENCES tabla_usuarios(id_usuario) -- FK a la tabla "usuarios" (elimina)
);

insert into tabla_cursos(titulo_curso,id_categoria_curso,niveles_curso,manejo_precio_curso,precio_curso,descripcion_curso,fecha_creacion_curso,id_instructor_creacion_curso) 
values ('Curso de Programaci�n en Python',1,1,1,1400.99,'Este curso est� dise�ado para principiantes y cubre los fundamentos de la programaci�n en Python, uno de los lenguajes de programaci�n m�s utilizados en la actualidad. A trav�s de ejemplos pr�cticos y ejercicios, los estudiantes aprender�n conceptos clave como variables, estructuras de control, funciones, y mucho m�s.',GETDATE(),1);

-- Creaci�n de la tabla "niveles"
CREATE TABLE tabla_niveles (
    id_nivel INT IDENTITY(1,1) PRIMARY KEY,                  -- ID NIVEL como llave primaria y autoincrementable
    id_instructor_nivel INT NOT NULL,                        -- ID USUARIO INSTRUCTOR NIVEL (llave for�nea a la tabla "usuarios")
    titulo_nivel VARCHAR(255) NOT NULL,						 -- Titulo del Video
	documento_nivel VARCHAR(MAX),							 -- Link del drive del documento PDF
	link_video_nivel VARCHAR(MAX) NOT NULL,                  -- Enlace del video del nivel
    costo_nivel FLOAT DEFAULT 0.0,                           -- Costo del nivel
    id_curso_nivel INT NOT NULL,                             -- ID CURSO NIVEL (llave for�nea a la tabla "cursos")
    informacion_nivel VARCHAR(255) NOT NULL,                 -- Informaci�n adicional sobre el nivel
    imagen_nivel IMAGE,                                      -- Imagen del nivel en formato BLOB
    referencias_nivel VARCHAR(MAX) NOT NULL,                 -- Link a p�gina externa sobre el nivel
    fecha_creacion_nivel DATETIME,							 -- Fecha de creaci�n del nivel
    FOREIGN KEY (id_instructor_nivel) REFERENCES tabla_usuarios(id_usuario),		 -- FK a la tabla "usuarios" (instructor)
    FOREIGN KEY (id_curso_nivel) REFERENCES tabla_cursos(id_curso)					 -- FK a la tabla "cursos"
);

insert into tabla_niveles(id_instructor_nivel,titulo_nivel,documento_nivel,link_video_nivel,costo_nivel,id_curso_nivel,informacion_nivel,referencias_nivel,fecha_creacion_nivel)
values (1,'Historia de Python','https://uanledu-my.sharepoint.com/:b:/g/personal/miguel_morenoda_uanl_edu_mx/EebbDw2pHvNEr5zpim5IrAMBB-B_NXfz9b9YqMOxgmOHig?e=vl6WGG','https://www.youtube.com/watch?v=tf4qLcKk6ZU&t=236s',0.0,1,'En este nivel se ver� la historia del lenguaje de programaci�n Python','https://www.aluracursos.com/blog/que-es-python-historia-guia-para-iniciar',GETDATE());

-- Creaci�n de la tabla "inscripciones"
CREATE TABLE tabla_inscripciones (
    id_inscripcion INT IDENTITY(1,1) PRIMARY KEY,             -- ID INSCRIPCION como llave primaria y autoincrementable
    id_estudiante_inscripcion INT NOT NULL,                   -- ID ESTUDIANTE INSCRIPCION (llave for�nea a la tabla "usuarios")
    id_curso_inscripcion INT NOT NULL,                        -- ID CURSO INSCRIPCION (llave for�nea a la tabla "cursos")
    fecha_inscripcion DATETIME,							      -- Fecha de inscripci�n
    ultima_fecha_ingreso DATETIME DEFAULT NULL,               -- �ltima fecha de ingreso al curso
    fecha_terminacion_inscripcion DATETIME DEFAULT NULL,      -- Fecha de terminaci�n de la inscripci�n
    inscripcion_finalizada BIT DEFAULT 0,		              -- Indica si la inscripci�n est� finalizada ( 0=NO TERMINADO, 1=TERMINADO,)
    metodo_pago_inscripcion INT NOT NULL,                     -- M�todo de pago de la inscripci�n ( 0 = TARJETA DEBITO,1 = TARJETA CREDITO, 2 = GRATIS)
    porcentaje_avance_curso FLOAT DEFAULT 0.0,	              -- Porcentaje de avance en el curso
    FOREIGN KEY (id_estudiante_inscripcion) REFERENCES tabla_usuarios(id_usuario),  -- FK a la tabla "usuarios" (estudiante)
    FOREIGN KEY (id_curso_inscripcion) REFERENCES tabla_cursos(id_curso)			-- FK a la tabla "cursos"
);

insert into tabla_inscripciones(id_estudiante_inscripcion,id_curso_inscripcion,fecha_inscripcion,metodo_pago_inscripcion)
values(2,1,GETDATE(),0);

-- Creaci�n de la tabla "comentarios"
CREATE TABLE tabla_comentarios (
    id_comentario INT IDENTITY(1,1) PRIMARY KEY,               -- ID COMENTARIO como llave primaria y autoincrementable
    descripcion_comentario VARCHAR(255) NOT NULL,              -- Descripci�n del comentario
    id_curso_comentario INT NOT NULL,                          -- ID CURSO COMENTARIO (llave for�nea a la tabla "cursos")
    id_estudiante_comentario INT NOT NULL,                     -- ID USUARIO COMENTARIO (llave for�nea a la tabla "usuarios")
    calificacion_curso INT NOT NULL,                           -- Calificaci�n del curso 1 AL 5 (ESTRELLAS)
    comentario_eliminado BIT DEFAULT 0,                        -- Indica si el comentario est� eliminado (0=NO ELIMINADO,1=ELIMINADO)
    fecha_creacion_comentario DATETIME,						   -- Fecha de creaci�n del comentario
    fecha_eliminacion_comentario DATETIME DEFAULT NULL,        -- Fecha de eliminaci�n del comentario
    causa_eliminacion_comentario VARCHAR(255) DEFAULT NULL,    -- Causa de eliminaci�n del comentario
    id_administrador_eliminacion_comentario INT DEFAULT NULL,        -- ID USUARIO ELIMINACION COMENTARIO (llave for�nea a la tabla "usuarios")
    FOREIGN KEY (id_curso_comentario) REFERENCES tabla_cursos(id_curso),				-- FK a la tabla "cursos"
    FOREIGN KEY (id_estudiante_comentario) REFERENCES tabla_usuarios(id_usuario),			  -- FK a la tabla "usuarios" (autor del comentario)
    FOREIGN KEY (id_administrador_eliminacion_comentario) REFERENCES tabla_usuarios(id_usuario) -- FK a la tabla "usuarios" (elimina comentario)
);

insert into tabla_comentarios(descripcion_comentario,id_curso_comentario,id_estudiante_comentario,calificacion_curso,fecha_creacion_comentario)
values('Excelente curso, aprend� mucho sobre Python. Los ejemplos fueron claros y �tiles.',1,2,4,GETDATE());

-- Creaci�n de la tabla "diplomas"
CREATE TABLE tabla_diplomas (
    id_diploma INT IDENTITY(1,1) PRIMARY KEY,                -- ID DIPLOMA como llave primaria y autoincrementable
    fecha_terminacion_diploma DATETIME NOT NULL,             -- Fecha de terminaci�n del diploma
    id_curso_diploma INT NOT NULL,                           -- ID CURSO DIPLOMA (llave for�nea a la tabla "cursos")
    id_estudiante_diploma INT NOT NULL,					     -- ID USUARIO ESTUDIANTE DIPLOMA (llave for�nea a la tabla "usuarios")
    id_instructor_diploma INT NOT NULL,						 -- ID USUARIO INSTRUCTOR DIPLOMA (llave for�nea a la tabla "usuarios")
    imagen_curso_diploma IMAGE,                              -- Imagen del diploma en formato BLOB
    promedio_diploma FLOAT DEFAULT 0.0,                      -- Promedio obtenido en el curso
    FOREIGN KEY (id_curso_diploma) REFERENCES tabla_cursos(id_curso),					-- FK a la tabla "cursos"
    FOREIGN KEY (id_estudiante_diploma) REFERENCES tabla_usuarios(id_usuario),  -- FK a la tabla "usuarios" (estudiante)
    FOREIGN KEY (id_instructor_diploma) REFERENCES tabla_usuarios(id_usuario)   -- FK a la tabla "usuarios" (instructor)
);

insert into tabla_diplomas(fecha_terminacion_diploma,id_curso_diploma,id_estudiante_diploma,id_instructor_diploma,promedio_diploma)
values(GETDATE(),1,2,1,8.7);

-- Creaci�n de la tabla "mensajes"
CREATE TABLE tabla_mensajes (
    id_mensaje INT IDENTITY(1,1) PRIMARY KEY,                -- ID MENSAJE como llave primaria y autoincrementable
    texto_mensaje VARCHAR(255) NOT NULL,                     -- Texto del mensaje
    id_curso_mensaje INT NOT NULL,                           -- ID CURSO MENSAJE (llave for�nea a la tabla "cursos")
    id_estudiante_mensaje INT NOT NULL,                      -- ID ALUMNO MENSAJE (llave for�nea a la tabla "usuarios")
    id_instructor_mensaje INT NOT NULL,                      -- ID INSTRUCTOR MENSAJE (llave for�nea a la tabla "usuarios")
    fecha_creacion_mensaje DATETIME,					     -- Fecha de creaci�n del mensaje
    FOREIGN KEY (id_curso_mensaje) REFERENCES tabla_cursos(id_curso),			-- FK a la tabla "cursos"
    FOREIGN KEY (id_estudiante_mensaje) REFERENCES tabla_usuarios(id_usuario),  -- FK a la tabla "usuarios" (alumno)
    FOREIGN KEY (id_instructor_mensaje) REFERENCES tabla_usuarios(id_usuario)	-- FK a la tabla "usuarios" (instructor)
);

insert into tabla_mensajes(texto_mensaje,id_curso_mensaje,id_estudiante_mensaje,id_instructor_mensaje,fecha_creacion_mensaje)
values('Hola!, tengo una duda sobre el curso de pyton',1,2,1,GETDATE());

---------------------------------------------------------------------------------------

SELECT * FROM tabla_usuarios;
SELECT * FROM tabla_categorias;
SELECT * FROM tabla_cursos;
SELECT * FROM tabla_niveles;
SELECT * FROM tabla_inscripciones;
SELECT * FROM tabla_comentarios;
SELECT * FROM tabla_diplomas;
SELECT * FROM tabla_mensajes;