import { Injectable } from '@angular/core';
import { UtilsService } from './utils.service';

@Injectable({
    providedIn: 'root'
})

export class AuthService {

    constructor(
        private utilsService: UtilsService
    ) {}

}