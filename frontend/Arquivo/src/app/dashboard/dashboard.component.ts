import { Component } from '@angular/core';
import { UserService } from '../services/user.service';
import { DashboardService } from '../services/dashboard.service';

@Component({
  selector: 'app-dashboard',
  templateUrl: './dashboard.component.html',
  styleUrl: './dashboard.component.css'
})
export class DashboardComponent {
  users: any[] = [];
  chartData: any;
  chartOptions: any;

  totalTickets: number = 0;
  attendedTickets: number = 0;
  pendingTickets: number = 0;
  teamAverageHandlingTime: number = 0;

  constructor(
    private userService: UserService,
    private dashboardService: DashboardService
  ) {}

  ngOnInit(): void {
    this.loadUsers();
    this.loadDashboardStats();
  }

  loadUsers(): void {
    this.userService.getUsers().subscribe(users => {
      this.users = users;
      this.generateChart();
    });
  }

  generateChart(): void {
    const labels = this.users.map(user => user.name);
    const tmaData = this.users.map(user => user.averageHandlingTime);

    this.chartData = {
      labels: labels,
      datasets: [
        {
          label: 'Tempo Médio de Atendimento (TMA)',
          backgroundColor: '#42A5F5',
          borderColor: '#1E88E5',
          data: tmaData
        }
      ]
    };

    this.chartOptions = {
      responsive: true,
      maintainAspectRatio: false,
      scales: {
        x: {
          title: {
            display: true,
            text: 'Colaboradores'
          }
        },
        y: {
          title: {
            display: true,
            text: 'Tempo Médio de Atendimento (minutos)'
          },
          beginAtZero: true
        }
      }
    };
  }

  loadDashboardStats(): void {
    this.dashboardService.getDashboardStats().subscribe(stats => {
      this.totalTickets = stats.totalTickets;
      this.attendedTickets = stats.attendedTickets;
      this.pendingTickets = stats.pendingTickets;
      this.teamAverageHandlingTime = stats.teamAverageHandlingTime;
    });
  }
}
