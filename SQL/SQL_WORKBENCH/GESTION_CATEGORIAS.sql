use db_leveluplearning;

DELIMITER //
CREATE PROCEDURE PROCAltaCategoria
(
	IN p_nombre_categoria  VARCHAR(255),
    IN p_descripcion_categoria  VARCHAR(255),
	IN p_imagen_categoria longblob,
    IN p_id_administrador_creador int
)
BEGIN
    INSERT INTO tabla_categorias(nombre_categoria, descripcion_categoria, imagen_categoria, id_administrador_creador, fecha_creacion_categoria)
    VALUES (p_nombre_categoria, p_descripcion_categoria, p_imagen_categoria, p_id_administrador_creador, now());
END //
DELIMITER ;

-- CALL PROCAltaCategoria("Programacion","Esta es una descripcion de la categoria programacion",null,1);

DELIMITER //
CREATE PROCEDURE PROCValidarCategoria
(   
    IN p_nombre_categoria VARCHAR(255)   
)
BEGIN
    SELECT 
			id_categoria,
			nombre_categoria,
            descripcion_categoria,
            imagen_categoria
    FROM 
        tabla_categorias
    WHERE 
        nombre_categoria = p_nombre_categoria AND categoria_eliminada != 1;
END //
DELIMITER ;

-- CALL PROCValidarCategoria("Programacion");

DELIMITER //
CREATE PROCEDURE PROCMostrarCategorias
(     
)
BEGIN
    SELECT 
			id_categoria,
			nombre_categoria,
            descripcion_categoria,
            imagen_categoria
    FROM 
        tabla_categorias
    WHERE 
        categoria_eliminada != 1;
END //
DELIMITER ;

-- CALL PROCMostrarCategorias();

DELIMITER //
CREATE PROCEDURE PROCBorrarCategoria
(   
    IN p_nombre_categoria VARCHAR(255),
    IN p_id_usuario int
)
BEGIN
    UPDATE  tabla_categorias
    SET
			categoria_eliminada = 1,
            fecha_eliminacion_categoria = NOW(),
            id_administrador_elimina_categoria = p_id_usuario
    WHERE 
        nombre_categoria = p_nombre_categoria;
END //
DELIMITER ;

-- CALL PROCBorrarCategoria('Arte',1);

DELIMITER //
CREATE PROCEDURE PROCEditarCategoria
(
    IN p_nombre_categoriaActual VARCHAR(255),
    IN p_nombre_categoriaNuevo VARCHAR(255),
    IN p_descripcion_categoria VARCHAR(255),
    IN p_imagen_categoria longblob
)
BEGIN
    UPDATE  tabla_categorias
    SET
			nombre_categoria = p_nombre_categoriaNuevo,
            descripcion_categoria = p_descripcion_categoria,
            imagen_categoria = p_imagen_categoria
    WHERE 
        nombre_categoria = p_nombre_categoriaActual and categoria_eliminada != 1;
END //
DELIMITER ;

-- CALL PROCEditarCategoria('Artee','Arte','En esta categd', null);

DELIMITER //

CREATE PROCEDURE EliminarCategoriaConCursos (
    IN nombre_categoria VARCHAR(255)
)
BEGIN
    DECLARE cat_id INT;

    -- Obtener el ID de la categoría basada en el nombre
    SELECT id_categoria INTO cat_id
    FROM tabla_categorias
    WHERE nombre_categoria = p_nombre_categoria;

    -- Verificar si la categoría existe
    IF cat_id IS NOT NULL THEN
        -- Eliminar diplomas asociados a inscripciones en cursos de la categoría
        DELETE d FROM tabla_diplomas d
        JOIN tabla_inscripciones i ON d.id_curso_diploma = i.id_curso_inscripcion
        JOIN tabla_cursos c ON i.id_curso_inscripcion = c.id_curso
        WHERE c.id_categoria_curso = cat_id;

        -- Eliminar comentarios asociados a los cursos de la categoría
        DELETE com FROM tabla_comentarios com
        JOIN tabla_cursos c ON com.id_curso_comentario = c.id_curso
        WHERE c.id_categoria_curso = cat_id;

        -- Eliminar niveles asociados a inscripciones de los cursos de la categoría
        DELETE ni FROM tabla_niveles_inscripcion ni
        JOIN tabla_inscripciones i ON ni.id_inscripcion = i.id_inscripcion
        JOIN tabla_cursos c ON i.id_curso_inscripcion = c.id_curso
        WHERE c.id_categoria_curso = cat_id;

        -- Eliminar inscripciones asociadas a los cursos de la categoría
        DELETE i FROM tabla_inscripciones i
        JOIN tabla_cursos c ON i.id_curso_inscripcion = c.id_curso
        WHERE c.id_categoria_curso = cat_id;

        -- Eliminar niveles asociados a los cursos de la categoría
        DELETE n FROM tabla_niveles n
        WHERE n.id_curso_nivel IN (SELECT id_curso FROM tabla_cursos WHERE id_categoria_curso = cat_id);

        -- Eliminar cursos de la categoría
        DELETE FROM tabla_cursos
        WHERE id_categoria_curso = cat_id;

        -- Eliminar la categoría
        DELETE FROM tabla_categorias
        WHERE id_categoria = cat_id;
    END IF;
END //

DELIMITER ;
