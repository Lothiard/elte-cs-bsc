document.addEventListener('DOMContentLoaded', function() {
    // Hide all solve details initially
    const solveDetails = document.querySelectorAll('.solve-details-js');
    solveDetails.forEach(detail => {
        detail.style.display = 'none';
    });
    
    // Show default message
    document.getElementById('default-message').style.display = 'block';
    
    // Add click listeners to rows
    const rows = document.querySelectorAll('.clickable-row');
    rows.forEach(row => {
        row.addEventListener('click', function() {
            // Remove active class from all rows
            rows.forEach(r => r.classList.remove('active-row'));
            
            // Add active class to clicked row
            this.classList.add('active-row');
            
            // Get solve ID
            const solveId = this.getAttribute('data-id');
            
            // Hide default message
            document.getElementById('default-message').style.display = 'none';
            
            // Hide all solve details
            solveDetails.forEach(detail => {
                detail.style.display = 'none';
            });
            
            // Show selected solve details
            document.getElementById(`solve${solveId}-details`).style.display = 'block';
        });
    });
});
