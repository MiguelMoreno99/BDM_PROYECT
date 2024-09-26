function Llenardatos_creacion() {
    var nombre_re = document.getElementById("Nombre").value;
    var usuario_re = document.getElementById("Usuario").value;
    var correo_re = document.getElementById("email").value;
    var contrasenia_re = document.getElementById("password").value;
    var fecha_nacimiento_re = document.getElementById("fecha").value;
    var foto_re = document.getElementById("Foto").files.length;

    // Obtener el género seleccionado
    var genero_re = document.querySelector('input[name="genero"]:checked');
    // Obtener el tipo de usuario seleccionado
    var tipo_usuario_re = document.querySelector('input[name="tipo_usuario"]:checked');

    var validacion_correo = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
    var validacion_contrasenia = /^(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]).{8,}$/;

    if (nombre_re === "") {
        alert("Introduce tu nombre");
        return false;
    } 
    else if (usuario_re === "") {
        alert("Introduce tus apellidos");
        return false;
    } 
    else if (!validacion_correo.test(correo_re) || correo_re === "") {
        alert("Por favor, introduce un correo electrónico válido.");
        return false;
    } 
    else if (!validacion_contrasenia.test(contrasenia_re)) {
        alert("Por favor, introduce una contraseña válida. Debe tener al menos 8 caracteres, una mayúscula, una minúscula, un número y un carácter especial.");
        return false;
    } 
    else if (fecha_nacimiento_re === "") {
        alert("Por favor, ingresa tu fecha de nacimiento.");
        return false;
    } 
    else if (foto_re === 0) {
        alert("Por favor, sube una foto de perfil.");
        return false;
    } 
    else if (!genero_re) {
        alert("Por favor, selecciona tu género.");
        return false;
    } 
    else if (!tipo_usuario_re) {
        alert("Por favor, selecciona tu tipo de usuario.");
        return false;
    } 
    else {
        alert("Usuario registrado");
        return true;
    }
}