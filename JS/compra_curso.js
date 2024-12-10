// Obtener referencias a elementos del DOM
const levelCheckboxes = document.querySelectorAll('.level');
const selectedLevelsList = document.getElementById('selectedLevelsList');
const totalCostSpan = document.getElementById('totalCost');
const hiddenNivelesInput = document.getElementById('hiddenNiveles');
const totalCostInput = document.querySelector('input[id="hiddenTotal"]'); // Referencia al input de costo_total
const paymentMethodSelect = document.getElementById('paymentMethod');
const hiddenPaymentMethodInput = document.getElementById('hiddenFormadePago');
const paymentMethodDisplay = document.getElementById('FormadePagoID');
const profileForm = document.getElementById('profileForm');

// Inicializar evento para los checkboxes de niveles
levelCheckboxes.forEach(checkbox => {
    checkbox.addEventListener('change', updateSelectedLevels);
});

// Función para actualizar la lista de niveles seleccionados y el costo total
function updateSelectedLevels() {
    let selectedLevels = [];
    let totalCost = 0;

    // Limpiar la lista visual de niveles seleccionados
    selectedLevelsList.innerHTML = '';

    // Recorrer los checkboxes para identificar los seleccionados
    levelCheckboxes.forEach(checkbox => {
        if (checkbox.checked) {
            const levelName = checkbox.dataset.name;
            const levelID = checkbox.dataset.id;
            const levelCost = parseFloat(checkbox.dataset.costo);

            // Crear un nuevo elemento <li> para la lista visual
            const listItem = document.createElement('li');
            listItem.textContent = `${levelID} ${levelName}`;
            selectedLevelsList.appendChild(listItem);

            // Sumar el costo al total y agregar al array de niveles seleccionados
            totalCost += levelCost;
            selectedLevels.push({ levelID, levelName });
        }
    });

    // Redondear el costo total
    totalCost = Math.round(totalCost);

    // Actualizar el costo total en el DOM
    totalCostSpan.textContent = totalCost;

    // Actualizar el costo total en el input oculto
    if (totalCostInput) {
        totalCostInput.value = totalCost;
    }

    // Guardar los niveles seleccionados como JSON en el campo oculto
    hiddenNivelesInput.value = JSON.stringify(selectedLevels);
}

// Manejar cambios en el método de pago
paymentMethodSelect.addEventListener('change', () => {
    const selectedValue = paymentMethodSelect.value;

    // Asignar el valor seleccionado (0, 1 o 2) al input 'hiddenForma'
    const hiddenFormaInput = document.getElementById('hiddenForma');
    if (hiddenFormaInput) {
        hiddenFormaInput.value = selectedValue; // Asigna el valor seleccionado
    }

    // Actualizar el texto visible del método de pago
    const selectedMethod = paymentMethodSelect.options[paymentMethodSelect.selectedIndex].text;
    paymentMethodDisplay.textContent = selectedMethod;

    // Mostrar/ocultar campos específicos para cada método de pago
    togglePaymentFields();
});

// Función para mostrar/ocultar campos según el método de pago seleccionado
function togglePaymentFields() {
    const method = paymentMethodSelect.value;

    // Referencias a los contenedores de los campos de métodos de pago
    const freeMessage = document.getElementById('freeMessage');
    const creditCardFields = document.getElementById('creditCardFields');
    const debitCardFields = document.getElementById('debitCardFields');
    const paypalFields = document.getElementById('paypalFields');

    // Ocultar todos los campos inicialmente
    freeMessage.classList.add('hidden');
    creditCardFields.classList.add('hidden');
    debitCardFields.classList.add('hidden');
    paypalFields.classList.add('hidden');

    // Mostrar los campos correspondientes al método seleccionado
    if (method === '3') {
        freeMessage.classList.remove('hidden');
    } else if (method === '1') {
        creditCardFields.classList.remove('hidden');
    } else if (method === '0') {
        debitCardFields.classList.remove('hidden');
    } else if (method === '2') {
        paypalFields.classList.remove('hidden');
    }
}

// Función de validación del formulario
function validateForm(event) {
    event.preventDefault(); // Prevenir el envío del formulario por defecto

    const selectedMethod = paymentMethodSelect.value;

    // Validar que al menos un nivel esté seleccionado
    const selectedLevels = hiddenNivelesInput.value ? JSON.parse(hiddenNivelesInput.value) : [];
    if (selectedLevels.length === 0) {
        alert("Por favor, seleccione al menos un nivel.");
        return;
    }

    // Validar que se haya seleccionado un método de pago
    if (!selectedMethod) {
        alert("Por favor, seleccione un método de pago.");
        return;
    }

    // Validar campos específicos según el método de pago seleccionado
    if (selectedMethod === '1') {
        // Validar tarjeta de crédito
        const cardName = document.getElementById('cardName').value;
        const cardNumber = document.getElementById('cardNumber').value;
        const expiryDate = document.getElementById('expiryDate').value;
        const cvv = document.getElementById('cvv').value;
        if (!cardName || !cardNumber || !expiryDate || !cvv) {
            alert("Por favor, complete todos los campos de la tarjeta de crédito.");
            return;
        }
    } else if (selectedMethod === '0') {
        // Validar tarjeta de débito
        const debitCardName = document.getElementById('debitCardName').value;
        const debitCardNumber = document.getElementById('debitCardNumber').value;
        const debitExpiryDate = document.getElementById('debitExpiryDate').value;
        const debitCvv = document.getElementById('debitCvv').value;
        if (!debitCardName || !debitCardNumber || !debitExpiryDate || !debitCvv) {
            alert("Por favor, complete todos los campos de la tarjeta de débito.");
            return;
        }
    } else if (selectedMethod === '2') {
        // Validar PayPal
        const paypalEmail = document.getElementById('paypalEmail').value;
        if (!paypalEmail) {
            alert("Por favor, complete el campo del correo electrónico de PayPal.");
            return;
        }
    }

    // Si todas las validaciones son correctas, enviar el formulario
    profileForm.submit();
}

// Adjuntar la función de validación al evento de envío del formulario
profileForm.addEventListener('submit', validateForm);

// Inicialización al cargar la página para asegurar consistencia en el DOM
document.addEventListener('DOMContentLoaded', () => {
    updateSelectedLevels();
    togglePaymentFields();
});
