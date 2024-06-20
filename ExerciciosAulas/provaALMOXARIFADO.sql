-- Exibir dados da tabela FORNECEDOR_EXT
SELECT * FROM FORNECEDOR_EXT;

-- Exibir dados da tabela MERCADORIA
SELECT * FROM MERCADORIA;

-- Exibir dados da tabela ALMOXARIFADO
SELECT * FROM ALMOXARIFADO;

-- Exibir dados da tabela EMPREGADO
SELECT * FROM EMPREGADO;

-- Exibir dados da tabela ENTRADA_MERCADORIA
SELECT * FROM ENTRADA_MERCADORIA;

-- Exibir dados da tabela SAIDA_MERCADORIA
SELECT * FROM SAIDA_MERCADORIA;


-- Fazer uma query para selecionar os almoxarifados distintos e ativos que tiveram pelo menos uma entrada de mercadorias nos seus estoques.
-- Mostrar: CODIGO e NOME do almoxarifado.
-- Ordenação: Decrescente pelo NOME do almoxarifado.
SELECT DISTINCT
    ALMOXARIFADO.codigo,
    ALMOXARIFADO.nome
FROM
    ALMOXARIFADO
JOIN
    ENTRADA_MERCADORIA ON ALMOXARIFADO.codigo = ENTRADA_MERCADORIA.ALM_codigo
WHERE
    UPPER(TRIM(ALMOXARIFADO.situacao)) = 'ATIVO'
ORDER BY
    ALMOXARIFADO.nome DESC;

-- Fazer uma query para selecionar todas as entradas de mercadorias nos almoxarifados.
-- Mostrar: Nome do almoxarifado (ALMOXARIFADO), descrição da mercadoria (MERCADORIA), data da entrada (DATA_ENTRADA) e quantidade entrada (QDE).
-- Ordenação: Decrescente pelo nome do almoxarifado e, dentro deste, ascendente þela descrição da mercadoria.
SELECT 
    ALMOXARIFADO.nome AS ALMOXARIFADO,
    MERCADORIA.descricao AS MERCADORIA,
    ENTRADA_MERCADORIA.data AS DATA_ENTRADA,
    ENTRADA_MERCADORIA.quantidade AS QDE
FROM 
    ENTRADA_MERCADORIA
JOIN 
    ALMOXARIFADO ON ENTRADA_MERCADORIA.ALM_codigo = ALMOXARIFADO.codigo
JOIN 
    MERCADORIA ON ENTRADA_MERCADORIA.MER_codigo = MERCADORIA.codigo
ORDER BY 
    ALMOXARIFADO.nome DESC,
    MERCADORIA.descricao ASC;
    
-- Fazer uma query para selecionar as mercadorias que não possuem entradas nos almoxarifados.
-- Mostrar: CODIGO, DESCRICAO da mercadoria e unidades de medida (UNID).
-- Ordenação: crescente pelo CODIGO da mercadoria.
SELECT 
    MERCADORIA.codigo AS CODIGO,
    MERCADORIA.descricao AS DESCRICAO,
    MERCADORIA.unidade_medida AS UNID
FROM 
    MERCADORIA
LEFT JOIN 
    ENTRADA_MERCADORIA ON MERCADORIA.codigo = ENTRADA_MERCADORIA.MER_codigo
WHERE 
    ENTRADA_MERCADORIA.MER_codigo IS NULL
ORDER BY 
    MERCADORIA.codigo ASC;

-- Fazer uma query para mostrar o(s) fornecedor (es) externo(s) que menos registrou (ram) entradas de mercadorias para os almoxarifados da rede de lojas. 
-- Mostrar: CODIGO, NOME do(s) fornecedor (es) externo (s) e quantidade de registros (QDE_R).
-- Ordenação: Crescente pelo nome do fornecedor.
WITH Fornecedor_Contagem AS (
    SELECT 
        FORNECEDOR_EXT.codigo,
        FORNECEDOR_EXT.nome,
        COUNT(ENTRADA_MERCADORIA.FOR_codigo) AS QDE_R
    FROM 
        FORNECEDOR_EXT
    LEFT JOIN 
        ENTRADA_MERCADORIA ON FORNECEDOR_EXT.codigo = ENTRADA_MERCADORIA.FOR_codigo
    GROUP BY 
        FORNECEDOR_EXT.codigo, 
        FORNECEDOR_EXT.nome
)
SELECT 
    codigo,
    nome,
    QDE_R
FROM 
    Fornecedor_Contagem
WHERE 
    QDE_R = (SELECT MIN(QDE_R) FROM Fornecedor_Contagem)
ORDER BY 
    nome ASC;

-- Fazer uma query para selecionar os almoxarifados inativos (situação) localizados nos estados (UF) de São Paulo (SP) ou Goiás (GO).
-- Mostrar: Nome do almoxarifado (ALMOXARIFADO) e a cidade em que está localizado (CIDADE)
-- Ordenação: Crescente pelo nome do almoxarifado.
SELECT 
    nome AS ALMOXARIFADO,
    cidade AS CIDADE
FROM 
    ALMOXARIFADO
WHERE 
    situacao = 'Inativo'
    AND UF IN ('SP', 'GO')
ORDER BY 
    nome ASC;
