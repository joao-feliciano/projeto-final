package example.treino3.DTO;

import lombok.Data;

@Data
public class LoginResponse {
    private String token;

    private long expiresIn;
}