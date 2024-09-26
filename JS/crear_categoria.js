document.getElementById('crear-curso-form').addEventListener('submit', function(event) {
    const tituloCurso = document.getElementById('titulo-curso');
    const descripcionCurso = document.getElementById('descripcion-curso');
    const imagenCurso = document.getElementById('imagen-curso');

    if (tituloCurso.value.trim() === '') {
      alert('Ingresa un nombre para la categoría.');
      tituloCurso.focus();
      event.preventDefault(); 
      return;
    }

    if (descripcionCurso.value.trim() === '') {
      alert('Ingresa una descripción para la categoría.');
      descripcionCurso.focus();
      event.preventDefault(); 
      return;
    }

    if (imagenCurso.files.length === 0) {
      alert('Selecciona una imagen para la categoría.');
      imagenCurso.focus();
      event.preventDefault(); 
      return;
    }

    alert('Categoria creada');
  });