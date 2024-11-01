<?php
session_start();

$usuario = $_SESSION['usuario'];
?>

<!DOCTYPE html>
<html lang="es">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Gestión Instructores</title>
  <link rel="stylesheet" href="../CSS/GENERAL/general_styles.css">
  <link rel="stylesheet" href="../CSS/GENERAL/header.css">
  <link rel="stylesheet" href="../CSS/GENERAL/footer.css">
  <link rel="stylesheet" href="../CSS/gestion_instructor.css">
</head>

<body>
  <!-- Header -->
  <div id="header-container"></div>

  <!-- Gestion Instructor -->
  <section class="ventas">

    <br>
    <br>
    <h1>Reporte de Ventas</h1>
    <br>
    <br>

    <form action="" method="post" class="filtros seleccion-accion">
      <label for="tipo_usuario">Acción:</label>
      <select id="tipo_usuario" name="tipo_usuario" onchange="cambiarTextoBoton()">
        <option value="desactivar">Desactivar</option>
        <option value="activar">Activar</option>
      </select>
    </form>

    <!-- Filtros de Reporte -->
    <form action="" method="post" class="filtros">
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

      <label for="estado">Estado:</label>
      <select id="estado" name="estado">
        <option value="todos">Todos los cursos</option>
        <option value="activos">Cursos Activos</option>
        <option value="inactivos">Cursos Inactivos</option>
      </select>

      <button type="submit" class="btn-submit">Aplicar filtros</button>
    </form>

    <!-- Lista de Cursos -->
    <div class="lista-cursos">
      <h1>Nombre de usuario</h1>
      <h2>Resumen de Ventas por Curso</h2>
      <table>
        <thead>
          <tr>
            <th>Seleccionar</th>
            <th>Categoria</th>
            <th>Curso</th>
            <th>Estado</th>
            <th>Fecha de creacion</th>
            <th>Alumnos Inscritos</th>
            <th>Nivel Promedio</th>
            <th>Ingresos Generados</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td><input type="checkbox" name="usuario_seleccionado" value="usuario1"></td>
            <td>""</td>
            <td>""</td>
            <td>""</td>
            <td>""</td>
            <td>""</td>
            <td>""</td>
            <td>""</td>
          </tr>
          <tr>
            <td><input type="checkbox" name="usuario_seleccionado" value="usuario2"></td>
            <td>""</td>
            <td>""</td>
            <td>""</td>
            <td>""</td>
            <td>""</td>
            <td>""</td>
            <td>""</td>
          </tr>
        </tbody>
        <tfoot>
          <tr>
            <td colspan="7">Total de Pago con tarjeta de credito</td>
            <td>$""</td>
          </tr>
          <tr>
            <td colspan="7">Total de Pago con tarjeta de debito</td>
            <td>$""</td>
          </tr>
          <tr>
            <td colspan="7">Total de Pago con paypal</td>
            <td>$""</td>
          </tr>
          <tr>
            <td colspan="7">Total de Ingresos</td>
            <td>$""</td>
          </tr>
        </tfoot>
      </table>
      <!-- El botón que cambiará su texto dinámicamente -->
      <button type="submit" id="accion-curso-btn" class="btn-submit">Desactivar curso</button>
      <br>
      <br>
    </div>

    <!-- Detalle de Alumnos por Curso -->
    <div class="detalle-curso">
      <h2>Detalle de Alumnos por Curso</h2>
      <table>
        <thead>
          <tr>
            <th>Alumno</th>
            <th>Fecha de Inscripción</th>
            <th>Nivel de Avance</th>
            <th>Precio Pagado</th>
            <th>Forma de Pago</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>Juan Pérez</td>
            <td>01 Ene 2023</td>
            <td>100%</td>
            <td>$100.00</td>
            <td>Tarjeta de Crédito</td>
          </tr>
          <tr>
            <td>María López</td>
            <td>15 Feb 2023</td>
            <td>75%</td>
            <td>$150.00</td>
            <td>PayPal</td>
          </tr>
        </tbody>
        <tfoot>
          <tr>
            <td colspan="3">Total Ingresos del Curso</td>
            <td>$250.00</td>
            <td></td>
          </tr>
        </tfoot>
      </table>
    </div>

  </section>

  <!-- Footer -->
  <div id="footer-container"></div>

  <script src="../JS/templates.js"></script>
  <script src="../JS/Cambiar_activo.js"></script>
  <script src="../JS/validacion_gestion_Usuarios.js"></script>
</body>

</html>