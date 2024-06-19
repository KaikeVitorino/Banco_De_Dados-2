-- Criação do usuário DEMO e concessão de privilégios
CREATE USER DEMO IDENTIFIED BY DEMO;
GRANT CONNECT TO DEMO;
GRANT RESOURCE TO DEMO;
ALTER USER DEMO DEFAULT TABLESPACE USERS;
ALTER USER DEMO QUOTA UNLIMITED ON USERS;
ALTER USER DEMO TEMPORARY TABLESPACE TEMP;

-- Conectando como o usuário DEMO
CONNECT DEMO/DEMO;

-- Executando os scripts necessários
@F:/Dev_Faculdade/Banco_De_Dados-2/AmbienteAlunoConfig/BDEMOBLD_S.SQL
@F:/Dev_Faculdade/Banco_De_Dados-2/AmbienteAlunoConfig/BD_Projeto_Pedidos.SQL
