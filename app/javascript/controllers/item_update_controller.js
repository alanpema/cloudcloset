import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="items"
export default class extends Controller {
  static targets = ["infos", "form", "card", "checkboxItem"]

  connect() {
  }

  update(event) {
    event.preventDefault()
    const url = this.formTarget.action

    fetch(url, {
      method: "PATCH",
      headers: { "Accept": "text/plain" },
      body: new FormData(this.formTarget)
    })
      .then(response => response.text())
      .then((data) => {
        this.cardTarget.outerHTML = data
      })
      setTimeout(() => this.markedAsChecked(), 500);
  }

  markedAsChecked() {
    document.querySelectorAll("[type=checkbox]").forEach((checkbox) => {
      checkbox.checked = JSON.parse(localStorage.getItem("items"))?.includes(checkbox.id)
    })
  }

  displayForm() {
    this.formTarget.classList.toggle("d-none")
    this.infosTarget.classList.toggle("d-none")
  }
}
