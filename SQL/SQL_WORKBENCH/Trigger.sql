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

DELIMITER //

CREATE TRIGGER TRAltainscripcion
BEFORE INSERT ON tabla_inscripciones
FOR EACH ROW
BEGIN
  SET NEW.fecha_inscripcion = NOW(); 
  SET NEW.hora_inscripcion = NOW();  
END;
//

DELIMITER ;

-- select * from tabla_usuario;
-- DELETE FROM tabla_usuario WHERE id_usuario='10';