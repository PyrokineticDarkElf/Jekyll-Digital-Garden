document.addEventListener("DOMContentLoaded", function () {
    const toggleButton = document.getElementById("dark-mode-toggle");
    const htmlElement = document.documentElement;

    // Check if user has a saved preference
    if (localStorage.getItem("darkMode") === "enabled") {
        htmlElement.classList.add("dark-mode");
        toggleButton.textContent = "☀️";
    }

    // Toggle dark mode on button click
    toggleButton.addEventListener("click", () => {
        if (htmlElement.classList.contains("dark-mode")) {
            htmlElement.classList.remove("dark-mode");
            localStorage.setItem("darkMode", "disabled");
            toggleButton.textContent = "🌙";
        } else {
            htmlElement.classList.add("dark-mode");
            localStorage.setItem("darkMode", "enabled");
            toggleButton.textContent = "☀️";
        }
    });
});
