import { Controller } from "stimulus"

export default class extends Controller {

  connect() {
    this.element.placeholder = "AAAA/LL/ZZ hh:mm"
    new Cleave(this.element, {
      delimiters: ["/", "/", " ", ":"],
      blocks: [4, 2, 2, 2, 2]
    })
  }

}
