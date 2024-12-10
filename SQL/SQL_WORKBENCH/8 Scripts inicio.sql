DELIMITER $$

CREATE PROCEDURE GetCursosMasInscritos()
BEGIN
    SELECT 
        c.id_curso,
        c.titulo_curso,
        c.descripcion_curso,
        c.imagen_curso,  -- Asegúrate de incluir la columna imagen_curso
        COUNT(i.id_inscripcion) AS numero_inscripciones
    FROM 
        tabla_cursos c
    LEFT JOIN 
        tabla_inscripciones i ON c.id_curso = i.id_curso_inscripcion
    WHERE 
        c.curso_deshabilitado = 0
    GROUP BY 
        c.id_curso, c.titulo_curso, c.descripcion_curso, c.imagen_curso
    ORDER BY 
        numero_inscripciones DESC;
END $$

DELIMITER ;


DELIMITER $$

CREATE PROCEDURE GetCursosMejorPuntuados
()
BEGIN
    SELECT 
        c.id_curso,
        c.titulo_curso,
        c.descripcion_curso,
        c.imagen_curso,
        AVG(com.calificacion_curso) AS calificacion_promedio,
        COUNT(i.id_inscripcion) AS numero_inscripciones
    FROM 
        tabla_cursos c
    LEFT JOIN 
        tabla_comentarios com ON c.id_curso = com.id_curso_comentario
    LEFT JOIN 
        tabla_inscripciones i ON c.id_curso = i.id_curso_inscripcion
    WHERE 
        c.curso_deshabilitado = 0
    GROUP BY 
        c.id_curso, c.titulo_curso, c.descripcion_curso, c.imagen_curso
    HAVING 
        AVG(com.calificacion_curso) IS NOT NULL
    ORDER BY 
        calificacion_promedio DESC, numero_inscripciones DESC;
END $$

DELIMITER ;

