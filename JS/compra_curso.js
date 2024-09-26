
//Seleccion de tipo de compra
function showCompleteCourse() {
        document.getElementById('completeCourse').classList.add('visible');
        document.getElementById('completeCourse').classList.remove('hidden');
        document.getElementById('courseLevels').classList.add('hidden');
        document.getElementById('courseLevels').classList.remove('visible');
    }

    function showCourseLevels() {
        document.getElementById('completeCourse').classList.add('hidden');
        document.getElementById('completeCourse').classList.remove('visible');
        document.getElementById('courseLevels').classList.add('visible');
        document.getElementById('courseLevels').classList.remove('hidden');
    }

    document.querySelectorAll('.level').forEach(checkbox => {
        checkbox.addEventListener('change', () => {
            let total = 0;
            document.querySelectorAll('.level:checked').forEach(checkedBox => {
                total += parseInt(checkedBox.value);
            });
            document.getElementById('totalCost').innerText = total;
        });
    });

//Metodo de pago 
function togglePaymentFields() {
    const paymentMethod = document.getElementById('paymentMethod').value;
    const creditCardFields = document.getElementById('creditCardFields');
    const paypalFields = document.getElementById('paypalFields');

    if (paymentMethod === 'creditCard') {
        creditCardFields.classList.remove('hidden');
        paypalFields.classList.add('hidden');
    } else if (paymentMethod === 'paypal') {
        paypalFields.classList.remove('hidden');
        creditCardFields.classList.add('hidden');
    } else {
        creditCardFields.classList.add('hidden');
        paypalFields.classList.add('hidden');
    }
}