import { LightningElement } from 'lwc';

export default class Survey extends LightningElement {
    Questions;

    handleClick(){
        this.Questions = "First question?";
        console.log("Question", this.Questions);
    }
}