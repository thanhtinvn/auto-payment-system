import { Component, OnInit, ElementRef, ViewChild } from '@angular/core';


@Component({
    selector: 'app-signin',
    templateUrl: './signin.component.html',
    styleUrls: ['./signin.component.css']
})

export class SigninComponent implements OnInit {

    email: any = '';
    password: any = '';

    ngOnInit(): void {
        
    }

    handleSignin(){
        console.log('-------');
        console.log(this.email);
        console.log(this.password);
        console.log('-------');
    }
}
