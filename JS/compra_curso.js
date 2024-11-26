// Mostrar/ocultar las secciones de curso
function showCompleteCourse() 
{
    document.getElementById('completeCourse').classList.add('visible');
    document.getElementById('completeCourse').classList.remove('hidden');
    document.getElementById('courseLevels').classList.add('hidden');
    document.getElementById('courseLevels').classList.remove('visible');
}

function showCourseLevels() 
{
    document.getElementById('completeCourse').classList.add('hidden');
    document.getElementById('completeCourse').classList.remove('visible');
    document.getElementById('courseLevels').classList.add('visible');
    document.getElementById('courseLevels').classList.remove('hidden');
}

document.querySelectorAll('.level').forEach(checkbox => {
    checkbox.addEventListener('change', () => {
        let total = 0;
        let selectedLevels = [];
        let levelsCount = 0; // Contador de niveles seleccionados

        // Calcular el total y obtener los niveles seleccionados
        document.querySelectorAll('.level:checked').forEach(checkedBox => {
            total += parseInt(checkedBox.value);
            selectedLevels.push(checkedBox.dataset.name); // Obtener el nombre del nivel
            levelsCount++; // Incrementar contador por cada nivel seleccionado
        });

        // Actualizar el total visible y el campo oculto
        document.getElementById('displayTotalCost').innerText = total || 0;
        document.getElementById('hiddenTotalCost').value = total || 0;

        // Mostrar los niveles seleccionados y actualizar el campo oculto
        const displayNiveles = document.getElementById('displayNiveles');
        if (selectedLevels.length > 0) {
            const nivelesText = `Niveles seleccionados (${levelsCount}): ${selectedLevels.join(', ')}`;
            displayNiveles.innerText = nivelesText; // Asignar el texto formateado
            document.getElementById('hiddenNiveles').value = nivelesText;
        } else {
            displayNiveles.innerText = 'Niveles seleccionados (0): Ninguno';
            document.getElementById('hiddenNiveles').value = '';
        }
    });
});
// Actualizar el método de pago seleccionado
function updatePaymentMethod() 
{
    let paymentMethod = document.getElementById('paymentMethod').value;
    let paymentMethodDisplay = document.getElementById('FormadePagoID');

    switch (paymentMethod) 
    {
        case '1':
            paymentMethodDisplay.innerText = "Tarjeta de Crédito";
            break;
        case '0':
            paymentMethodDisplay.innerText = "Tarjeta de Débito";
            break;
        case '2':
            paymentMethodDisplay.innerText = "PayPal";
            break;
        case '3':
            paymentMethodDisplay.innerText = "Gratis";
            break;
        default:
            paymentMethodDisplay.innerText = "Seleccione un método de pago";
            break;
    }
    // Actualizar campo oculto con el valor del método de pago
    document.getElementById('hiddenFormadePago').value = paymentMethod;
}

// Mostrar campos específicos según el método de pago seleccionado
function togglePaymentFields() 
{
    const paymentMethod = document.getElementById('paymentMethod')?.value;

    const fieldGroups = {
        '3': 'freeMessage',
        '1': 'creditCardFields',
        '0': 'debitCardFields',
        '2': 'paypalFields'
    };

    Object.values(fieldGroups).forEach(field => {
        document.getElementById(field)?.classList.add('hidden');
    });

    const selectedField = fieldGroups[paymentMethod];
    if (selectedField) 
    {
        document.getElementById(selectedField)?.classList.remove('hidden');
    }
}

// Validar y actualizar los campos ocultos antes de enviar el formulario
document.getElementById('profileForm').addEventListener('submit', function (event) 
{
    const idCurso = document.getElementById('displayIDCurso').value.trim();
    const totalCost = document.getElementById('totalCost').innerText.trim();
    const formaPago = document.getElementById('hiddenFormadePago').value.trim();
    const nivelesSeleccionados = document.getElementById('displayNiveles').innerText.trim();

    // Actualizar los campos ocultos con los valores
    document.getElementById('hiddenTotalCost').value = totalCost || 0;
    document.getElementById('hiddenFormadePago').value = formaPago || 'Sin especificar';
    document.getElementById('hiddenNiveles').value = nivelesSeleccionados || 'Sin niveles seleccionados';

    // Validar que el ID del curso no esté vacío
    if (!idCurso) 
    {
        alert("El ID del curso no está definido. Por favor, selecciona un curso válido.");
        event.preventDefault(); // Detener el envío del formulario
    }

    // Validar que el método de pago sea válido
    if (formaPago === "" || isNaN(formaPago)) 
    {
        alert("Seleccione un método de pago válido.");
        event.preventDefault(); // Detener el envío si el método de pago no es válido
    }
});

// Evento para actualizar el método de pago cuando cambia la selección
document.getElementById('paymentMethod').addEventListener('change', updatePaymentMethod);

// Inicialización de los valores en el formulario al cargar la página
window.onload = function() 
{
    updatePaymentMethod();

    // Obtener el ID del curso desde el input generado dinámicamente
    let IDCurso = document.getElementById('Id_curso_id').value.trim();
    if (IDCurso) 
    {
        document.getElementById('displayIDCurso').value = IDCurso; // Asignar el ID del curso
    }

    // Obtener el título del curso
    let TituloCurso = document.getElementById('titulo-curso').innerText.trim();
    if (TituloCurso) 
    {
        document.getElementById('displayTituloCurso').innerText = TituloCurso; // Asignar el título del curso
    }

    // Obtener el costo total
    let totalCost = document.getElementById('totalCost').innerText.trim();
    if (totalCost) 
    {
        document.getElementById('displayTotalCost').innerText = totalCost; // Asignar el costo total
    }

    // Mostrar los niveles seleccionados si no hay checkboxes
    let hiddenLevels = document.getElementById('nivelesOcultos');
    if (hiddenLevels) 
    {
        const niveles = JSON.parse(hiddenLevels.value);
        if (niveles.length > 0) 
        {
            const nivelesText = `Niveles incluidos: ${niveles.join(', ')}`;
            document.getElementById('displayNiveles').innerText = nivelesText;
            document.getElementById('hiddenNiveles').value = nivelesText;
        }
    }

};

// Actualizar los niveles seleccionados y el costo total
document.querySelectorAll('.level').forEach(checkbox => {
    checkbox.addEventListener('change', () => {
        let total = 0;
        let selectedLevels = [];
        let levelsCount = 0;

        // Recorrer los checkboxes seleccionados
        document.querySelectorAll('.level:checked').forEach(checkedBox => {
            levelsCount++;
            selectedLevels.push({
                id: checkedBox.value, // ID del nivel
                title: checkedBox.dataset.name // Título del nivel
            });
        });

        // Actualizar el total visible y el campo oculto
        document.getElementById('totalCost').innerText = total || 0;
        document.getElementById('hiddenTotalCost').value = total || 0;

        const displayNiveles = document.getElementById('displayNiveles');
        if (selectedLevels.length > 0) {
            const nivelesText = `Niveles seleccionados (${levelsCount}): ${selectedLevels.map(nivel => nivel.title).join(', ')}`;
            displayNiveles.innerText = nivelesText;
        } else {
            displayNiveles.innerText = 'Niveles seleccionados (0): Ninguno';
        }

        // Actualizar el campo oculto con los niveles seleccionados en formato JSON
        document.getElementById('hiddenNivelesSeleccionados').value = JSON.stringify(selectedLevels);
    });
});