import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";

// Connects to data-controller="datepicker"
export default class extends Controller {
  static targets = [ "pickup", "dropoff" ]

  connect() {
    let tomorrow = new Date();
    tomorrow.setDate(tomorrow.getDate() + 1);

    flatpickr(this.pickupTarget, {
      minDate: "today",
    }),
    flatpickr(this.dropoffTarget,
      {
        minDate: tomorrow,
        maxdate: tomorrow
      })
  }
}
