// Función para validar y manejar el envío del formulario
document.getElementById('crear-curso-form').addEventListener('submit', function(event) {
    // Obtener los elementos del formulario
    const tituloCurso = document.getElementById('titulo-curso');
    const descripcionCurso = document.getElementById('descripcion-curso');
    const imagenCurso = document.getElementById('imagen-curso');
    const contenedorNiveles = document.getElementById('contenedor-niveles');
  
    // Validar campos básicos
    if (tituloCurso.value.trim() === '') {
      alert('Por favor, ingresa un nombre para el curso.');
      tituloCurso.focus();
      event.preventDefault();
      return;
    }
  
    if (descripcionCurso.value.trim() === '') {
      alert('Por favor, ingresa una descripción para el curso.');
      descripcionCurso.focus();
      event.preventDefault();
      return;
    }
  
    if (imagenCurso.files.length === 0) {
      alert('Por favor, selecciona una imagen para el curso.');
      imagenCurso.focus();
      event.preventDefault();
      return;
    }
  
    // Validar que haya al menos un nivel
    if (contenedorNiveles.children.length === 0) {
      alert('Por favor, agrega al menos un nivel para el curso.');
      event.preventDefault();
      return;
    }
  
    // Si todo está correcto, se puede enviar el formulario
    alert('Curso creado');
  });