package example.treino3.Controller;

import example.treino3.DTO.DashboardStats;
import example.treino3.Repository.TicketRepository;
import example.treino3.Model.Ticket;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.temporal.ChronoUnit;
import java.util.List;

@RestController
@RequestMapping("/dashboard")
public class DashboardController {

    @Autowired
    private TicketRepository ticketRepository;

    @GetMapping("/stats")
    public DashboardStats getDashboardStats() {
        List<Ticket> tickets = ticketRepository.findAll();

        // Total de chamados
        long totalTickets = tickets.size();

        // Chamados atendidos são aqueles com status "Finalizado"
        long attendedTickets = tickets.stream().filter(ticket -> ticket.getStatus().equals("Finalizado")).count();

        // Chamados na fila são aqueles com status "Aguardando"
        long pendingTickets = tickets.stream().filter(ticket -> ticket.getStatus().equals("Aguardando")).count();

        // Calcular o TMA do time
        long totalHandlingTime = tickets.stream()
                .filter(ticket -> ticket.getStartDate() != null && ticket.getEndDate() != null)
                .mapToLong(ticket -> ChronoUnit.MINUTES.between(ticket.getStartDate(), ticket.getEndDate()))
                .sum();

        long resolvedTickets = tickets.stream()
                .filter(ticket -> ticket.getStartDate() != null && ticket.getEndDate() != null)
                .count();

        long teamAverageHandlingTime = resolvedTickets > 0 ? totalHandlingTime / resolvedTickets : 0;

        DashboardStats stats = new DashboardStats();
        stats.setTotalTickets(totalTickets);
        stats.setAttendedTickets(attendedTickets);
        stats.setPendingTickets(pendingTickets);
        stats.setTeamAverageHandlingTime(teamAverageHandlingTime);

        return stats;
    }
}
