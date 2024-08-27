# Sistema de Chamados para Service Desk

Este projeto de backend foi desenvolvido com o Spring Boot e utiliza um banco de dados PostgreSQL. O sistema implementa uma API para um serviço de Service Desk, permitindo que usuários abram tickets de forma rápida e que os atendentes gerenciem esses tickets.

## Funcionalidades

O sistema é uma aplicação simples de gerenciamento de chamados. Usuários podem abrir tickets com informações mínimas, e atendentes do Service Desk podem logar na "Área do Colaborador" para visualizar e atender os chamados. O sistema contabiliza informações como datas de início e fim dos tickets para calcular o tempo médio de atendimento, que pode ser visualizado através de relatórios.

- **Usuários anônimos** (não logados) podem abrir tickets.
- **Atendentes** precisam se logar para visualizar e atender tickets.


## Autenticação
A autenticação é feita por meio de token JWT. O usuário registrado precisa chamar POST /login com seu email e senha, se o usuário for válido, retornará um token e uma data de expiração. O usuário deve então enviar esse token junto com todas as requisições subsequentes para que a API cheque sua identidade e permita seu uso, até que o token expire, quando o usuário deve pedir um novo token no /login.


## Estrutura do Projeto

A API foi organizada nos seguintes pacotes: `Config`, `Controller`, `DTO`, `Model`, `Repository`, e `Services`.

### Config

O pacote `Config` contém as classes de configuração da aplicação Spring. Ele inclui as configurações necessárias, como a configuração do Spring Security, CORS, token e encriptação da senha, entre outras personalizações essenciais para o funcionamento da aplicação.

- **SecurityConfiguration**: A classe SecurityConfiguration cuida da segurança da aplicação. Ela usa o Spring Security para definir quais endpoints precisam de autenticação e quais são públicos, como `/auth/**` e requisições POST para `/tickets`, que podem ser acessados sem login. Ela adiciona um filtro especial para lidar com tokens JWT, que são usados para autenticar os usuários na API.

- **JwtAuthenticationFilter**: A JwtAuthenticationFilter é uma classe que verifica cada requisição para ver se há um token JWT válido no cabeçalho. Se a requisição for para um endpoint público, como o login ou a criação de tickets, ela deixa a requisição passar sem checar o token. Mas se o token estiver presente e for válido, a classe autentica o usuário e permite que ele acesse os recursos protegidos da aplicação.

- **CorsConfig**: A classe CorsConfig configura as permissões de CORS, que permitem que a API seja acessada por um frontend que pode estar hospedado em um servidor diferente, como `http://localhost:4200` (nosso endereço padrão do frontend do Angular).

- **ApplicationConfiguration**: Por último, a ApplicationConfiguration cuida da autenticação e do gerenciamento de senhas. Ela define um serviço que carrega as informações dos usuários a partir do banco de dados, usando o email para autenticação. Também configura o `BCryptPasswordEncoder`, que codifica as senhas antes de armazená-las, garantindo segurança.

### Controller

O pacote `Controller` abriga as classes de controle da aplicação. Essas classes gerenciam as requisições HTTP recebidas, processam-nas e retornam as respostas adequadas. Os controladores foram definidos com as anotações `@RestController` ou `@Controller`, servindo como ponto de entrada para as APIs REST da aplicação.

- **AuthenticationController**: No pacote `Controller`, o AuthenticationController lida com a autenticação e o registro de usuários. Ele oferece o endpoint `/auth/signup` para criar novos usuários e o endpoint `/auth/login` para login. Após a autenticação, um token JWT é gerado e retornado.

- **DashboardController**: O DashboardController é responsável por fornecer estatísticas dos tickets através do endpoint `/dashboard/stats`, onde são exibidos dados como o número total de tickets, tickets finalizados, pendentes, e o tempo médio de atendimento da equipe.

- **TicketController**: O TicketController gerencia as operações de tickets. Ele oferece as seguintes rotas:

  - `GET /tickets` para listar todos os tickets,
  - `GET /tickets/{id}` para visualizar um ticket específico,
  - `POST /tickets` para criar um novo ticket,
  - `PUT /tickets/{id}` para atualizar um ticket existente,
  - `DELETE /tickets/{id}` para excluir um ticket,
  - `PUT /tickets/{id}/start` para iniciar o atendimento de um ticket,
  - `PUT /tickets/{id}/stop` para finalizar o atendimento.

- **UserController**: O UserController cuida da gestão dos usuários, oferecendo as seguintes rotas:

  - `GET /users` para listar todos os usuários,
  - `GET /users/{id}` para visualizar um usuário específico,
  - `POST /users` para criar um novo usuário (não está sendo consumido pelo frontend, a lógica foi reimplementada no endpoint `signup`),
  - `PUT /users/{id}` para atualizar um usuário existente,
  - `DELETE /users/{id}` para excluir um usuário.

### DTO (Data Transfer Object)

O pacote `DTO` contém as classes que representam os objetos de transferência de dados. Os DTOs foram usados para encapsular os dados trocados entre o cliente e o servidor, evitando a exposição direta dos modelos de domínio e permitindo a manipulação dos dados antes de serem enviados ou recebidos.

- **DashboardStats**: No pacote DTO, a classe DashboardStats é utilizada para transferir dados de estatísticas do dashboard. Ela encapsula informações como o número total de tickets, a quantidade de tickets atendidos, os tickets pendentes, e o tempo médio de atendimento da equipe. Esses dados são usados para gerar relatórios e visualizações no dashboard da aplicação.

- **LoginResponse**: A classe LoginResponse é responsável por encapsular a resposta de login. Ela armazena o token JWT gerado após a autenticação bem-sucedida e o tempo de expiração desse token. Esse DTO é enviado ao cliente para que ele possa usar o token nas próximas requisições que exigem autenticação.

### Model

O pacote `Model` contém as classes que representam as entidades de domínio da aplicação, mapeadas para tabelas no banco de dados usando JPA.

#### Modelo de ticket
- `id`: Id do ticket.
- `requesterName`: Nome do usuário que abriu o ticket - Identifica quem solicitou o suporte ou abriu o ticket.
- `email`: Email do usuário que abriu o ticket - Informação de contato do solicitante, utilizada para comunicações e atualizações sobre o ticket.
- `phone`: Telefone do usuário que abriu o ticket - Outro meio de contato com o solicitante, caso necessário.
- `description`: Descrição - Explicação detalhada do problema ou solicitação do usuário. Pode incluir informações sobre o que está errado, quando o problema começou, e qualquer passo já tentado para resolver a questão.
- `user`: Nome do atendente - Nome do profissional de suporte que está lidando com o ticket. Responsável por resolver o problema.
- `status`: Status - Estado atual do ticket. Pode incluir valores como "Aberto", "Em andamento", "Resolvido", "Fechado", etc.
- `creationDate`: Data de criação - Data e hora em que o ticket foi criado no sistema.
- `startDate`: Data de início - Data e hora em que o atendimento ao ticket foi iniciado.
- `endDate`: Data de término - Data e hora em que o ticket foi resolvido ou fechado.
- `resolution`: Tratativa - Detalhes sobre como o problema foi resolvido, incluindo ações tomadas, soluções aplicadas, e qualquer outra informação relevante para encerrar o ticket.
- `hoursOpen`: Horas aberto - Tempo total, em horas, que o ticket permaneceu aberto desde a criação até a resolução (propriedade transiente, não é persistida mas calculada a partir dos datas de início e fim do ticket).

#### Modelo de usuário
- `id`: Id do usuário
- `nome`: Nome do usuário colaborador
- `email`: Email do usuário colaborador
- `password`: Senha do colaborador
- `averageHandlingTime`: Tempo médio de atendimento, propriedade transiente que calcula o tempo médio de atendimento dos tickets vinculados a ele.

### Repository

O pacote `Repository` contém as interfaces que gerenciam o acesso aos dados. Essas interfaces estendem o `JpaRepository` e são usadas para realizar operações de CRUD (Create, Read, Update, Delete) no banco de dados, abstraindo as operações de banco de dados para evitar a necessidade de SQL manual.

### Services

No pacote `Services` foram organizadas as classes de serviço que encapsulam algumas lógica de negócios da autenticaçAo. Os serviços são invocados pelos controladores para executar as operações necessárias. 

- **AuthenticationService**: No pacote `Services`, a classe AuthenticationService é responsável por gerenciar o processo de autenticação e registro de usuários. Quando um novo usuário se registra, o serviço criptografa a senha usando um codificador e salva o usuário no banco de dados. Para autenticação, ele valida as credenciais fornecidas e, se corretas, recupera o usuário do repositório. É chamado pelo `AuthenticationController`. Especificamente, os métodos `signup` e `authenticate` do `AuthenticationService

- **JwtService**: A classe JwtService lida com a geração e validação de tokens JWT, que são usados para autenticar as requisições na aplicação. Ela gera tokens com base nos detalhes do usuário, define o tempo de expiração, e valida se um token é legítimo e ainda válido, extraindo informações como o nome de usuário a partir do token. É chamado pela classe JwtAuthenticationFilter no pacote Config. Nessa classe, ele é utilizado para extrair e validar o token JWT nas requisições recebidas.

# Documentação do Frontend

Este projeto foi desenvolvido utilizando **Angular** com a biblioteca de componentes **PrimeNG** ([https://primeng.org/](https://primeng.org/)) e o template **Sakai**.

O projeto foi criado com o comando `ng new --no-standalone`.

## Configuração do Template

Para conectar o template Sakai ao projeto, foi seguido o procedimento descrito no vídeo [https://www.youtube.com/watch?v=s0qV5TbwRBA](https://www.youtube.com/watch?v=s0qV5TbwRBA), disponível na documentação oficial do template Sakai: [https://sakai.primeng.org/documentation](https://sakai.primeng.org/documentation).

## Telas Implementadas

### Tela de Login

**Função:** Permite que os colaboradores façam login no sistema de Service Desk. O usuário insere seu email e senha para acessar o painel.

**Elementos:**
- Campos de entrada para email e senha.
- Botões para "Sign In" e "Registrar-se".
- Link para retornar à página inicial.

### Tela de Registro

**Função:** Permite que novos colaboradores se registrem no sistema, criando uma nova conta com nome, email e senha.

**Elementos:**
- Campos de entrada para nome, email e senha.
- Botões para "Registrar" e "Login".

### Página Inicial

**Função:** Apresenta uma tela de boas-vindas com duas opções principais: abrir um chamado rápido ou acessar a área do colaborador.

**Elementos:**
- Botões para abrir um chamado rápido e acessar a área do colaborador.

### Tela de Dashboard

**Função:** Apresenta uma visão geral das métricas de desempenho do Service Desk, incluindo o número total de chamados, chamados atendidos, chamados na fila, e o Tempo Médio de Atendimento (TMA) por colaborador.

**Elementos:**
- Indicadores de desempenho com informações sobre chamados e TMA.
- Gráfico que mostra o TMA por colaborador.

### Tela de Tickets

**Função:** Exibe uma lista de todos os tickets abertos e finalizados, permitindo que os usuários criem novos tickets, editem ou excluam tickets existentes.

**Elementos:**
- Lista de tickets com ID, requisitante, descrição, status, tempo aberto e ações (editar/excluir).
- Botão para "Criar Ticket".
- Opção para ocultar tickets finalizados.

### Tela de Edição de Ticket

**Função:** Permite a edição dos detalhes de um ticket existente, incluindo informações do requisitante, descrição, status, atendente, e datas de início e fim do atendimento.

**Elementos:**
- Campos para editar o requisitante, email, celular, descrição, status, atendente, e datas de início e fim.
- Botão para salvar as alterações feitas no ticket.

### Tela de Usuários

**Função:** Lista os colaboradores registrados no sistema, exibindo seu ID, nome, email e Tempo Médio de Atendimento (TMA).

**Elementos:**
- Lista de usuários com seus respectivos ID, nome, email e TMA.
- Botões para editar as informações dos usuários.

## Autenticação no Frontend

A autenticação no frontend usa três componentes principais: o `AuthService`, o `AuthInterceptor` e o `AuthGuard`.

### 1. AuthService (Serviço de Autenticação)

O `AuthService` é o responsável por gerenciar o login, logout e verificar o status de autenticação do usuário.

- **Login:** Quando o usuário faz login, suas credenciais são enviadas ao servidor. Se as credenciais estiverem corretas, o servidor retorna um token, que é salvo no navegador.
- **Logout:** Remove o token do navegador, desconectando o usuário.
- **Verificar Login:** O serviço pode verificar se o usuário está logado ao conferir se há um token válido armazenado.

### 2. AuthInterceptor (Interceptor de Autenticação)

O `AuthInterceptor` intercepta todas as requisições HTTP enviadas ao servidor e adiciona o token de autenticação (se disponível) no cabeçalho da requisição. Isso garante que o servidor possa identificar que a requisição está sendo feita por um usuário autenticado.

### 3. AuthGuard (Guardião de Rotas)

O `AuthGuard` protege as rotas que devem ser acessadas apenas por usuários autenticados. Antes de acessar uma rota protegida, ele verifica se o usuário está logado. Se não estiver, redireciona o usuário para a página de login.

### Como Tudo Funciona Junto

- Quando o usuário faz login, ele recebe um token que permite o acesso a partes protegidas do site.
- Sempre que o usuário tenta acessar uma página protegida, o `AuthGuard` verifica se ele está logado.
- Todas as requisições ao servidor passam pelo `AuthInterceptor`, que adiciona o token na mensagem, garantindo que o servidor saiba que o usuário está autorizado.

## Integração com a API

Os serviços de dashboard, tickets e usuários (dashboard, ticket e user services) fazem as requisições para cada ação da API, que são chamadas pelas telas correspondentes.
