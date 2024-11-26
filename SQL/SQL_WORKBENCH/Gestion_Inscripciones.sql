-- Insertar Inscripcion

DELIMITER $$

CREATE PROCEDURE PROCInsertarInscripcion(
    IN p_id_estudiante_inscripcion INT,
    IN p_id_curso_inscripcion INT,
    IN p_metodo_pago_inscripcion INT,
    IN p_precio_pagado FLOAT
)
BEGIN
    INSERT INTO tabla_inscripciones (
        id_estudiante_inscripcion, 
        id_curso_inscripcion,  
        metodo_pago_inscripcion, 
        Precio_pagado
    ) VALUES (
        p_id_estudiante_inscripcion, 
        p_id_curso_inscripcion, 
        p_metodo_pago_inscripcion, 
        p_precio_pagado
    );
END $$

DELIMITER //

-- Insertar niveles de la inscripcion

DELIMITER $$

CREATE PROCEDURE PROCInsertar_nivel_inscripcion 
(
    IN p_id_inscripcion INT,
    IN p_id_nivel INT,
    IN p_titulo_nivel VARCHAR(255)
)
BEGIN
    -- Inserta un registro en la tabla `tabla_niveles_inscripcion`
    INSERT INTO tabla_niveles_inscripcion 
    (
        id_inscripcion,
        id_nivel,
        titulo_nivel
    )
    VALUES 
    (
        p_id_inscripcion,
        p_id_nivel,
        p_titulo_nivel
    );
END$$

DELIMITER ;

-- Trayendo informacion de la inscripcion

DELIMITER $$

CREATE PROCEDURE PROCValidarInscripcion(
IN p_id_estudiante_inscripcion INT,
IN p_id_curso_inscripcion INT
)
BEGIN
    SELECT 
        id_inscripcion,
        id_estudiante_inscripcion,
        id_curso_inscripcion,
        fecha_inscripcion,
        hora_inscripcion,
        ultima_fecha_ingreso,
        ultima_hora_inreso,
        fecha_terminacion_inscripcion,
        hora_terminacion_inscripcion,
        inscripcion_finalizada,
        metodo_pago_inscripcion,
        Precio_pagado,
        porcentaje_avance_curso
    FROM tabla_inscripciones
    WHERE id_estudiante_inscripcion = p_id_estudiante_inscripcion and id_curso_inscripcion = p_id_curso_inscripcion;
END $$

DELIMITER ;

DELIMITER //

CREATE PROCEDURE PROCObtenerInformacionCurso(
    IN idEstudiante INT
)
BEGIN
    SELECT 
        c.imagen_curso,                  -- Foto del curso
        c.titulo_curso,                 -- Nombre del curso
        i.porcentaje_avance_curso       -- Porcentaje de avance del curso
    FROM 
        tabla_inscripciones i
    INNER JOIN 
        tabla_cursos c ON i.id_curso_inscripcion = c.id_curso
    WHERE 
        i.id_estudiante_inscripcion = idEstudiante; -- Filtra por el ID del estudiante
END //

DELIMITER ;