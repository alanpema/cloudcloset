import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="items"
export default class extends Controller {
  static targets = ["infos", "form", "card"]

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
      setTimeout(() => this.markedAsChecked(), 200);
  }

  markedAsChecked() {
    let checkbox = document.querySelector(`[type=checkbox]`)
    checkbox.checked = true
  }

  displayForm() {
    this.formTarget.classList.toggle("d-none")
  }
}