import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.updateProgressBar();
  }
  updateProgressBar(){
    const totalTodos = this.data.get("totalTodos");
    const completedCount = this.data.get("completedCount");
    const progressBar = document.getElementById('progressBar');
    progressBar.style.width = `${(completedCount/totalTodos) * 100}%`
    }
}
