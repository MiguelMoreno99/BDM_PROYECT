function updateTotalCost() {
    let totalCost = 0;
    const selectedLevels = document.querySelectorAll('.level:checked');
    selectedLevels.forEach(level => {
        totalCost += parseFloat(level.value);
    });
    document.getElementById('totalCost').textContent = totalCost.toFixed(2);
}
document.addEventListener('change', updateTotalCost);