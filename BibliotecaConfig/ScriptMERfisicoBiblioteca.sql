-- Cria a tabela USUARIO para armazenar informações sobre os usuários da biblioteca
CREATE TABLE USUARIO (
    CODIGO NUMBER PRIMARY KEY,  -- Código único para identificar o usuário
    NOME VARCHAR2(80) NOT NULL  -- Nome do usuário
);

-- Cria a tabela BIBLIOTECARIO para armazenar informações sobre os bibliotecários
CREATE TABLE BIBLIOTECARIO (
    CODIGO NUMBER PRIMARY KEY,  -- Código único para identificar o bibliotecário
    NOME VARCHAR2(60) NOT NULL  -- Nome do bibliotecário
);

-- Cria a tabela AUTOR para armazenar informações sobre os autores dos livros
CREATE TABLE AUTOR (
    CODIGO NUMBER PRIMARY KEY,  -- Código único para identificar o autor
    NOME VARCHAR2(80) NOT NULL  -- Nome do autor
);

-- Cria a tabela CIDADE para armazenar informações sobre as cidades de publicação
CREATE TABLE CIDADE (
    CODIGO NUMBER PRIMARY KEY,  -- Código único para identificar a cidade
    NOME VARCHAR2(60) NOT NULL, -- Nome da cidade
    UF VARCHAR2(2) NOT NULL     -- Unidade Federativa (estado) da cidade
);

-- Cria a tabela TITULO para armazenar informações sobre os títulos dos livros
CREATE TABLE TITULO (
    CODIGO NUMBER PRIMARY KEY,  -- Código único para identificar o título
    DESCRICAO VARCHAR2(100) NOT NULL  -- Descrição do título
);

-- Cria a tabela PUBLICACAO para armazenar informações sobre as publicações dos livros
CREATE TABLE PUBLICACAO (
    CODIGO NUMBER PRIMARY KEY,  -- Código único para identificar a publicação
    ANO VARCHAR2(4) NOT NULL,   -- Ano de publicação
    EDICAO VARCHAR2(4) NOT NULL, -- Edição da publicação
    AREA VARCHAR2(50),          -- Área do conhecimento da publicação
    RESUMO VARCHAR2(2000),      -- Resumo da publicação
    CD_TIT NUMBER NOT NULL,     -- Código do título da publicação (chave estrangeira)
    CD_CID NUMBER NOT NULL,     -- Código da cidade da publicação (chave estrangeira)
    CD_AUT NUMBER NOT NULL,     -- Código do autor da publicação (chave estrangeira)
    FOREIGN KEY (CD_TIT) REFERENCES TITULO(CODIGO),  -- Define chave estrangeira para TITULO
    FOREIGN KEY (CD_CID) REFERENCES CIDADE(CODIGO),  -- Define chave estrangeira para CIDADE
    FOREIGN KEY (CD_AUT) REFERENCES AUTOR(CODIGO)    -- Define chave estrangeira para AUTOR
);

-- Cria a tabela LIVRO para armazenar informações sobre os livros
CREATE TABLE LIVRO (
    CODIGO NUMBER PRIMARY KEY,  -- Código único para identificar o livro
    VOLUME NUMBER(3),           -- Volume do livro
    PAGINAS NUMBER(3),          -- Número de páginas do livro
    SITUACAO VARCHAR2(500),     -- Situação do livro (por exemplo, disponível, emprestado)
    OBSERVACOES VARCHAR2(500),  -- Observações sobre o livro
    CD_PUB NUMBER,              -- Código da publicação associada (chave estrangeira)
    FOREIGN KEY (CD_PUB) REFERENCES PUBLICACAO(CODIGO)  -- Define chave estrangeira para PUBLICACAO
);

-- Cria a tabela EMPRESTIMO para armazenar informações sobre os empréstimos de livros
CREATE TABLE EMPRESTIMO (
    CODIGO NUMBER PRIMARY KEY,  -- Código único para identificar o empréstimo
    DT_EMPRESTIMO DATE NOT NULL, -- Data do empréstimo
    DT_DEVOLUCAO DATE,          -- Data de devolução
    OBSERVACOES VARCHAR2(200),  -- Observações sobre o empréstimo
    CD_USR NUMBER NOT NULL,     -- Código do usuário que fez o empréstimo (chave estrangeira)
    CD_BIB NUMBER NOT NULL,     -- Código do bibliotecário responsável (chave estrangeira)
    CD_LIV NUMBER NOT NULL,     -- Código do livro emprestado (chave estrangeira)
    FOREIGN KEY (CD_USR) REFERENCES USUARIO(CODIGO),  -- Define chave estrangeira para USUARIO
    FOREIGN KEY (CD_BIB) REFERENCES BIBLIOTECARIO(CODIGO),  -- Define chave estrangeira para BIBLIOTECARIO
    FOREIGN KEY (CD_LIV) REFERENCES LIVRO(CODIGO)  -- Define chave estrangeira para LIVRO
);

-- Cria a tabela associativa FK_EMPR_USUARIO para relacionar EMPRESTIMO e USUARIO
CREATE TABLE FK_EMPR_USUARIO (
    CD_EMPRESTIMO NUMBER NOT NULL,  -- Código do empréstimo (chave estrangeira)
    CD_USR NUMBER NOT NULL,         -- Código do usuário (chave estrangeira)
    PRIMARY KEY (CD_EMPRESTIMO, CD_USR),  -- Define a combinação das chaves como primária
    FOREIGN KEY (CD_EMPRESTIMO) REFERENCES EMPRESTIMO(CODIGO),  -- Define chave estrangeira para EMPRESTIMO
    FOREIGN KEY (CD_USR) REFERENCES USUARIO(CODIGO)  -- Define chave estrangeira para USUARIO
);

-- Cria a tabela associativa FK_EMPR_BIBLIOTECARIO para relacionar EMPRESTIMO e BIBLIOTECARIO
CREATE TABLE FK_EMPR_BIBLIOTECARIO (
    CD_EMPRESTIMO NUMBER NOT NULL,  -- Código do empréstimo (chave estrangeira)
    CD_BIB NUMBER NOT NULL,         -- Código do bibliotecário (chave estrangeira)
    PRIMARY KEY (CD_EMPRESTIMO, CD_BIB),  -- Define a combinação das chaves como primária
    FOREIGN KEY (CD_EMPRESTIMO) REFERENCES EMPRESTIMO(CODIGO),  -- Define chave estrangeira para EMPRESTIMO
    FOREIGN KEY (CD_BIB) REFERENCES BIBLIOTECARIO(CODIGO)  -- Define chave estrangeira para BIBLIOTECARIO
);

-- Cria a tabela associativa FK_EMPR_LIVRO para relacionar EMPRESTIMO e LIVRO
CREATE TABLE FK_EMPR_LIVRO (
    CD_EMPRESTIMO NUMBER NOT NULL,  -- Código do empréstimo (chave estrangeira)
    CD_LIV NUMBER NOT NULL,         -- Código do livro (chave estrangeira)
    PRIMARY KEY (CD_EMPRESTIMO, CD_LIV),  -- Define a combinação das chaves como primária
    FOREIGN KEY (CD_EMPRESTIMO) REFERENCES EMPRESTIMO(CODIGO),  -- Define chave estrangeira para EMPRESTIMO
    FOREIGN KEY (CD_LIV) REFERENCES LIVRO(CODIGO)  -- Define chave estrangeira para LIVRO
);

-- Cria a tabela associativa FK_LIVRO_PUBLICACAO para relacionar LIVRO e PUBLICACAO
CREATE TABLE FK_LIVRO_PUBLICACAO (
    CD_LIV NUMBER NOT NULL,         -- Código do livro (chave estrangeira)
    CD_PUB NUMBER NOT NULL,         -- Código da publicação (chave estrangeira)
    PRIMARY KEY (CD_LIV, CD_PUB),   -- Define a combinação das chaves como primária
    FOREIGN KEY (CD_LIV) REFERENCES LIVRO(CODIGO),  -- Define chave estrangeira para LIVRO
    FOREIGN KEY (CD_PUB) REFERENCES PUBLICACAO(CODIGO)  -- Define chave estrangeira para PUBLICACAO
);

-- Cria a tabela associativa FK_PUB_TITULO para relacionar PUBLICACAO e TITULO
CREATE TABLE FK_PUB_TITULO (
    CD_PUB NUMBER NOT NULL,         -- Código da publicação (chave estrangeira)
    CD_TIT NUMBER NOT NULL,         -- Código do título (chave estrangeira)
    PRIMARY KEY (CD_PUB, CD_TIT),   -- Define a combinação das chaves como primária
    FOREIGN KEY (CD_PUB) REFERENCES PUBLICACAO(CODIGO),  -- Define chave estrangeira para PUBLICACAO
    FOREIGN KEY (CD_TIT) REFERENCES TITULO(CODIGO)  -- Define chave estrangeira para TITULO
);

-- Cria a tabela associativa FK_PUB_CIDADE para relacionar PUBLICACAO e CIDADE
CREATE TABLE FK_PUB_CIDADE (
    CD_PUB NUMBER NOT NULL,         -- Código da publicação (chave estrangeira)
    CD_CID NUMBER NOT NULL,         -- Código da cidade (chave estrangeira)
    PRIMARY KEY (CD_PUB, CD_CID),   -- Define a combinação das chaves como primária
    FOREIGN KEY (CD_PUB) REFERENCES PUBLICACAO(CODIGO),  -- Define chave estrangeira para PUBLICACAO
    FOREIGN KEY (CD_CID) REFERENCES CIDADE(CODIGO)  -- Define chave estrangeira para CIDADE
);

-- Cria a tabela associativa FK_PUB_AUTOR para relacionar PUBLICACAO e AUTOR
CREATE TABLE FK_PUB_AUTOR (
    CD_PUB NUMBER NOT NULL,         -- Código da publicação (chave estrangeira)
    CD_AUT NUMBER NOT NULL,         -- Código do autor (chave estrangeira)
    PRIMARY KEY (CD_PUB, CD_AUT),   -- Define a combinação das chaves como primária
    FOREIGN KEY (CD_PUB) REFERENCES PUBLICACAO(CODIGO),  -- Define chave estrangeira para PUBLICACAO
    FOREIGN KEY (CD_AUT) REFERENCES AUTOR(CODIGO)  -- Define chave estrangeira para AUTOR
);
