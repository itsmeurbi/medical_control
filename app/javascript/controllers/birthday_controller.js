import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['dateInput', 'ageInput']

  updateAge() {
    const birthDate = new Date(this.dateInputTarget.value);
    const age = this.calculateAge(birthDate)
    this.ageInputTarget.value = age;
  }

  calculateAge(birthDate) {
    const currentDate = new Date();
    let age = currentDate.getFullYear() - birthDate.getFullYear();
    let monthDiff = currentDate.getMonth() - birthDate.getMonth();
    if (monthDiff < 0 || (monthDiff === 0 && currentDate.getDate() < birthDate.getDate())) {
        age--;
    }
    return age
  }
}
