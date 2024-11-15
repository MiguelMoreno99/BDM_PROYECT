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

CALL PROCAltaCategoria("Programacion","Esta es una descripcion de la categoria programacion",null,1);

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

CALL PROCValidarCategoria("Programacion");

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

CALL PROCMostrarCategorias();

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

CALL PROCBorrarCategoria('Arte',1);

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

CALL PROCEditarCategoria('Artee','Arte','En esta categd', null);
