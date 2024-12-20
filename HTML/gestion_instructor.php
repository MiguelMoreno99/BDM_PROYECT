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

    <!-- Filtros de Reporte -->
    <form action="../.Controlador/Curso.php" method="post" class="filtros">
      <input type="hidden" name="accion" value="Curso_Info">
      <label for="fecha_inicio">Fecha inicio:</label>
      <input type="date" id="fecha_inicio" name="fecha_inicio">

      <label for="fecha_fin">Fecha fin:</label>
      <input type="date" id="fecha_fin" name="fecha_fin">

      <label for="categoria">Categoría:</label>
      <input type="text" name="categoria">

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
      <form id="accionCursoForm1" action="../.Controlador/Curso.php" method="post" class="filtros">
        <input type="hidden" name="accion" id="accionCurso" value="Curso_Alumno">
        <h1>Nombre de usuario</h1>
        <h2>Resumen de Ventas por Curso</h2>
        <table>
          <thead>
            <tr>
              <th>Seleccionar</th>
              <th>Categoria</th>
              <th>Curso</th>
              <th>Estado</th>
              <th>Fecha de creación</th>
              <th>Alumnos Inscritos</th>
              <th>Nivel Promedio</th>
              <th>Ingresos Generados</th>
            </tr>
          </thead>
          <tbody>
            <?php
            if (isset($_SESSION['curso_data']) && !empty($_SESSION['curso_data'])) {
              foreach ($_SESSION['curso_data'] as $curso) {
                echo "
                  <tr>
                      <td>
                         <input type='radio' name='curso_seleccionado' value='{$curso['CursoID']}'>
                      </td>
                      <td>{$curso['Categoria']}</td>
                      <td>{$curso['Curso']}</td>
                      <td>" . ($curso['CursoDeshabilitado'] ? 'Inactivo' : 'Activo') . "</td>
                      <td>{$curso['FechaCreacion']}</td>
                      <td>{$curso['TotalAlumnos']}</td>
                      <td>{$curso['PromedioAvance']}%</td>
                      <td>$ {$curso['IngresosDelCurso']}</td>
                  </tr>";
              }
            }
            ?>
          </tbody>
          <tfoot>
            <?php
            $totalTarjetaCredito = 0;
            $totalTarjetaDebito = 0;
            $totalPayPal = 0;
            $totalIngresos = 0;

            if (isset($_SESSION['curso_data']) && !empty($_SESSION['curso_data'])) {
              foreach ($_SESSION['curso_data'] as $curso) {
                $totalTarjetaCredito += $curso['IngresosTarjetaCredito'];
                $totalTarjetaDebito += $curso['IngresosTarjetaDebito'];
                $totalPayPal += $curso['IngresosPayPal'];
                $totalIngresos += $curso['TotalIngresos'];
              }
            }
            ?>
            <tr>
              <td colspan="7">Total de Pago con tarjeta de crédito</td>
              <td>$<?php echo number_format($totalTarjetaCredito, 2); ?></td>
            </tr>
            <tr>
              <td colspan="7">Total de Pago con tarjeta de débito</td>
              <td>$<?php echo number_format($totalTarjetaDebito, 2); ?></td>
            </tr>
            <tr>
              <td colspan="7">Total de Pago con PayPal</td>
              <td>$<?php echo number_format($totalPayPal, 2); ?></td>
            </tr>
            <tr>
              <td colspan="7">Total de Ingresos</td>
              <td>$<?php echo number_format($totalIngresos, 2); ?></td>
            </tr>
          </tfoot>
        </table>

        <!-- El botón que cambiará su texto dinámicamente -->
        <br>
        <button type="submit" class="btn-submit">Traer usuarios</button>
        <br>
        <br>
      </form>

      <form id="accionCursoForm2" action="../.Controlador/Curso.php" method="post" class="filtros">
        <input type="hidden" name="accion" value="Desactivarcurso">
        <input type="hidden" name="curso_seleccionado" value="">
        <button type="submit" class="btn-submit" onclick="enviarFormulario('accionCursoForm2')">Desactivar curso</button>
      </form>

      <form id="accionCursoForm3" action="../.Controlador/Curso.php" method="post" class="filtros">
        <input type="hidden" name="accion" value="ActivarCurso">
        <input type="hidden" name="curso_seleccionado" value="">
        <button type="submit" class="btn-submit" onclick="enviarFormulario('accionCursoForm3')">Activar curso</button>
      </form>


    </div>

    <!-- Detalle de Alumnos por Curso -->
    <div class="detalle-curso">
      <h2>Detalle de Alumnos por Curso</h2>
      <table>
        <thead>
          <tr>
            <th>Nombre</th>
            <th>Apellido</th>
            <th>Fecha de Inscripción</th>
            <th>Nivel de Avance</th>
            <th>Precio Pagado</th>
            <th>Forma de Pago</th>
          </tr>
        </thead>
        <tbody>
          <?php
          $totalIngresosAlumno = 0;
          if (isset($_SESSION['curso_Alumno']) && !empty($_SESSION['curso_Alumno'])) {
            foreach ($_SESSION['curso_Alumno'] as $curso) {
              $totalIngresosAlumno += $curso['Precio_pagado'];
              echo "
            <tr>
                <td>{$curso['nombre_usuario']}</td>
                <td>{$curso['apellido_paterno']}</td>
                <td>{$curso['fecha_inscripcion']}</td>
                <td>{$curso['porcentaje_avance_curso']}%</td>
                <td>$ {$curso['Precio_pagado']}</td>
                <td>" . getMetodoPago($curso['metodo_pago_inscripcion']) . "</td>
            </tr>";
            }
          }
          ?>
        </tbody>

        <tfoot>
          <tr>
            <td colspan="4">Total Ingresos del Curso</td>
            <td>$<?php echo number_format($totalIngresosAlumno, 2); ?></td>
            <td></td>
          </tr>
        </tfoot>

      </table>
    </div>

    <?php
    function getMetodoPago($metodo_pago)
    {
      switch ($metodo_pago) {
        case 0:
          return "Tarjeta Débito";
        case 1:
          return "Tarjeta Crédito";
        case 2:
          return "PayPal";
        case 3:
          return "Gratis";
        default:
          return "Desconocido";
      }
    }
    ?>

  </section>

  <!-- Footer -->
  <div id="footer-container"></div>


  <script>
    function enviarFormulario(formularioId) {
      const formulario = document.getElementById(formularioId);
      const cursoSeleccionado = document.querySelector('input[name="curso_seleccionado"]:checked');

      if (cursoSeleccionado) {
        formulario.querySelector('input[name="curso_seleccionado"]').value = cursoSeleccionado.value;
        formulario.submit();
      } else {
        alert('Por favor, selecciona un curso.');
      }
    }
  </script>



  <script src="../JS/templates.js"></script>
  <script src="../JS/Cambiar_activo.js"></script>
  <script src="../JS/validacion_gestion_Usuarios.js"></script>
</body>

</html>