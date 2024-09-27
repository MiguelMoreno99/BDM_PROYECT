go
create trigger TRBajaUsuario
on Usuarios instead of delete
as
begin

	declare @correo_electronico char(30)
	declare @contrasena1 char(30)
	declare @contrasena2 char(30)
	declare @contrasena3 char(30)

	select @correo_electronico = correo_electronico from deleted
	select @contrasena1 = primera_contrasena from deleted
	select @contrasena2 = segunda_contrasena from deleted
	select @contrasena3 = tercera_contrasena from deleted

	UPDATE Usuarios SET tercera_contrasena = @contrasena2	WHERE correo_electronico = @correo_electronico
	UPDATE Usuarios SET segunda_contrasena = @contrasena1	WHERE correo_electronico = @correo_electronico
	UPDATE Usuarios SET primera_contrasena = @correo_electronico	WHERE correo_electronico = @correo_electronico
	update Usuarios set usuario_inhabilitado = 1, fecha_hora_de_baja = GETDATE() where correo_electronico = @correo_electronico
end
go

create trigger TRAltaUsuario
on Usuarios after insert
as
begin

	declare @correo_electronico char(30)
	select @correo_electronico = correo_electronico from inserted

	update Usuarios set usuario_inhabilitado = 0, fecha_hora_de_registro = GETDATE() where correo_electronico = @correo_electronico
end
go

create trigger TRAltaHistoria --buscar triggers de mas utilidad
on Historial after insert
as
begin
	declare @id_historia int

	select @id_historia = id_historia from inserted

	update Historial set fecha_hora_de_busqueda = GETDATE() where id_historia = @id_historia
end
go