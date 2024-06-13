import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['modalContainer']

  closeModal() {
    this.modalContainerTarget.classList.add('hidden')
  }
}
