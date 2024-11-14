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

CALL PROCAltaNivel(3,"Introduccion a la Programacion Web JavaScript","linkdocumento","linkvideo",0,1,"Esta es la informacion del nivel 1 de programacion web javascript",null,"link referencias nivel");

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