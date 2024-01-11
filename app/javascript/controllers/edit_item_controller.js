import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="edit-item"
export default class extends Controller {
  static targets = ["infos", "form", "card"]
  connect() {

  }
  displayForm() {
    this.infosTarget.classList.add("d-none")
    debugger
    this.formTarget.classList.remove("d-none")
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
  }
}

const itemsbooking = document.getElementById('hidden-input').setAttribute('value', [0])

itemsbooking.addEventListener('click', () => {
  const itemsbooking = document.getElementById('hidden-input').setAttribute('value', [0])
  });
