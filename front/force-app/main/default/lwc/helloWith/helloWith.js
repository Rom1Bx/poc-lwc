import { LightningElement, track } from 'lwc';

export default class HelloWith extends LightningElement {
    @track name = 'World';
    @track data;
    @track error;

    handleChange(event) {
        this.name = event.target.value;
    }


    async handleApiCall() {
        try{
            console.log('Fetching ...')
            const response = await fetch('http://127.0.0.1:8000')
            if(!response.ok){
                throw new Error('Network response was not ok');
            }
            this.data = await response.json();
            this.error = undefined;
            console.log('Response data is' + JSON.stringify(this.data));
        }catch(error){
            this.error = error.message;
            this.data = undefined;
            console.log('Error is' + error);
        }
    }

    // Getter to safely access message
    get message() {
        return this.data ? this.data.message : 'No data yet';
    }
}