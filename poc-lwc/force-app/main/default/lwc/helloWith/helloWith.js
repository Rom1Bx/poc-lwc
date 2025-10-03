import { LightningElement, track } from 'lwc';

export default class HelloWith extends LightningElement {
    @track name = 'World';

    handleChange(event) {
        this.name = event.target.value;
    }
}