// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)

document.getElementById("postTextarea").value = "";
document.addEventListener('DOMContentLoaded', function () {
    const textarea = document.getElementById('postTextarea');
    textarea.value = textarea.value.trim(); // Remove any whitespace
});