function Llenardatos_creacion(event) 
{
    event.preventDefault(); 

    var nombre_re = document.getElementById("Nombre").value;
    var apellido_pa = document.getElementById("apellido_paterno").value;
    var apellido_ma = document.getElementById("apellido_materno").value;
    var correo_re = document.getElementById("email").value;
    var contrasenia_re = document.getElementById("password").value;
    var fecha_nacimiento_re = document.getElementById("fecha").value;
    var foto_re = document.getElementById("Foto").files.length;
    var genero_re = document.querySelector('input[name="genero_usuario"]:checked');
    var tipo_usuario_re = document.querySelector('input[name="tipo_usuario"]:checked');

    var validacion_correo = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
    var validacion_contrasenia = /^(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]).{8,}$/;

    var today = new Date();
    var currentYear = today.getFullYear();
    var currentMonth = (today.getMonth() + 1).toString().padStart(2, '0');
    var currentDay = today.getDate().toString().padStart(2, '0');
    var currentDate = `${currentYear}-${currentMonth}-${currentDay}`;

    if (nombre_re === "") 
    {
        alert("Introduce tu nombre");
        return false;
    } 
    else if (apellido_pa === "") 
    {
        alert("Introduce tu apellido paterno");
        return false;
    } 
    else if (apellido_ma === "") 
    {
        alert("Introduce tu apellido materno");
        return false;
    } 
    else if (!validacion_correo.test(correo_re) || correo_re === "") 
    {
        alert("Por favor, introduce un correo electrónico válido.");
        return false;
    } 
    else if (!validacion_contrasenia.test(contrasenia_re)) 
    {
        alert("Por favor, introduce una contraseña válida. Debe tener al menos 8 caracteres, una mayúscula, una minúscula, un número y un carácter especial.");
        return false;
    } 
    else if (fecha_nacimiento_re === "") 
    {
        alert("Por favor, ingresa tu fecha de nacimiento.");
        return false;
    } 
    else if (fecha_nacimiento_re >= currentDate) 
    {
        alert("La fecha de nacimiento no puede ser hoy o una fecha futura.");
        return false;
    }
    else if (foto_re === 0) 
    {
        alert("Por favor, sube una foto de perfil.");
        return false;
    } 
    else if (!genero_re) 
    {
        alert("Por favor, selecciona tu género.");
        return false;
    } 
    else if (!tipo_usuario_re) 
    {
        alert("Por favor, selecciona tu tipo de usuario.");
        return false;
    } 
    else 
    {
         document.getElementById("registroForm").submit();
    }
}