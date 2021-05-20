import { Component } from '@angular/core';
import { Router, NavigationEnd, NavigationStart } from '@angular/router';
import { AuthService } from './services/auth.service';
import { UtilsService } from './services/utils.service';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  title = 'app';
  activedRoute = '';
  empName: string = '';
  isLogged: boolean = true;
  uinfo: any = {};

  constructor(
    private router: Router,
    private authService: AuthService,
    private utilsService: UtilsService
  ) { }
}
