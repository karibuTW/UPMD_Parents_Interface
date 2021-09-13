import { Controller } from 'stimulus'


export default class extends Controller {
    static targets = [ 'type', 'message' ]

    connect () {

    }

   reload() {
     const locale = this.element.value
     window.location.href = `/${locale}/`
   }
}