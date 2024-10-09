    --id_usuario INT IDENTITY(1,1) PRIMARY KEY,			-- ID USUARIO como llave primaria y autoincrementable
    --tipo_usuario INT NOT NULL,							-- Tipo de usuario (1=INSTRUCTOR,2=ESTUDIANTE,3=ADMINISTRADOR)
    --imagen_usuario IMAGE,								-- Imagen de usuario en formato BLOB
    --usuario_bloqueado BIT DEFAULT 0,					-- Usuario bloqueado (0=DESBLOQUEADO,1=BLOQUEADO)
    --nombre_usuario VARCHAR(255) NOT NULL,                -- Nombre(s) del usuario
    --apellido_usuario VARCHAR(255) NOT NULL,  			-- Apellido(s) del usuario
    --genero_usuario INT NOT NULL,						-- Género del usuario (0=MASCULINO,1=FEMENINO,2=OTRO)
    --nacimiento_usuario DATETIME NOT NULL,				-- Fecha de nacimiento del usuario
    --correo_usuario VARCHAR(255) NOT NULL,                -- Correo del usuario
    --contraseña_usuario VARCHAR(255) NOT NULL,            -- Contraseña del usuario
    --registro_usuario DATETIME,							-- Fecha de registro del usuario
    --equivocaciones_usuario INT DEFAULT 0				-- Número de equivocaciones del usuario

	--sp_updateextendedproperty 

EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'ID USUARIO como llave primaria y autoincrementable',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_usuarios',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'id_usuario';  -- Nombre de la columna

EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Tipo de usuario (1=INSTRUCTOR,2=ESTUDIANTE,3=ADMINISTRADOR)',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_usuarios',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'tipo_usuario';  -- Nombre de la columna

EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Imagen de usuario en formato BLOB',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_usuarios',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'imagen_usuario';  -- Nombre de la columna

EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Usuario bloqueado (0=DESBLOQUEADO,1=BLOQUEADO)',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_usuarios',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'usuario_bloqueado';  -- Nombre de la columna

EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Nombre(s) del usuario',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_usuarios',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'nombre_usuario';  -- Nombre de la columna

EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Apellido(s) del usuario',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_usuarios',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'apellido_usuario';  -- Nombre de la columna

EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Género del usuario (0=MASCULINO,1=FEMENINO,2=OTRO)',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_usuarios',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'genero_usuario';  -- Nombre de la columna

EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Fecha de nacimiento del usuario',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_usuarios',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'nacimiento_usuario';  -- Nombre de la columna

EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Correo del usuario',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_usuarios',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'correo_usuario';  -- Nombre de la columna

EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Contraseña del usuario',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_usuarios',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'contraseña_usuario';  -- Nombre de la columna

EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Fecha de registro del usuario',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_usuarios',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'registro_usuario';  -- Nombre de la columna

EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Número de equivocaciones del usuario (MAXIMO 3)',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_usuarios',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'equivocaciones_usuario';  -- Nombre de la columna

	--id_categoria INT IDENTITY(1,1) PRIMARY KEY,            -- ID CATEGORIA como llave primaria y autoincrementable
 --   descripcion_categoria VARCHAR(255) NOT NULL,		   -- Descripción de la categoría
	--imagen_categoria IMAGE,								   -- Imagen de la categoria en formato BLOB
 --   id_administrador_creador INT,                          -- ID USUARIO CREADOR (llave foránea a la tabla "usuarios")
	--fecha_creacion_categoria DATETIME,					   -- Fecha de creación de la categoría
 --   categoria_eliminada BIT DEFAULT 0,		               -- Indica si la categoría está eliminada (0=HABILITADO,1=DESHABILITADO)
 --   id_administrador_elimina_categoria INT DEFAULT NULL,   -- ID USUARIO ELIMINA CATEGORIA (llave foránea a la tabla "usuarios")
 --   fecha_eliminacion_categoria DATETIME DEFAULT NULL,     -- Fecha de eliminación de la categoría
 
EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'ID CATEGORIA como llave primaria y autoincrementable',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_categorias',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'id_categoria';  -- Nombre de la columna

EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Descripción de la categoría',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_categorias',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'descripcion_categoria';  -- Nombre de la columna

EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Imagen de la categoria en formato BLOB',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_categorias',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'imagen_categoria';  -- Nombre de la columna

EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'ID USUARIO CREADOR (llave foránea a la tabla "usuarios")',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_categorias',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'id_administrador_creador';  -- Nombre de la columna

EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Fecha de creación de la categoría',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_categorias',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'fecha_creacion_categoria';  -- Nombre de la columna

EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Indica si la categoría está eliminada (0=HABILITADO,1=DESHABILITADO)',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_categorias',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'categoria_eliminada';  -- Nombre de la columna

EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'ID USUARIO ELIMINA CATEGORIA (llave foránea a la tabla "usuarios")',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_categorias',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'id_administrador_elimina_categoria';  -- Nombre de la columna
	   	  
EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Fecha de eliminación de la categoría',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_categorias',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'fecha_eliminacion_categoria';  -- Nombre de la columna

	--id_curso INT IDENTITY(1,1) PRIMARY KEY,                  -- ID CURSO como llave primaria y autoincrementable
 --   titulo_curso VARCHAR(255) NOT NULL,                      -- Título del curso
 --   id_categoria_curso INT,                                  -- ID CATEGORIA CURSO (llave foránea a la tabla "categorias")
 --   niveles_curso INT NOT NULL,                              -- Niveles del curso
 --   manejo_precio_curso INT NOT NULL,						 -- 0=CURSO COMPLETO GRATIS, 1=PRECIO POR CURSO COMPLETO, 2=PRECIO POR CADA NIVEL
	--precio_curso FLOAT DEFAULT NULL,                         -- Precio del curso
 --   descripcion_curso VARCHAR(MAX),                          -- Descripción del curso
 --   porcentaje_resenas_positivas FLOAT DEFAULT 0.0,          -- Porcentaje de reseñas positivas del curso
 --   imagen_curso IMAGE,                                      -- Imagen del curso en formato BLOB
 --   curso_deshabilitado BIT DEFAULT 0,		                 -- Indica si el curso está deshabilitado (0=HABILITADO,1=DESHABILITADO)
 --   fecha_creacion_curso DATETIME,						     -- Fecha de creación del curso
 --   id_instructor_creacion_curso INT,                           -- ID USUARIO CREACION CURSO (llave foránea a la tabla "usuarios")
 --   id_instructor_eliminacion_curso INT DEFAULT NULL,           -- ID USUARIO ELIMINACION CURSO (llave foránea a la tabla "usuarios")
 --   fecha_eliminacion_curso DATETIME DEFAULT NULL,           -- Fecha de eliminación del curso

EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'ID CURSO como llave primaria y autoincrementable',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_cursos',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'id_curso';  -- Nombre de la columna

EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Título del curso',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_cursos',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'titulo_curso';  -- Nombre de la columna

EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'ID CATEGORIA CURSO (llave foránea a la tabla "categorias")',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_cursos',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'id_categoria_curso';  -- Nombre de la columna

EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Niveles del curso',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_cursos',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'niveles_curso';  -- Nombre de la columna

EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Id para saber como se va a manejar el costo 0=CURSO COMPLETO GRATIS, 1=PRECIO POR CURSO COMPLETO, 2=PRECIO POR CADA NIVEL',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_cursos',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'manejo_precio_curso';  -- Nombre de la columna

EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Precio del curso',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_cursos',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'precio_curso';  -- Nombre de la columna

EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Descripción del curso',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_cursos',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'descripcion_curso';  -- Nombre de la columna

EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Porcentaje de reseñas positivas del curso',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_cursos',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'porcentaje_resenas_positivas';  -- Nombre de la columna

EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Imagen del curso en formato BLOB',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_cursos',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'imagen_curso';  -- Nombre de la columna

EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Indica si el curso está deshabilitado (0=HABILITADO,1=DESHABILITADO)',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_cursos',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'curso_deshabilitado';  -- Nombre de la columna

EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Fecha de creación del curso',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_cursos',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'fecha_creacion_curso';  -- Nombre de la columna

EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'ID USUARIO CREACION CURSO (llave foránea a la tabla "usuarios")',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_cursos',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'id_instructor_creacion_curso';  -- Nombre de la columna

EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'ID USUARIO ELIMINACION CURSO (llave foránea a la tabla "usuarios")',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_cursos',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'id_instructor_eliminacion_curso';  -- Nombre de la columna

EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Fecha de eliminación del curso',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_cursos',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'fecha_eliminacion_curso';  -- Nombre de la columna

	--id_nivel INT IDENTITY(1,1) PRIMARY KEY,                  -- ID NIVEL como llave primaria y autoincrementable
 --   id_instructor_nivel INT NOT NULL,                        -- ID USUARIO INSTRUCTOR NIVEL (llave foránea a la tabla "usuarios")
 --   titulo_nivel VARCHAR(255) NOT NULL,						 -- Titulo del Video
	--documento_nivel VARCHAR(MAX),							 -- Link del drive del documento PDF
	--link_video_nivel VARCHAR(MAX) NOT NULL,                  -- Enlace del video del nivel
 --   costo_nivel FLOAT DEFAULT 0.0,                           -- Costo del nivel
 --   id_curso_nivel INT NOT NULL,                             -- ID CURSO NIVEL (llave foránea a la tabla "cursos")
 --   informacion_nivel VARCHAR(255) NOT NULL,                 -- Información adicional sobre el nivel
 --   imagen_nivel IMAGE,                                      -- Imagen del nivel en formato BLOB
 --   referencias_nivel VARCHAR(MAX) NOT NULL,                 -- Link a página externa sobre el nivel
 --   fecha_creacion_nivel DATETIME,							 -- Fecha de creación del nivel

 EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'ID NIVEL como llave primaria y autoincrementable',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_niveles',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'id_nivel';  -- Nombre de la columna

 EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'ID USUARIO INSTRUCTOR NIVEL (llave foránea a la tabla "usuarios")',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_niveles',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'id_instructor_nivel';  -- Nombre de la columna

 EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Titulo del Video',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_niveles',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'titulo_nivel';  -- Nombre de la columna

 EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Link del drive del documento PDF',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_niveles',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'documento_nivel';  -- Nombre de la columna

 EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Enlace del video del nivel',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_niveles',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'link_video_nivel';  -- Nombre de la columna

 EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Costo del nivel',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_niveles',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'costo_nivel';  -- Nombre de la columna

 EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'ID CURSO NIVEL (llave foránea a la tabla "cursos")',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_niveles',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'id_curso_nivel';  -- Nombre de la columna

 EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Información adicional sobre el nivel',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_niveles',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'informacion_nivel';  -- Nombre de la columna

 EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Imagen del nivel en formato BLOB',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_niveles',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'imagen_nivel';  -- Nombre de la columna

 EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Link a página externa sobre el nivel',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_niveles',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'referencias_nivel';  -- Nombre de la columna

 EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Fecha de creación del nivel',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_niveles',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'fecha_creacion_nivel';  -- Nombre de la columna

	--id_inscripcion INT IDENTITY(1,1) PRIMARY KEY,             -- ID INSCRIPCION como llave primaria y autoincrementable
 --   id_estudiante_inscripcion INT NOT NULL,                   -- ID ESTUDIANTE INSCRIPCION (llave foránea a la tabla "usuarios")
 --   id_curso_inscripcion INT NOT NULL,                        -- ID CURSO INSCRIPCION (llave foránea a la tabla "cursos")
 --   fecha_inscripcion DATETIME,							      -- Fecha de inscripción
 --   ultima_fecha_ingreso DATETIME DEFAULT NULL,               -- Última fecha de ingreso al curso
 --   fecha_terminacion_inscripcion DATETIME DEFAULT NULL,      -- Fecha de terminación de la inscripción
 --   inscripcion_finalizada BIT DEFAULT 0,		              -- Indica si la inscripción está finalizada ( 0=NO TERMINADO, 1=TERMINADO)
 --   metodo_pago_inscripcion INT NOT NULL,                     -- Método de pago de la inscripción ( 0 = TARJETA DEBITO,1 = TARJETA CREDITO, 2 = GRATIS)
 --   porcentaje_avance_curso FLOAT DEFAULT 0.0,	              -- Porcentaje de avance en el curso

  EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'ID INSCRIPCION como llave primaria y autoincrementable',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_inscripciones',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'id_inscripcion';  -- Nombre de la columna

  EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'ID ESTUDIANTE INSCRIPCION (llave foránea a la tabla "usuarios")',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_inscripciones',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'id_estudiante_inscripcion';  -- Nombre de la columna

  EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'ID CURSO INSCRIPCION (llave foránea a la tabla "cursos")',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_inscripciones',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'id_curso_inscripcion';  -- Nombre de la columna

  EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Fecha de inscripción',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_inscripciones',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'fecha_inscripcion';  -- Nombre de la columna

  EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Última fecha de ingreso al curso',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_inscripciones',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'ultima_fecha_ingreso';  -- Nombre de la columna

  EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Indica si la inscripción está finalizada ( 0=NO TERMINADO, 1=TERMINADO)',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_inscripciones',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'inscripcion_finalizada';  -- Nombre de la columna

  EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Método de pago de la inscripción ( 0 = TARJETA DEBITO,1 = TARJETA CREDITO, 2 = GRATIS)',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_inscripciones',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'metodo_pago_inscripcion';  -- Nombre de la columna

  EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Porcentaje de avance en el curso',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_inscripciones',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'porcentaje_avance_curso';  -- Nombre de la columna

  EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Fecha de terminación de la inscripción',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_inscripciones',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'fecha_terminacion_inscripcion';  -- Nombre de la columna

    --id_comentario INT IDENTITY(1,1) PRIMARY KEY,               -- ID COMENTARIO como llave primaria y autoincrementable
    --descripcion_comentario VARCHAR(255) NOT NULL,              -- Descripción del comentario
    --id_curso_comentario INT NOT NULL,                          -- ID CURSO COMENTARIO (llave foránea a la tabla "cursos")
    --id_estudiante_comentario INT NOT NULL,                     -- ID USUARIO COMENTARIO (llave foránea a la tabla "usuarios")
    --calificacion_curso INT NOT NULL,                           -- Calificación del curso 1 AL 5 (ESTRELLAS)
    --comentario_eliminado BIT DEFAULT 0,                        -- Indica si el comentario está eliminado (0=NO ELIMINADO,1=ELIMINADO)
    --fecha_creacion_comentario DATETIME,						   -- Fecha de creación del comentario
    --fecha_eliminacion_comentario DATETIME DEFAULT NULL,        -- Fecha de eliminación del comentario
    --causa_eliminacion_comentario VARCHAR(255) DEFAULT NULL,    -- Causa de eliminación del comentario
    --id_administrador_eliminacion_comentario INT DEFAULT NULL,        -- ID USUARIO ELIMINACION COMENTARIO (llave foránea a la tabla "usuarios")

  EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'ID COMENTARIO como llave primaria y autoincrementable',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_comentarios',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'id_comentario';  -- Nombre de la columna

  EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Descripción del comentario',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_comentarios',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'descripcion_comentario';  -- Nombre de la columna

  EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'ID CURSO COMENTARIO (llave foránea a la tabla "cursos")',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_comentarios',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'id_curso_comentario';  -- Nombre de la columna

  EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'ID USUARIO COMENTARIO (llave foránea a la tabla "usuarios")',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_comentarios',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'id_estudiante_comentario';  -- Nombre de la columna

  EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Calificación del curso 1 AL 5 (ESTRELLAS)',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_comentarios',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'calificacion_curso';  -- Nombre de la columna

  EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Indica si el comentario está eliminado (0=NO ELIMINADO,1=ELIMINADO)',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_comentarios',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'comentario_eliminado';  -- Nombre de la columna

  EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Fecha de creación del comentario',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_comentarios',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'fecha_creacion_comentario';  -- Nombre de la columna

  EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Fecha de eliminación del comentario',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_comentarios',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'fecha_eliminacion_comentario';  -- Nombre de la columna

  EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Causa de eliminación del comentario',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_comentarios',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'causa_eliminacion_comentario';  -- Nombre de la columna

  EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'ID USUARIO ELIMINACION COMENTARIO (llave foránea a la tabla "usuarios")',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_comentarios',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'id_administrador_eliminacion_comentario';  -- Nombre de la columna

    --id_diploma INT IDENTITY(1,1) PRIMARY KEY,                -- ID DIPLOMA como llave primaria y autoincrementable
    --fecha_terminacion_diploma DATETIME NOT NULL,             -- Fecha de terminación del diploma
    --id_curso_diploma INT NOT NULL,                           -- ID CURSO DIPLOMA (llave foránea a la tabla "cursos")
    --id_estudiante_diploma INT NOT NULL,					     -- ID USUARIO ESTUDIANTE DIPLOMA (llave foránea a la tabla "usuarios")
    --id_instructor_diploma INT NOT NULL,						 -- ID USUARIO INSTRUCTOR DIPLOMA (llave foránea a la tabla "usuarios")
    --imagen_curso_diploma IMAGE,                              -- Imagen del diploma en formato BLOB
    --promedio_diploma FLOAT DEFAULT 0.0,                      -- Promedio obtenido en el curso

  EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'ID DIPLOMA como llave primaria y autoincrementable',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_diplomas',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'id_diploma';  -- Nombre de la columna

  EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Fecha de terminación del diploma',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_diplomas',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'fecha_terminacion_diploma';  -- Nombre de la columna

  EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'ID CURSO DIPLOMA (llave foránea a la tabla "cursos")',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_diplomas',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'id_curso_diploma';  -- Nombre de la columna

  EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'ID USUARIO ESTUDIANTE DIPLOMA (llave foránea a la tabla "usuarios")',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_diplomas',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'id_estudiante_diploma';  -- Nombre de la columna

  EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'ID USUARIO INSTRUCTOR DIPLOMA (llave foránea a la tabla "usuarios")',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_diplomas',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'id_instructor_diploma';  -- Nombre de la columna

  EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Imagen del diploma en formato BLOB',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_diplomas',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'imagen_curso_diploma';  -- Nombre de la columna

  EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Promedio obtenido en el curso',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_diplomas',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'promedio_diploma';  -- Nombre de la columna

    --id_mensaje INT IDENTITY(1,1) PRIMARY KEY,                -- ID MENSAJE como llave primaria y autoincrementable
    --texto_mensaje VARCHAR(255) NOT NULL,                     -- Texto del mensaje
    --id_curso_mensaje INT NOT NULL,                           -- ID CURSO MENSAJE (llave foránea a la tabla "cursos")
    --id_estudiante_mensaje INT NOT NULL,                      -- ID ALUMNO MENSAJE (llave foránea a la tabla "usuarios")
    --id_instructor_mensaje INT NOT NULL,                      -- ID INSTRUCTOR MENSAJE (llave foránea a la tabla "usuarios")
    --fecha_creacion_mensaje DATETIME,					     -- Fecha de creación del mensaje

  EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'ID MENSAJE como llave primaria y autoincrementable',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_mensajes',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'id_mensaje';  -- Nombre de la columna

  EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Texto del mensaje',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_mensajes',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'texto_mensaje';  -- Nombre de la columna

  EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'ID CURSO MENSAJE (llave foránea a la tabla "cursos")',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_mensajes',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'id_curso_mensaje';  -- Nombre de la columna

  EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'ID ALUMNO MENSAJE (llave foránea a la tabla "usuarios")',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_mensajes',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'id_estudiante_mensaje';  -- Nombre de la columna

  EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'ID INSTRUCTOR MENSAJE (llave foránea a la tabla "usuarios")',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_mensajes',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'id_instructor_mensaje';  -- Nombre de la columna

  EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Fecha de creación del mensaje',  -- Descripción de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_mensajes',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'fecha_creacion_mensaje';  -- Nombre de la columna