go
create trigger TRBloqueoUsuario
on tabla_usuarios instead of delete
as
begin
	declare @correo_usuario char(50)
	select @correo_usuario = correo_usuario from deleted
	update tabla_usuarios set usuario_bloqueado = 1, equivocaciones_usuario = 0 where correo_usuario = @correo_usuario
end
go

create trigger TRAltaUsuario
on tabla_usuarios after insert
as
begin
	declare @correo_usuario char(50)
	select @correo_usuario = correo_usuario from inserted
	update tabla_usuarios set registro_usuario = GETDATE() where correo_usuario = @correo_usuario
end
go

--create trigger TRAltaHistoria --buscar triggers de mas utilidad
--on Historial after insert
--as
--begin
--	declare @id_historia int

--	select @id_historia = id_historia from inserted

--	update Historial set fecha_hora_de_busqueda = GETDATE() where id_historia = @id_historia
--end
--go