create database db_leveluplearning;

use db_leveluplearning;

CREATE TABLE tabla_usuario
(
	id_usuario int NOT NULL AUTO_INCREMENT PRIMARY KEY,			-- ID USUARIO como llave primaria y autoincrementable
    tipo_usuario INT NOT NULL,							-- Tipo de usuario (1=INSTRUCTOR,2=ESTUDIANTE,3=ADMINISTRADOR)
    imagen_usuario longblob,								-- Imagen de usuario en formato BLOB
    usuario_bloqueado BIT DEFAULT 0,					-- Usuario bloqueado (0=DESBLOQUEADO,1=BLOQUEADO)
    nombre_usuario VARCHAR(50) NOT NULL,                -- Nombre(s) del usuario
    apellido_paterno VARCHAR(50) NOT NULL,  			-- Apellido(s) paterno del usuario
    apellido_materno VARCHAR(50) NOT NULL, 
    genero_usuario INT NOT NULL,						-- Género del usuario (0=MASCULINO,1=FEMENINO,2=OTRO)
    nacimiento_usuario DATETIME NOT NULL,				-- Fecha de nacimiento del usuario
    correo_usuario VARCHAR(255) NOT NULL,                -- Correo del usuario
    contrasenia_usuario VARCHAR(255) NOT NULL,            -- Contraseña del usuario
    registro_usuario DATE,							-- Fecha de registro del usuario
    Hora_usuario TIME,
    equivocaciones_usuario INT DEFAULT 0				-- Número de equivocaciones del usuario
);

CREATE TABLE tabla_categorias 
(
    id_categoria int NOT NULL AUTO_INCREMENT PRIMARY KEY,            -- ID CATEGORIA como llave primaria y autoincrementable
    descripcion_categoria VARCHAR(255) NOT NULL,		   -- Descripción de la categoría
	imagen_categoria longblob,								   -- Imagen de la categoria en formato BLOB
    id_administrador_creador INT,                          -- ID USUARIO CREADOR (llave foránea a la tabla "usuarios")
	fecha_creacion_categoria DATETIME,					   -- Fecha de creación de la categoría
    categoria_eliminada BIT DEFAULT 0,		               -- Indica si la categoría está eliminada (0=HABILITADO,1=DESHABILITADO)
    id_administrador_elimina_categoria INT DEFAULT NULL,   -- ID USUARIO ELIMINA CATEGORIA (llave foránea a la tabla "usuarios")
    fecha_eliminacion_categoria DATETIME DEFAULT NULL,     -- Fecha de eliminación de la categoría
    FOREIGN KEY (id_administrador_creador) REFERENCES tabla_usuario(id_usuario),			 -- FK a la tabla "usuarios" (creador)
    FOREIGN KEY (id_administrador_elimina_categoria) REFERENCES tabla_usuario(id_usuario)   -- FK a la tabla "usuarios" (elimina)
);

CREATE TABLE tabla_cursos 
(
    id_curso int NOT NULL AUTO_INCREMENT PRIMARY KEY,                  -- ID CURSO como llave primaria y autoincrementable
    titulo_curso VARCHAR(255) NOT NULL,                      -- Título del curso
    id_categoria_curso INT,                                  -- ID CATEGORIA CURSO (llave foránea a la tabla "categorias")
    niveles_curso INT NOT NULL,                              -- Niveles del curso
    manejo_precio_curso INT NOT NULL,						 -- 0=CURSO COMPLETO GRATIS, 1=PRECIO POR CURSO COMPLETO, 2=PRECIO POR CADA NIVEL
	precio_curso FLOAT DEFAULT NULL,                         -- Precio del curso
    descripcion_curso VARCHAR(255),                          -- Descripción del curso
    porcentaje_resenas_positivas FLOAT DEFAULT 0.0,          -- Porcentaje de reseñas positivas del curso
    imagen_curso longblob,                                      -- Imagen del curso en formato BLOB
    curso_deshabilitado BIT DEFAULT 0,		                 -- Indica si el curso está deshabilitado (FALSE=HABILITADO,TRUE=DESHABILITADO)
    fecha_creacion_curso DATETIME,						     -- Fecha de creación del curso
    id_instructor_creacion_curso INT,                           -- ID USUARIO CREACION CURSO (llave foránea a la tabla "usuarios")
    id_instructor_eliminacion_curso INT DEFAULT NULL,           -- ID USUARIO ELIMINACION CURSO (llave foránea a la tabla "usuarios")
    fecha_eliminacion_curso DATETIME DEFAULT NULL,           -- Fecha de eliminación del curso
    FOREIGN KEY (id_categoria_curso) REFERENCES tabla_categorias(id_categoria),		 -- FK a la tabla "categorias"
    FOREIGN KEY (id_instructor_creacion_curso) REFERENCES tabla_usuario(id_usuario),   -- FK a la tabla "usuarios" (creador)
    FOREIGN KEY (id_instructor_eliminacion_curso) REFERENCES tabla_usuario(id_usuario) -- FK a la tabla "usuarios" (elimina)
);


CREATE TABLE tabla_niveles 
(
    id_nivel int NOT NULL AUTO_INCREMENT PRIMARY KEY,                  -- ID NIVEL como llave primaria y autoincrementable
    id_instructor_nivel INT NOT NULL,                        -- ID USUARIO INSTRUCTOR NIVEL (llave foránea a la tabla "usuarios")
    titulo_nivel VARCHAR(255) NOT NULL,						 -- Titulo del Video
	documento_nivel VARCHAR(255),							 -- Link del drive del documento PDF
	link_video_nivel VARCHAR(255) NOT NULL,                  -- Enlace del video del nivel
    costo_nivel FLOAT DEFAULT 0.0,                           -- Costo del nivel
    id_curso_nivel INT NOT NULL,                             -- ID CURSO NIVEL (llave foránea a la tabla "cursos")
    informacion_nivel VARCHAR(255) NOT NULL,                 -- Información adicional sobre el nivel
    imagen_nivel longblob,                                      -- Imagen del nivel en formato BLOB
    referencias_nivel VARCHAR(255) NOT NULL,                 -- Link a página externa sobre el nivel
    fecha_creacion_nivel DATETIME,							 -- Fecha de creación del nivel
    FOREIGN KEY (id_instructor_nivel) REFERENCES tabla_usuario(id_usuario),		 -- FK a la tabla "usuarios" (instructor)
    FOREIGN KEY (id_curso_nivel) REFERENCES tabla_cursos(id_curso)					 -- FK a la tabla "cursos"
);

CREATE TABLE tabla_inscripciones 
(
    id_inscripcion int NOT NULL AUTO_INCREMENT PRIMARY KEY,             -- ID INSCRIPCION como llave primaria y autoincrementable
    id_estudiante_inscripcion INT NOT NULL,                   -- ID ESTUDIANTE INSCRIPCION (llave foránea a la tabla "usuarios")
    id_curso_inscripcion INT NOT NULL,                        -- ID CURSO INSCRIPCION (llave foránea a la tabla "cursos")
    fecha_inscripcion DATETIME,							      -- Fecha de inscripción
    ultima_fecha_ingreso DATETIME DEFAULT NULL,               -- Última fecha de ingreso al curso
    fecha_terminacion_inscripcion DATETIME DEFAULT NULL,      -- Fecha de terminación de la inscripción
    inscripcion_finalizada BIT DEFAULT 0,		              -- Indica si la inscripción está finalizada ( 0=NO TERMINADO, 1=TERMINADO,)
    metodo_pago_inscripcion INT NOT NULL,                     -- Método de pago de la inscripción ( 0 = TARJETA DEBITO,1 = TARJETA CREDITO, 2 = GRATIS)
    porcentaje_avance_curso FLOAT DEFAULT 0.0,	              -- Porcentaje de avance en el curso
    FOREIGN KEY (id_estudiante_inscripcion) REFERENCES tabla_usuario(id_usuario),  -- FK a la tabla "usuarios" (estudiante)
    FOREIGN KEY (id_curso_inscripcion) REFERENCES tabla_cursos(id_curso)			-- FK a la tabla "cursos"
);

CREATE TABLE tabla_comentarios 
(
    id_comentario int NOT NULL AUTO_INCREMENT PRIMARY KEY,               -- ID COMENTARIO como llave primaria y autoincrementable
    descripcion_comentario VARCHAR(255) NOT NULL,              -- Descripción del comentario
    id_curso_comentario INT NOT NULL,                          -- ID CURSO COMENTARIO (llave foránea a la tabla "cursos")
    id_estudiante_comentario INT NOT NULL,                     -- ID USUARIO COMENTARIO (llave foránea a la tabla "usuarios")
    calificacion_curso INT NOT NULL,                           -- Calificación del curso 1 AL 5 (ESTRELLAS)
    comentario_eliminado BIT DEFAULT 0,                        -- Indica si el comentario está eliminado (0=NO ELIMINADO,1=ELIMINADO)
    fecha_creacion_comentario DATETIME,						   -- Fecha de creación del comentario
    fecha_eliminacion_comentario DATETIME DEFAULT NULL,        -- Fecha de eliminación del comentario
    causa_eliminacion_comentario VARCHAR(255) DEFAULT NULL,    -- Causa de eliminación del comentario
    id_administrador_eliminacion_comentario INT DEFAULT NULL,        -- ID USUARIO ELIMINACION COMENTARIO (llave foránea a la tabla "usuarios")
    FOREIGN KEY (id_curso_comentario) REFERENCES tabla_cursos(id_curso),				-- FK a la tabla "cursos"
    FOREIGN KEY (id_estudiante_comentario) REFERENCES tabla_usuario(id_usuario),			  -- FK a la tabla "usuarios" (autor del comentario)
    FOREIGN KEY (id_administrador_eliminacion_comentario) REFERENCES tabla_usuario(id_usuario) -- FK a la tabla "usuarios" (elimina comentario)
);

CREATE TABLE tabla_diplomas 
(
    id_diploma int NOT NULL AUTO_INCREMENT PRIMARY KEY,                -- ID DIPLOMA como llave primaria y autoincrementable
    fecha_terminacion_diploma DATETIME NOT NULL,             -- Fecha de terminación del diploma
    id_curso_diploma INT NOT NULL,                           -- ID CURSO DIPLOMA (llave foránea a la tabla "cursos")
    id_estudiante_diploma INT NOT NULL,					     -- ID USUARIO ESTUDIANTE DIPLOMA (llave foránea a la tabla "usuarios")
    id_instructor_diploma INT NOT NULL,						 -- ID USUARIO INSTRUCTOR DIPLOMA (llave foránea a la tabla "usuarios")
    imagen_curso_diploma longblob,                              -- Imagen del diploma en formato BLOB
    promedio_diploma FLOAT DEFAULT 0.0,                      -- Promedio obtenido en el curso
    FOREIGN KEY (id_curso_diploma) REFERENCES tabla_cursos(id_curso),					-- FK a la tabla "cursos"
    FOREIGN KEY (id_estudiante_diploma) REFERENCES tabla_usuario(id_usuario),  -- FK a la tabla "usuarios" (estudiante)
    FOREIGN KEY (id_instructor_diploma) REFERENCES tabla_usuario(id_usuario)   -- FK a la tabla "usuarios" (instructor)
);

CREATE TABLE tabla_mensajes 
(
    id_mensaje int NOT NULL AUTO_INCREMENT PRIMARY KEY,                -- ID MENSAJE como llave primaria y autoincrementable
    texto_mensaje VARCHAR(255) NOT NULL,                     -- Texto del mensaje
    id_curso_mensaje INT NOT NULL,                           -- ID CURSO MENSAJE (llave foránea a la tabla "cursos")
    id_estudiante_mensaje INT NOT NULL,                      -- ID ALUMNO MENSAJE (llave foránea a la tabla "usuarios")
    id_instructor_mensaje INT NOT NULL,                      -- ID INSTRUCTOR MENSAJE (llave foránea a la tabla "usuarios")
    fecha_creacion_mensaje DATETIME,					     -- Fecha de creación del mensaje
    FOREIGN KEY (id_curso_mensaje) REFERENCES tabla_cursos(id_curso),			-- FK a la tabla "cursos"
    FOREIGN KEY (id_estudiante_mensaje) REFERENCES tabla_usuario(id_usuario),  -- FK a la tabla "usuarios" (alumno)
    FOREIGN KEY (id_instructor_mensaje) REFERENCES tabla_usuario(id_usuario)	-- FK a la tabla "usuarios" (instructor)
);








