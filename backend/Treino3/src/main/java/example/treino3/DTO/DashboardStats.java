package example.treino3.DTO;

import lombok.Data;

@Data
public class DashboardStats {
    private long totalTickets;
    private long attendedTickets;
    private long pendingTickets;
    private long teamAverageHandlingTime;
}
