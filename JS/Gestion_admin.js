function mostrarReporte(tipo) {
    document.getElementById('reporte_instructor').style.display = tipo === 'instructor' ? 'block' : 'none';
    document.getElementById('reporte_estudiante').style.display = tipo === 'estudiante' ? 'block' : 'none';
}