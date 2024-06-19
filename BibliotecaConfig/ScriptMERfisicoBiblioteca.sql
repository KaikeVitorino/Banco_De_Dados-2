-- Cria a tabela USUARIO para armazenar informa��es sobre os usu�rios da biblioteca
CREATE TABLE USUARIO (
    CODIGO NUMBER PRIMARY KEY,  -- C�digo �nico para identificar o usu�rio
    NOME VARCHAR2(80) NOT NULL  -- Nome do usu�rio
);

-- Cria a tabela BIBLIOTECARIO para armazenar informa��es sobre os bibliotec�rios
CREATE TABLE BIBLIOTECARIO (
    CODIGO NUMBER PRIMARY KEY,  -- C�digo �nico para identificar o bibliotec�rio
    NOME VARCHAR2(60) NOT NULL  -- Nome do bibliotec�rio
);

-- Cria a tabela AUTOR para armazenar informa��es sobre os autores dos livros
CREATE TABLE AUTOR (
    CODIGO NUMBER PRIMARY KEY,  -- C�digo �nico para identificar o autor
    NOME VARCHAR2(80) NOT NULL  -- Nome do autor
);

-- Cria a tabela CIDADE para armazenar informa��es sobre as cidades de publica��o
CREATE TABLE CIDADE (
    CODIGO NUMBER PRIMARY KEY,  -- C�digo �nico para identificar a cidade
    NOME VARCHAR2(60) NOT NULL, -- Nome da cidade
    UF VARCHAR2(2) NOT NULL     -- Unidade Federativa (estado) da cidade
);

-- Cria a tabela TITULO para armazenar informa��es sobre os t�tulos dos livros
CREATE TABLE TITULO (
    CODIGO NUMBER PRIMARY KEY,  -- C�digo �nico para identificar o t�tulo
    DESCRICAO VARCHAR2(100) NOT NULL  -- Descri��o do t�tulo
);

-- Cria a tabela PUBLICACAO para armazenar informa��es sobre as publica��es dos livros
CREATE TABLE PUBLICACAO (
    CODIGO NUMBER PRIMARY KEY,  -- C�digo �nico para identificar a publica��o
    ANO VARCHAR2(4) NOT NULL,   -- Ano de publica��o
    EDICAO VARCHAR2(4) NOT NULL, -- Edi��o da publica��o
    AREA VARCHAR2(50),          -- �rea do conhecimento da publica��o
    RESUMO VARCHAR2(2000),      -- Resumo da publica��o
    CD_TIT NUMBER NOT NULL,     -- C�digo do t�tulo da publica��o (chave estrangeira)
    CD_CID NUMBER NOT NULL,     -- C�digo da cidade da publica��o (chave estrangeira)
    CD_AUT NUMBER NOT NULL,     -- C�digo do autor da publica��o (chave estrangeira)
    FOREIGN KEY (CD_TIT) REFERENCES TITULO(CODIGO),  -- Define chave estrangeira para TITULO
    FOREIGN KEY (CD_CID) REFERENCES CIDADE(CODIGO),  -- Define chave estrangeira para CIDADE
    FOREIGN KEY (CD_AUT) REFERENCES AUTOR(CODIGO)    -- Define chave estrangeira para AUTOR
);

-- Cria a tabela LIVRO para armazenar informa��es sobre os livros
CREATE TABLE LIVRO (
    CODIGO NUMBER PRIMARY KEY,  -- C�digo �nico para identificar o livro
    VOLUME NUMBER(3),           -- Volume do livro
    PAGINAS NUMBER(3),          -- N�mero de p�ginas do livro
    SITUACAO VARCHAR2(500),     -- Situa��o do livro (por exemplo, dispon�vel, emprestado)
    OBSERVACOES VARCHAR2(500),  -- Observa��es sobre o livro
    CD_PUB NUMBER,              -- C�digo da publica��o associada (chave estrangeira)
    FOREIGN KEY (CD_PUB) REFERENCES PUBLICACAO(CODIGO)  -- Define chave estrangeira para PUBLICACAO
);

-- Cria a tabela EMPRESTIMO para armazenar informa��es sobre os empr�stimos de livros
CREATE TABLE EMPRESTIMO (
    CODIGO NUMBER PRIMARY KEY,  -- C�digo �nico para identificar o empr�stimo
    DT_EMPRESTIMO DATE NOT NULL, -- Data do empr�stimo
    DT_DEVOLUCAO DATE,          -- Data de devolu��o
    OBSERVACOES VARCHAR2(200),  -- Observa��es sobre o empr�stimo
    CD_USR NUMBER NOT NULL,     -- C�digo do usu�rio que fez o empr�stimo (chave estrangeira)
    CD_BIB NUMBER NOT NULL,     -- C�digo do bibliotec�rio respons�vel (chave estrangeira)
    CD_LIV NUMBER NOT NULL,     -- C�digo do livro emprestado (chave estrangeira)
    FOREIGN KEY (CD_USR) REFERENCES USUARIO(CODIGO),  -- Define chave estrangeira para USUARIO
    FOREIGN KEY (CD_BIB) REFERENCES BIBLIOTECARIO(CODIGO),  -- Define chave estrangeira para BIBLIOTECARIO
    FOREIGN KEY (CD_LIV) REFERENCES LIVRO(CODIGO)  -- Define chave estrangeira para LIVRO
);

-- Cria a tabela associativa FK_EMPR_USUARIO para relacionar EMPRESTIMO e USUARIO
CREATE TABLE FK_EMPR_USUARIO (
    CD_EMPRESTIMO NUMBER NOT NULL,  -- C�digo do empr�stimo (chave estrangeira)
    CD_USR NUMBER NOT NULL,         -- C�digo do usu�rio (chave estrangeira)
    PRIMARY KEY (CD_EMPRESTIMO, CD_USR),  -- Define a combina��o das chaves como prim�ria
    FOREIGN KEY (CD_EMPRESTIMO) REFERENCES EMPRESTIMO(CODIGO),  -- Define chave estrangeira para EMPRESTIMO
    FOREIGN KEY (CD_USR) REFERENCES USUARIO(CODIGO)  -- Define chave estrangeira para USUARIO
);

-- Cria a tabela associativa FK_EMPR_BIBLIOTECARIO para relacionar EMPRESTIMO e BIBLIOTECARIO
CREATE TABLE FK_EMPR_BIBLIOTECARIO (
    CD_EMPRESTIMO NUMBER NOT NULL,  -- C�digo do empr�stimo (chave estrangeira)
    CD_BIB NUMBER NOT NULL,         -- C�digo do bibliotec�rio (chave estrangeira)
    PRIMARY KEY (CD_EMPRESTIMO, CD_BIB),  -- Define a combina��o das chaves como prim�ria
    FOREIGN KEY (CD_EMPRESTIMO) REFERENCES EMPRESTIMO(CODIGO),  -- Define chave estrangeira para EMPRESTIMO
    FOREIGN KEY (CD_BIB) REFERENCES BIBLIOTECARIO(CODIGO)  -- Define chave estrangeira para BIBLIOTECARIO
);

-- Cria a tabela associativa FK_EMPR_LIVRO para relacionar EMPRESTIMO e LIVRO
CREATE TABLE FK_EMPR_LIVRO (
    CD_EMPRESTIMO NUMBER NOT NULL,  -- C�digo do empr�stimo (chave estrangeira)
    CD_LIV NUMBER NOT NULL,         -- C�digo do livro (chave estrangeira)
    PRIMARY KEY (CD_EMPRESTIMO, CD_LIV),  -- Define a combina��o das chaves como prim�ria
    FOREIGN KEY (CD_EMPRESTIMO) REFERENCES EMPRESTIMO(CODIGO),  -- Define chave estrangeira para EMPRESTIMO
    FOREIGN KEY (CD_LIV) REFERENCES LIVRO(CODIGO)  -- Define chave estrangeira para LIVRO
);

-- Cria a tabela associativa FK_LIVRO_PUBLICACAO para relacionar LIVRO e PUBLICACAO
CREATE TABLE FK_LIVRO_PUBLICACAO (
    CD_LIV NUMBER NOT NULL,         -- C�digo do livro (chave estrangeira)
    CD_PUB NUMBER NOT NULL,         -- C�digo da publica��o (chave estrangeira)
    PRIMARY KEY (CD_LIV, CD_PUB),   -- Define a combina��o das chaves como prim�ria
    FOREIGN KEY (CD_LIV) REFERENCES LIVRO(CODIGO),  -- Define chave estrangeira para LIVRO
    FOREIGN KEY (CD_PUB) REFERENCES PUBLICACAO(CODIGO)  -- Define chave estrangeira para PUBLICACAO
);

-- Cria a tabela associativa FK_PUB_TITULO para relacionar PUBLICACAO e TITULO
CREATE TABLE FK_PUB_TITULO (
    CD_PUB NUMBER NOT NULL,         -- C�digo da publica��o (chave estrangeira)
    CD_TIT NUMBER NOT NULL,         -- C�digo do t�tulo (chave estrangeira)
    PRIMARY KEY (CD_PUB, CD_TIT),   -- Define a combina��o das chaves como prim�ria
    FOREIGN KEY (CD_PUB) REFERENCES PUBLICACAO(CODIGO),  -- Define chave estrangeira para PUBLICACAO
    FOREIGN KEY (CD_TIT) REFERENCES TITULO(CODIGO)  -- Define chave estrangeira para TITULO
);

-- Cria a tabela associativa FK_PUB_CIDADE para relacionar PUBLICACAO e CIDADE
CREATE TABLE FK_PUB_CIDADE (
    CD_PUB NUMBER NOT NULL,         -- C�digo da publica��o (chave estrangeira)
    CD_CID NUMBER NOT NULL,         -- C�digo da cidade (chave estrangeira)
    PRIMARY KEY (CD_PUB, CD_CID),   -- Define a combina��o das chaves como prim�ria
    FOREIGN KEY (CD_PUB) REFERENCES PUBLICACAO(CODIGO),  -- Define chave estrangeira para PUBLICACAO
    FOREIGN KEY (CD_CID) REFERENCES CIDADE(CODIGO)  -- Define chave estrangeira para CIDADE
);

-- Cria a tabela associativa FK_PUB_AUTOR para relacionar PUBLICACAO e AUTOR
CREATE TABLE FK_PUB_AUTOR (
    CD_PUB NUMBER NOT NULL,         -- C�digo da publica��o (chave estrangeira)
    CD_AUT NUMBER NOT NULL,         -- C�digo do autor (chave estrangeira)
    PRIMARY KEY (CD_PUB, CD_AUT),   -- Define a combina��o das chaves como prim�ria
    FOREIGN KEY (CD_PUB) REFERENCES PUBLICACAO(CODIGO),  -- Define chave estrangeira para PUBLICACAO
    FOREIGN KEY (CD_AUT) REFERENCES AUTOR(CODIGO)  -- Define chave estrangeira para AUTOR
);
