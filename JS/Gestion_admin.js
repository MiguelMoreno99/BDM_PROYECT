function mostrarReporte(tipo) {
    document.getElementById('reporte_instructor').style.display = tipo === '0' ? 'block' : 'none';
    document.getElementById('reporte_estudiante').style.display = tipo === '1' ? 'block' : 'none';
  }