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

DELIMITER //

CREATE TRIGGER TRAltacomentario
BEFORE INSERT ON tabla_comentarios
FOR EACH ROW
BEGIN
  SET NEW.fecha_creacion_comentario = NOW(); 
END;
//

DELIMITER ;

DELIMITER $$

CREATE TRIGGER TRActualizarProgresoCurso
AFTER UPDATE ON tabla_niveles_inscripcion
FOR EACH ROW
BEGIN
    DECLARE totalNiveles INT;
    DECLARE nivelesTerminados INT;
    DECLARE porcentajeAvance FLOAT;

    -- Obtener el total de niveles para la inscripción
    SELECT COUNT(*)
    INTO totalNiveles
    FROM tabla_niveles_inscripcion
    WHERE id_inscripcion = NEW.id_inscripcion;

    -- Obtener el número de niveles terminados para la inscripción
    SELECT COUNT(*)
    INTO nivelesTerminados
    FROM tabla_niveles_inscripcion
    WHERE id_inscripcion = NEW.id_inscripcion
    AND Nivel_terminado = 1;

    -- Calcular el porcentaje de avance
    SET porcentajeAvance = (nivelesTerminados / totalNiveles) * 100;

    -- Actualizar el porcentaje de avance del curso en la tabla de inscripciones
    UPDATE tabla_inscripciones
    SET porcentaje_avance_curso = porcentajeAvance
    WHERE id_inscripcion = NEW.id_inscripcion;

    -- Marcar la inscripción como finalizada e insertar la fecha y hora de terminación si el porcentaje es 100%
    IF porcentajeAvance = 100 THEN
        UPDATE tabla_inscripciones
        SET inscripcion_finalizada = 1,
            fecha_terminacion_inscripcion = CURRENT_DATE,
            hora_terminacion_inscripcion = CURRENT_TIME
        WHERE id_inscripcion = NEW.id_inscripcion;
    END IF;
END$$

DELIMITER ;