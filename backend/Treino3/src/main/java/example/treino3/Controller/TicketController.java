package example.treino3.Controller;


import example.treino3.Model.Ticket;
import example.treino3.Model.User;
import example.treino3.Repository.TicketRepository;
import example.treino3.Repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/tickets")
public class TicketController {

    @Autowired
    private TicketRepository ticketRepository;

    @Autowired
    private UserRepository userRepository;

    @GetMapping
    public List<Ticket> getAllTickets() {
        return ticketRepository.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Ticket> getTicketById(@PathVariable Long id) {
        Optional<Ticket> ticket = ticketRepository.findById(id);
        return ticket.map(ResponseEntity::ok)
                .orElseGet(() -> ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<Ticket> createTicket(@RequestBody Ticket ticket) {
        if (ticket.getUser() != null && ticket.getUser().getId() != null && !ticket.getUser().getName().trim().isEmpty()) {
            User user = userRepository.findById(ticket.getUser().getId())
                    .orElseThrow(() -> new RuntimeException("User not found"));
            ticket.setUser(user);
        } else {
            ticket.setUser(null);
        }

        ticket.setStatus("Aguardando");

        Ticket createdTicket = ticketRepository.save(ticket);
        return ResponseEntity.ok(createdTicket);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Ticket> updateTicket(@PathVariable Long id, @RequestBody Ticket ticketDetails) {
        Optional<Ticket> ticket = ticketRepository.findById(id);

        if (ticket.isPresent()) {
            Ticket updatedTicket = ticket.get();
            updatedTicket.setRequesterName(ticketDetails.getRequesterName());
            updatedTicket.setEmail(ticketDetails.getEmail());
            updatedTicket.setPhone(ticketDetails.getPhone());
            updatedTicket.setDescription(ticketDetails.getDescription());
            updatedTicket.setAttendantName(ticketDetails.getAttendantName());
            updatedTicket.setStatus(ticketDetails.getStatus());
            updatedTicket.setStartDate(ticketDetails.getStartDate());
            updatedTicket.setEndDate(ticketDetails.getEndDate());
            updatedTicket.setResolution(ticketDetails.getResolution());
            updatedTicket.setUser(ticketDetails.getUser());
            return ResponseEntity.ok(ticketRepository.save(updatedTicket));
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteTicket(@PathVariable Long id) {
        if (ticketRepository.existsById(id)) {
            ticketRepository.deleteById(id);
            return ResponseEntity.noContent().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @PutMapping("/{id}/start")
    public ResponseEntity<Ticket> startTicket(@PathVariable Long id) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        if (authentication != null && authentication.getPrincipal() instanceof UserDetails) {
            UserDetails userDetails = (UserDetails) authentication.getPrincipal();

            String email = userDetails.getUsername();

            Optional<User> userOptional = userRepository.findByEmail(email);
            if (!userOptional.isPresent()) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
            }

            User user = userOptional.get();
            Optional<Ticket> ticketOptional = ticketRepository.findById(id);

            if (ticketOptional.isPresent()) {
                Ticket ticket = ticketOptional.get();
                ticket.setUser(user);
                ticket.setStartDate(LocalDateTime.now());
                ticket.setStatus("Em andamento");

                Ticket updatedTicket = ticketRepository.save(ticket);
                return ResponseEntity.ok(updatedTicket);
            } else {
                return ResponseEntity.notFound().build();
            }
        } else {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
    }

    @PutMapping("/{id}/stop")
    public ResponseEntity<Ticket> stopTicket(@PathVariable Long id) {
        Optional<Ticket> ticketOptional = ticketRepository.findById(id);

        if (ticketOptional.isPresent()) {
            Ticket ticket = ticketOptional.get();
            ticket.setEndDate(LocalDateTime.now());
            ticket.setStatus("Finalizado");

            Ticket updatedTicket = ticketRepository.save(ticket);
            return ResponseEntity.ok(updatedTicket);
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}