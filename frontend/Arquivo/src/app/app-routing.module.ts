import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { AppLayoutComponent } from './layout/app.layout.component';
import { TicketsComponent } from './tickets/tickets.component';
import { UsersComponent } from './users/users.component';
import { TicketDetailComponent } from './tickets/ticket-detail/ticket-detail.component';
import { UserDetailComponent } from './users/user-detail/user-detail.component';
import { CenterLayoutComponent } from './layout/center-layout/center-layout.component';
import { HomeComponent } from './home/home.component';
import { LoginComponent } from './login/login.component';
import { AuthGuard } from './services/auth.guard';
import { RegisterComponent } from './register/register.component';
import { DashboardComponent } from './dashboard/dashboard.component';

const routes: Routes = [
  { path: 'panel', canActivate: [AuthGuard], component: AppLayoutComponent,
    children: [
      { path: 'dashboard', component: DashboardComponent },
      { path: 'tickets', component: TicketsComponent },
      { path: 'tickets/create', component: TicketDetailComponent },
      { path: 'tickets/edit/:id', component: TicketDetailComponent },
      { path: 'users', component: UsersComponent },
      { path: 'users/create', component: UserDetailComponent },
      { path: 'users/edit/:id', component: UserDetailComponent },
    ]
  },
  { path: '', component: CenterLayoutComponent,
    children: [
      { path: '', component: HomeComponent },
      { path: 'tickets/create', component: TicketDetailComponent }
    ]
  },
  { path: 'login', component: LoginComponent },
  { path: 'register', component: RegisterComponent },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
