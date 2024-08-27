import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { TicketService } from '../services/ticket.service';
import { Ticket } from '../models/ticket.model';

@Component({
  selector: 'app-tickets',
  templateUrl: './tickets.component.html',
  styleUrls: ['./tickets.component.css']
})
export class TicketsComponent implements OnInit {
  tickets: Ticket[] = [];
  filteredTickets: Ticket[] = [];
  filterForm: FormGroup;

  constructor(
    private ticketService: TicketService,
    private fb: FormBuilder
  ) {
    this.filterForm = this.fb.group({
      hideFinalized: [false]
    });
  }

  ngOnInit(): void {
    this.loadTickets();
  
    // Observe mudanças no checkbox e aplique o filtro quando mudar
    this.filterForm.get('hideFinalized')?.valueChanges.subscribe((value) => {
      console.log("Checkbox value changed:", value); // Verifique se isto está sendo chamado
      this.filterTickets(value);
    });
  }

  loadTickets(): void {
    this.ticketService.getTickets().subscribe((data) => {
      this.tickets = data;
      this.filterTickets(this.filterForm.get('hideFinalized')?.value);
    });
  }

  filterTickets(hideFinalized: boolean): void {
    console.log("Filtering tickets, hideFinalized =", hideFinalized); // Depuração
    if (hideFinalized) {
      this.filteredTickets = this.tickets.filter(ticket => ticket.status !== 'Finalizado');
    } else {
      this.filteredTickets = [...this.tickets];
    }
    console.log("Filtered Tickets:", this.filteredTickets); // Verifique o resultado do filtro
  }

  onDelete(id: number): void {
    this.ticketService.deleteTicket(id).subscribe(() => {
      this.loadTickets();
    });
  }
}
