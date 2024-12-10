use db_leveluplearning;

DELIMITER //
CREATE PROCEDURE PROCAltaCurso
(
	IN p_titulo_curso  VARCHAR(255),
    IN p_id_categoria_curso INT,
    IN p_niveles_curso INT,
    IN p_manejo_precio_curso INT,
    IN p_precio_curso FLOAT,
    IN p_descripcion_curso VARCHAR(100),
	IN p_imagen_curso longblob,
    IN p_id_instructor_creacion_curso INT
)
BEGIN
    INSERT INTO tabla_cursos(titulo_curso, id_categoria_curso, niveles_curso, manejo_precio_curso, precio_curso,descripcion_curso,imagen_curso,fecha_creacion_curso,id_instructor_creacion_curso)
    VALUES (p_titulo_curso, p_id_categoria_curso, p_niveles_curso, p_manejo_precio_curso,p_precio_curso,p_descripcion_curso,p_imagen_curso, now(),p_id_instructor_creacion_curso);
END //
DELIMITER ;

-- CALL PROCAltaCurso("Programacion Web JavaScript",23,1,0,0,"Esta es una descripcion del curso de programacion web javascript",null,3);

DELIMITER //
CREATE PROCEDURE PROCAltaNivel
(
	IN p_id_instructor_nivel  INT,
    IN p_titulo_nivel varchar(255),
    IN p_documento_nivel varchar(255),
    IN p_link_video_nivel varchar(255),
    IN p_costo_nivel FLOAT,
    IN p_id_curso_nivel INT,
	IN p_informacion_nivel varchar(255),
    IN p_imagen_nivel longblob,
    IN p_referencias_nivel varchar(255)
)
BEGIN
    INSERT INTO tabla_niveles(id_instructor_nivel, titulo_nivel, documento_nivel, link_video_nivel, costo_nivel,id_curso_nivel, informacion_nivel,imagen_nivel,referencias_nivel,fecha_creacion_nivel)
    VALUES (p_id_instructor_nivel, p_titulo_nivel, p_documento_nivel, p_link_video_nivel,p_costo_nivel,p_id_curso_nivel,p_informacion_nivel,p_imagen_nivel,p_referencias_nivel, now());
END //
DELIMITER ;

-- CALL PROCAltaNivel(1,"Introduccion a la Programacion Web JavaScript","linkdocumento","linkvideo",0,1,"Esta es la informacion del nivel 1 de programacion web javascript",null,"link referencias nivel");

DELIMITER //
CREATE PROCEDURE PROCValidarCurso
(   
    IN p_titulo_curso VARCHAR(255)   
)
BEGIN
    SELECT
    id_curso,
	titulo_curso,
    id_categoria_curso,
    niveles_curso,
    manejo_precio_curso,
    precio_curso,
    descripcion_curso,
	imagen_curso,
    id_instructor_creacion_curso
    FROM 
        tabla_cursos
    WHERE 
        titulo_curso = p_titulo_curso AND curso_deshabilitado != 1;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE PROCValidarCurso2
(   
    IN p_titulo_curso VARCHAR(255)   
)
BEGIN
    SELECT
    id_curso,
	titulo_curso,
    id_categoria_curso,
    niveles_curso,
    manejo_precio_curso,
    precio_curso,
    descripcion_curso,
	imagen_curso,
    id_instructor_creacion_curso
    FROM 
        tabla_cursos
    WHERE 
        titulo_curso = p_titulo_curso AND curso_deshabilitado != 1 AND
        curso_deshabilitado = 0;
END //
DELIMITER ;

-- CALL PROCValidarCurso("Programacion Web JavaScript");

DELIMITER //
CREATE PROCEDURE PROCValidarNivelesCurso
(   
    IN p_id_curso int
)
BEGIN
    SELECT
    id_nivel,
	id_instructor_nivel,
    titulo_nivel,
    documento_nivel,
    link_video_nivel,
    costo_nivel,
    informacion_nivel,
	imagen_nivel,
    referencias_nivel,
    fecha_creacion_nivel
    FROM 
        tabla_niveles
    WHERE 
        id_curso_nivel = p_id_curso;
END //
DELIMITER ;

-- CALL PROCValidarNivelesCurso(1);

DELIMITER //
CREATE PROCEDURE PROCBorrarCurso
(   
    IN p_titulo_curso VARCHAR(255),
    IN p_id_instructor_eliminacion_curso int
)
BEGIN
    UPDATE  tabla_cursos
    SET
			curso_deshabilitado = 1,
            fecha_eliminacion_curso = NOW(),
            id_instructor_eliminacion_curso = p_id_instructor_eliminacion_curso
    WHERE 
        titulo_curso = p_titulo_curso;
END //
DELIMITER ;

-- CALL PROCBorrarCurso('Programacion Web JavaScript',1);

DELIMITER //
CREATE PROCEDURE PROCMostrarCursos
(     
)
BEGIN
    SELECT 
    id_curso,
	titulo_curso,
    id_categoria_curso,
    niveles_curso,
    manejo_precio_curso,
    precio_curso,
    descripcion_curso,
	imagen_curso,
    id_instructor_creacion_curso
    FROM 
        tabla_cursos
    WHERE 
        curso_deshabilitado != 1;
END //
DELIMITER ;

-- CALL PROCMostrarCursos();
DELIMITER //
CREATE PROCEDURE PROCMostrarCursosPorCategoria
(
IN p_id_categoria_curso INT
)
BEGIN
    SELECT 
    id_curso,
	titulo_curso,
    id_categoria_curso,
    niveles_curso,
    manejo_precio_curso,
    precio_curso,
    descripcion_curso,
	imagen_curso,
    id_instructor_creacion_curso
    FROM 
        tabla_cursos
    WHERE 
        id_categoria_curso = p_id_categoria_curso AND curso_deshabilitado != 1;
END //
DELIMITER ;

-- CALL PROCMostrarCursosPorCategoria(23);

DELIMITER //
CREATE PROCEDURE PROCBusquedaAvanzadaCursos(
    IN p_id_categoria_curso INT,
    IN p_titulo_curso VARCHAR(255),
    IN p_id_instructor_creacion_curso INT,
    IN p_fecha_inicio DATE,
    IN p_fecha_fin DATE
)
BEGIN
    SELECT 
	id_curso,
	titulo_curso,
    id_categoria_curso,
    niveles_curso,
    manejo_precio_curso,
    precio_curso,
    descripcion_curso,
	imagen_curso,
    id_instructor_creacion_curso,
    fecha_creacion_curso
    FROM tabla_cursos
    WHERE (p_id_categoria_curso IS NULL OR id_categoria_curso = p_id_categoria_curso)
      AND (p_titulo_curso IS NULL OR titulo_curso LIKE CONCAT('%', p_titulo_curso, '%'))
      AND (p_id_instructor_creacion_curso IS NULL OR id_instructor_creacion_curso = p_id_instructor_creacion_curso)
      AND (p_fecha_inicio IS NULL OR fecha_creacion_curso >= p_fecha_inicio)
      AND (p_fecha_fin IS NULL OR fecha_creacion_curso <= p_fecha_fin)
      AND curso_deshabilitado = 0;
END //
DELIMITER ;

-- CALL PROCBusquedaAvanzadaCursos(NULL, NULL, NULL, NULL, NULL);

DELIMITER $$

-- CREATE PROCEDURE PROCobtener_precio_y_niveles(
--     IN p_titulo_curso VARCHAR(255) -- Recibe el título del curso como parámetro
-- )
-- BEGIN
--     -- Combinamos los resultados de curso y niveles buscando por el título del curso
--     SELECT 
--         'Curso' AS tipo, 
--         titulo_curso AS titulo, 
--         precio_curso AS costo,
--         manejo_precio_curso AS manejo_precio_curso,
--         id_curso AS id
--     FROM tabla_cursos
--     WHERE titulo_curso = p_titulo_curso -- Compara con el título del curso
-- 
--     UNION ALL
-- 
--     SELECT 
--         'Nivel' AS tipo, 
--         titulo_nivel AS titulo, 
--         costo_nivel AS costo, 
--         NULL AS manejo_precio_curso, -- Añadimos una columna "dummy" para que coincidan
--         id_nivel AS id -- Incluimos el id del nivel
--     FROM tabla_niveles
--     WHERE id_curso_nivel = (
--         SELECT id_curso -- Busca el id_curso asociado al título
--         FROM tabla_cursos
--         WHERE titulo_curso = p_titulo_curso
--         LIMIT 1
--     );
-- END $$
-- 
DELIMITER ;

-- CALL PROCobtener_precio_y_niveles('C# de cero a 100');

DELIMITER $$

-- CREATE PROCEDURE PROCInsertarInscripcion(
--     IN p_id_estudiante_inscripcion INT,
--     IN p_id_curso_inscripcion INT,
--     IN p_metodo_pago_inscripcion INT,
--     IN p_precio_pagado FLOAT
-- )
-- BEGIN
--     INSERT INTO tabla_inscripciones (
--         id_estudiante_inscripcion, 
--         id_curso_inscripcion,  
--         metodo_pago_inscripcion, 
--         Precio_pagado, 
--         porcentaje_avance_curso
--    ) VALUES (
--         p_id_estudiante_inscripcion, 
--         p_id_curso_inscripcion, 
--         p_metodo_pago_inscripcion, 
--         p_precio_pagado
--     );
-- END $$

DELIMITER //

DELIMITER $$

-- CREATE PROCEDURE PROCInsertarNivelInscripcion
-- (
--     IN p_id_nivel INT,
--     IN p_titulo_nivel VARCHAR(255)
-- )
-- BEGIN
--     INSERT INTO tabla_niveles_inscripcion (id_nivel, titulo_nivel) 
--     VALUES (p_id_nivel, p_titulo_nivel);
-- END $$

DELIMITER ;

-- CALL PROCobtener_precio_y_niveles('C# de cero a 100');

DELIMITER //
-- CREATE PROCEDURE PROCMostrarNivelesPorCurso
-- (   
--     IN p_id_curso INT
-- )
-- BEGIN
--     SELECT
--     id_nivel,
--     id_instructor_nivel,
--     titulo_nivel,
-- 	documento_nivel,
-- 	link_video_nivel,
--  costo_nivel,
--     id_curso_nivel,
--     informacion_nivel,
--     imagen_nivel,
--     referencias_nivel,
--     fecha_creacion_nivel
--     FROM 
--         tabla_niveles
--     WHERE 
--         id_curso_nivel = p_id_curso;
-- END //
DELIMITER ;

DELIMITER $$

CREATE PROCEDURE PROCobtener_precio_y_niveles(
    IN p_titulo_curso VARCHAR(255) -- Recibe el título del curso como parámetro
)
BEGIN
    -- Combinamos los resultados de curso y niveles buscando por el título del curso
    SELECT 
        'Curso' AS tipo, 
        titulo_curso AS titulo, 
        precio_curso AS costo,
        manejo_precio_curso AS manejo_precio_curso,
        id_curso AS id
    FROM tabla_cursos
    WHERE titulo_curso = p_titulo_curso -- Compara con el título del curso

    UNION ALL

    SELECT 
        'Nivel' AS tipo, 
        titulo_nivel AS titulo, 
        costo_nivel AS costo, 
        NULL AS manejo_precio_curso, -- Añadimos una columna "dummy" para que coincidan
        id_nivel AS id -- Incluimos el id del nivel
    FROM tabla_niveles
    WHERE id_curso_nivel = (
        SELECT id_curso -- Busca el id_curso asociado al título
        FROM tabla_cursos
        WHERE titulo_curso = p_titulo_curso
        LIMIT 1
    );
END $$

DELIMITER ;

-- CALL PROCobtener_precio_y_niveles('C# de cero a 100');
-- SE AGREGA

DELIMITER //
CREATE PROCEDURE PROCMostrarNivelesPorCurso
(   
    IN p_id_curso INT
)
BEGIN
    SELECT
    id_nivel,
    id_instructor_nivel,
    titulo_nivel,
	documento_nivel,
	link_video_nivel,
    costo_nivel,
    id_curso_nivel,
    informacion_nivel,
    imagen_nivel,
    referencias_nivel,
    fecha_creacion_nivel
    FROM 
        tabla_niveles
    WHERE 
        id_curso_nivel = p_id_curso;
END //
DELIMITER ;

-- Traer el informacion del curso finalizado

DELIMITER $$

CREATE PROCEDURE PROCObtenerCursoPorTitulo
(
    IN tituloBuscado VARCHAR(255) -- Parámetro de entrada: Título del curso a buscar
)
BEGIN
    SELECT 
		id_curso,
        titulo_curso, 
        imagen_curso,
        id_instructor_creacion_curso
    FROM 
        tabla_cursos
    WHERE 
        titulo_curso = tituloBuscado;
END$$

DELIMITER ;

-- CALL PROCObtenerCursoPorTitulo('SQL');

-- informacion del usuario

DELIMITER $$

CREATE PROCEDURE PROCObtener_usuario_por_id
(
IN p_id_usuario INT
)
BEGIN
    SELECT id_usuario,
           imagen_usuario,
           usuario_bloqueado,
           nombre_usuario,
           apellido_paterno,
           apellido_materno
    FROM tabla_usuario
    WHERE id_usuario = p_id_usuario;
END $$

DELIMITER ;

-- CALL PROCObtener_usuario_por_id(15);

-- Insertar diploma

DELIMITER $$

CREATE PROCEDURE PROCInsertarDiploma(
    IN p_id_curso INT,
    IN p_id_estudiante INT,
    IN p_id_instructor INT
)
BEGIN
    -- Insertar un nuevo diploma en la tabla tabla_diplomas
    INSERT INTO tabla_diplomas (
        fecha_terminacion_diploma,
        id_curso_diploma,
        id_estudiante_diploma,
        id_instructor_diploma
    )
    VALUES (
        NOW(),              -- Utiliza la fecha y hora actual del sistema
        p_id_curso,         -- ID del curso
        p_id_estudiante,    -- ID del estudiante
        p_id_instructor     -- ID del instructor
    );
END $$

DELIMITER ;

-- Obetener inscripciones

DELIMITER $$

CREATE PROCEDURE PROCObtenerInscripciones 
(
    IN p_id_curso INT,
    IN p_id_usuario INT
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
    FROM 
        tabla_inscripciones
    WHERE 
        id_curso_inscripcion = p_id_curso
        AND id_estudiante_inscripcion = p_id_usuario;
END$$

DELIMITER ;

-- CALL PROCObtenerInscripciones(3, 17);

-- Obtener los niveles de la inscripcion

DELIMITER $$

CREATE PROCEDURE PROCObtenerNivelesPorInscripcion (
    IN p_id_inscripcion INT
)
BEGIN
    SELECT 
        ni.id_nivel_inscripcion,
        ni.id_inscripcion,
        ni.id_nivel,
        ni.titulo_nivel AS titulo_nivel_inscripcion,
        ni.Nivel_terminado,
        n.titulo_nivel AS titulo_nivel_general,
		n.imagen_nivel,
        n.documento_nivel,
        n.link_video_nivel,
        n.costo_nivel,
        n.informacion_nivel,
        n.referencias_nivel,
        n.fecha_creacion_nivel
    FROM 
        tabla_niveles_inscripcion ni
    INNER JOIN 
        tabla_niveles n
    ON 
        ni.id_nivel = n.id_nivel
    WHERE 
        ni.id_inscripcion = p_id_inscripcion;
END $$

DELIMITER ;

-- call PROCObtenerNivelesPorInscripcion(11);

-- Update a el porcentaje

DELIMITER $$

CREATE PROCEDURE PROCActualizarAvanceCurso
(
    IN p_id_inscripcion INT,          -- ID de la inscripción a actualizar
    IN p_porcentaje_avance FLOAT      -- Nuevo porcentaje de avance
)
BEGIN
    -- Actualizar el porcentaje de avance del curso para la inscripción especificada
    UPDATE tabla_inscripciones
    SET porcentaje_avance_curso = p_porcentaje_avance
    WHERE id_inscripcion = p_id_inscripcion;

    -- Opcional: Comprobar si el porcentaje es 100 para marcar la inscripción como finalizada
    IF p_porcentaje_avance = 100 THEN
        UPDATE tabla_inscripciones
        SET inscripcion_finalizada = 1,
            fecha_terminacion_inscripcion = CURRENT_DATE,
            hora_terminacion_inscripcion = CURRENT_TIME
        WHERE id_inscripcion = p_id_inscripcion;
    END IF;
END$$

DELIMITER ;

-- call PROCActualizarAvanceCurso(13, 0);

-- Actualizar si el nive fue completado

DELIMITER $$

CREATE PROCEDURE PROCActualizarNivelTerminado (
    IN p_id_nivel_inscripcion INT -- Parámetro de entrada para identificar el registro
)
BEGIN
    -- Actualización del registro específico
    UPDATE tabla_niveles_inscripcion
    SET Nivel_terminado = 1
    WHERE id_nivel_inscripcion = p_id_nivel_inscripcion;
END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE PROCObtenerInformacionCurso
(
    IN idEstudiante INT
)
BEGIN
    SELECT 
		c.id_curso, 
        c.imagen_curso,                  -- Foto del curso
        c.titulo_curso,                 -- Nombre del curso
        i.porcentaje_avance_curso,      -- Porcentaje de avance del curso
        i.id_inscripcion
    FROM 
        tabla_inscripciones i
    INNER JOIN 
        tabla_cursos c ON i.id_curso_inscripcion = c.id_curso
    WHERE 
        i.id_estudiante_inscripcion = idEstudiante; -- Filtra por el ID del estudiante
END $$

DELIMITER ;

-- call PROCObtenerInformacionCurso(13);

DELIMITER $$

CREATE PROCEDURE ActualizarUltimoIngreso (
    IN p_id_inscripcion INT
)
BEGIN
    UPDATE tabla_inscripciones
    SET 
        ultima_fecha_ingreso = NOW(), 
        ultima_hora_inreso = NOW()
    WHERE 
        id_inscripcion = p_id_inscripcion;
END$$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE DeshabilitarCurso (
    IN p_id_curso INT
)
BEGIN
    UPDATE tabla_cursos
    SET 
        curso_deshabilitado = 1
    WHERE 
        id_curso = p_id_curso;
END$$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE HabilitarCurso (
    IN p_id_curso INT
)
BEGIN
    UPDATE tabla_cursos
    SET 
        curso_deshabilitado = 0
    WHERE 
        id_curso = p_id_curso;
END$$

DELIMITER ;


