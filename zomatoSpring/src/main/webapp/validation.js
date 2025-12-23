function validateForm() {
    let isValid = true;
    clearErrors();

    if (!/^[A-Za-z\s]{4,}$/.test(document.getElementById('ownerName').value)) {
            showError('ownerName', 'Full name must be at least 4 letters');
            isValid = false;
        }

    const email = document.getElementById('email').value;
        if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
            showError('email', 'Enter valid email address');
            isValid = false;
        }

    if (!/^[A-Za-z\s]{4,}$/.test(document.getElementById('restaurantName').value)) {
            showError('restaurantName', 'restaurant name must be at least 4 letters');
            isValid = false;
        }


    const foodStyles = document.getElementById('foodStyles').value;
        if (foodStyles === "") {
            showError('foodStyles', 'Please select a food Styles');
            isValid = false;
        }

        if (!/^[A-Za-z\s]{4,}$/.test(document.getElementById('city').value)) {
                    showError('city', 'Full name must be at least 4 letters');
                    isValid = false;
                }


    const number = document.getElementById('number').value.trim();
        if (number === "" || isNaN(number) || number <= 0) {
            showError('number', 'Enter a valid number');
            isValid = false;
        }

          const numbers = document.getElementById('numbers').value.trim();
                if (numbers === "" || isNaN(numbers) || number <= 0) {
                    showError('numbers', 'Enter number of star ');
                    isValid = false;
                }


        return isValid;
    }

    // Display error message below input
    function showError(fieldId, message) {
        document.getElementById(fieldId + '-error').textContent = message;
    }

    // Clears all error messages
    function clearErrors() {
        const errors = document.querySelectorAll('.error');
        errors.forEach(err => err.textContent = "");
    }


