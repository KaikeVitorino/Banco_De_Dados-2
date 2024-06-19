-- Drop associative tables first
DROP TABLE FK_EMPR_USUARIO CASCADE CONSTRAINTS;
DROP TABLE FK_EMPR_BIBLIOTECARIO CASCADE CONSTRAINTS;
DROP TABLE FK_EMPR_LIVRO CASCADE CONSTRAINTS;
DROP TABLE FK_LIVRO_PUBLICACAO CASCADE CONSTRAINTS;
DROP TABLE FK_PUB_TITULO CASCADE CONSTRAINTS;
DROP TABLE FK_PUB_CIDADE CASCADE CONSTRAINTS;
DROP TABLE FK_PUB_AUTOR CASCADE CONSTRAINTS;

-- Drop main tables
DROP TABLE EMPRESTIMO CASCADE CONSTRAINTS;
DROP TABLE LIVRO CASCADE CONSTRAINTS;
DROP TABLE PUBLICACAO CASCADE CONSTRAINTS;
DROP TABLE TITULO CASCADE CONSTRAINTS;
DROP TABLE CIDADE CASCADE CONSTRAINTS;
DROP TABLE AUTOR CASCADE CONSTRAINTS;
DROP TABLE BIBLIOTECARIO CASCADE CONSTRAINTS;
DROP TABLE USUARIO CASCADE CONSTRAINTS;