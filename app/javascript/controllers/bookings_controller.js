import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="items"
export default class extends Controller {
  static targets = [ "items" ]

  connect() {
    this.resetBookingValues();
  }

  resetCache() {
    localStorage.removeItem("items");
  }

  resetBookingValues() {
    let itemIds = JSON.parse(localStorage.getItem("items"));
    const itemsInput = document.querySelector('[name="booking[items][]"]');
    this.itemsTarget.value = JSON.stringify(itemIds);
    console.log(this.itemsTarget.value);
  }

  reloadPage() {
    window.location.reload();
  }
}
