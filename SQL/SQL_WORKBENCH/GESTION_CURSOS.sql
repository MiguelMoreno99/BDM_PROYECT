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

CALL PROCAltaCurso("Programacion Web JavaScript",23,1,0,0,"Esta es una descripcion del curso de programacion web javascript",null,3);

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

CALL PROCAltaNivel(1,"Introduccion a la Programacion Web JavaScript","linkdocumento","linkvideo",0,1,"Esta es la informacion del nivel 1 de programacion web javascript",null,"link referencias nivel");

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

CALL PROCValidarCurso("Programacion Web JavaScript");

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

CALL PROCValidarNivelesCurso(1);

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

CALL PROCBorrarCurso('Programacion Web JavaScript',1);

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

CALL PROCMostrarCursos();

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

CALL PROCMostrarCursosPorCategoria(23);

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

CALL PROCBusquedaAvanzadaCursos(NULL, 'de', 3, '2024-01-01 00:00:00', '2024-11-15 00:00:00');

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

CALL PROCobtener_precio_y_niveles('C# de cero a 100');

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
        Precio_pagado, 
        porcentaje_avance_curso
    ) VALUES (
        p_id_estudiante_inscripcion, 
        p_id_curso_inscripcion, 
        p_metodo_pago_inscripcion, 
        p_precio_pagado
    );
END $$

DELIMITER //

DELIMITER $$

CREATE PROCEDURE PROCInsertarNivelInscripcion
(
    IN p_id_nivel INT,
    IN p_titulo_nivel VARCHAR(255)
)
BEGIN
    INSERT INTO tabla_niveles_inscripcion (id_nivel, titulo_nivel) 
    VALUES (p_id_nivel, p_titulo_nivel);
END $$

DELIMITER ;

CALL PROCobtener_precio_y_niveles('C# de cero a 100');