<?php
session_start();

$usuario = $_SESSION['usuario'];
?>

<!DOCTYPE html>
<html lang="es">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Gestión Usuarios</title>
  <link rel="stylesheet" href="../CSS/GENERAL/general_styles.css">
  <link rel="stylesheet" href="../CSS/GENERAL/header.css">
  <link rel="stylesheet" href="../CSS/GENERAL/footer.css">
  <link rel="stylesheet" href="../CSS/gestion_usuario.css">
</head>

<body>
  <!-- Header -->
  <div id="header-container"></div>

  <section class="ventas">
    <h1>Nombre de usuario</h1>
    <h2>Kardex</h2>

    <!-- Filtros de Reporte -->
    <form action="../.Controlador/Curso.php" method="post" class="filtros">
      <input type="hidden" name="accion" value="Alumnos_Cursos">

      <label for="fecha_inicio">Fecha inicio:</label>
      <input type="date" id="fecha_inicio" name="fecha_inicio">

      <label for="fecha_fin">Fecha fin:</label>
      <input type="date" id="fecha_fin" name="fecha_fin">

      <label for="categoria">Categoría:</label>
      <select id="categoria" name="categoria">
        <option value="">Todas</option>
        <option value="Programacion">Programacion</option>
        <option value="Arte">Modelado 3d</option>
      </select>

      <label for="cursos">Cursos:</label>
      <select id="cursos" name="cursos">
        <option value="todas">Todas</option>
        <option value="0">Cursos sin terminar</option>
        <option value="1">Cursos terminados</option>
      </select>

      <label for="estado">Estado:</label>
      <select id="estado" name="estado">
        <option value="">Todos los cursos</option>
        <option value="0">Cursos Activos</option>
        <option value="1">Cursos Inactivos</option>
      </select>

      <button type="submit" class="btn-submit">Aplicar filtros</button>
    </form>

    <!-- Lista de Cursos -->
    <div class="lista-cursos">
      <h2>Resumen de Cursos</h2>
      <table>
        <thead>
          <tr>
            <th>Categoria</th>
            <th>Curso</th>
            <th>Fecha de Inscripción</th>
            <th>Última Fecha de Acceso</th>
            <th>Fecha de Finalización</th>
            <th>Progreso</th>
            <th>Estado</th>
          </tr>
        </thead>
        <tbody>
          <?php
          if (isset($_SESSION['Alumno_datos']) && !empty($_SESSION['Alumno_datos'])) {
            foreach ($_SESSION['Alumno_datos'] as $curso) {
              echo "
                <tr>
                    <td>{$curso['nombre_categoria']}</td>
                    <td>{$curso['titulo_curso']}</td>
                    <td>{$curso['fecha_inscripcion']}</td>
                    <td>{$curso['ultima_fecha_ingreso']}</td>
                    <td>{$curso['fecha_terminacion_inscripcion']}</td>
                    <td>{$curso['porcentaje_avance_curso']}%</td>
                    <td>" . ($curso['inscripcion_finalizada'] ? 'Finalizado' : 'En progreso') . "</td>
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
  <script src="../JS/validacion_gestion_Usuarios.js"></script>
</body>

</html>