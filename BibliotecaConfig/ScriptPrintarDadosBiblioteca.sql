-- Listar todas as tabelas no esquema atual
SELECT table_name
FROM user_tables
WHERE table_name IN ('USUARIO', 'BIBLIOTECARIO', 'AUTOR', 'CIDADE', 'TITULO', 'PUBLICACAO', 'LIVRO', 'EMPRESTIMO', 'FK_EMPR_USUARIO', 'FK_EMPR_BIBLIOTECARIO', 'FK_EMPR_LIVRO', 'FK_LIVRO_PUBLICACAO', 'FK_PUB_TITULO', 'FK_PUB_CIDADE', 'FK_PUB_AUTOR')
ORDER BY table_name;

-- Listar todas as colunas de todas as tabelas no esquema atual
SELECT table_name, column_name, data_type, data_length, nullable
FROM user_tab_columns
WHERE table_name IN ('USUARIO', 'BIBLIOTECARIO', 'AUTOR', 'CIDADE', 'TITULO', 'PUBLICACAO', 'LIVRO', 'EMPRESTIMO', 'FK_EMPR_USUARIO', 'FK_EMPR_BIBLIOTECARIO', 'FK_EMPR_LIVRO', 'FK_LIVRO_PUBLICACAO', 'FK_PUB_TITULO', 'FK_PUB_CIDADE', 'FK_PUB_AUTOR')
ORDER BY table_name, column_id;

-- Listar todas as chaves estrangeiras no esquema atual
SELECT a.constraint_name, a.table_name, a.column_name, c_pk.table_name r_table_name, b_pk.column_name r_column_name
FROM user_cons_columns a
JOIN user_constraints b ON a.constraint_name = b.constraint_name
JOIN user_cons_columns b_pk ON b.r_constraint_name = b_pk.constraint_name AND a.position = b_pk.position
JOIN user_constraints c_pk ON b.r_constraint_name = c_pk.constraint_name
WHERE b.constraint_type = 'R'
AND a.table_name IN ('USUARIO', 'BIBLIOTECARIO', 'AUTOR', 'CIDADE', 'TITULO', 'PUBLICACAO', 'LIVRO', 'EMPRESTIMO', 'FK_EMPR_USUARIO', 'FK_EMPR_BIBLIOTECARIO', 'FK_EMPR_LIVRO', 'FK_LIVRO_PUBLICACAO', 'FK_PUB_TITULO', 'FK_PUB_CIDADE', 'FK_PUB_AUTOR')
ORDER BY a.table_name, a.column_name;

-- Listar todas as constraints (restrições) no esquema atual
SELECT constraint_name, constraint_type, table_name
FROM user_constraints
WHERE table_name IN ('USUARIO', 'BIBLIOTECARIO', 'AUTOR', 'CIDADE', 'TITULO', 'PUBLICACAO', 'LIVRO', 'EMPRESTIMO', 'FK_EMPR_USUARIO', 'FK_EMPR_BIBLIOTECARIO', 'FK_EMPR_LIVRO', 'FK_LIVRO_PUBLICACAO', 'FK_PUB_TITULO', 'FK_PUB_CIDADE', 'FK_PUB_AUTOR')
ORDER BY table_name, constraint_name;

-- Listar todas as views no esquema atual
SELECT view_name
FROM user_views
ORDER BY view_name;

-- Listar todas as sequences no esquema atual
SELECT sequence_name
FROM user_sequences
ORDER BY sequence_name;

-- Listar todas as triggers no esquema atual
SELECT trigger_name, table_name, description
FROM user_triggers
ORDER BY table_name, trigger_name;

-- Listar todas as procedures e functions no esquema atual
SELECT object_name, object_type
FROM user_objects
WHERE object_type IN ('PROCEDURE', 'FUNCTION')
ORDER BY object_type, object_name;

-- Listar todos os índices no esquema atual
SELECT index_name, table_name, uniqueness
FROM user_indexes
WHERE table_name IN ('USUARIO', 'BIBLIOTECARIO', 'AUTOR', 'CIDADE', 'TITULO', 'PUBLICACAO', 'LIVRO', 'EMPRESTIMO', 'FK_EMPR_USUARIO', 'FK_EMPR_BIBLIOTECARIO', 'FK_EMPR_LIVRO', 'FK_LIVRO_PUBLICACAO', 'FK_PUB_TITULO', 'FK_PUB_CIDADE', 'FK_PUB_AUTOR')
ORDER BY table_name, index_name;

-- Listar todas as constraints com detalhes
SELECT 
    uc.constraint_name, 
    uc.constraint_type, 
    ucc.table_name, 
    ucc.column_name, 
    uc.status 
FROM 
    user_constraints uc 
JOIN 
    user_cons_columns ucc 
ON 
    uc.constraint_name = ucc.constraint_name 
WHERE 
    ucc.table_name IN ('USUARIO', 'BIBLIOTECARIO', 'AUTOR', 'CIDADE', 'TITULO', 'PUBLICACAO', 'LIVRO', 'EMPRESTIMO', 'FK_EMPR_USUARIO', 'FK_EMPR_BIBLIOTECARIO', 'FK_EMPR_LIVRO', 'FK_LIVRO_PUBLICACAO', 'FK_PUB_TITULO', 'FK_PUB_CIDADE', 'FK_PUB_AUTOR')
ORDER BY 
    ucc.table_name, uc.constraint_type, uc.constraint_name;
