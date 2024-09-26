function cambiarTextoBoton() {
    const selectAccion = document.getElementById('tipo_usuario');
    const boton = document.getElementById('accion-curso-btn');
    
    if (selectAccion.value === 'activar') {
      boton.textContent = 'Activar curso';
    } else {
      boton.textContent = 'Desactivar curso';
    }
  }