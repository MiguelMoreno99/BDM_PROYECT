go
create procedure dbo.PROCAltaUsuario
(
@tipo_usuario int,
@correo_usuario char(50),
@contraseña_usuario char(50),
@nombre_usuario char(50),
@apellido_usuario char(50),
@nacimiento_usuario date,
@genero_usuario int,
@imagen_usuario image
)
AS
BEGIN
	declare @i int
	select @i = (select dbo.FNValidarUsuarioRepedido(@correo_usuario))
	if @i > 0
		BEGIN
			;THROW 99001, 'ERROR, YA HAY UN USUARIO CON ESE CORREO ELECTRONICO!', 1;
		END
	insert into tabla_usuarios(tipo_usuario,correo_usuario,contraseña_usuario,nombre_usuario,apellido_usuario,nacimiento_usuario,genero_usuario,imagen_usuario)
		values (@tipo_usuario,@correo_usuario,@contraseña_usuario,@nombre_usuario,@apellido_usuario,@nacimiento_usuario,@genero_usuario,@imagen_usuario)
END
go
--exec dbo.PROCAltaUsuario 1,'ejemplsso2@outlook.com','contraseña12221!','Pera Alex','Perez Moreno','1994-01-13',0,null

go
create procedure dbo.PROCBloquearUsuario
(
	@correo_usuario char(50)
)
as
begin
	declare @i int
	select @i = (select dbo.FNValidarUsuarioBloqueado(@correo_usuario))
	if @i > 0
		BEGIN
			;THROW 99001, 'ERROR, ESTE USUARIO YA ESTÁ BLOQUEADO!', 1;
		END
	delete from tabla_usuarios where correo_usuario = @correo_usuario
end
go
--exec dbo.PROCBloquearUsuario 'ejemplsso2@outlook.com'

go
create procedure dbo.PROCHablitarUsuario --Se restablece su contraseña que sería el mismo correo electrónico
(
	@correo_usuario char(50)
)
as
begin
	declare @i int
	select @i = (select dbo.FNValidarUsuarioBloqueado(@correo_usuario))
	if @i != 1
		BEGIN
			;THROW 99001, 'ERROR, ESTE USUARIO NO ESTÁ BLOQUEADO!', 1;
		END
	UPDATE tabla_usuarios SET contraseña_usuario = correo_usuario WHERE correo_usuario = @correo_usuario
	update tabla_usuarios set usuario_bloqueado = 0, equivocaciones_usuario = 0 where correo_usuario = @correo_usuario
end
go
--exec dbo.PROCHablitarUsuario 'mr.-@hotmail.com'

go
create procedure dbo.PROCEditarUsuario
(
@correo_usuario char(50),
@contraseña_usuario char(50),
@nombre_usuario char(50),
@apellido_usuario char(50),
@nacimiento_usuario date,
@genero_usuario int,
@modificar_contraseña int --1 = El usuario quiere modificar la contraseña, 0 = El usuario no quiere modificar la contraseña
)
AS
BEGIN
	if @modificar_contraseña = 1
	BEGIN
		declare @i int
		select @i = (select dbo.FNValidarContraseñaRepedida(@correo_usuario,@contraseña_usuario))
		if @i > 0
			BEGIN
				;THROW 99001, 'ERROR, LA NUEVA CONTRASEÑA NO PUEDE SER IGUAL A LA ANTERIOR!', 1;
			END
		UPDATE tabla_usuarios SET contraseña_usuario = @contraseña_usuario	WHERE correo_usuario = @correo_usuario
	END
	UPDATE tabla_usuarios SET nombre_usuario = @nombre_usuario, apellido_usuario = @apellido_usuario, nacimiento_usuario = @nacimiento_usuario, genero_usuario = @genero_usuario
	WHERE correo_usuario = @correo_usuario
END
go
--exec dbo.PROCEditarUsuario 'mr.-@hotmail.com','adioss123456433!','Hugo','Sanchez','2001-01-11',0,1

go
create procedure dbo.PROCIniciarSesion
(
@correo_usuario char(50),
@contraseña_usuario char(50)
)
AS
BEGIN
	declare @i int
	select @i = (select dbo.FNValidarUsuarioContrasena(@correo_usuario,@contraseña_usuario))
	if @i > 0
		BEGIN
			declare @h int
			select @h = (select dbo.FNValidarUsuarioBloqueado(@correo_usuario))
			if @h > 0
				BEGIN
					;THROW 99001, 'ERROR, ESTE USUARIO ESTÁ BLOQUEADO!', 1;
				END
			else
				select tipo,correo,nombre,apellido,imagen,genero,nacimiento,registro from dbo.FNDevolverDatosSesion(@correo_usuario,@contraseña_usuario)
		END
	else
		declare @f int
		select @f = (select dbo.FNValidarUsuarioRepedido(@correo_usuario))
		if @f > 0
			BEGIN
				declare @j int
				select @j = (select dbo.FNValidarUsuarioBloqueado(@correo_usuario))
				if @j > 0
					BEGIN
						;THROW 99001, 'ERROR, ESTE USUARIO ESTÁ BLOQUEADO!', 1;
					END
					else
						declare @g int
						select @g = (select dbo.FNValidarIntentosUsuario(@correo_usuario))
						if @g >= 2
						BEGIN
							exec dbo.PROCBloquearUsuario @correo_usuario
						END
						else
							UPDATE tabla_usuarios SET equivocaciones_usuario = (equivocaciones_usuario + 1) WHERE correo_usuario = @correo_usuario
			END
		else
			THROW 99001, 'ERROR, NO HAY NINGUN USUARIO CON ESE CORREO ELECTRONICO!', 1;
END
go
--exec dbo.PROCIniciarSesion 'mr.-@hotmail.com','mr.-@hotmail.com'

--go
--create procedure dbo.PROCBorrarHistorialUsuario
--(
--	@correo_electronico char(30)
--)
--as
--begin
--	declare @cantidad int
--	select @cantidad = (select COUNT(id_historia) from Historial where correo_electronico = @correo_electronico)
--	if @cantidad = 0
--		BEGIN
--			;THROW 99001, 'ERROR, NO HAY NADA QUE BORRAR!', 1;
--		END
--	DELETE FROM Historial
--	WHERE correo_electronico = @correo_electronico
--end
--go

--go
--create procedure dbo.PROCBorrarHistoriaUsuario
--(
--	@correo_electronico char(30),
--	@id_historia int
--)
--as
--begin
--	declare @cantidad int
--	select @cantidad = (select COUNT(id_historia) from Historial where correo_electronico = @correo_electronico and id_historia = @id_historia)
--	if @cantidad = 0
--		BEGIN
--			;THROW 99001, 'ERROR, INGRESE UN ID VALIDO!', 1;
--		END
--	DELETE FROM Historial
--	WHERE correo_electronico = @correo_electronico and id_historia = @id_historia
--end
--go

--go
--create procedure dbo.PROCBorrarFavoritoUsuario
--(
--	@correo_electronico char(30),
--	@id_favorito int
--)
--as
--begin
--	declare @cantidad int
--	select @cantidad = (select COUNT(id_favorito) from Favoritos where correo_electronico = @correo_electronico and id_favorito = @id_favorito)
--	if @cantidad = 0
--		BEGIN
--			;THROW 99001, 'ERROR, INGRESE UN ID VALIDO!', 1;
--		END
--	DELETE FROM Favoritos
--	WHERE correo_electronico = @correo_electronico and id_favorito = @id_favorito
--end
--go

--go
--create procedure dbo.PROCAgregarFavoritoUsuario
--(
--	@correo_electronico char(30),
--	@Id_Vers int
--)
--as
--begin
--	declare @cantidad int
--	select @cantidad = (select COUNT(id_Vers) from Versiculos where Id_Vers = @Id_Vers)
--	if @cantidad = 0
--		BEGIN
--			;THROW 99001, 'ERROR, INGRESE UN ID VALIDO!', 1;
--		END
--	declare @version int
--	declare @libro int
--	declare @cap int
--	declare @vers int
--	select @version = (select Id_Version from Versiculos where Id_Vers = @Id_Vers)
--	select @libro = (select Id_Libro from Versiculos where Id_Vers = @Id_Vers)
--	select @cap = (select NumeroCap from Versiculos where Id_Vers = @Id_Vers)
--	select @vers = (select NumeroVers from Versiculos where Id_Vers = @Id_Vers)
--	select @cantidad = 0
--	select @cantidad = (select COUNT(id_favorito) from Favoritos where (Id_Version = @version and Id_Libro = @libro and NumeroCap = @cap and NumeroVers = @vers and correo_electronico = @correo_electronico))
--	if @cantidad > 0
--		BEGIN
--			;THROW 99001, 'ERROR, ESTE VERSICULO YA ESTÁ EN FAVORITOS!', 1;
--		END
--	INSERT INTO Favoritos(correo_electronico,Id_Version,Id_Libro,NumeroCap,NumeroVers) 
--	VALUES (@correo_electronico,@version,@libro,@cap,@vers)
--end
--go

--go
--create procedure dbo.PROCAgregarHistoriaUsuario
--(
--	@historia char(40),
--	@correo_electronico char(30),
--	@id_Version int,
--	@id_Testamento int NULL,
--	@id_Libro int NULL
--)
--as
--begin
--	IF @id_Testamento=-1 AND @id_Libro=-1
--		BEGIN
--				INSERT INTO Historial(historia,correo_electronico,Id_Version) 
--				VALUES (@historia,@correo_electronico,@id_Version)
--		END
--	ELSE IF @id_Testamento > 0 AND @id_Libro=-1
--		BEGIN
--				INSERT INTO Historial(historia,correo_electronico,Id_Version,Id_Testamento) 
--				VALUES (@historia,@correo_electronico,@id_Version,@id_Testamento)
--		END
--	ELSE
--		BEGIN
--				INSERT INTO Historial(historia,correo_electronico,Id_Version,Id_Testamento,Id_Libro) 
--				VALUES (@historia,@correo_electronico,@id_Version,@id_Testamento,@id_Libro)
--		END

--end
--go