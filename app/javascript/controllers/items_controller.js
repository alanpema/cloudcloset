import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="items"
export default class extends Controller {
  static targets = ["infos", "form", "card", "checkboxItem", "items", "popup"]
  static values = { neededCaching: Number }

  connect() {
    if (document.querySelector("[data-item-id]") && document.querySelector("[data-item-id]").dataset.itemId.length > 0) {
      let itemId = document.querySelector("[data-item-id]").dataset.itemId;
      let items = JSON.parse(localStorage.getItem("items")) || [];
      if (items.includes(itemId)) {
        let index = items.indexOf(itemId);
        items.splice(index, 1);
      } else {
        items.push(itemId);
      }
      localStorage.setItem("items", JSON.stringify(items));
    }

    this.checkboxItemTargets.forEach((checkbox) => {
      checkbox.checked = JSON.parse(localStorage.getItem("items"))?.includes(checkbox.id)
    })

    if (this.hasItemsTarget) {
      this.displayCachedItems()
    }
  }

  cacheItem() {
    debugger

  }

  displayCachedItems() {
    this.itemsTarget.innerHTML = ""
    let items = JSON.parse(localStorage.getItem("items"))
    if (items) {
      items.forEach((item) => {
        fetch(`/get_item/${item}`)
          .then(response => response.text())
          .then((data) => {
            this.itemsTarget.insertAdjacentHTML("beforeend", data)
          })
      })
    }
  }

  displayForm() {
    this.infosTarget.classList.add("d-none")
    this.formTarget.classList.remove("d-none")
  }

  cacheItem(event) {
    let itemId = event.target.id;
    let items = JSON.parse(localStorage.getItem("items")) || [];
    if (items.includes(itemId)) {
      let index = items.indexOf(itemId);
      items.splice(index, 1);
    } else {
      items.push(itemId);
    }
    localStorage.setItem("items", JSON.stringify(items));

    if (this.hasItemsTarget) {
      this.displayCachedItems()
    }
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

  popup() {
    console.log(this.popupTarget.classList);
    this.popupTarget.classList.toggle("d-none")
  }
}