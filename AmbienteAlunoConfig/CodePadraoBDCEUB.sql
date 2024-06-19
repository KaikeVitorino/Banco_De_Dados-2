-- SOLUÇÃO:
/*==============================================================*/
/* Table: CLIENTE */
/*==============================================================*/
DROP TABLE CLIENTE CASCADE CONSTRAINT;
create table CLIENTE (
CODIGO NUMBER not null,
NOME varchar2(60) not null,
RUA varchar2(80) not null,
NR NUMBER(4) not null,
BAIRRO varchar2(50) not null,
COMPLEMENTO varchar2(100),
CIDADE varchar2(50) not null,
UF varchar2(2) not null,
CEP varchar2(10) not null,
constraint PK_CLIENTE primary key (CODIGO)
);
/*==============================================================*/
/* Table: VENDEDOR */
/*==============================================================*/
DROP TABLE VENDEDOR CASCADE CONSTRAINT;
create table VENDEDOR (
MATRICULA NUMBER not null,
NOME varchar2(60) not null,
CNPF varchar2(14) not null,
constraint PK_VENDEDOR primary key (MATRICULA)
);
/*==============================================================*/
/* Table: FONE_CLIENTE */
/*==============================================================*/
DROP TABLE FONE_CLIENTE CASCADE CONSTRAINT;

create table FONE_CLIENTE (
NUMERO varchar2(14) not null,
CODIGO_CLI NUMBER not null,
constraint PK_FONE_CLIENTE primary key (NUMERO, CODIGO_CLI),
constraint FK_FONE_CLIENTE foreign key (CODIGO_CLI) references CLIENTE (CODIGO)
);
/*==============================================================*/
/* Table: FONE_VENDEDOR */
/*==============================================================*/
DROP TABLE FONE_VENDEDOR CASCADE CONSTRAINT;
create table FONE_VENDEDOR (
NUMERO varchar2(14) not null,
MATRICULA_VEN NUMBER not null,
constraint PK_FONE_VENDEDOR primary key (NUMERO, MATRICULA_VEN),
constraint FK_FONE_VENDEDOR foreign key (MATRICULA_VEN) references VENDEDOR
(MATRICULA)
);
/*==============================================================*/
/* Table: PF */
/*==============================================================*/
DROP TABLE PF;
create table PF (
CODIGO_CLI NUMBER not null,
CNPF varchar2(14) not null,
RG varchar2(10) not null,
DATA_NASCIMENTO DATE not null,
constraint PK_PF primary key (CODIGO_CLI),
constraint FK_PF_CLIENTE foreign key (CODIGO_CLI) references CLIENTE (CODIGO)
);
/*==============================================================*/
/* Table: PJ */
/*==============================================================*/
DROP TABLE Pj;
create table PJ (
CODIGO_CLI NUMBER not null,
CNPJ varchar2(19) not null,
IE varchar2(10) not null,
NOME_FANTASIA varchar2(60) not null,
constraint PK_PJ primary key (CODIGO_CLI),
constraint FK_PJ_CLIENTE foreign key (CODIGO_CLI) references CLIENTE (CODIGO)
);

/*==============================================================*/
/* Table: PRATELEIRA */
/*==============================================================*/
DROP TABLE PRATELEIRA CASCADE CONSTRAINT;
create table PRATELEIRA (
CODIGO NUMBER(3) not null,
DESCRICAO varchar2(50) not null,
NUMERO_SECOES NUMBER(2) not null,
constraint PK_PRATELEIRA primary key (CODIGO)
);
/*==============================================================*/
/* Table: PRODUTO */
/*==============================================================*/
DROP TABLE PRODUTO CASCADE CONSTRAINT;
create table PRODUTO (
CODIGO NUMBER not null,
DESCRICAO varchar2(80) not null,
UNID_MEDIDA varchar2(10) not null,
constraint PK_PRODUTO primary key (CODIGO)
);

-- SOLUÇÃO 1)
/*==============================================================*/
/* Table: PEDIDO */
/*==============================================================*/
DROP TABLE PEDIDO CASCADE CONSTRAINT;
create table PEDIDO (
NUMERO NUMBER(6) not null,
DATA DATE not null,
PRAZO_ENTREGA DATE,
RUA varchar2(80),
NR NUMBER(4),
BAIRRO varchar2(50),
COMPLEMENTO varchar2(100),
CIDADE varchar2(50),
UF varchar2(2),
CEP varchar2(10),
TOTAL_FATURA NUMBER(8,2),
CODIGO_CLI NUMBER not null,
MATRICULA_VEN NUMBER not null
);
/*==============================================================*/
/* Table: ITEM_PRODUTO */
/*==============================================================*/
DROP TABLE ITEM_PRODUTO;
create table ITEM_PRODUTO (
CODIGO_PRO NUMBER not null,
NUMERO_PED NUMBER(6) not null,

QUANTIDADE NUMBER(5) not null,
PRECO_UNITARIO NUMBER(5,2) not null,
VALOR_ITEM NUMBER(7,2)
);
/*==============================================================*/
/* Table: CAPACIDADE_ESTOQUE */
/*==============================================================*/
DROP TABLE CAPACIDADE_ESTOQUE;
create table CAPACIDADE_ESTOQUE (
CODIGO_PRO NUMBER not null,
CODIGO_PRA NUMBER(3) not null,
QUANTIDADE NUMBER(5) not null
);
/*==============================================================*/
/* Table: ESTOQUE */
/*==============================================================*/
DROP TABLE ESTOQUE;
create table ESTOQUE (
DATA_ENTRADA DATE not null,
CODIGO_PRO NUMBER not null,
CODIGO_PRA NUMBER(3) not null,
QUANTIDADE NUMBER(5) not null,
DATA_VALIDADE DATE
);
-- SOLUÇÃO 2)
alter table PEDIDO
ADD constraint PK_PEDIDO primary key (NUMERO);
alter table ITEM_PRODUTO
ADD constraint PK_ITEM_PRODUTO primary key (CODIGO_PRO, NUMERO_PED);
alter table CAPACIDADE_ESTOQUE
ADD constraint PK_CAPACIDADE_ESTOQUE primary key (CODIGO_PRO, CODIGO_PRA);
alter table ESTOQUE
ADD constraint PK_ESTOQUE primary key (CODIGO_PRO, CODIGO_PRA,
DATA_ENTRADA);
-- SOLUÇÃO 3)
alter table PEDIDO
add constraint FK_PED_VENDEDOR foreign key (MATRICULA_VEN)

references VENDEDOR (MATRICULA);
alter table PEDIDO
add constraint FK_PED_CLIENTE foreign key (CODIGO_CLI)
references CLIENTE (CODIGO);
alter table ITEM_PRODUTO
add constraint FK_ITEM_PEDIDO foreign key (NUMERO_PED)
references PEDIDO (NUMERO);
alter table ITEM_PRODUTO
add constraint FK_ITEM_PRODUTO foreign key (CODIGO_PRO)
references PRODUTO (CODIGO);
alter table CAPACIDADE_ESTOQUE
add constraint FK_CAP_EST_PRATELEIRA foreign key (CODIGO_PRA)
references PRATELEIRA (CODIGO);
alter table CAPACIDADE_ESTOQUE
add constraint FK_CAP_EST_PRODUTO foreign key (CODIGO_PRO)
references PRODUTO (CODIGO);
alter table ESTOQUE
add constraint FK_EST_PRATELEIRA foreign key (CODIGO_PRA)
references PRATELEIRA (CODIGO);
alter table ESTOQUE
add constraint FK_EST_PRODUTO foreign key (CODIGO_PRO)
references PRODUTO (CODIGO);

-- SOLUÇÃO
-- Inclusão de CLIENTE
INSERT INTO CLIENTE
SELECT *
FROM DEMO.CLIENTE;
-- Inclusão de FONE_CLIENTE
INSERT INTO FONE_CLIENTE
SELECT *
FROM DEMO.FONE_CLIENTE;
-- Inclusão de VENDEDOR
INSERT INTO VENDEDOR
SELECT *
FROM DEMO.VENDEDOR;
-- Inclusão de FONE_VENDEDOR
INSERT INTO FONE_VENDEDOR
SELECT *
FROM DEMO.FONE_VENDEDOR;
-- Inclusão de PF
INSERT INTO PF
SELECT *
FROM DEMO.PF;
-- Inclusão de PJ
INSERT INTO PJ
SELECT *
FROM DEMO.PJ;
-- Inclusão de PEDIDO
INSERT INTO PEDIDO
SELECT *
FROM DEMO.PEDIDO;

-- Inclusão de PRATELEIRA
INSERT INTO PRATELEIRA
SELECT *
FROM DEMO.PRATELEIRA;
-- Inclusão de PRODUTO
INSERT INTO PRODUTO
SELECT *
FROM DEMO.PRODUTO;
-- Inclusão de CAPACIDADE_ESTOQUE
INSERT INTO CAPACIDADE_ESTOQUE
SELECT *
FROM DEMO.CAPACIDADE_ESTOQUE;
-- Inclusão de ESTOQUE
INSERT INTO ESTOQUE
SELECT *
FROM DEMO.ESTOQUE;
COMMIT;

-- 1. Produto 207 para todos os pedidos pares e ano menor 2018, com a quantidade 100 e
-- preço unitário R$ 10.00
-- RESOLUÇÃO:
INSERT INTO ITEM_PRODUTO
SELECT 207 AS CODIGO_PRO,
NUMERO AS NUMERO_PED,
100 AS QUANTIDADE,
10.00 AS PRECO_UNITARIO,
NULL
FROM PEDIDO
WHERE MOD(NUMERO,2)=0
AND TO_CHAR(DATA, 'YYYY') < 2018;
-- 2. Produto 206 para todos os pedidos impares e ano igual 2018, com a quantidade 50 e
-- preço unitário R$ 12.00
-- RESOLUÇÃO:
INSERT INTO ITEM_PRODUTO
SELECT 206 AS CODIGO_PRO,
NUMERO AS NUMERO_PED,
50 AS QUANTIDADE,
12.00 AS PRECO_UNITARIO,
NULL
FROM PEDIDO
WHERE MOD(NUMERO,2)=1
AND TO_CHAR(DATA, 'YYYY') = 2018;
INSERT INTO ITEM_PRODUTO
SELECT 207 AS CODIGO_PRO,
NUMERO AS NUMERO_PED,
150 AS QUANTIDADE,
14.00 AS PRECO_UNITARIO,
NULL
FROM PEDIDO
WHERE MOD(NUMERO,2)=0
AND TO_CHAR(DATA, 'YYYY') = 2018;
-- 4. Produto 206 para todos os pedidos impares e ano menor 2018, com a quantidade 200 e
-- preço unitário R$ 8.00
-- RESOLUÇÃO:

INSERT INTO ITEM_PRODUTO
SELECT 206 AS CODIGO_PRO,
NUMERO AS NUMERO_PED,
200 AS QUANTIDADE,
8.00 AS PRECO_UNITARIO,
NULL
FROM PEDIDO
WHERE MOD(NUMERO,2)=1
AND TO_CHAR(DATA, 'YYYY') < 2018;
-- 5. Produto 208 para todos sem endereço de entrega e ano igual 2017, com a quantidade
-- 80 e preço unitário R$ 18.00
-- RESOLUÇÃO:
INSERT INTO ITEM_PRODUTO
SELECT 208 AS CODIGO_PRO,
NUMERO AS NUMERO_PED,
80 AS QUANTIDADE,
18.00 AS PRECO_UNITARIO,
NULL
FROM PEDIDO
WHERE TO_CHAR(DATA, 'YYYY') = 2017
AND RUA IS NULL;
-- 6. Produto 208 para todos sem endereço de entrega e ano igual 2018, com a quantidade
-- 70 e preço unitário R$ 20.00
-- RESOLUÇÃO:
INSERT INTO ITEM_PRODUTO
SELECT 208 AS CODIGO_PRO,
NUMERO AS NUMERO_PED,
70 AS QUANTIDADE,
20.00 AS PRECO_UNITARIO,
NULL
FROM PEDIDO
WHERE TO_CHAR(DATA, 'YYYY') = 2018
AND PRAZO_ENTREGA IS NULL;
-- 7. Produto 202 para todos pedidos com endereço de entrega e dia impar de entrega, com a
-- quantidade 60 e preço unitário R$ 15.00
-- RESOLUÇÃO:
INSERT INTO ITEM_PRODUTO
SELECT 202 AS CODIGO_PRO,
NUMERO AS NUMERO_PED,
60 AS QUANTIDADE,
15.00 AS PRECO_UNITARIO,
NULL
FROM PEDIDO
WHERE MOD(TO_NUMBER(TO_CHAR(PRAZO_ENTREGA, 'DD')),2) = 1
AND RUA IS NOT NULL;

-- 8. Produto 205 para todos pedidos com endereço de entrega e dia par da data do pedido,
-- com a quantidade 90 e preço unitário R$ 11.50
-- RESOLUÇÃO:
INSERT INTO ITEM_PRODUTO
SELECT 205 AS CODIGO_PRO,
NUMERO AS NUMERO_PED,
90 AS QUANTIDADE,
11.50 AS PRECO_UNITARIO,
NULL
FROM PEDIDO
WHERE MOD(TO_NUMBER(TO_CHAR(DATA, 'DD')),2) = 0
AND RUA IS NOT NULL;
-- 9. Produto 203 para todos pedidos com endereço de entrega e dia ímpar da data de
-- pedido, com a quantidade 550 e preço unitário R$ 21.35
-- RESOLUÇÃO:
INSERT INTO ITEM_PRODUTO
SELECT 203 AS CODIGO_PRO,
NUMERO AS NUMERO_PED,
550 AS QUANTIDADE,
21.35 AS PRECO_UNITARIO,
NULL
FROM PEDIDO
WHERE MOD(TO_NUMBER(TO_CHAR(DATA, 'DD')),2) = 1
AND RUA IS NOT NULL;
-- 10. Produto 204 para todos pedidos sem endereço de entrega e dia par da data do pedido,
-- com a quantidade 150 e preço unitário R$ 25.85
-- RESOLUÇÃO:
INSERT INTO ITEM_PRODUTO
SELECT 204 AS CODIGO_PRO,
NUMERO AS NUMERO_PED,
150 AS QUANTIDADE,
25.85 AS PRECO_UNITARIO,
NULL
FROM PEDIDO
WHERE MOD(TO_NUMBER(TO_CHAR(DATA, 'DD')),2) = 0
AND RUA IS NULL;
COMMIT;