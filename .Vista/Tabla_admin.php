<!-- Contenido de Gestión Admin -->
<section class="seccion-admin">
  <h1>Sección de Administradores</h1>

  <!-- Filtros de Reporte -->
  <form action="../.Controlador/Usuario.php" method="POST" class="filtros">
    <input type="hidden" name="accion" value="Gestion_admin">

    <label for="registro_usuario">Fecha de ingreso:</label>
    <input type="date" id="registro_usuario" name="registro_usuario">

    <label for="ID_Usuario">ID:</label>
    <input type="text" id="ID_Usuario" name="id_usuario" placeholder="Ingrese el id">

    <label for="nombre">Nombre:</label>
    <input type="text" id="nombre_usuario" name="nombre_usuario" placeholder="Ingrese el nombre">

    <label for="correo">Correo:</label>
    <input type="text" id="correo_usuario" name="correo_usuario" placeholder="Ingrese el correo">

    <label for="tipo_usuario">Tipo de usuario:</label>
    <select id="tipo_usuario" name="tipo_usuario">
      <option value="">Selecciona</option>
      <option value="2">Estudiante</option>
      <option value="1">Instructor</option>
    </select>

    <label for="estado_usuario">Acción:</label>
    <select id="estado_usuario" name="estado_usuario" onchange="mostrarReporte(this.value)">
      <option value="">Selecciona</option>
      <option value="0">Bloquear</option>
      <option value="1">Desbloquear</option>
    </select>

    <br><br>
    <button type="submit" class="btn-submit">Aplicar filtros</button>
  </form>

  <div id="reporte_instructor" class="reporte">
    <h2>Bloquear</h2>
    <form method="post" action="../.Controlador/Usuario.php">
      <input type="hidden" name="accion" value="bloquear_usuarios">
      <table>
        <thead>
          <tr>
            <th>Seleccionar</th>
            <th>ID</th>
            <th>Nombre</th>
            <th>Correo</th>
            <th>Fecha de ingreso</th>
          </tr>
        </thead>
        <tbody>
          <?php
          if (isset($_SESSION['admin_user_data']) && !empty($_SESSION['admin_user_data'])) {
            foreach ($_SESSION['admin_user_data'] as $usuario) {
              echo "
              <tr>
                <td>
                  <input type='radio' name='usuario_seleccionado' value='{$usuario['id_usuario']}'>
                </td>
                <td>{$usuario['id_usuario']}</td>
                <td>{$usuario['nombre_usuario']}</td>
                <td>{$usuario['correo_usuario']}</td>
                <td>{$usuario['registro_usuario']}</td>
              </tr>";
            }
          }
          ?>
        </tbody>
      </table>
      <button type="submit" class="btn-submit">Bloquear seleccionado</button>
    </form>
  </div>

    <!-- Tabla para Estudiantes -->
    <div id="reporte_estudiante" class="reporte" style="display:none;">
      <h2>Desbloquear</h2>
      <form method="post" action="../.Controlador/Usuario.php">
      <input type="hidden" name="accion" value="Desbloquear_usuarios">
        <table>
          <thead>
            <tr>
              <th>Seleccionar</th>
              <th>ID</th>
              <th>Nombre</th>
              <th>Correo</th>
              <th>Fecha de ingreso</th>
            </tr>
          </thead>
          <tbody>
          <?php
          if (isset($_SESSION['admin_user_data']) && !empty($_SESSION['admin_user_data'])) {
            foreach ($_SESSION['admin_user_data'] as $usuario) {
              echo "
              <tr>
                <td>
                  <input type='radio' name='usuario_seleccionado' value='{$usuario['id_usuario']}'>
                </td>
                <td>{$usuario['id_usuario']}</td>
                <td>{$usuario['nombre_usuario']}</td>
                <td>{$usuario['correo_usuario']}</td>
                <td>{$usuario['registro_usuario']}</td>
              </tr>";
            }
          }
          ?>
        </tbody>
        </table>
        <button type="submit" class="btn-submit">Desbloquear seleccionados</button>
      </form>
    </div>

  </section>
</section>