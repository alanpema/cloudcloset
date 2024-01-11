import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="items"
export default class extends Controller {
  static targets = ["infos", "form", "card", "checkboxItem", "items", "popup"]
  connect() {
    this.checkboxItemTargets.forEach((checkbox) => {
      checkbox.checked = JSON.parse(localStorage.getItem("items"))?.includes(checkbox.id)
    })

    if (this.hasItemsTarget) {
      this.displayCachedItems()
    }
  }

  initialize() {
    this.isOpen = true;
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
    console.log("popup")
    console.log(this.popupTarget)
    this.isOpen? this.hidePopup() : this.showPopup()
    this.isOpen = !this.isOpen
  }

  showPopup() {
    this.popupTarget.classList.remove("d-none")
  }

  hidePopup() {
    this.popupTarget.classList.add("d-none")
  }
}
