-- Query 1: Selecionar as publicações existentes na biblioteca.
-- Mostrar: Nome do autor (AUTOR), título do livro (TITULO), cidade da publicação (CIDADE), edição (ED), unidade da federação (UF) e ano da publicação (ANO).
-- Ordenação: Decrescente pelo nome do autor e ascendente pelo ano da publicação.
SELECT 
    AUTOR.NOME AS AUTOR,          -- Nome do autor
    TITULO.DESCRICAO AS TITULO,   -- Título do livro
    CIDADE.NOME AS CIDADE,        -- Cidade da publicação
    PUBLICACAO.EDICAO AS ED,      -- Edição
    CIDADE.UF AS UF,              -- Unidade da federação
    PUBLICACAO.ANO AS ANO         -- Ano da publicação
FROM 
    PUBLICACAO
JOIN 
    AUTOR ON PUBLICACAO.CD_AUT = AUTOR.CODIGO
JOIN 
    TITULO ON PUBLICACAO.CD_TIT = TITULO.CODIGO
JOIN 
    CIDADE ON PUBLICACAO.CD_CID = CIDADE.CODIGO
ORDER BY 
    AUTOR.NOME DESC,              -- Ordenação decrescente pelo nome do autor
    PUBLICACAO.ANO ASC;           -- Ordenação ascendente pelo ano da publicação

-- Query 2: Selecionar a quantidade de empréstimos sem devolução por usuário.
-- Mostrar: O nome do usuário (USUÁRIO) e QDE_ESD (Quantidade de Empréstimos Sem Devolução).
-- Ordenação: Descendente pela quantidade de empréstimos sem devolução (QDE_ESD).
SELECT 
    USUARIO.NOME AS USUARIO,      -- Nome do usuário
    COUNT(EMPRESTIMO.CODIGO) AS QDE_ESD -- Quantidade de empréstimos sem devolução
FROM 
    EMPRESTIMO
JOIN 
    USUARIO ON EMPRESTIMO.CD_USR = USUARIO.CODIGO
WHERE 
    EMPRESTIMO.DT_DEVOLUCAO IS NULL -- Filtro para empréstimos sem devolução
GROUP BY 
    USUARIO.NOME
ORDER BY 
    QDE_ESD DESC;                -- Ordenação descendente pela quantidade de empréstimos sem devolução

-- Query 3: Selecionar os bibliotecários que não realizaram empréstimos na biblioteca.
-- Mostrar: O código do bibliotecário (CODIGO) e nome do bibliotecário (BIBLIOTECARIO).
-- Ordenação: Ascendente pelo código do bibliotecário.
SELECT 
    BIBLIOTECARIO.CODIGO,        -- Código do bibliotecário
    BIBLIOTECARIO.NOME AS BIBLIOTECARIO -- Nome do bibliotecário
FROM 
    BIBLIOTECARIO
LEFT JOIN 
    EMPRESTIMO ON BIBLIOTECARIO.CODIGO = EMPRESTIMO.CD_BIB
WHERE 
    EMPRESTIMO.CODIGO IS NULL    -- Filtro para bibliotecários sem empréstimos
ORDER BY 
    BIBLIOTECARIO.CODIGO ASC;    -- Ordenação ascendente pelo código do bibliotecário

-- Query 4: Selecionar os livros com situação disponível.
-- Mostrar: Código e observações dos livros.
-- Ordenação: Ascendente pelo código do livro.
SELECT 
    LIVRO.CODIGO,                -- Código do livro
    LIVRO.OBSERVACOES            -- Observações sobre o livro
FROM 
    LIVRO
WHERE 
    LIVRO.SITUACAO = 'Available' -- Filtro para livros disponíveis
ORDER BY 
    LIVRO.CODIGO ASC;            -- Ordenação ascendente pelo código do livro

-- Query 5: Selecionar os empréstimos sem devolução.
-- Mostrar: Nome do usuário (USUARIO), nome do bibliotecário (BIBLIOTECARIO), código do livro (LIVRO) e data do empréstimo (DATA EMPRESTIMO).
-- Ordenação: Crescente pelo nome do usuário.
SELECT 
    USUARIO.NOME AS USUARIO,     -- Nome do usuário
    BIBLIOTECARIO.NOME AS BIBLIOTECARIO, -- Nome do bibliotecário
    LIVRO.CODIGO AS LIVRO,       -- Código do livro
    EMPRESTIMO.DT_EMPRESTIMO AS DATA_EMPRESTIMO -- Data do empréstimo
FROM 
    EMPRESTIMO
JOIN 
    USUARIO ON EMPRESTIMO.CD_USR = USUARIO.CODIGO
JOIN 
    BIBLIOTECARIO ON EMPRESTIMO.CD_BIB = BIBLIOTECARIO.CODIGO
JOIN 
    LIVRO ON EMPRESTIMO.CD_LIV = LIVRO.CODIGO
WHERE 
    EMPRESTIMO.DT_DEVOLUCAO IS NULL -- Filtro para empréstimos sem devolução
ORDER BY 
    USUARIO.NOME ASC;            -- Ordenação crescente pelo nome do usuário
