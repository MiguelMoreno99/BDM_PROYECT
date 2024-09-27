go	
create function dbo.FNValidarUsuarioRepedido
(
	@correo_electronico char(30)
)
returns int
as
begin
	declare @cantidad int

	select @cantidad = (select COUNT(genero_id) from Usuarios where correo_electronico = @correo_electronico)

	return @cantidad
end
go

go
create function dbo.FNVerHistorialUsuario
(
	@correo_electronico char(30)
)
returns table
as
return
(
	SELECT ID,HISTORIA,CORREO,TIEMPO,VERSIÓN,TESTAMENTO,LIBRO FROM VW_Historial 
	WHERE CORREO = @correo_electronico
)
go

go
create function dbo.FNLoginUsuario
(
	@correo_electronico char(30),
	@contrasena char(30)
)
returns table
as
return
	select correo_electronico as correo, usuario_inhabilitado as inhabilitado, imagen as imagen from Usuarios
	where correo_electronico = @correo_electronico and primera_contrasena = @contrasena
go

go
create function dbo.FNVerDatosUsuario
(
	@correo_electronico char(30)
)
returns table
as
return
(
	select correo_electronico as correo,primera_contrasena as contrasena,nombre as nombre,apellido_paterno as paterno,apellido_materno as materno,fecha_de_nacimiento as fecha,genero_id as genero from Usuarios
	where correo_electronico = @correo_electronico
)
go

go
create function dbo.FNValidarContraseñaRepedida
(
	@correo_electronico char(30),
	@contraseña char(30)
)
returns int
as
begin
	declare @cantidad int

	select @cantidad = (select COUNT(genero_id) from Usuarios where correo_electronico = @correo_electronico and (primera_contrasena = @contraseña or segunda_contrasena = @contraseña or tercera_contrasena = @contraseña))

	return @cantidad
end
go

go
create function dbo.FNVerFavoritosUsuario
(
	@correo_electronico char(30)
)
returns table
as
return
(
	SELECT ID,TEXTO FROM VW_Favoritos 
	WHERE CORREO = @correo_electronico
)
go

go
create function dbo.FNFiltarBiblia
(
	@Version VARCHAR(30),
	@Libro VARCHAR(20) null,
	@Capitulo INT null,
	@Versiculo INT null
)
returns @Tabla table
(
	ID INT,
	VERSIÓN VARCHAR(30),
	LIBRO VARCHAR(20),
	CAPITULO INT,
	VERSICULO INT,
	TEXTO TEXT
)
as
BEGIN
	IF ((@Libro = '') AND (@Capitulo = -1) AND (@Versiculo = -1))
		BEGIN
			INSERT INTO @Tabla SELECT ID,VERSIÓN,LIBRO,CAPITULO,VERSICULO,TEXTO FROM VW_Consulta WHERE VERSIÓN = @Version
		END
	ELSE IF (@Capitulo = -1 AND @Versiculo = -1)
		BEGIN
			INSERT INTO @Tabla SELECT ID,VERSIÓN,LIBRO,CAPITULO,VERSICULO,TEXTO FROM VW_Consulta WHERE VERSIÓN = @Version AND LIBRO = @Libro
		END
	ELSE IF (@Versiculo = -1)
		BEGIN
			INSERT INTO @Tabla SELECT ID,VERSIÓN,LIBRO,CAPITULO,VERSICULO,TEXTO FROM VW_Consulta WHERE VERSIÓN = @Version AND LIBRO = @Libro AND CAPITULO = @Capitulo 
		END
	ELSE
		BEGIN
			INSERT INTO @Tabla SELECT ID,VERSIÓN,LIBRO,CAPITULO,VERSICULO,TEXTO FROM VW_Consulta WHERE VERSIÓN = @Version AND LIBRO = @Libro AND CAPITULO = @Capitulo AND VERSICULO = @Versiculo 
		END
	return
END
go

go
CREATE function dbo.FNFiltarBibliaBusqueda
(
	@Version VARCHAR(30),
	@Testamento VARCHAR(30) null,
	@Libro VARCHAR(20) null,
	@Texto1 TEXT,
	@Texto2 TEXT,
	@Texto3 TEXT
)
returns @Tabla table
(
	VERSIÓN VARCHAR(30),
	TESTAMENTO VARCHAR(30),
	LIBRO VARCHAR(20),
	CAPITULO INT,
	VERSICULO INT,
	TEXTO TEXT
)
as
BEGIN
	
	IF (@Testamento = '' AND @Libro = '')
		BEGIN
			INSERT INTO @Tabla SELECT VERSIÓN,TESTAMENTO,LIBRO,CAPITULO,VERSICULO,TEXTO FROM VW_Busqueda WHERE VERSIÓN = @Version AND ((TEXTO LIKE @Texto1)AND(TEXTO LIKE @Texto2)AND(TEXTO LIKE @Texto3))
		END
	ELSE IF (@Libro = '')
		BEGIN
			INSERT INTO @Tabla SELECT VERSIÓN,TESTAMENTO,LIBRO,CAPITULO,VERSICULO,TEXTO FROM VW_Busqueda WHERE VERSIÓN = @Version AND TESTAMENTO = @Testamento AND ((TEXTO LIKE @Texto1)AND(TEXTO LIKE @Texto2)AND(TEXTO LIKE @Texto3))
		END
	ELSE
		BEGIN
			INSERT INTO @Tabla SELECT VERSIÓN,TESTAMENTO,LIBRO,CAPITULO,VERSICULO,TEXTO FROM VW_Busqueda WHERE VERSIÓN = @Version AND TESTAMENTO = @Testamento AND LIBRO = @Libro AND ((TEXTO LIKE @Texto1)AND(TEXTO LIKE @Texto2)AND(TEXTO LIKE @Texto3))
		END
	return
END
go

go
create function dbo.FNHistoriaConsulta
(
	@correo_electronico char(30),
	@id_historia int
)
returns table
as
return
	select historia, correo_electronico, id_version,Id_Testamento,Id_Libro from Historial
	where correo_electronico = @correo_electronico and id_historia = @id_historia
go
