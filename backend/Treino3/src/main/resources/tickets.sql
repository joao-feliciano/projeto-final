INSERT INTO ticket (
    creation_date, requester_name, email, phone, description,
    start_date, end_date, status, resolution, user_id
) VALUES
-- Chamados do Usuário 1 (10 dias)
('2024-08-10 08:15', 'Carlos Silva', 'carlos.silva@example.com', '(11) 98765-4321', 'Problema ao acessar o e-mail.', '2024-08-10 08:30', '2024-08-10 09:00', 'Finalizado', 'Redefinição de senha de e-mail.', 1),
('2024-08-10 10:15', 'Ana Souza', 'ana.souza@example.com', '(21) 99988-7766', 'Impressora não funciona.', '2024-08-10 10:30', '2024-08-10 11:00', 'Finalizado', 'Instalação de drivers da impressora.', 1),
('2024-08-10 12:30', 'João Lima', 'joao.lima@example.com', '(31) 99887-6655', 'Computador lento.', '2024-08-10 12:45', '2024-08-10 14:30', 'Finalizado', 'Limpeza de arquivos temporários e atualização de software.', 1),
('2024-08-10 15:00', 'Beatriz Oliveira', 'beatriz.oliveira@example.com', '(51) 98765-4321', 'Não consigo acessar a VPN.', '2024-08-10 15:15', '2024-08-10 16:45', 'Finalizado', 'Configuração de novo cliente VPN.', 1),
('2024-08-10 17:00', 'Rafael Costa', 'rafael.costa@example.com', '(41) 99988-7766', 'Falha ao iniciar o aplicativo.', '2024-08-10 17:15', '2024-08-10 19:15', 'Finalizado', 'Atualização do aplicativo.', 1),
('2024-08-11 08:15', 'Mariana Fernandes', 'mariana.fernandes@example.com', '(61) 99887-6655', 'Problema na sincronização do e-mail.', '2024-08-11 08:30', '2024-08-11 09:30', 'Finalizado', 'Reconfiguração das definições de e-mail.', 1),
('2024-08-11 10:15', 'Pedro Ramos', 'pedro.ramos@example.com', '(71) 98765-4321', 'Requisição de instalação de software.', '2024-08-11 10:30', '2024-08-11 11:30', 'Finalizado', 'Instalação de software solicitado.', 1),
('2024-08-11 12:30', 'Letícia Barbosa', 'leticia.barbosa@example.com', '(81) 99988-7766', 'Não consigo imprimir.', '2024-08-11 12:45', '2024-08-11 13:15', 'Finalizado', 'Instalação de drivers da impressora.', 1),

-- Chamados do Usuário 2 (10 dias)
('2024-08-10 08:30', 'Ricardo Almeida', 'ricardo.almeida@example.com', '(21) 99988-7766', 'Problema de desempenho no sistema.', '2024-08-10 08:45', '2024-08-10 09:45', 'Finalizado', 'Otimização das configurações do sistema.', 2),
('2024-08-10 10:30', 'Bruna Castro', 'bruna.castro@example.com', '(31) 99887-6655', 'Falha na conexão da VPN.', '2024-08-10 10:45', '2024-08-10 11:45', 'Finalizado', 'Reconfiguração da VPN.', 2),
('2024-08-10 12:45', 'Marcelo Dias', 'marcelo.dias@example.com', '(51) 98765-4321', 'Erro ao abrir documento.', '2024-08-10 13:00', '2024-08-10 13:30', 'Finalizado', 'Reparação de arquivo corrompido.', 2),
('2024-08-10 15:00', 'Carla Nunes', 'carla.nunes@example.com', '(61) 99887-6655', 'Não consigo acessar a internet.', '2024-08-10 15:15', '2024-08-10 17:15', 'Finalizado', 'Reconfiguração do roteador.', 2),
('2024-08-10 17:15', 'Fábio Santos', 'fabio.santos@example.com', '(41) 99988-7766', 'Impressora travada.', '2024-08-10 17:30', '2024-08-10 19:00', 'Finalizado', 'Desbloqueio e reinstalação de drivers.', 2),
('2024-08-11 08:15', 'Patrícia Lima', 'patricia.lima@example.com', '(71) 98765-4321', 'Problema ao acessar o sistema.', '2024-08-11 08:30', '2024-08-11 09:30', 'Finalizado', 'Redefinição de senha e teste de login.', 2),
('2024-08-11 10:00', 'César Ribeiro', 'cesar.ribeiro@example.com', '(81) 99988-7766', 'E-mail não sincroniza.', '2024-08-11 10:15', '2024-08-11 12:15', 'Finalizado', 'Reconfiguração das definições de e-mail.', 2),
('2024-08-11 12:30', 'Helena Teixeira', 'helena.teixeira@example.com', '(91) 99887-6655', 'Computador reinicia sozinho.', '2024-08-11 12:45', '2024-08-11 14:15', 'Finalizado', 'Substituição da fonte de alimentação.', 2),
('2024-08-11 15:30', 'Rogério Marques', 'rogerio.marques@example.com', '(11) 98765-4321', 'Aplicativo não responde.', '2024-08-11 15:45', '2024-08-11 17:15', 'Finalizado', 'Reinstalação do aplicativo.', 2),
('2024-08-11 17:15', 'Júlia Rocha', 'julia.rocha@example.com', '(21) 99988-7766', 'Problema de desempenho no computador.', '2024-08-11 17:30', '2024-08-11 19:00', 'Finalizado', 'Otimização das configurações do sistema.', 2),

-- Chamados do Usuário 3 (10 dias)
('2024-08-10 08:00', 'Lucas Moura', 'lucas.moura@example.com', '(31) 99887-6655', 'Problema de conexão com o servidor.', '2024-08-10 08:15', '2024-08-10 09:00', 'Finalizado', 'Restabelecimento da conexão.', 3),
('2024-08-10 10:00', 'Isabela Ferreira', 'isabela.ferreira@example.com', '(41) 99988-7766', 'Não consigo imprimir.', '2024-08-10 10:15', '2024-08-10 12:15', 'Finalizado', 'Instalação de drivers da impressora.', 3),
('2024-08-10 12:45', 'Mateus Oliveira', 'mateus.oliveira@example.com', '(51) 98765-4321', 'Erro ao abrir programa.', '2024-08-10 13:00', '2024-08-10 14:30', 'Finalizado', 'Reinstalação do programa.', 3),
('2024-08-10 14:45', 'Jéssica Gomes', 'jessica.gomes@example.com', '(61) 99887-6655', 'Computador travando.', '2024-08-10 15:00', '2024-08-10 16:00', 'Finalizado', 'Atualização do sistema operacional.', 3),
('2024-08-10 17:15', 'Thiago Araújo', 'thiago.araujo@example.com', '(71) 98765-4321', 'Problema com conexão Wi-Fi.', '2024-08-10 17:30', '2024-08-10 19:00', 'Finalizado', 'Reconfiguração do roteador.', 3),
('2024-08-11 08:15', 'Carolina Souza', 'carolina.souza@example.com', '(81) 99988-7766', 'Problema ao acessar o e-mail.', '2024-08-11 08:30', '2024-08-11 09:00', 'Finalizado', 'Redefinição de senha de e-mail.', 3),
('2024-08-11 10:30', 'Bruno Almeida', 'bruno.almeida@example.com', '(91) 99887-6655', 'Erro de conexão com a VPN.', '2024-08-11 10:45', '2024-08-11 12:15', 'Finalizado', 'Reconfiguração da VPN.', 3),
('2024-08-11 12:45', 'Luana Martins', 'luana.martins@example.com', '(11) 98765-4321', 'Computador desligando sozinho.', '2024-08-11 13:00', '2024-08-11 15:30', 'Finalizado', 'Substituição da fonte de alimentação.', 3),
('2024-08-11 15:45', 'Henrique Melo', 'henrique.melo@example.com', '(21) 99988-7766', 'Erro ao acessar o sistema.', '2024-08-11 16:00', '2024-08-11 17:30', 'Finalizado', 'Redefinição de senha.', 3),
('2024-08-11 17:15', 'Juliana Castro', 'juliana.castro@example.com', '(31) 99887-6655', 'Aplicativo não responde.', '2024-08-11 17:30', '2024-08-11 19:30', 'Finalizado', 'Reinstalação do aplicativo.', 3),

-- Chamados do Usuário 4 (10 dias)
('2024-08-10 08:00', 'Guilherme Pereira', 'guilherme.pereira@example.com', '(21) 98765-4321', 'Problema ao iniciar o computador.', '2024-08-10 08:15', '2024-08-10 09:45', 'Finalizado', 'Substituição de cabo de energia.', 4),
('2024-08-10 09:45', 'Lívia Fernandes', 'livia.fernandes@example.com', '(31) 99988-7766', 'Erro ao acessar o e-mail.', '2024-08-10 10:00', '2024-08-10 12:00', 'Finalizado', 'Reconfiguração do cliente de e-mail.', 4),
('2024-08-10 12:15', 'Vinícius Rodrigues', 'vinicius.rodriques@example.com', '(11) 99887-6655', 'Rede Wi-Fi instável.', '2024-08-10 12:30', '2024-08-10 14:00', 'Finalizado', 'Reconfiguração do roteador.', 4),
('2024-08-10 14:15', 'Marta Araújo', 'marta.araujo@example.com', '(61) 98765-4321', 'Erro ao imprimir documentos.', '2024-08-10 14:30', '2024-08-10 16:00', 'Finalizado', 'Atualização dos drivers da impressora.', 4),
('2024-08-10 16:15', 'Hugo Oliveira', 'hugo.oliveira@example.com', '(71) 99988-7766', 'Problema ao acessar a VPN.', '2024-08-10 16:30', '2024-08-10 18:30', 'Finalizado', 'Configuração do cliente VPN.', 4),
('2024-08-11 08:15', 'Amanda Gomes', 'amanda.gomes@example.com', '(41) 99887-6655', 'Erro no sistema.', '2024-08-11 08:30', '2024-08-11 10:00', 'Finalizado', 'Reinstalação do sistema.', 4),
('2024-08-11 10:15', 'Eduardo Castro', 'eduardo.castro@example.com', '(51) 98765-4321', 'Computador travando.', '2024-08-11 10:30', '2024-08-11 12:30', 'Finalizado', 'Otimização do sistema operacional.', 4),
('2024-08-11 12:30', 'Renata Lima', 'renata.lima@example.com', '(11) 99988-7766', 'Problema com o software de contabilidade.', '2024-08-11 12:45', '2024-08-11 14:15', 'Finalizado', 'Atualização do software.', 4),
('2024-08-11 15:00', 'Gabriel Moreira', 'gabriel.moreira@example.com', '(21) 99887-6655', 'Erro na configuração da rede.', '2024-08-11 15:15', '2024-08-11 17:15', 'Finalizado', 'Reconfiguração das definições de rede.', 4),

-- Chamados do Usuário 5 (10 dias)
('2024-08-10 08:00', 'Antônio Souza', 'antonio.souza@example.com', '(21) 98765-4321', 'Falha no sistema de login.', '2024-08-10 08:15', '2024-08-10 09:00', 'Finalizado', 'Reset de senha e configuração.', 5),
('2024-08-10 12:45', 'Rodrigo Lima', 'rodrigo.lima@example.com', '(41) 99887-6655', 'Erro ao abrir software.', '2024-08-10 13:00', '2024-08-10 14:30', 'Finalizado', 'Reinstalação do software.', 5),
('2024-08-10 14:45', 'Tatiana Dias', 'tatiana.dias@example.com', '(51) 98765-4321', 'Computador reiniciando sozinho.', '2024-08-10 15:00', '2024-08-10 17:00', 'Finalizado', 'Troca da fonte de alimentação.', 5),
('2024-08-10 17:15', 'Marcos Nogueira', 'marcos.nogueira@example.com', '(61) 99988-7766', 'Problema ao conectar na VPN.', '2024-08-10 17:30', '2024-08-10 19:00', 'Finalizado', 'Configuração de novo cliente VPN.', 5),
('2024-08-11 08:15', 'Paula Santos', 'paula.santos@example.com', '(71) 98765-4321', 'Erro no sistema de arquivos.', '2024-08-11 08:30', '2024-08-11 10:30', 'Finalizado', 'Reparação do sistema de arquivos.', 5),
('2024-08-11 10:30', 'Tiago Almeida', 'tiago.almeida@example.com', '(81) 98765-4321', 'Problema na rede local.', '2024-08-11 10:45', '2024-08-11 12:15', 'Finalizado', 'Reconfiguração do roteador.', 5),
('2024-08-11 13:00', 'Débora Ribeiro', 'debora.ribeiro@example.com', '(91) 99988-7766', 'Computador não liga.', '2024-08-11 13:00', '2024-08-11 15:30', 'Finalizado', 'Troca do cabo de energia.', 5),
('2024-08-11 15:45', 'José Martins', 'jose.martins@example.com', '(11) 99887-6655', 'Erro ao abrir planilhas.', '2024-08-11 16:00', '2024-08-11 17:30', 'Finalizado', 'Atualização do software de planilhas.', 5),
('2024-08-11 17:15', 'Camila Costa', 'camila.costa@example.com', '(21) 98765-4321', 'Falha ao sincronizar e-mails.', '2024-08-11 17:30', '2024-08-11 19:30', 'Finalizado', 'Reconfiguração do cliente de e-mail.', 5),

-- Chamados do Usuário 6 (10 dias)
('2024-08-10 08:15', 'Daniel Freitas', 'daniel.freitas@example.com', '(31) 99988-7766', 'Erro ao acessar o sistema.', '2024-08-10 08:30', '2024-08-10 09:00', 'Finalizado', 'Redefinição de senha.', 6),
('2024-08-10 10:15', 'Roberta Silva', 'roberta.silva@example.com', '(41) 99887-6655', 'Impressora fora de rede.', '2024-08-10 10:30', '2024-08-10 11:00', 'Finalizado', 'Reconfiguração de rede da impressora.', 6),
('2024-08-10 12:45', 'Vitor Correia', 'vitor.correia@example.com', '(51) 98765-4321', 'Computador reiniciando sozinho.', '2024-08-10 13:00', '2024-08-10 14:30', 'Finalizado', 'Substituição da fonte de alimentação.', 6),
('2024-08-11 12:45', 'Elaine Costa', 'elaine.costa@example.com', '(11) 98765-4321', 'Erro ao acessar a VPN.', '2024-08-11 13:00', '2024-08-11 15:30', 'Finalizado', 'Reconfiguração da VPN.', 6),
('2024-08-11 15:45', 'André Cardoso', 'andre.cardoso@example.com', '(21) 99988-7766', 'Erro na sincronização de e-mails.', '2024-08-11 16:00', '2024-08-11 17:30', 'Finalizado', 'Reconfiguração do cliente de e-mail.', 6),
('2024-08-11 17:15', 'Fernanda Braga', 'fernanda.braga@example.com', '(31) 99887-6655', 'Problema de conexão com o servidor.', '2024-08-11 17:30', '2024-08-11 19:30', 'Finalizado', 'Reinicialização do servidor.', 6);
