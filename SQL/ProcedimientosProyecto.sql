go
create procedure dbo.PROCAltaUsuario
(
@correo_electronico char(30),
@contrasena char(30),
@nombre char(50),
@apellido_paterno char(50),
@apellido_materno char(50),
@fecha_nacimiento date,
@genero int,
@imagen image
)
AS
BEGIN
	if @correo_electronico = '' 
		BEGIN
			;THROW 99001, 'ERROR, NO INGRESO NINGUN CORREO ELECTRONICO!', 1;
		END
	declare @i int
	select @i = (select dbo.FNValidarUsuarioRepedido(@correo_electronico))
	if @i > 0
		BEGIN
			;THROW 99001, 'ERROR, YA HAY UN USUARIO CON ESE CORREO ELECTRONICO!', 1;
		END
	if @contrasena = '' 
		BEGIN
			;THROW 99001, 'ERROR, INGRESE UNA CONTRASEÑA!', 1;
		END
	if @nombre = '' 
		BEGIN
			;THROW 99001, 'ERROR, INGRESE SU NOMBRE!', 1;
		END
	if @apellido_paterno = '' 
		BEGIN
			;THROW 99001, 'ERROR, INGRESE SU APELLIDO PATERNO!', 1;
		END
	if @apellido_materno = '' 
		BEGIN
			;THROW 99001, 'ERROR, INGRESE SU APELLIDO MATERNO!', 1;
		END
	if @imagen is null 
		BEGIN
			;THROW 99001, 'ERROR, INGRESE UNA IMAGEN!', 1;
		END
	ELSE
	insert into Usuarios(correo_electronico,primera_contrasena,nombre,apellido_paterno,apellido_materno,fecha_de_nacimiento,genero_id,imagen)
		values (@correo_electronico,@contrasena,@nombre,@apellido_paterno,@apellido_materno,@fecha_nacimiento,@genero,@imagen)
END
go

go
create procedure dbo.PROCBorrarUsuario
(
	@correo_electronico char(30)
)
as
begin
	delete from Usuarios where correo_electronico=@correo_electronico
end
go

go
create procedure dbo.PROCEditarUsuario
(
@correo_electronico char(30),
@contrasena char(30),
@nombre char(50),
@apellido_paterno char(50),
@apellido_materno char(50),
@fecha_nacimiento date,
@genero int,
@modificar_contraseña int
)
AS
BEGIN
	if @modificar_contraseña = 1
	BEGIN
		declare @i int
		select @i = (select dbo.FNValidarContraseñaRepedida(@correo_electronico,@contrasena))
		if @i > 0
			BEGIN
				;THROW 99001, 'ERROR, LA NUEVA CONTRASEÑA NO PUEDE SER IGUAL A LAS ULTIMAS REGISTRADAS!', 1;
			END
		if @contrasena = '' 
			BEGIN
				;THROW 99001, 'ERROR, INGRESE UNA CONTRASEÑA!', 1;
			END
		declare @contrasena1 char(30)
		declare @contrasena2 char(30)
		declare @contrasena3 char(30)
		select @contrasena1 = (select primera_contrasena from Usuarios where correo_electronico = @correo_electronico)
		select @contrasena2 = (select segunda_contrasena from Usuarios where correo_electronico = @correo_electronico)
		select @contrasena3 = (select tercera_contrasena from Usuarios where correo_electronico = @correo_electronico)
		UPDATE Usuarios SET tercera_contrasena = @contrasena2	WHERE correo_electronico = @correo_electronico
		UPDATE Usuarios SET segunda_contrasena = @contrasena1	WHERE correo_electronico = @correo_electronico
		UPDATE Usuarios SET primera_contrasena = @contrasena	WHERE correo_electronico = @correo_electronico
	END
	if @nombre = '' 
		BEGIN
			;THROW 99001, 'ERROR, INGRESE SU NOMBRE!', 1;
		END
	if @apellido_paterno = '' 
		BEGIN
			;THROW 99001, 'ERROR, INGRESE SU APELLIDO PATERNO!', 1;
		END
	if @apellido_materno = '' 
		BEGIN
			;THROW 99001, 'ERROR, INGRESE SU APELLIDO MATERNO!', 1;
		END
	ELSE
	UPDATE Usuarios SET nombre = @nombre, apellido_paterno = @apellido_paterno, apellido_materno = @apellido_materno, fecha_de_nacimiento = @fecha_nacimiento, genero_id = @genero
	WHERE correo_electronico = @correo_electronico
END
go

go
create procedure dbo.PROCHablitarUsuario
(
	@correo_electronico char(30),
	@contrasena char(30)
)
as
begin
	declare @i int
	select @i = (select dbo.FNValidarContraseñaRepedida(@correo_electronico,@contrasena))
	if @i > 0
		BEGIN
			;THROW 99001, 'ERROR, LA NUEVA CONTRASEÑA NO PUEDE SER IGUAL A LAS ULTIMAS REGISTRADAS!', 1;
		END
	if @contrasena = '' 
		BEGIN
			;THROW 99001, 'ERROR, INGRESE UNA CONTRASEÑA!', 1;
		END
	UPDATE Usuarios SET primera_contrasena = @contrasena	WHERE correo_electronico = @correo_electronico
	update Usuarios set usuario_inhabilitado = 0, fecha_hora_de_baja = null where correo_electronico = @correo_electronico
end
go

go
create procedure dbo.PROCBorrarHistorialUsuario
(
	@correo_electronico char(30)
)
as
begin
	declare @cantidad int
	select @cantidad = (select COUNT(id_historia) from Historial where correo_electronico = @correo_electronico)
	if @cantidad = 0
		BEGIN
			;THROW 99001, 'ERROR, NO HAY NADA QUE BORRAR!', 1;
		END
	DELETE FROM Historial
	WHERE correo_electronico = @correo_electronico
end
go

go
create procedure dbo.PROCBorrarHistoriaUsuario
(
	@correo_electronico char(30),
	@id_historia int
)
as
begin
	declare @cantidad int
	select @cantidad = (select COUNT(id_historia) from Historial where correo_electronico = @correo_electronico and id_historia = @id_historia)
	if @cantidad = 0
		BEGIN
			;THROW 99001, 'ERROR, INGRESE UN ID VALIDO!', 1;
		END
	DELETE FROM Historial
	WHERE correo_electronico = @correo_electronico and id_historia = @id_historia
end
go

go
create procedure dbo.PROCBorrarFavoritoUsuario
(
	@correo_electronico char(30),
	@id_favorito int
)
as
begin
	declare @cantidad int
	select @cantidad = (select COUNT(id_favorito) from Favoritos where correo_electronico = @correo_electronico and id_favorito = @id_favorito)
	if @cantidad = 0
		BEGIN
			;THROW 99001, 'ERROR, INGRESE UN ID VALIDO!', 1;
		END
	DELETE FROM Favoritos
	WHERE correo_electronico = @correo_electronico and id_favorito = @id_favorito
end
go

go
create procedure dbo.PROCAgregarFavoritoUsuario
(
	@correo_electronico char(30),
	@Id_Vers int
)
as
begin
	declare @cantidad int
	select @cantidad = (select COUNT(id_Vers) from Versiculos where Id_Vers = @Id_Vers)
	if @cantidad = 0
		BEGIN
			;THROW 99001, 'ERROR, INGRESE UN ID VALIDO!', 1;
		END
	declare @version int
	declare @libro int
	declare @cap int
	declare @vers int
	select @version = (select Id_Version from Versiculos where Id_Vers = @Id_Vers)
	select @libro = (select Id_Libro from Versiculos where Id_Vers = @Id_Vers)
	select @cap = (select NumeroCap from Versiculos where Id_Vers = @Id_Vers)
	select @vers = (select NumeroVers from Versiculos where Id_Vers = @Id_Vers)
	select @cantidad = 0
	select @cantidad = (select COUNT(id_favorito) from Favoritos where (Id_Version = @version and Id_Libro = @libro and NumeroCap = @cap and NumeroVers = @vers and correo_electronico = @correo_electronico))
	if @cantidad > 0
		BEGIN
			;THROW 99001, 'ERROR, ESTE VERSICULO YA ESTÁ EN FAVORITOS!', 1;
		END
	INSERT INTO Favoritos(correo_electronico,Id_Version,Id_Libro,NumeroCap,NumeroVers) 
	VALUES (@correo_electronico,@version,@libro,@cap,@vers)
end
go

go
create procedure dbo.PROCAgregarHistoriaUsuario
(
	@historia char(40),
	@correo_electronico char(30),
	@id_Version int,
	@id_Testamento int NULL,
	@id_Libro int NULL
)
as
begin
	IF @id_Testamento=-1 AND @id_Libro=-1
		BEGIN
				INSERT INTO Historial(historia,correo_electronico,Id_Version) 
				VALUES (@historia,@correo_electronico,@id_Version)
		END
	ELSE IF @id_Testamento > 0 AND @id_Libro=-1
		BEGIN
				INSERT INTO Historial(historia,correo_electronico,Id_Version,Id_Testamento) 
				VALUES (@historia,@correo_electronico,@id_Version,@id_Testamento)
		END
	ELSE
		BEGIN
				INSERT INTO Historial(historia,correo_electronico,Id_Version,Id_Testamento,Id_Libro) 
				VALUES (@historia,@correo_electronico,@id_Version,@id_Testamento,@id_Libro)
		END

end
go