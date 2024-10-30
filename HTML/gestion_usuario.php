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
    <form action="" class="filtros">
      <label for="fecha_inicio">Fecha inicio:</label>
      <input type="date" id="fecha_inicio" name="fecha_inicio">

      <label for="fecha_fin">Fecha fin:</label>
      <input type="date" id="fecha_fin" name="fecha_fin">

      <label for="categoria">Categoría:</label>
      <select id="categoria" name="categoria">
        <option value="todas">Todas</option>
        <option value="Programacion">Programacion</option>
        <option value="Arte">Modelado 3d</option>
      </select>

      <label for="categoria">Cursos:</label>
      <select id="categoria" name="categoria">
        <option value="todas">Todas</option>
        <option value="IT">Cursos Terminados</option>
        <option value="Marketing">Cursos sin terminar</option>
      </select>

      <label for="estado">Estado:</label>
      <select id="estado" name="estado">
        <option value="todos">Todos los cursos</option>
        <option value="activos">Cursos Activos</option>
        <option value="inactivos">Cursos Inactivos</option>
      </select>

      <button type="" class="btn-submit">Aplicar filtros</button>
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
          <tr>
            <td>Programacion</td>
            <td>Python</td>
            <td>5/19/2024</td>
            <td>9/19/2024</td>
            <td>9/19/2024</td>
            <td>100%</td>
            <td><a href="curso_finalizado.html">Finalizado</a></td>
          </tr>
          <tr>
            <td>""</td>
            <td>""</td>
            <td>""</td>
            <td>""</td>
            <td>""</td>
            <td>""</td>
            <td>""</td>
          </tr>
          <tr>
            <td>""</td>
            <td>""</td>
            <td>""</td>
            <td>""</td>
            <td>""</td>
            <td>""</td>
            <td>""</td>
          </tr>
          <tr>
            <td>""</td>
            <td>""</td>
            <td>""</td>
            <td>""</td>
            <td>""</td>
            <td>""</td>
            <td>""</td>
          </tr>
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