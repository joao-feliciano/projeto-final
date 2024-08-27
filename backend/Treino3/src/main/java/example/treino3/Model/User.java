package example.treino3.Model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.*;
import lombok.Data;
import lombok.Getter;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.time.temporal.ChronoUnit;
import java.util.Collection;
import java.util.List;

@Entity
@Data
@Table(name = "users")
public class User implements UserDetails {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 100)
    private String name;

    @Column(nullable = false, unique = true)
    private String email;

    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    @Getter
    @Column(nullable = false)
    private String password;

    @JsonIgnore
    @OneToMany(mappedBy = "user")
    private List<Ticket> tickets;

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return List.of();
    }

    @Override
    public String getUsername() {
        return email;
    }

    @Transient
    private Long averageHandlingTime;

    public void calculateAverageHandlingTime() {
        if (tickets != null && !tickets.isEmpty()) {
            long totalHandlingTime = tickets.stream()
                    .filter(ticket -> ticket.getStartDate() != null && ticket.getEndDate() != null)
                    .mapToLong(ticket -> ChronoUnit.MINUTES.between(ticket.getStartDate(), ticket.getEndDate()))
                    .sum();

            long handledTickets = tickets.stream()
                    .filter(ticket -> ticket.getStartDate() != null && ticket.getEndDate() != null)
                    .count();

            this.averageHandlingTime = handledTickets > 0 ? totalHandlingTime / handledTickets : null;
        } else {
            this.averageHandlingTime = null;
        }
    }

}