import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="items"
export default class extends Controller {
  static targets = [ "items", "itemsContainer", "checkboxItem", "popup" ]

  connect() {
    this.maybeCacheItem();
    this.resetBookingValues();
    this.displayCachedItems();
  }

  maybeCacheItem(event) {
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
  }

  displayCachedItems() {
    this.itemsContainerTarget.innerHTML = ""
    let items = JSON.parse(localStorage.getItem("items"))
    if (items) {
      items.forEach((item) => {
        fetch(`/get_item/${item}`)
          .then(response => response.text())
          .then((data) => {
            if (data.includes("error")) {
              let index = items.indexOf(item);
              items.splice(index, 1);
              localStorage.setItem("items", JSON.stringify(items));
            } else {
              this.itemsContainerTarget.insertAdjacentHTML("beforeend", data)
            }
          })
      })
    }
    setTimeout(() => this.markedAsChecked(), 500);
  }

  markedAsChecked() {
    document.querySelectorAll("[type=checkbox]").forEach((checkbox) => {
      checkbox.checked = JSON.parse(localStorage.getItem("items"))?.includes(checkbox.id)
    })
  }

  removeItemFromCache(event) {
    let itemId = event.target.id
    let items = JSON.parse(localStorage.getItem("items"));
    let index = items.indexOf(itemId);
    items.splice(index, 1);
    localStorage.setItem("items", JSON.stringify(items));
    this.resetBookingValues();
    this.displayCachedItems();
  }

  resetCache() {
    localStorage.removeItem("items");
  }

  resetBookingValues() {
    let itemIds = JSON.parse(localStorage.getItem("items"));
    this.itemsTarget.value = JSON.stringify(itemIds);
  }

  reloadPage() {
    window.location.reload();
  }

  popup() {
    this.popupTarget.classList.toggle("d-none")
  }
}
