import { OnInit } from '@angular/core';
import { Component } from '@angular/core';
import { LayoutService } from './service/app.layout.service';

@Component({
    selector: 'app-menu',
    templateUrl: './app.menu.component.html'
})
export class AppMenuComponent implements OnInit {

    model: any[] = [];

    constructor(public layoutService: LayoutService) { }

    ngOnInit() {
        this.model = [
            {
                label: 'Menu',
                items: [
                    { label: 'Dashboard', icon: 'pi pi-fw pi-chart-bar', routerLink: ['/panel/dashboard'] },
                    { label: 'Tickets', icon: 'pi pi-fw pi-ticket', routerLink: ['/panel/tickets'] },
                    { label: 'Usuários', icon: 'pi pi-fw pi-user', routerLink: ['/panel/users'] },
                ]
            },
        ];
    }
}
