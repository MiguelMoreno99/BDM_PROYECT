document.getElementById('ratingForm').addEventListener('submit', function(event) {
    event.preventDefault();
    const rating = document.querySelector('input[name="star"]:checked').value;
    const comment = document.getElementById('comment').value;
    alert(`Calificación: ${rating} estrellas\nComentario: ${comment}`);
});