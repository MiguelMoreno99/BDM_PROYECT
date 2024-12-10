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

-- CALL PROCInsertarInscripcion(
--    11,   -- p_id_estudiante_inscripcion (reemplaza con el ID real del estudiante)
--    4,   -- p_id_curso_inscripcion (reemplaza con el ID real del curso)
--    1,     -- p_metodo_pago_inscripcion (reemplaza con el valor adecuado del método de pago, por ejemplo 1)
--    199.99 -- p_precio_pagado (reemplaza con el precio pagado real)
-- );

-- Insertar niveles de la inscripcion

DELIMITER //

CREATE PROCEDURE PROCInsertarNivelInscripcion(
    IN p_id_inscripcion INT,
    IN p_id_nivel INT,
    IN p_titulo_nivel VARCHAR(255)
)
BEGIN
    -- Insertar un nuevo registro en la tabla `tabla_niveles_inscripcion`
    INSERT INTO tabla_niveles_inscripcion (
        id_inscripcion,
        id_nivel,
        titulo_nivel
    )
    VALUES (
        p_id_inscripcion,
        p_id_nivel,
        p_titulo_nivel
    );
END;
//

DELIMITER ;

-- CALL PROCInsertar_nivel_inscripcion(1, 6, 'Primer paso');

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

-- CREATE PROCEDURE PROCObtenerInformacionCurso(
--     IN idEstudiante INT
-- )
-- BEGIN
--     SELECT 
--         c.imagen_curso,                  -- Foto del curso
--         c.titulo_curso,                 -- Nombre del curso
--         i.porcentaje_avance_curso       -- Porcentaje de avance del curso
--     FROM 
--         tabla_inscripciones i
--     INNER JOIN 
--         tabla_cursos c ON i.id_curso_inscripcion = c.id_curso
--     WHERE 
--         i.id_estudiante_inscripcion = idEstudiante; -- Filtra por el ID del estudiante
-- END //

DELIMITER ;

DELIMITER $$

-- CREATE PROCEDURE GetCursoInfo(
--     IN start_date DATETIME,         -- Fecha inicial del rango
--     IN end_date DATETIME,           -- Fecha final del rango
--     IN category_name VARCHAR(255),  -- Nombre de la categoría (puede ser NULL para no filtrar)
--     IN curso_deshabilitado INT,     -- Filtro de cursos deshabilitados (puede ser NULL para no filtrar)
--     IN user_id INT                  -- ID del usuario (puede ser NULL para no filtrar)
-- )
-- BEGIN
--     SELECT 
--        c.nombre_categoria AS Categoria,
--         cr.id_curso AS IdCurso,                              -- ID del curso
--         cr.titulo_curso AS Curso,
--         cr.curso_deshabilitado AS CursoDeshabilitado,
--         cr.fecha_creacion_curso AS FechaCreacion,
--         COUNT(i.id_inscripcion) AS TotalAlumnos,             -- Total de alumnos inscritos
--         COALESCE(AVG(i.porcentaje_avance_curso), 0) AS PromedioAvance, -- Promedio de avance
--         COALESCE(SUM(CASE WHEN i.metodo_pago_inscripcion = 1 THEN i.Precio_pagado ELSE 0 END), 0) AS TotalTarjetaCredito, -- Total pago con tarjeta de crédito
--         COALESCE(SUM(CASE WHEN i.metodo_pago_inscripcion = 0 THEN i.Precio_pagado ELSE 0 END), 0) AS TotalTarjetaDebito,  -- Total pago con tarjeta de débito
--         COALESCE(SUM(CASE WHEN i.metodo_pago_inscripcion = 2 THEN i.Precio_pagado ELSE 0 END), 0) AS TotalPayPal,         -- Total pago con PayPal
--         COALESCE(SUM(i.Precio_pagado), 0) AS TotalIngresos   -- Total ingresos generados
--     FROM 
--         tabla_categorias c
--     INNER JOIN 
--         tabla_cursos cr ON c.id_categoria = cr.id_categoria_curso
--     LEFT JOIN 
--         tabla_inscripciones i ON cr.id_curso = i.id_curso_inscripcion
--     WHERE 
--        (start_date IS NULL OR cr.fecha_creacion_curso >= start_date) AND
--         (end_date IS NULL OR cr.fecha_creacion_curso <= end_date) AND
--         (category_name IS NULL OR c.nombre_categoria = category_name) AND
--         (curso_deshabilitado IS NULL OR cr.curso_deshabilitado = curso_deshabilitado) AND
--         (user_id IS NULL OR cr.id_instructor_creacion_curso = user_id) -- Validación por instructor
--     GROUP BY 
--         c.nombre_categoria, 
--         cr.id_curso,                  -- Incluido en el GROUP BY
--         cr.titulo_curso, 
--         cr.curso_deshabilitado, 
--         cr.fecha_creacion_curso
--     ORDER BY 
--         cr.fecha_creacion_curso DESC;
-- END$$

DELIMITER ;

-- CALL GetCursoInfo(NULL, NULL, 'Programación', 0, 13);

DELIMITER $$

CREATE PROCEDURE ObtenerDatosInscripcionPorCurso(IN id_curso INT)
BEGIN
    SELECT 
        u.nombre_usuario,
        u.apellido_paterno,
        i.fecha_inscripcion,
        i.porcentaje_avance_curso,
        i.Precio_pagado,
        i.metodo_pago_inscripcion
    FROM 
        tabla_inscripciones i
    JOIN 
        tabla_usuario u ON i.id_estudiante_inscripcion = u.id_usuario
    WHERE 
        i.id_curso_inscripcion = id_curso;
END $$

DELIMITER ;

-- CALL ObtenerDatosInscripcionPorCurso(4);

DELIMITER $$

CREATE PROCEDURE GetDetallesCursoPorEstudianteConFechas(
    IN p_id_estudiante INT,
    IN p_fecha_inscripcion DATE,
    IN p_ultima_fecha_ingreso DATE,
    IN p_nombre_categoria VARCHAR(255),
    IN p_inscripcion_finalizada INT,
    IN p_curso_deshabilitado INT
)
BEGIN
    SELECT
        cat.nombre_categoria,
        cur.titulo_curso,
        ins.fecha_inscripcion,
        ins.ultima_fecha_ingreso,
        ins.fecha_terminacion_inscripcion,
        ins.porcentaje_avance_curso,
        ins.inscripcion_finalizada
    FROM
        tabla_inscripciones ins
    JOIN
        tabla_cursos cur ON ins.id_curso_inscripcion = cur.id_curso
    JOIN
        tabla_categorias cat ON cur.id_categoria_curso = cat.id_categoria
    WHERE
        (ins.id_estudiante_inscripcion = p_id_estudiante OR p_id_estudiante IS NULL)
        AND (p_fecha_inscripcion IS NULL OR DATE(ins.fecha_inscripcion) = p_fecha_inscripcion)
        AND (p_ultima_fecha_ingreso IS NULL OR DATE(ins.ultima_fecha_ingreso) = p_ultima_fecha_ingreso)
        AND (cat.nombre_categoria = p_nombre_categoria OR p_nombre_categoria IS NULL)
        AND (ins.inscripcion_finalizada = p_inscripcion_finalizada OR p_inscripcion_finalizada IS NULL)
        AND (cur.curso_deshabilitado = p_curso_deshabilitado OR p_curso_deshabilitado IS NULL);
END $$

DELIMITER ;


-- CALL GetDetallesCursoPorEstudianteConFechas(11, '2024-11-25', NULL, 'programacion', NULL, NULL);