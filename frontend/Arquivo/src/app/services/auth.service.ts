import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, BehaviorSubject } from 'rxjs';
import { tap } from 'rxjs/operators';

@Injectable({
  providedIn: 'root'
})
export class AuthService {
  private apiUrl = 'http://localhost:8080/auth/login'; // URL do seu endpoint de login
  private loggedIn = new BehaviorSubject<boolean>(false);

  constructor(private http: HttpClient) {}

  // Método de login
  login(email: string, password: string): Observable<any> {
    return this.http.post<any>(this.apiUrl, { email, password }).pipe(
      tap(response => {
        if (response && response.token) {
          localStorage.setItem('authToken', response.token); // Armazena o token no localStorage
          this.loggedIn.next(true);
        }
      })
    );
  }

  // Método para obter o token armazenado
  getToken(): string | null {
    return localStorage.getItem('authToken');
  }

  // Método para verificar se o usuário está logado
  isLoggedIn(): Observable<boolean> {
    return this.loggedIn.asObservable();
  }

  // Método para logout
  logout(): void {
    localStorage.removeItem('authToken');
    this.loggedIn.next(false);
  }

  register(name: string, email: string, password: string): Observable<any> {
    return this.http.post('http://localhost:8080/auth/signup', { name, email, password });
  }
  
}
