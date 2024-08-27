package example.treino3.Model;

import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;

@Entity //Mostra que é uma entidade
@Data //Getters e Setters@Table(name = "users")
public class Ticket {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 255)
    private String requesterName;

    @Column(nullable = false, length = 255)
    private String email;

    @Column(nullable = false, length = 20)
    private String phone;

    @Column(nullable = false, length = 255)
    private String description;

    @Column(nullable = true, length = 255)
    private String attendantName;

    @Column(nullable = false, length = 50)
    private String status = "Aguardando";

    @Column(name = "creation_date", nullable = false, updatable = false)
    private LocalDateTime creationDate;

    @Column(name = "start_date", nullable = true)
    private LocalDateTime startDate;

    @Column(name = "end_date", nullable = true)
    private LocalDateTime endDate;

    @Column(length = 255)
    private String resolution;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    @Transient
    private long hoursOpen;

    @PrePersist
    public void prePersist() {
        if (this.status == null) {
            this.status = "Aguardando";
        }
        creationDate = LocalDateTime.now();
    }

    @PostLoad
    @PostPersist
    @PostUpdate
    public void updateHoursOpen() {
        hoursOpen = ChronoUnit.HOURS.between(creationDate, LocalDateTime.now());
    }
}
