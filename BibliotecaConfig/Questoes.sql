-- Query 1: Selecionar as publica��es existentes na biblioteca.
-- Mostrar: Nome do autor (AUTOR), t�tulo do livro (TITULO), cidade da publica��o (CIDADE), edi��o (ED), unidade da federa��o (UF) e ano da publica��o (ANO).
-- Ordena��o: Decrescente pelo nome do autor e ascendente pelo ano da publica��o.
SELECT 
    AUTOR.NOME AS AUTOR,          -- Nome do autor
    TITULO.DESCRICAO AS TITULO,   -- T�tulo do livro
    CIDADE.NOME AS CIDADE,        -- Cidade da publica��o
    PUBLICACAO.EDICAO AS ED,      -- Edi��o
    CIDADE.UF AS UF,              -- Unidade da federa��o
    PUBLICACAO.ANO AS ANO         -- Ano da publica��o
FROM 
    PUBLICACAO
JOIN 
    AUTOR ON PUBLICACAO.CD_AUT = AUTOR.CODIGO
JOIN 
    TITULO ON PUBLICACAO.CD_TIT = TITULO.CODIGO
JOIN 
    CIDADE ON PUBLICACAO.CD_CID = CIDADE.CODIGO
ORDER BY 
    AUTOR.NOME DESC,              -- Ordena��o decrescente pelo nome do autor
    PUBLICACAO.ANO ASC;           -- Ordena��o ascendente pelo ano da publica��o

-- Query 2: Selecionar a quantidade de empr�stimos sem devolu��o por usu�rio.
-- Mostrar: O nome do usu�rio (USU�RIO) e QDE_ESD (Quantidade de Empr�stimos Sem Devolu��o).
-- Ordena��o: Descendente pela quantidade de empr�stimos sem devolu��o (QDE_ESD).
SELECT 
    USUARIO.NOME AS USUARIO,      -- Nome do usu�rio
    COUNT(EMPRESTIMO.CODIGO) AS QDE_ESD -- Quantidade de empr�stimos sem devolu��o
FROM 
    EMPRESTIMO
JOIN 
    USUARIO ON EMPRESTIMO.CD_USR = USUARIO.CODIGO
WHERE 
    EMPRESTIMO.DT_DEVOLUCAO IS NULL -- Filtro para empr�stimos sem devolu��o
GROUP BY 
    USUARIO.NOME
ORDER BY 
    QDE_ESD DESC;                -- Ordena��o descendente pela quantidade de empr�stimos sem devolu��o

-- Query 3: Selecionar os bibliotec�rios que n�o realizaram empr�stimos na biblioteca.
-- Mostrar: O c�digo do bibliotec�rio (CODIGO) e nome do bibliotec�rio (BIBLIOTECARIO).
-- Ordena��o: Ascendente pelo c�digo do bibliotec�rio.
SELECT 
    BIBLIOTECARIO.CODIGO,        -- C�digo do bibliotec�rio
    BIBLIOTECARIO.NOME AS BIBLIOTECARIO -- Nome do bibliotec�rio
FROM 
    BIBLIOTECARIO
LEFT JOIN 
    EMPRESTIMO ON BIBLIOTECARIO.CODIGO = EMPRESTIMO.CD_BIB
WHERE 
    EMPRESTIMO.CODIGO IS NULL    -- Filtro para bibliotec�rios sem empr�stimos
ORDER BY 
    BIBLIOTECARIO.CODIGO ASC;    -- Ordena��o ascendente pelo c�digo do bibliotec�rio

-- Query 4: Selecionar os livros com situa��o dispon�vel.
-- Mostrar: C�digo e observa��es dos livros.
-- Ordena��o: Ascendente pelo c�digo do livro.
SELECT 
    LIVRO.CODIGO,                -- C�digo do livro
    LIVRO.OBSERVACOES            -- Observa��es sobre o livro
FROM 
    LIVRO
WHERE 
    LIVRO.SITUACAO = 'Available' -- Filtro para livros dispon�veis
ORDER BY 
    LIVRO.CODIGO ASC;            -- Ordena��o ascendente pelo c�digo do livro

-- Query 5: Selecionar os empr�stimos sem devolu��o.
-- Mostrar: Nome do usu�rio (USUARIO), nome do bibliotec�rio (BIBLIOTECARIO), c�digo do livro (LIVRO) e data do empr�stimo (DATA EMPRESTIMO).
-- Ordena��o: Crescente pelo nome do usu�rio.
SELECT 
    USUARIO.NOME AS USUARIO,     -- Nome do usu�rio
    BIBLIOTECARIO.NOME AS BIBLIOTECARIO, -- Nome do bibliotec�rio
    LIVRO.CODIGO AS LIVRO,       -- C�digo do livro
    EMPRESTIMO.DT_EMPRESTIMO AS DATA_EMPRESTIMO -- Data do empr�stimo
FROM 
    EMPRESTIMO
JOIN 
    USUARIO ON EMPRESTIMO.CD_USR = USUARIO.CODIGO
JOIN 
    BIBLIOTECARIO ON EMPRESTIMO.CD_BIB = BIBLIOTECARIO.CODIGO
JOIN 
    LIVRO ON EMPRESTIMO.CD_LIV = LIVRO.CODIGO
WHERE 
    EMPRESTIMO.DT_DEVOLUCAO IS NULL -- Filtro para empr�stimos sem devolu��o
ORDER BY 
    USUARIO.NOME ASC;            -- Ordena��o crescente pelo nome do usu�rio
