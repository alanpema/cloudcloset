import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="items"
export default class extends Controller {
  static targets = [ "items" ]

  connect() {
    let itemIds = JSON.parse(localStorage.getItem("items"));
    const itemsInput = document.querySelector('[name="booking[items][]"]');
    this.itemsTarget.value = JSON.stringify(itemIds);
  }
}
