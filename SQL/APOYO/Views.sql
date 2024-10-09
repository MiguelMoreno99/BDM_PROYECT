go
CREATE VIEW VW_Consulta AS
SELECT        dbo.Versiculos.Id_Vers AS ID, dbo.Versiones.NombreVersion AS VERSIÓN, dbo.Libros.Nombre AS LIBRO, dbo.Versiculos.NumeroCap AS CAPITULO, dbo.Versiculos.NumeroVers AS VERSICULO, dbo.Versiculos.Texto AS TEXTO
FROM          dbo.Versiones INNER JOIN
              dbo.Versiculos ON dbo.Versiones.Id_Version = dbo.Versiculos.Id_Version INNER JOIN
              dbo.Libros ON dbo.Versiculos.Id_Libro = dbo.Libros.Id_Libro
go

go
create VIEW VW_Busqueda AS
SELECT        dbo.Versiones.NombreVersion AS VERSIÓN, dbo.Testamentos.Nombre AS TESTAMENTO, dbo.Libros.Nombre AS LIBRO, dbo.Versiculos.NumeroCap AS CAPITULO, dbo.Versiculos.NumeroVers AS VERSICULO, dbo.Versiculos.Texto AS TEXTO
FROM          dbo.Versiones INNER JOIN
              dbo.Versiculos ON dbo.Versiones.Id_Version = dbo.Versiculos.Id_Version INNER JOIN
              dbo.Libros ON dbo.Versiculos.Id_Libro = dbo.Libros.Id_Libro INNER JOIN
              dbo.Testamentos ON dbo.Libros.Id_Testamento = dbo.Testamentos.Id_Testamento
go

go
CREATE VIEW VW_Favoritos AS
SELECT        dbo.Favoritos.id_favorito AS ID,dbo.Favoritos.correo_electronico AS CORREO, dbo.Versiculos.Texto AS TEXTO
FROM          dbo.Favoritos INNER JOIN
              dbo.Versiculos ON dbo.Favoritos.Id_Version = dbo.Versiculos.Id_Version AND dbo.Favoritos.Id_Libro = dbo.Versiculos.Id_Libro AND dbo.Favoritos.NumeroCap = dbo.Versiculos.NumeroCap AND 
              dbo.Favoritos.NumeroVers = dbo.Versiculos.NumeroVers
go

go
CREATE VIEW VW_Historial AS
SELECT        dbo.Historial.id_historia AS ID, dbo.Historial.historia AS HISTORIA, dbo.Historial.correo_electronico AS CORREO, dbo.Historial.fecha_hora_de_busqueda AS TIEMPO, 
			  dbo.Versiones.NombreVersion AS VERSIÓN, dbo.Testamentos.Nombre AS TESTAMENTO, dbo.Libros.Nombre AS LIBRO
FROM          dbo.Historial INNER JOIN
              dbo.Versiones ON dbo.Historial.Id_Version = dbo.Versiones.Id_Version LEFT OUTER JOIN
              dbo.Testamentos ON dbo.Historial.Id_Testamento = dbo.Testamentos.Id_Testamento LEFT OUTER JOIN
              dbo.Libros ON dbo.Historial.Id_Libro = dbo.Libros.Id_Libro AND dbo.Testamentos.Id_Testamento = dbo.Libros.Id_Testamento
go
