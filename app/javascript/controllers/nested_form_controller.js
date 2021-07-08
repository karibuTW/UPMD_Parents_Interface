import NestedForm from 'stimulus-rails-nested-form'

export default class extends NestedForm {

    add(e) {
        e.preventDefault()
        const id = new Date().getTime().toString()
        const content = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, id)

        const parent_bus = document.getElementById("bus_registration_yes")
        console.log(parent_bus)

        this.targetTarget.insertAdjacentHTML('beforebegin', content)


        if(parent_bus.checked) {
            document.getElementById(`parent_children_attributes_${id}_taking_bus`).checked = true
        }
    }
}