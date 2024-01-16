import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="items"
export default class extends Controller {
  static targets = ["checkboxItem", "items", "popup"]
  static values = { neededCaching: Number }

  connect() {
    document.querySelectorAll("[type=checkbox]").forEach((checkbox) => {
      checkbox.checked = JSON.parse(localStorage.getItem("items"))?.includes(checkbox.id)
    })
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

  toggleAll(event) {
    if (!event.target.checked) {
      localStorage.removeItem('items')
      this.checkboxItemTargets.forEach((checkbox) => {
        checkbox.checked = false
      })
    } else {
      localStorage.removeItem('items')
      this.checkboxItemTargets.forEach((checkbox) => {
        checkbox.checked = true
        let items = JSON.parse(localStorage.getItem("items")) || [];
        items.push(checkbox.id);
        localStorage.setItem("items", JSON.stringify(items));
      })
    }
  }
}
