// ====================================================================
// KathiravanMart - Core Client Application JavaScript
// ====================================================================

document.addEventListener('DOMContentLoaded', () => {
    // Auto-dismiss alerts after 5 seconds
    const alerts = document.querySelectorAll('.alert');
    alerts.forEach(alert => {
        setTimeout(() => {
            alert.style.opacity = '0';
            setTimeout(() => alert.style.display = 'none', 300);
        }, 5000);
    });

    // Star rating selector on product detail page
    const stars = document.querySelectorAll('.star-rating-select .star');
    const ratingInput = document.getElementById('selectedRating');
    if (stars.length && ratingInput) {
        stars.forEach(star => {
            star.addEventListener('click', () => {
                const val = star.getAttribute('data-value');
                ratingInput.value = val;
                stars.forEach(s => {
                    if (parseInt(s.getAttribute('data-value')) <= parseInt(val)) {
                        s.classList.add('active');
                    } else {
                        s.classList.remove('active');
                    }
                });
            });
        });
    }
});
