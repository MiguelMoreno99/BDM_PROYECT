DELIMITER //

CREATE TRIGGER TRAltaUsuario
BEFORE INSERT ON tabla_usuario
FOR EACH ROW
BEGIN
  SET NEW.usuario_bloqueado = 0;
  SET NEW.registro_usuario = NOW();
  SET NEW.Hora_usuario = NOW();
END;

//

DELIMITER ;
