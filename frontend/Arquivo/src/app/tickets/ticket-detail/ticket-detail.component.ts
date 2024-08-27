import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { TicketService } from '../../services/ticket.service';
import { Ticket } from '../../models/ticket.model';
import { UserService } from '../../services/user.service';

@Component({
  selector: 'app-ticket-detail',
  templateUrl: './ticket-detail.component.html',
  styleUrls: ['./ticket-detail.component.css']
})
export class TicketDetailComponent implements OnInit {
  ticketForm: FormGroup;
  ticketId: number | null = null;
  currentUrl: string;

  constructor(
    private fb: FormBuilder,
    private ticketService: TicketService,
    private userService: UserService,
    private route: ActivatedRoute,
    private router: Router
  ) {
    this.ticketForm = this.fb.group({
      requesterName: ['', Validators.required],
      email: ['', [Validators.required, Validators.email]],
      phone: ['', Validators.required],
      description: ['', Validators.required],
      startDate: [{ value: null, disabled: true }],
      endDate: [{ value: null, disabled: true }],
      status: [{ value: '', disabled: true }],
      resolution: [''],
      user: this.fb.group({
        id: [null],
        name: [{ value: '', disabled: true }]
      }),
    });
    this.currentUrl = this.router.url;
  }

  ngOnInit(): void {
    this.route.paramMap.subscribe(params => {
      const id = params.get('id');
      if (id) {
        this.ticketId = +id;
        this.loadTicket();
      }
    });
  }

  loadTicket(): void {
    if (this.ticketId) {
      this.ticketService.getTicket(this.ticketId).subscribe(ticket => {
        const startDate = ticket.startDate ? new Date(ticket.startDate) : null;
        const endDate = ticket.endDate ? new Date(ticket.endDate) : null;
        this.ticketForm.patchValue({
          ...ticket,
          user: ticket.user,
          startDate: startDate,
          endDate: endDate
        });
      }); 
    }
  }

  redirectToPreviousPage(): void {
    this.router.navigate([this.currentUrl.includes('/panel') ? '/panel/tickets' : '/']);
  }

  onSubmit(): void {
    if (this.ticketForm.valid) {
      const formValue = {
        ...this.ticketForm.value,
        startDate: this.ticketForm.get('startDate')?.value,
        endDate: this.ticketForm.get('endDate')?.value,
        status: this.ticketForm.get('status')?.value,
        user: this.ticketForm.get('user')?.value
      };
  
      if (this.ticketId) {
        // Update existing ticket
        const updatedTicket: Ticket = { id: this.ticketId, ...formValue };
        this.ticketService.updateTicket(updatedTicket).subscribe(() => {
          this.redirectToPreviousPage();
        });
      } else {
        // Create new ticket
        this.ticketService.createTicket(formValue).subscribe({
          next: (ticket) => {
            alert(`Chamado aberto com sucesso. ID: ${ticket.id}`);
            this.redirectToPreviousPage();
          },
          error: (error) => {
            console.error('Error creating ticket:', error);
            alert('Falha ao abrir chamado.');
          }
        });
      }
    }
  }
  

  startTicket(): void {
    if (this.ticketId) {
      this.ticketService.startTicket(this.ticketId).subscribe({
        next: (updatedTicket) => {
          const startDate = updatedTicket.startDate ? new Date(updatedTicket.startDate) : null;
          const endDate = updatedTicket.endDate ? new Date(updatedTicket.endDate) : null;
          this.ticketForm.patchValue({
            ...updatedTicket,
            user: updatedTicket.user,
            startDate: startDate,
            endDate: endDate,
            status: updatedTicket.status
          });
        },
        error: (error) => {
          console.error('Erro ao iniciar atendimento:', error);
          alert('Falha ao iniciar atendimento.');
        }
      });
    }
  }

  stopTicket(): void {
    if (this.ticketId) {
      this.ticketService.stopTicket(this.ticketId).subscribe({
        next: (updatedTicket) => {
          const endDate = updatedTicket.endDate ? new Date(updatedTicket.endDate) : null;
          this.ticketForm.patchValue({
            endDate: endDate,
            status: updatedTicket.status
          });
        },
        error: (error) => {
          console.error('Erro ao concluir atendimento:', error);
          alert('Falha ao concluir atendimento.');
        }
      });
    }
  }
}
