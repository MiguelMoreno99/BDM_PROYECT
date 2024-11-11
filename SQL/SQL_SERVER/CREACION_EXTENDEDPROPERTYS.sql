    --id_usuario INT IDENTITY(1,1) PRIMARY KEY,			-- ID USUARIO como llave primaria y autoincrementable
    --tipo_usuario INT NOT NULL,							-- Tipo de usuario (1=INSTRUCTOR,2=ESTUDIANTE,3=ADMINISTRADOR)
    --imagen_usuario IMAGE,								-- Imagen de usuario en formato BLOB
    --usuario_bloqueado BIT DEFAULT 0,					-- Usuario bloqueado (0=DESBLOQUEADO,1=BLOQUEADO)
    --nombre_usuario VARCHAR(255) NOT NULL,                -- Nombre(s) del usuario
    --apellido_usuario VARCHAR(255) NOT NULL,  			-- Apellido(s) del usuario
    --genero_usuario INT NOT NULL,						-- G�nero del usuario (0=MASCULINO,1=FEMENINO,2=OTRO)
    --nacimiento_usuario DATETIME NOT NULL,				-- Fecha de nacimiento del usuario
    --correo_usuario VARCHAR(255) NOT NULL,                -- Correo del usuario
    --contrase�a_usuario VARCHAR(255) NOT NULL,            -- Contrase�a del usuario
    --registro_usuario DATETIME,							-- Fecha de registro del usuario
    --equivocaciones_usuario INT DEFAULT 0				-- N�mero de equivocaciones del usuario

	--sp_updateextendedproperty 

EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'ID USUARIO como llave primaria y autoincrementable',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_usuarios',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'id_usuario';  -- Nombre de la columna

EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Tipo de usuario (1=INSTRUCTOR,2=ESTUDIANTE,3=ADMINISTRADOR)',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_usuarios',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'tipo_usuario';  -- Nombre de la columna

EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Imagen de usuario en formato BLOB',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_usuarios',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'imagen_usuario';  -- Nombre de la columna

EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Usuario bloqueado (0=DESBLOQUEADO,1=BLOQUEADO)',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_usuarios',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'usuario_bloqueado';  -- Nombre de la columna

EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Nombre(s) del usuario',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_usuarios',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'nombre_usuario';  -- Nombre de la columna

EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Apellido(s) del usuario',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_usuarios',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'apellido_usuario';  -- Nombre de la columna

EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'G�nero del usuario (0=MASCULINO,1=FEMENINO,2=OTRO)',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_usuarios',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'genero_usuario';  -- Nombre de la columna

EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Fecha de nacimiento del usuario',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_usuarios',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'nacimiento_usuario';  -- Nombre de la columna

EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Correo del usuario',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_usuarios',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'correo_usuario';  -- Nombre de la columna

EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Contrase�a del usuario',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_usuarios',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'contrase�a_usuario';  -- Nombre de la columna

EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Fecha de registro del usuario',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_usuarios',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'registro_usuario';  -- Nombre de la columna

EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'N�mero de equivocaciones del usuario (MAXIMO 3)',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_usuarios',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'equivocaciones_usuario';  -- Nombre de la columna

	--id_categoria INT IDENTITY(1,1) PRIMARY KEY,            -- ID CATEGORIA como llave primaria y autoincrementable
 --   descripcion_categoria VARCHAR(255) NOT NULL,		   -- Descripci�n de la categor�a
	--imagen_categoria IMAGE,								   -- Imagen de la categoria en formato BLOB
 --   id_administrador_creador INT,                          -- ID USUARIO CREADOR (llave for�nea a la tabla "usuarios")
	--fecha_creacion_categoria DATETIME,					   -- Fecha de creaci�n de la categor�a
 --   categoria_eliminada BIT DEFAULT 0,		               -- Indica si la categor�a est� eliminada (0=HABILITADO,1=DESHABILITADO)
 --   id_administrador_elimina_categoria INT DEFAULT NULL,   -- ID USUARIO ELIMINA CATEGORIA (llave for�nea a la tabla "usuarios")
 --   fecha_eliminacion_categoria DATETIME DEFAULT NULL,     -- Fecha de eliminaci�n de la categor�a
 
EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'ID CATEGORIA como llave primaria y autoincrementable',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_categorias',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'id_categoria';  -- Nombre de la columna

EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Descripci�n de la categor�a',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_categorias',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'descripcion_categoria';  -- Nombre de la columna

EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Imagen de la categoria en formato BLOB',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_categorias',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'imagen_categoria';  -- Nombre de la columna

EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'ID USUARIO CREADOR (llave for�nea a la tabla "usuarios")',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_categorias',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'id_administrador_creador';  -- Nombre de la columna

EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Fecha de creaci�n de la categor�a',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_categorias',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'fecha_creacion_categoria';  -- Nombre de la columna

EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Indica si la categor�a est� eliminada (0=HABILITADO,1=DESHABILITADO)',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_categorias',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'categoria_eliminada';  -- Nombre de la columna

EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'ID USUARIO ELIMINA CATEGORIA (llave for�nea a la tabla "usuarios")',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_categorias',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'id_administrador_elimina_categoria';  -- Nombre de la columna
	   	  
EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Fecha de eliminaci�n de la categor�a',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_categorias',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'fecha_eliminacion_categoria';  -- Nombre de la columna

	--id_curso INT IDENTITY(1,1) PRIMARY KEY,                  -- ID CURSO como llave primaria y autoincrementable
 --   titulo_curso VARCHAR(255) NOT NULL,                      -- T�tulo del curso
 --   id_categoria_curso INT,                                  -- ID CATEGORIA CURSO (llave for�nea a la tabla "categorias")
 --   niveles_curso INT NOT NULL,                              -- Niveles del curso
 --   manejo_precio_curso INT NOT NULL,						 -- 0=CURSO COMPLETO GRATIS, 1=PRECIO POR CURSO COMPLETO, 2=PRECIO POR CADA NIVEL
	--precio_curso FLOAT DEFAULT NULL,                         -- Precio del curso
 --   descripcion_curso VARCHAR(MAX),                          -- Descripci�n del curso
 --   porcentaje_resenas_positivas FLOAT DEFAULT 0.0,          -- Porcentaje de rese�as positivas del curso
 --   imagen_curso IMAGE,                                      -- Imagen del curso en formato BLOB
 --   curso_deshabilitado BIT DEFAULT 0,		                 -- Indica si el curso est� deshabilitado (0=HABILITADO,1=DESHABILITADO)
 --   fecha_creacion_curso DATETIME,						     -- Fecha de creaci�n del curso
 --   id_instructor_creacion_curso INT,                           -- ID USUARIO CREACION CURSO (llave for�nea a la tabla "usuarios")
 --   id_instructor_eliminacion_curso INT DEFAULT NULL,           -- ID USUARIO ELIMINACION CURSO (llave for�nea a la tabla "usuarios")
 --   fecha_eliminacion_curso DATETIME DEFAULT NULL,           -- Fecha de eliminaci�n del curso

EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'ID CURSO como llave primaria y autoincrementable',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_cursos',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'id_curso';  -- Nombre de la columna

EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'T�tulo del curso',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_cursos',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'titulo_curso';  -- Nombre de la columna

EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'ID CATEGORIA CURSO (llave for�nea a la tabla "categorias")',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_cursos',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'id_categoria_curso';  -- Nombre de la columna

EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Niveles del curso',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_cursos',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'niveles_curso';  -- Nombre de la columna

EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Id para saber como se va a manejar el costo 0=CURSO COMPLETO GRATIS, 1=PRECIO POR CURSO COMPLETO, 2=PRECIO POR CADA NIVEL',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_cursos',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'manejo_precio_curso';  -- Nombre de la columna

EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Precio del curso',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_cursos',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'precio_curso';  -- Nombre de la columna

EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Descripci�n del curso',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_cursos',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'descripcion_curso';  -- Nombre de la columna

EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Porcentaje de rese�as positivas del curso',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_cursos',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'porcentaje_resenas_positivas';  -- Nombre de la columna

EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Imagen del curso en formato BLOB',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_cursos',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'imagen_curso';  -- Nombre de la columna

EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Indica si el curso est� deshabilitado (0=HABILITADO,1=DESHABILITADO)',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_cursos',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'curso_deshabilitado';  -- Nombre de la columna

EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Fecha de creaci�n del curso',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_cursos',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'fecha_creacion_curso';  -- Nombre de la columna

EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'ID USUARIO CREACION CURSO (llave for�nea a la tabla "usuarios")',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_cursos',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'id_instructor_creacion_curso';  -- Nombre de la columna

EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'ID USUARIO ELIMINACION CURSO (llave for�nea a la tabla "usuarios")',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_cursos',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'id_instructor_eliminacion_curso';  -- Nombre de la columna

EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Fecha de eliminaci�n del curso',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_cursos',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'fecha_eliminacion_curso';  -- Nombre de la columna

	--id_nivel INT IDENTITY(1,1) PRIMARY KEY,                  -- ID NIVEL como llave primaria y autoincrementable
 --   id_instructor_nivel INT NOT NULL,                        -- ID USUARIO INSTRUCTOR NIVEL (llave for�nea a la tabla "usuarios")
 --   titulo_nivel VARCHAR(255) NOT NULL,						 -- Titulo del Video
	--documento_nivel VARCHAR(MAX),							 -- Link del drive del documento PDF
	--link_video_nivel VARCHAR(MAX) NOT NULL,                  -- Enlace del video del nivel
 --   costo_nivel FLOAT DEFAULT 0.0,                           -- Costo del nivel
 --   id_curso_nivel INT NOT NULL,                             -- ID CURSO NIVEL (llave for�nea a la tabla "cursos")
 --   informacion_nivel VARCHAR(255) NOT NULL,                 -- Informaci�n adicional sobre el nivel
 --   imagen_nivel IMAGE,                                      -- Imagen del nivel en formato BLOB
 --   referencias_nivel VARCHAR(MAX) NOT NULL,                 -- Link a p�gina externa sobre el nivel
 --   fecha_creacion_nivel DATETIME,							 -- Fecha de creaci�n del nivel

 EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'ID NIVEL como llave primaria y autoincrementable',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_niveles',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'id_nivel';  -- Nombre de la columna

 EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'ID USUARIO INSTRUCTOR NIVEL (llave for�nea a la tabla "usuarios")',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_niveles',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'id_instructor_nivel';  -- Nombre de la columna

 EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Titulo del Video',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_niveles',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'titulo_nivel';  -- Nombre de la columna

 EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Link del drive del documento PDF',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_niveles',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'documento_nivel';  -- Nombre de la columna

 EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Enlace del video del nivel',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_niveles',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'link_video_nivel';  -- Nombre de la columna

 EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Costo del nivel',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_niveles',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'costo_nivel';  -- Nombre de la columna

 EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'ID CURSO NIVEL (llave for�nea a la tabla "cursos")',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_niveles',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'id_curso_nivel';  -- Nombre de la columna

 EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Informaci�n adicional sobre el nivel',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_niveles',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'informacion_nivel';  -- Nombre de la columna

 EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Imagen del nivel en formato BLOB',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_niveles',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'imagen_nivel';  -- Nombre de la columna

 EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Link a p�gina externa sobre el nivel',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_niveles',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'referencias_nivel';  -- Nombre de la columna

 EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Fecha de creaci�n del nivel',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_niveles',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'fecha_creacion_nivel';  -- Nombre de la columna

	--id_inscripcion INT IDENTITY(1,1) PRIMARY KEY,             -- ID INSCRIPCION como llave primaria y autoincrementable
 --   id_estudiante_inscripcion INT NOT NULL,                   -- ID ESTUDIANTE INSCRIPCION (llave for�nea a la tabla "usuarios")
 --   id_curso_inscripcion INT NOT NULL,                        -- ID CURSO INSCRIPCION (llave for�nea a la tabla "cursos")
 --   fecha_inscripcion DATETIME,							      -- Fecha de inscripci�n
 --   ultima_fecha_ingreso DATETIME DEFAULT NULL,               -- �ltima fecha de ingreso al curso
 --   fecha_terminacion_inscripcion DATETIME DEFAULT NULL,      -- Fecha de terminaci�n de la inscripci�n
 --   inscripcion_finalizada BIT DEFAULT 0,		              -- Indica si la inscripci�n est� finalizada ( 0=NO TERMINADO, 1=TERMINADO)
 --   metodo_pago_inscripcion INT NOT NULL,                     -- M�todo de pago de la inscripci�n ( 0 = TARJETA DEBITO,1 = TARJETA CREDITO, 2 = GRATIS)
 --   porcentaje_avance_curso FLOAT DEFAULT 0.0,	              -- Porcentaje de avance en el curso

  EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'ID INSCRIPCION como llave primaria y autoincrementable',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_inscripciones',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'id_inscripcion';  -- Nombre de la columna

  EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'ID ESTUDIANTE INSCRIPCION (llave for�nea a la tabla "usuarios")',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_inscripciones',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'id_estudiante_inscripcion';  -- Nombre de la columna

  EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'ID CURSO INSCRIPCION (llave for�nea a la tabla "cursos")',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_inscripciones',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'id_curso_inscripcion';  -- Nombre de la columna

  EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Fecha de inscripci�n',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_inscripciones',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'fecha_inscripcion';  -- Nombre de la columna

  EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'�ltima fecha de ingreso al curso',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_inscripciones',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'ultima_fecha_ingreso';  -- Nombre de la columna

  EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Indica si la inscripci�n est� finalizada ( 0=NO TERMINADO, 1=TERMINADO)',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_inscripciones',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'inscripcion_finalizada';  -- Nombre de la columna

  EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'M�todo de pago de la inscripci�n ( 0 = TARJETA DEBITO,1 = TARJETA CREDITO, 2 = GRATIS)',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_inscripciones',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'metodo_pago_inscripcion';  -- Nombre de la columna

  EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Porcentaje de avance en el curso',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_inscripciones',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'porcentaje_avance_curso';  -- Nombre de la columna

  EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Fecha de terminaci�n de la inscripci�n',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_inscripciones',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'fecha_terminacion_inscripcion';  -- Nombre de la columna

    --id_comentario INT IDENTITY(1,1) PRIMARY KEY,               -- ID COMENTARIO como llave primaria y autoincrementable
    --descripcion_comentario VARCHAR(255) NOT NULL,              -- Descripci�n del comentario
    --id_curso_comentario INT NOT NULL,                          -- ID CURSO COMENTARIO (llave for�nea a la tabla "cursos")
    --id_estudiante_comentario INT NOT NULL,                     -- ID USUARIO COMENTARIO (llave for�nea a la tabla "usuarios")
    --calificacion_curso INT NOT NULL,                           -- Calificaci�n del curso 1 AL 5 (ESTRELLAS)
    --comentario_eliminado BIT DEFAULT 0,                        -- Indica si el comentario est� eliminado (0=NO ELIMINADO,1=ELIMINADO)
    --fecha_creacion_comentario DATETIME,						   -- Fecha de creaci�n del comentario
    --fecha_eliminacion_comentario DATETIME DEFAULT NULL,        -- Fecha de eliminaci�n del comentario
    --causa_eliminacion_comentario VARCHAR(255) DEFAULT NULL,    -- Causa de eliminaci�n del comentario
    --id_administrador_eliminacion_comentario INT DEFAULT NULL,        -- ID USUARIO ELIMINACION COMENTARIO (llave for�nea a la tabla "usuarios")

  EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'ID COMENTARIO como llave primaria y autoincrementable',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_comentarios',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'id_comentario';  -- Nombre de la columna

  EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Descripci�n del comentario',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_comentarios',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'descripcion_comentario';  -- Nombre de la columna

  EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'ID CURSO COMENTARIO (llave for�nea a la tabla "cursos")',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_comentarios',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'id_curso_comentario';  -- Nombre de la columna

  EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'ID USUARIO COMENTARIO (llave for�nea a la tabla "usuarios")',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_comentarios',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'id_estudiante_comentario';  -- Nombre de la columna

  EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Calificaci�n del curso 1 AL 5 (ESTRELLAS)',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_comentarios',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'calificacion_curso';  -- Nombre de la columna

  EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Indica si el comentario est� eliminado (0=NO ELIMINADO,1=ELIMINADO)',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_comentarios',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'comentario_eliminado';  -- Nombre de la columna

  EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Fecha de creaci�n del comentario',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_comentarios',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'fecha_creacion_comentario';  -- Nombre de la columna

  EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Fecha de eliminaci�n del comentario',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_comentarios',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'fecha_eliminacion_comentario';  -- Nombre de la columna

  EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Causa de eliminaci�n del comentario',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_comentarios',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'causa_eliminacion_comentario';  -- Nombre de la columna

  EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'ID USUARIO ELIMINACION COMENTARIO (llave for�nea a la tabla "usuarios")',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_comentarios',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'id_administrador_eliminacion_comentario';  -- Nombre de la columna

    --id_diploma INT IDENTITY(1,1) PRIMARY KEY,                -- ID DIPLOMA como llave primaria y autoincrementable
    --fecha_terminacion_diploma DATETIME NOT NULL,             -- Fecha de terminaci�n del diploma
    --id_curso_diploma INT NOT NULL,                           -- ID CURSO DIPLOMA (llave for�nea a la tabla "cursos")
    --id_estudiante_diploma INT NOT NULL,					     -- ID USUARIO ESTUDIANTE DIPLOMA (llave for�nea a la tabla "usuarios")
    --id_instructor_diploma INT NOT NULL,						 -- ID USUARIO INSTRUCTOR DIPLOMA (llave for�nea a la tabla "usuarios")
    --imagen_curso_diploma IMAGE,                              -- Imagen del diploma en formato BLOB
    --promedio_diploma FLOAT DEFAULT 0.0,                      -- Promedio obtenido en el curso

  EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'ID DIPLOMA como llave primaria y autoincrementable',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_diplomas',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'id_diploma';  -- Nombre de la columna

  EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Fecha de terminaci�n del diploma',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_diplomas',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'fecha_terminacion_diploma';  -- Nombre de la columna

  EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'ID CURSO DIPLOMA (llave for�nea a la tabla "cursos")',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_diplomas',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'id_curso_diploma';  -- Nombre de la columna

  EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'ID USUARIO ESTUDIANTE DIPLOMA (llave for�nea a la tabla "usuarios")',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_diplomas',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'id_estudiante_diploma';  -- Nombre de la columna

  EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'ID USUARIO INSTRUCTOR DIPLOMA (llave for�nea a la tabla "usuarios")',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_diplomas',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'id_instructor_diploma';  -- Nombre de la columna

  EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Imagen del diploma en formato BLOB',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_diplomas',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'imagen_curso_diploma';  -- Nombre de la columna

  EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Promedio obtenido en el curso',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_diplomas',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'promedio_diploma';  -- Nombre de la columna

    --id_mensaje INT IDENTITY(1,1) PRIMARY KEY,                -- ID MENSAJE como llave primaria y autoincrementable
    --texto_mensaje VARCHAR(255) NOT NULL,                     -- Texto del mensaje
    --id_curso_mensaje INT NOT NULL,                           -- ID CURSO MENSAJE (llave for�nea a la tabla "cursos")
    --id_estudiante_mensaje INT NOT NULL,                      -- ID ALUMNO MENSAJE (llave for�nea a la tabla "usuarios")
    --id_instructor_mensaje INT NOT NULL,                      -- ID INSTRUCTOR MENSAJE (llave for�nea a la tabla "usuarios")
    --fecha_creacion_mensaje DATETIME,					     -- Fecha de creaci�n del mensaje

  EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'ID MENSAJE como llave primaria y autoincrementable',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_mensajes',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'id_mensaje';  -- Nombre de la columna

  EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Texto del mensaje',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_mensajes',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'texto_mensaje';  -- Nombre de la columna

  EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'ID CURSO MENSAJE (llave for�nea a la tabla "cursos")',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_mensajes',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'id_curso_mensaje';  -- Nombre de la columna

  EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'ID ALUMNO MENSAJE (llave for�nea a la tabla "usuarios")',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_mensajes',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'id_estudiante_mensaje';  -- Nombre de la columna

  EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'ID INSTRUCTOR MENSAJE (llave for�nea a la tabla "usuarios")',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_mensajes',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'id_instructor_mensaje';  -- Nombre de la columna

  EXEC sp_addextendedproperty 
    @name = N'ep', 
    @value = N'Fecha de creaci�n del mensaje',  -- Descripci�n de la columna
    @level0type = N'SCHEMA', @level0name = N'dbo',  -- Esquema de la tabla
    @level1type = N'TABLE',  @level1name = N'tabla_mensajes',  -- Nombre de la tabla
    @level2type = N'COLUMN', @level2name = N'fecha_creacion_mensaje';  -- Nombre de la columna