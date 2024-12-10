<?php
session_start();

$usuario = $_SESSION['usuario'];
?>

<!DOCTYPE html>
<html lang="es">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Reportes</title>
  <link rel="stylesheet" href="../CSS/GENERAL/general_styles.css">
  <link rel="stylesheet" href="../CSS/GENERAL/header.css">
  <link rel="stylesheet" href="../CSS/GENERAL/footer.css">
  <link rel="stylesheet" href="../CSS/reportes.css">
</head>

<body>
  <!-- Header -->
  <div id="header-container"></div>

  <!-- Reportes -->
  <section class="reporte-usuarios">
    <br>
    <br>
    <h1>Reporte de Usuarios</h1>
    <br>
    <!-- Selección de Tipo de Usuario -->
    <form action="../.Controlador/Usuario.php" method="post" class="filtros">
    <input type="hidden" name="accion" value="Reporte_instructor">
        <h2>Instructores</h2>
          <br>
          <button type="submit" class="btn-aplicar">Buscar instructores</button>
    </form>

    <!-- Tabla para Instructores -->
    <div id="reporte_instructor" class="reporte">
        <h3>Reporte para Instructores</h2>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nombre</th>
                    <th>Fecha de Ingreso</th>
                    <th>Cantidad de Cursos Ofrecidos</th>
                    <th>Total de Ganancias</th>
                </tr>
            </thead>
            <tbody>

            <?php
          if (isset($_SESSION['Reporte_Instructor']) && !empty($_SESSION['Reporte_Instructor'])) 
          {
            foreach ($_SESSION['Reporte_Instructor'] as $usuario) 
            {
              echo "
              <tr>
                   <td>{$usuario['ID_Usuario']}</td>
                   <td>{$usuario['Nombre_Completo']}</td>
                   <td>{$usuario['Registro_Usuario']}</td>
                   <td>{$usuario['Numero_Cursos']}</td>
                   <td>{$usuario['Total_Ganancias']}</td>
              </tr>";
            }
          }
          ?>
            </tbody>
        </table>
    </div>

    <form action="../.Controlador/Usuario.php" method="post" class="filtros">
    <input type="hidden" name="accion" value="Reporte_estudiante">
        <h2>Estudiantes</h2>
          <br>
          <button type="submit" class="btn-aplicar">Buscar Estudiantes</button>
    </form>

    <!-- Tabla para Estudiantes -->
    <div id="reporte_estudiante" class="reporte">
        <h3>Reporte para Estudiantes</h2>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nombre</th>
                    <th>Fecha de Ingreso</th>
                    <th>Cantidad de Cursos Inscritos</th>
                    <th>% de Cursos Terminados</th>
                </tr>
            </thead>
            <tbody>
            <?php
          if (isset($_SESSION['Reporte_Estudiante']) && !empty($_SESSION['Reporte_Estudiante'])) 
          {
            foreach ($_SESSION['Reporte_Estudiante'] as $usuario) 
            {
              echo "
              <tr>
                   <td>{$usuario['ID_Usuario']}</td>
                   <td>{$usuario['Nombre_Completo']}</td>
                   <td>{$usuario['Registro_Usuario']}</td>
                   <td>{$usuario['Numero_Cursos_Inscritos']}</td>
                   <td>{$usuario['Porcentaje_Cursos_Completados']}</td>
              </tr>";
            }
          }
          ?>
            </tbody>
        </table>
    </div>
</section>

  <!-- Footer -->
  <div id="footer-container"></div>

  <script src="../JS/templates.js"></script>
</body>

</html>