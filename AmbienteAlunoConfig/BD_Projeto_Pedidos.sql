/*==============================================================*/
/* DBMS name:      ORACLE Version 10g                           */
/* Created on:     28/04/2018 23:05:59                          */
/*==============================================================*/


alter table CAPACIDADE_ESTOQUE
   drop constraint FK_CAP_EST_PRATELEIRA;

alter table CAPACIDADE_ESTOQUE
   drop constraint FK_CAP_EST_PRODUTO;

alter table ESTOQUE
   drop constraint FK__EST_PRATELEIRA;

alter table ESTOQUE
   drop constraint FK_EST_PRODUTO;

alter table FONE_CLIENTE
   drop constraint FK_FONE_CLIENTE;

alter table FONE_VENDEDOR
   drop constraint FK_FONE_VENDEDOR;

alter table ITEM_PRODUTO
   drop constraint FK_ITEM_PEDIDO;

alter table ITEM_PRODUTO
   drop constraint FK_ITEM_PRODUTO;

alter table PEDIDO
   drop constraint FK_PED_VENDEDOR;

alter table PEDIDO
   drop constraint FK_PED_CLIENTE;

alter table PF
   drop constraint FK_PF_CLIENTE;

alter table PJ
   drop constraint FK_PJ_CLIENTE;

drop view VIEW_ESTOQUE;

drop view VIEW_CLIENTE;

drop view VIEW_CAPACIDADE_ESTOQUE;

drop table CAPACIDADE_ESTOQUE cascade constraints;

drop table CLIENTE cascade constraints;

drop table ESTOQUE cascade constraints;

drop table FONE_CLIENTE cascade constraints;

drop table FONE_VENDEDOR cascade constraints;

drop table ITEM_PRODUTO cascade constraints;

drop table PEDIDO cascade constraints;

drop index IND_CNPF_PF;

drop table PF cascade constraints;

drop index IND_CNPJ_PJ;

drop table PJ cascade constraints;

drop table PRATELEIRA cascade constraints;

drop table PRODUTO cascade constraints;

drop table VENDEDOR cascade constraints;

/*==============================================================*/
/* Table: CAPACIDADE_ESTOQUE                                    */
/*==============================================================*/
create table CAPACIDADE_ESTOQUE  (
   CODIGO_PRO           INTEGER                         not null,
   CODIGO_PRA           NUMBER(3)                       not null,
   QUANTIDADE           NUMBER(5)                       not null,
   constraint PK_CAPACIDADE_ESTOQUE primary key (CODIGO_PRO, CODIGO_PRA)
);

comment on table CAPACIDADE_ESTOQUE is
'Mantém informações sobre capacidade de estoque de produtos no negócio do sistema de pedido.';

comment on column CAPACIDADE_ESTOQUE.CODIGO_PRO is
'Código que identifica cada produto do negócio. PEx: 12345.';

comment on column CAPACIDADE_ESTOQUE.CODIGO_PRA is
'Código que identifica cada prateleira existente no estabelecimento. PEx: 123.';

comment on column CAPACIDADE_ESTOQUE.QUANTIDADE is
'Define a quantidade de produtos que podem ser armazenados na prateleira.';

/*==============================================================*/
/* Table: CLIENTE                                               */
/*==============================================================*/
create table CLIENTE  (
   CODIGO               INTEGER                         not null
      constraint CKC_CODIGO_CLIENTE check (CODIGO between 1 and 99999),
   NOME                 varchar2(60)                    not null,
   RUA                  varchar2(80)                    not null,
   NR                   NUMBER(4)                       not null,
   BAIRRO               varchar2(50)                    not null,
   COMPLEMENTO          varchar2(100),
   CIDADE               varchar2(50)                    not null,
   UF                   varchar2(2)                     not null,
   CEP                  varchar2(10)                     not null,
   constraint PK_CLIENTE primary key (CODIGO)
);

comment on table CLIENTE is
'Mantém os dados de clientes do sistema de pedido.';

comment on column CLIENTE.CODIGO is
'Idenficador do cliente. Valor sequencial numérico a ser incrementado por uma sequence de nome SEQ_CODIGO_CLIENTE.';

/*==============================================================*/
/* Table: ESTOQUE                                               */
/*==============================================================*/
create table ESTOQUE  (
   DATA_ENTRADA         DATE                            not null,
   CODIGO_PRO           INTEGER                         not null,
   CODIGO_PRA           NUMBER(3)                       not null,
   QUANTIDADE           NUMBER(5)                       not null,
   DATA_VALIDADE        DATE,
   constraint PK_ESTOQUE primary key (CODIGO_PRO, CODIGO_PRA, DATA_ENTRADA)
);

comment on table ESTOQUE is
'Mantém informações sobre o estoque de produtos no negócio do sistema de pedido.';

comment on column ESTOQUE.CODIGO_PRO is
'Código que identifica cada produto do negócio. PEx: 12345.';

comment on column ESTOQUE.CODIGO_PRA is
'Código que identifica cada prateleira existente no estabelecimento. PEx: 123.';

comment on column ESTOQUE.QUANTIDADE is
'Define a quantidade de produtos que podem ser armazenados na prateleira.';

/*==============================================================*/
/* Table: FONE_CLIENTE                                          */
/*==============================================================*/
create table FONE_CLIENTE  (
   NUMERO               varchar2(14)                    not null,
   CODIGO_CLI           INTEGER                         not null,
   constraint PK_FONE_CLIENTE primary key (NUMERO, CODIGO_CLI)
);

comment on table FONE_CLIENTE is
'Mantém os telefones dos clientes do sistema de pedido.';

comment on column FONE_CLIENTE.NUMERO is
'Identifica o número do telefone do cliente. PEx: (61) 98877-6655.';

comment on column FONE_CLIENTE.CODIGO_CLI is
'Idenficador do cliente. Valor sequencial numérico a ser incrementado por uma sequence de nome SEQ_CODIGO_CLIENTE.';

/*==============================================================*/
/* Table: FONE_VENDEDOR                                         */
/*==============================================================*/
create table FONE_VENDEDOR  (
   NUMERO               varchar2(14)                    not null,
   MATRICULA_VEN        INTEGER                         not null,
   constraint PK_FONE_VENDEDOR primary key (NUMERO, MATRICULA_VEN)
);

comment on table FONE_VENDEDOR is
'Mantém os telefones dos clientes do sistema de pedido.';

comment on column FONE_VENDEDOR.NUMERO is
'Identifica o número do telefone do vendedor. PEx: (61) 98877-6655.';

comment on column FONE_VENDEDOR.MATRICULA_VEN is
'Idenficador do vendedor. Valor sequencial numérico a ser incrementado por uma sequence de nome SEQ_CODIGO_VENDEDOR.';

/*==============================================================*/
/* Table: ITEM_PRODUTO                                          */
/*==============================================================*/
create table ITEM_PRODUTO  (
   CODIGO_PRO           INTEGER                         not null,
   NUMERO_PED           NUMBER(6)                       not null,
   QUANTIDADE           NUMBER(5)                       not null,
   PRECO_UNITARIO       NUMBER(5,2)                     not null,
   VALOR_ITEM           NUMBER(7,2),
   constraint PK_ITEM_PRODUTO primary key (CODIGO_PRO, NUMERO_PED)
);

comment on table ITEM_PRODUTO is
'Mantém os dados dos itens de produtos dos pedidos no negócio do sistema de pedido.';

comment on column ITEM_PRODUTO.CODIGO_PRO is
'Código que identifica cada produto do negócio. PEx: 12345.';

comment on column ITEM_PRODUTO.NUMERO_PED is
'Número que identifica cada pedido efetuado no sistema. Seu valor é sequencial e é gerado por uma sequence de nome SEQ_NUNMERO_PEDIDO. PEx: 123456.';

/*==============================================================*/
/* Table: PEDIDO                                                */
/*==============================================================*/
create table PEDIDO  (
   NUMERO               NUMBER(6)                       not null
      constraint CKC_NUMERO_PEDIDO check (NUMERO between 1 and 999999),
   DATA                 DATE                            not null,
   PRAZO_ENTREGA        DATE,
   RUA                  varchar2(80),
   NR                   NUMBER(4),
   BAIRRO               varchar2(50),
   COMPLEMENTO          varchar2(100),
   CIDADE               varchar2(50),
   UF                   varchar2(2),
   CEP                  varchar2(10),
   TOTAL_FATURA         NUMBER(8,2),
   CODIGO_CLI           INTEGER                         not null,
   MATRICULA_VEN        INTEGER                         not null,
   constraint PK_PEDIDO primary key (NUMERO)
);

comment on table PEDIDO is
'Mantém os dados dos pedidos realizados pelos clentes no sistema de pedido.';

comment on column PEDIDO.NUMERO is
'Número que identifica cada pedido efetuado no sistema. Seu valor é sequencial e é gerado por uma sequence de nome SEQ_NUNMERO_PEDIDO. PEx: 123456.';

comment on column PEDIDO.DATA is
'Indica a data em o pedido foi realizado.';

comment on column PEDIDO.PRAZO_ENTREGA is
'Determina a data prazo de entrega do pedido realizado.';

comment on column PEDIDO.RUA is
'Descreve a rua do endereço de entrega.';

comment on column PEDIDO.NR is
'Identifica o numero na rua do endereço de entrega.';

comment on column PEDIDO.BAIRRO is
'Descreve o bairro do endereço de entrega.';

comment on column PEDIDO.COMPLEMENTO is
'Complementa o endereço de entrega.';

comment on column PEDIDO.CIDADE is
'Realciona a cidade do endereço de entrega.';

comment on column PEDIDO.UF is
'Realciona a UF do endereço de entrega.';

comment on column PEDIDO.CEP is
'Realciona o CEP do endereço de entrega.';

comment on column PEDIDO.TOTAL_FATURA is
'Totaliza toda a fatura do pedido.';

comment on column PEDIDO.CODIGO_CLI is
'Idenficador do cliente. Valor sequencial numérico a ser incrementado por uma sequence de nome SEQ_CODIGO_CLIENTE.';

comment on column PEDIDO.MATRICULA_VEN is
'Idenficador do vendedor. Valor sequencial numérico a ser incrementado por uma sequence de nome SEQ_CODIGO_VENDEDOR.';

/*==============================================================*/
/* Table: PF                                                    */
/*==============================================================*/
create table PF  (
   CODIGO_CLI           INTEGER                         not null,
   CNPF                 varchar2(14)                    not null,
   RG                   varchar2(10)                    not null,
   DATA_NASCIMENTO      DATE                            not null,
   constraint PK_PF primary key (CODIGO_CLI)
);

comment on table PF is
'Mantém os dados de clientes PF do sistema de pedido.';

comment on column PF.CODIGO_CLI is
'Idenficador do cliente. Valor sequencial numérico a ser incrementado por uma sequence de nome SEQ_CODIGO_CLIENTE.';

/*==============================================================*/
/* Index: IND_CNPF_PF                                           */
/*==============================================================*/
create unique index IND_CNPF_PF on PF (
   CNPF DESC
);

/*==============================================================*/
/* Table: PJ                                                    */
/*==============================================================*/
create table PJ  (
   CODIGO_CLI           INTEGER                         not null,
   CNPJ                 varchar2(19)                    not null,
   IE                   varchar2(10)                    not null,
   NOME_FANTASIA        varchar2(60)                    not null,
   constraint PK_PJ primary key (CODIGO_CLI)
);

comment on table PJ is
'Mantém os dados de clientes PJ do sistema de pedido.';

comment on column PJ.CODIGO_CLI is
'Idenficador do cliente. Valor sequencial numérico a ser incrementado por uma sequence de nome SEQ_CODIGO_CLIENTE.';

/*==============================================================*/
/* Index: IND_CNPJ_PJ                                           */
/*==============================================================*/
create unique index IND_CNPJ_PJ on PJ (
   CNPJ DESC
);

/*==============================================================*/
/* Table: PRATELEIRA                                            */
/*==============================================================*/
create table PRATELEIRA  (
   CODIGO               NUMBER(3)                       not null,
   DESCRICAO            varchar2(50)                    not null,
   NUMERO_SECOES        NUMBER(2)                       not null,
   constraint PK_PRATELEIRA primary key (CODIGO)
);

comment on table PRATELEIRA is
'Mantém os dados das prateleiras que guardam os produtos em estóque no negócio do sistema de pedido.';

comment on column PRATELEIRA.CODIGO is
'Código que identifica cada prateleira existente no estabelecimento. PEx: 123.';

/*==============================================================*/
/* Table: PRODUTO                                               */
/*==============================================================*/
create table PRODUTO  (
   CODIGO               INTEGER                         not null,
   DESCRICAO            varchar2(80)                    not null,
   UNID_MEDIDA          varchar2(10)                    not null,
   constraint PK_PRODUTO primary key (CODIGO)
);

comment on table PRODUTO is
'Mantém os dados dos produtos pedidos pelos clientes no negócio do sistema de pedido.';

comment on column PRODUTO.CODIGO is
'Código que identifica cada produto do negócio. PEx: 12345.';

comment on column PRODUTO.DESCRICAO is
'Descreve o produto existente no negócio. PEx: Cimento, Cal, Areia, etc...';

comment on column PRODUTO.UNID_MEDIDA is
'Unidade que mede cada produto existente no sistema. PEx: Kg, Un, Gr, L,...';

/*==============================================================*/
/* Table: VENDEDOR                                              */
/*==============================================================*/
create table VENDEDOR  (
   MATRICULA            INTEGER                         not null,
   NOME                 varchar2(60)                    not null,
   CNPF                 varchar2(14)                    not null,
   constraint PK_VENDEDOR primary key (MATRICULA)
);

comment on table VENDEDOR is
'Mantém os dados dos vendedores do negócio no sistema de pedido.';

comment on column VENDEDOR.MATRICULA is
'Idenficador do vendedor. Valor sequencial numérico a ser incrementado por uma sequence de nome SEQ_CODIGO_VENDEDOR.';

/*==============================================================*/
/* View: VIEW_CAPACIDADE_ESTOQUE                                */
/*==============================================================*/
create or replace view VIEW_CAPACIDADE_ESTOQUE as
select pro.DESCRICAO as produto,
       pra.DESCRICAO as prateleira,
       ce.QUANTIDADE,
       pro.UNID_MEDIDA as unidade_medida
from   PRODUTO pro join
       CAPACIDADE_ESTOQUE ce on (pro.CODIGO=ce.CODIGO_PRO) join
       PRATELEIRA pra on (ce.CODIGO_PRA=pra.CODIGO)
with read only;

 comment on table VIEW_CAPACIDADE_ESTOQUE is
'Mostra as prateleiras e respectivas capacidades.';

comment on column VIEW_CAPACIDADE_ESTOQUE.PRODUTO is
'Descreve o produto existente no negócio. PEx: Cimento, Cal, Areia, etc...';

comment on column VIEW_CAPACIDADE_ESTOQUE.PRATELEIRA is
'Descreve as características da prateleira cadastrada para receber produtos em estoque no negócio. PEx: Aço inoxidável reforçada.';

comment on column VIEW_CAPACIDADE_ESTOQUE.QUANTIDADE is
'Define a quantidade de produtos que podem ser armazenados na prateleira.';

comment on column VIEW_CAPACIDADE_ESTOQUE.UNIDADE_MEDIDA is
'Unidade que mede cada produto existente no sistema. PEx: Kg, Un, Gr, L,...';

/*==============================================================*/
/* View: VIEW_CLIENTE                                           */
/*==============================================================*/
create or replace view VIEW_CLIENTE as
select 'PF' as tipo,
       C.CODIGO,
       C.NOME,
       PF.CNPF,
       PF.RG
from CLIENTE C inner join
     PF on (c.CODIGO=PF.CODIGO_CLI)
union       
select 'PJ' as tipo,
       C.CODIGO,
       C.NOME,
       PJ.CNPJ,
       PJ.IE
from CLIENTE C inner join
     PJ on (c.CODIGO=PJ.CODIGO_CLI)
with read only;

 comment on table VIEW_CLIENTE is
'Apresenta todos os clientes com seus respectivos atributos. Apresenta o acréscimo da coluna TIPO (PF ou PJ).';

comment on column VIEW_CLIENTE.CODIGO is
'Idenficador do cliente. Valor sequencial numérico a ser incrementado por uma sequence de nome SEQ_CODIGO_CLIENTE.';

comment on column VIEW_CLIENTE.NOME is
'Nome do cliente cadastrado no sistema de pedidos.';

comment on column VIEW_CLIENTE.CNPF is
'CNPF de uma PF que é cliente da organização.';

comment on column VIEW_CLIENTE.RG is
'Regestro Geral de uma PF que é cliente da organização.';

/*==============================================================*/
/* View: VIEW_ESTOQUE                                           */
/*==============================================================*/
create or replace view VIEW_ESTOQUE as
select pro.descricao as produto,
       quantidade_adquirida,
       quantidade_saida,
       disponivel,
       pro.unid_medida
from PRODUTO
with read only;

 comment on table VIEW_ESTOQUE is
'Relaciona os níveis de estoque existente no sistema de pedido.';

/*==============================================================*/
/* CHAVES ESTRANGEIRAS                                          */
/*==============================================================*/
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

alter table FONE_CLIENTE
   add constraint FK_FONE_CLIENTE foreign key (CODIGO_CLI)
      references CLIENTE (CODIGO);

alter table FONE_VENDEDOR
   add constraint FK_FONE_VENDEDOR foreign key (MATRICULA_VEN)
      references VENDEDOR (MATRICULA);

alter table ITEM_PRODUTO
   add constraint FK_ITEM_PEDIDO foreign key (NUMERO_PED)
      references PEDIDO (NUMERO);

alter table ITEM_PRODUTO
   add constraint FK_ITEM_PRODUTO foreign key (CODIGO_PRO)
      references PRODUTO (CODIGO);

alter table PEDIDO
   add constraint FK_PED_VENDEDOR foreign key (MATRICULA_VEN)
      references VENDEDOR (MATRICULA);

alter table PEDIDO
   add constraint FK_PED_CLIENTE foreign key (CODIGO_CLI)
      references CLIENTE (CODIGO);

alter table PF
   add constraint FK_PF_CLIENTE foreign key (CODIGO_CLI)
      references CLIENTE (CODIGO);

alter table PJ
   add constraint FK_PJ_CLIENTE foreign key (CODIGO_CLI)
      references CLIENTE (CODIGO);

/*************************************************************************/
/* COMPARTILHAMENTO DAS TABELAS PARA SELEÇÃO AO PÚBLICO                  */
/*************************************************************************/

grant select on CLIENTE to public;
grant select on PF to public;
grant select on PJ to public;
grant select on FONE_CLIENTE to public;
grant select on FONE_VENDEDOR to public;
grant select on PRODUTO to public;
grant select on VENDEDOR to public;
grant select on PEDIDO to public;
grant select on PRATELEIRA to public;
grant select on ESTOQUE to public;
grant select on CAPACIDADE_ESTOQUE to public;

/*************************************************************************/
/* CARGA DE DADOS DO PROJETO DE BD PEDIDOS                               */
/*************************************************************************/

/* TABELA CLIENTE */
INSERT INTO CLIENTE VALUES (10, 'José Ribeiro Gonçalves', 'Alfredo Justino', 16, 'Interlagos', 'Próximo à lagoa principal','Três Lagoas','MS','76000-000');
INSERT INTO CLIENTE VALUES (11, 'Mário Gomes Ribeiro', 'Manguaguá', 226, 'São Gonçalo', 'Imediações do buracão','Santos','SP','72100-010');
INSERT INTO CLIENTE VALUES (12, 'Airt0 Silva Gonçalves', 'Amoreiras', 643, 'Feijão Queimado', 'Alameda principal','Campinas','SP','71500-000');
INSERT INTO CLIENTE VALUES (13, 'Ana Júlia Gomes', 'General Souto Brito', 126, 'Interlagos', '','Três Lagoas','MS','76000-050');
INSERT INTO CLIENTE VALUES (14, 'José Roberto Silva', 'Cel Baratta', 876, 'Santa Terezinha', '','Três Lagoas','MS','76000-040');
INSERT INTO CLIENTE VALUES (15, 'Ribamar dos Santos Ribeiro', 'Capitão Felinto', 908, 'Lapa', 'Ao lado do hopital público','São Paulo','SP','91000-000');
INSERT INTO CLIENTE VALUES (16, 'Edvaldo Gastão de Dinheiro', 'Jorge Aragão', 1005, 'Campo Limpo', 'Frente à PF','Cristalina','GO','56080-000');
INSERT INTO CLIENTE VALUES (17, 'Maria de Lurdes Santana', 'Içã Cobiça', 2001, 'Interlagos', '','Três Lagoas','MS','76000-030');
INSERT INTO CLIENTE VALUES (18, 'Maria de Fátima Gonçalves', 'Jangada Amarela', 98, 'Centro', '','Sete Marias','MG','26010-010');
INSERT INTO CLIENTE VALUES (19, 'António Augusto da Silva', 'Colina azul', 11, 'Interlagos', 'Ao lado do quartel central','Três Lagoas','MS','76100-020');
INSERT INTO CLIENTE VALUES (20, 'Eduarda Rosa Cottonetti', 'Capitão Felinto', 44, 'Vila Nova', '','Beiral','PI','66000-000');
INSERT INTO CLIENTE VALUES (30, 'Calçados Ltda', 'Indaiá dos Nobres', 1066, 'Lapa', 'Próximo à Mangueira','Alto das Garças','MT','73100-002');
INSERT INTO CLIENTE VALUES (31, 'Tubiara Refrigerantes SA', 'Alfredo Justino', 1122, 'Colina', 'Final da rua','Sobral','BA','51101-000');
INSERT INTO CLIENTE VALUES (32, 'Grupo Segurança Total Ltda', 'Presidente GV', 1076, 'Colibri', '','Itaqui','RS','49100-100');
INSERT INTO CLIENTE VALUES (33, 'Assoalhos Suspensos SA', 'Pitangas', 1088, 'Laguna Seca', 'Esquina com colégio Giru','Jaboticabal','SP','46100-000');
INSERT INTO CLIENTE VALUES (34, 'Tudo De Alvenaria', 'Jorge Amado', 180, 'Lamaçal', '','Lagoas','ES','75106-109');
INSERT INTO CLIENTE VALUES (35, 'Metais e Serralheria SA', 'Alto da Compadecida', 106, 'Tijuca', '','Jacutinga','MA','56110-110');
INSERT INTO CLIENTE VALUES (36, 'Madeiras em Geral Ltda', 'Xique Xique', 1999, 'Mangueiral', '','Tapera','AM','86170-000');

/* TABELA CLIENTE PF */
INSERT INTO PF VALUES (10, '345.245.673-16', '0135671-9', '01-05-1974');
INSERT INTO PF VALUES (11, '436.326.489-26', '0246722-0', '11-06-1952');
INSERT INTO PF VALUES (12, '527.414.399-39', '3354833-7', '18-12-1966');
INSERT INTO PF VALUES (13, '618.507.288-38', '0763942-7', '19-11-1949');
INSERT INTO PF VALUES (14, '709.694.188-40', '9572154-5', '15-10-1959');
INSERT INTO PF VALUES (15, '890.788.096-51', '8681275-3', '04-12-1967');
INSERT INTO PF VALUES (16, '989.874.946-52', '0090362-4', '26-08-1973');
INSERT INTO PF VALUES (17, '078.069.844-54', '5009486-2', '24-04-1983');
INSERT INTO PF VALUES (18, '167.154.754-63', '0918592-3', '13-09-1972');
INSERT INTO PF VALUES (19, '256.240.653-22', '2127607-1', '06-02-1951');
INSERT INTO PF VALUES (20, '345.235.563-31', '0646572-1', '28-06-1960');

/* TABELA CLIENTE PJ */
INSERT INTO PJ VALUES (30, '345.679.012/0001-67', '92345-9', 'Samba Calçados');
INSERT INTO PJ VALUES (31, '436.588.103/0001-58', '82697-1', 'Tibibi do Refri');
INSERT INTO PJ VALUES (32, '527.407.293/0001-49', '72645-0', 'Assoalhos de Ouro');
INSERT INTO PJ VALUES (34, '618.316.384/0001-30', '57365-1', 'Construções Perenes');
INSERT INTO PJ VALUES (35, '709.225.475/0001-21', '18368-7', 'Serra de Tudo');
INSERT INTO PJ VALUES (36, '890.134.566/0001-12', '18335-0', 'Só Madeiras');

/* TABELA FONE CLIENTE */
INSERT INTO FONE_CLIENTE VALUES ('(67) 3479-3021',10);
INSERT INTO FONE_CLIENTE VALUES ('(67) 4357-9420',10);
INSERT INTO FONE_CLIENTE VALUES ('(57) 5450-8339',12);
INSERT INTO FONE_CLIENTE VALUES ('(47) 6969-7127',10);
INSERT INTO FONE_CLIENTE VALUES ('(37) 7966-6048',13);
INSERT INTO FONE_CLIENTE VALUES ('(27) 8776-5226',15);
INSERT INTO FONE_CLIENTE VALUES ('(87) 9788-4056',16);
INSERT INTO FONE_CLIENTE VALUES ('(97) 1689-3125',15);
INSERT INTO FONE_CLIENTE VALUES ('(87) 2871-2084',18);
INSERT INTO FONE_CLIENTE VALUES ('(67) 3691-1023',19);
INSERT INTO FONE_CLIENTE VALUES ('(77) 3570-0021',20);

/* TABELA VENDEDOR */
INSERT INTO VENDEDOR VALUES (100, 'João Maria', '158.274.423-11');
INSERT INTO VENDEDOR VALUES (101, 'Gilberto Silva', '269.183.534-23');
INSERT INTO VENDEDOR VALUES (102, 'Ana Amélia', '387.678.843-24');
INSERT INTO VENDEDOR VALUES (103, 'Gastão do Papo', '657.973.123-44');
INSERT INTO VENDEDOR VALUES (104, 'Antônio Rivoril', '130.253.493-51');
INSERT INTO VENDEDOR VALUES (105, 'Ricardo Amoedo', '657.104.303-12');
INSERT INTO VENDEDOR VALUES (106, 'Joana Malaquias Amoedo', '736.170.127-53');

/* TABELA FONE VENDEDOR */
INSERT INTO FONE_VENDEDOR VALUES ('(67)98377-1241',100);
INSERT INTO FONE_VENDEDOR VALUES ('(63)98835-0492',101);
INSERT INTO FONE_VENDEDOR VALUES ('(62)98404-0383',102);
INSERT INTO FONE_VENDEDOR VALUES ('(61)98593-8475',104);
INSERT INTO FONE_VENDEDOR VALUES ('(77)98682-7566',105);
INSERT INTO FONE_VENDEDOR VALUES ('(45)98770-6757',106);
INSERT INTO FONE_VENDEDOR VALUES ('(21)98061-5642',103);

/* TABELA PRODUTO */
INSERT INTO PRODUTO VALUES (200, 'Áreia fina', 'Saco 15 kg');
INSERT INTO PRODUTO VALUES (201, 'Áreia grossa', 'Saco 15 kg');
INSERT INTO PRODUTO VALUES (202, 'Cimento', 'Saco 20 kg');
INSERT INTO PRODUTO VALUES (203, 'Vergalhão fino', 'Barra 1/2');
INSERT INTO PRODUTO VALUES (204, 'Vergalhão grosso', 'Barra 1/2');
INSERT INTO PRODUTO VALUES (205, 'Cal', 'Saco 10 kg');
INSERT INTO PRODUTO VALUES (206, 'Rejunte preto', 'Kg');
INSERT INTO PRODUTO VALUES (207, 'Rejunte marrom', 'Kg');
INSERT INTO PRODUTO VALUES (208, 'Argamassa fraca', 'Kg');
INSERT INTO PRODUTO VALUES (209, 'Argamassa médio', 'Kg');
INSERT INTO PRODUTO VALUES (210, 'Argamassa forte', 'Kg');

/* TABELA PEDIDO */
INSERT INTO PEDIDO VALUES (1,'10-05-2017','10-06-2017','Alfredo Justino', 66, 'Interlagos', 'Próximo à lagoa principal','Três Lagoas','MS','76000-000',NULL,10,100);
INSERT INTO PEDIDO VALUES (2,'11-06-2017','15-06-2017','Alfredo Justino', 66, 'Interlagos', 'Próximo à lagoa principal','Três Lagoas','MS','76000-000',NULL,10,100);
INSERT INTO PEDIDO VALUES (3,'10-07-2017',NULL,NULL, NULL, NULL, NULL,NULL,NULL,NULL,NULL,10,101);
INSERT INTO PEDIDO VALUES (4,'12-08-2017','10-08-2017','Alfredo Justino', 66, 'Interlagos', 'Próximo à lagoa principal','Três Lagoas','MS','76000-000',NULL,10,102);
INSERT INTO PEDIDO VALUES (5,'23-09-2017',NULL,NULL, NULL, NULL, NULL,NULL,NULL,NULL,NULL,10,102);
INSERT INTO PEDIDO VALUES (6,'20-02-2018','10-03-2018','Alfredo Justino', 66, 'Interlagos', 'Próximo à lagoa principal','Três Lagoas','MS','76000-000',NULL,10,102);
INSERT INTO PEDIDO VALUES (7,'10-03-2018',NULL,NULL, NULL, NULL, NULL,NULL,NULL,NULL,NULL,10,100);
INSERT INTO PEDIDO VALUES (8,'15-08-2017','10-09-2017','Manguaguá', 226, 'São Gonçalo', 'Imediações do buracão','Santos','SP','72100-010',NULL,11,100);
INSERT INTO PEDIDO VALUES (9,'10-03-2018',NULL,NULL, NULL, NULL, NULL,NULL,NULL,NULL,NULL,11,101);
INSERT INTO PEDIDO VALUES (10,'17-04-2017','10-06-2017','Manguaguá', 226, 'São Gonçalo', 'Imediações do buracão','Santos','SP','72100-010',NULL,11,100);
INSERT INTO PEDIDO VALUES (11,'12-03-2018',NULL,NULL, NULL, NULL, NULL,NULL,NULL,NULL,NULL,11,101);
INSERT INTO PEDIDO VALUES (12,'12-05-2017','10-06-2017','Manguaguá', 226, 'São Gonçalo', 'Imediações do buracão','Santos','SP','72100-010',NULL,11,100);
INSERT INTO PEDIDO VALUES (13,'23-03-2018',NULL,NULL, NULL, NULL, NULL,NULL,NULL,NULL,NULL,11,101);
INSERT INTO PEDIDO VALUES (14,'23-03-2018',NULL,NULL, NULL, NULL, NULL,NULL,NULL,NULL,NULL,12,102);
INSERT INTO PEDIDO VALUES (15,'24-03-2018',NULL,NULL, NULL, NULL, NULL,NULL,NULL,NULL,NULL,12,102);
INSERT INTO PEDIDO VALUES (16,'25-03-2018',NULL,NULL, NULL, NULL, NULL,NULL,NULL,NULL,NULL,12,103);
INSERT INTO PEDIDO VALUES (17,'26-03-2018',NULL,NULL, NULL, NULL, NULL,NULL,NULL,NULL,NULL,12,104);
INSERT INTO PEDIDO VALUES (18,'27-03-2018',NULL,NULL, NULL, NULL, NULL,NULL,NULL,NULL,NULL,12,105);
INSERT INTO PEDIDO VALUES (19,'28-03-2018',NULL,NULL, NULL, NULL, NULL,NULL,NULL,NULL,NULL,12,106);
INSERT INTO PEDIDO VALUES (20,'29-03-2018',NULL,NULL, NULL, NULL, NULL,NULL,NULL,NULL,NULL,12,106);
INSERT INTO PEDIDO VALUES (21,'23-01-2018',NULL,NULL, NULL, NULL, NULL,NULL,NULL,NULL,NULL,11,101);
INSERT INTO PEDIDO VALUES (22,'23-01-2018',NULL,NULL, NULL, NULL, NULL,NULL,NULL,NULL,NULL,12,102);
INSERT INTO PEDIDO VALUES (23,'24-01-2018',NULL,NULL, NULL, NULL, NULL,NULL,NULL,NULL,NULL,13,102);
INSERT INTO PEDIDO VALUES (24,'25-01-2018',NULL,'General Souto Brito', 126, 'Interlagos', '','Três Lagoas','MS','76000-050',NULL,13,103);
INSERT INTO PEDIDO VALUES (25,'26-01-2018',NULL,NULL, NULL, NULL, NULL,NULL,NULL,NULL,NULL,13,104);
INSERT INTO PEDIDO VALUES (26,'27-01-2018',NULL,'General Souto Brito', 126, 'Interlagos', '','Três Lagoas','MS','76000-050',NULL,13,105);
INSERT INTO PEDIDO VALUES (27,'28-01-2018',NULL,NULL, NULL, NULL, NULL,NULL,NULL,NULL,NULL,13,106);
INSERT INTO PEDIDO VALUES (28,'29-01-2018',NULL,NULL, NULL, NULL, NULL,NULL,NULL,NULL,NULL,13,106);
INSERT INTO PEDIDO VALUES (29,'23-03-2017',NULL,NULL, NULL, NULL, NULL,NULL,NULL,NULL,NULL,14,102);
INSERT INTO PEDIDO VALUES (30,'24-03-2017',NULL,NULL, NULL, NULL, NULL,NULL,NULL,NULL,NULL,14,102);
INSERT INTO PEDIDO VALUES (31,'25-03-2017',NULL,NULL, NULL, NULL, NULL,NULL,NULL,NULL,NULL,14,103);
INSERT INTO PEDIDO VALUES (32,'26-03-2017',NULL,'Capitão Felinto', 908, 'Lapa', 'Ao lado do hopital público','São Paulo','SP','91000-000',NULL,15,104);
INSERT INTO PEDIDO VALUES (33,'27-03-2017',NULL,'Capitão Felinto', 908, 'Lapa', 'Ao lado do hopital público','São Paulo','SP','91000-000',NULL,15,105);
INSERT INTO PEDIDO VALUES (34,'28-03-2017',NULL,NULL, NULL, NULL, NULL,NULL,NULL,NULL,NULL,15,106);
INSERT INTO PEDIDO VALUES (35,'29-03-2017',NULL,NULL, NULL, NULL, NULL,NULL,NULL,NULL,NULL,15,106);
INSERT INTO PEDIDO VALUES (36,'23-03-2017',NULL,'Jorge Aragão', 1005, 'Campo Limpo', 'Frente à PF','Cristalina','GO','56080-000',NULL,16,102);
INSERT INTO PEDIDO VALUES (37,'24-04-2017',NULL,'Jorge Aragão', 1005, 'Campo Limpo', 'Frente à PF','Cristalina','GO','56080-000',NULL,16,102);
INSERT INTO PEDIDO VALUES (38,'25-05-2017',NULL,NULL, NULL, NULL, NULL,NULL,NULL,NULL,NULL,16,103);
INSERT INTO PEDIDO VALUES (39,'26-06-2017',NULL,NULL, NULL, NULL, NULL,NULL,NULL,NULL,NULL,16,104);
INSERT INTO PEDIDO VALUES (40,'27-07-2017',NULL,NULL, NULL, NULL, NULL,NULL,NULL,NULL,NULL,17,105);
INSERT INTO PEDIDO VALUES (41,'28-08-2017',NULL,NULL, NULL, NULL, NULL,NULL,NULL,NULL,NULL,17,106);
INSERT INTO PEDIDO VALUES (42,'29-09-2017',NULL,NULL, NULL, NULL, NULL,NULL,NULL,NULL,NULL,17,106);
INSERT INTO PEDIDO VALUES (43,'01-03-2017',NULL,NULL, NULL, NULL, NULL,NULL,NULL,NULL,NULL,18,102);
INSERT INTO PEDIDO VALUES (44,'02-04-2017',NULL,'Jangada Amarela', 98, 'Centro', '','Sete Marias','MG','26010-010',NULL,18,102);
INSERT INTO PEDIDO VALUES (45,'03-05-2017',NULL,'Jangada Amarela', 98, 'Centro', '','Sete Marias','MG','26010-010',NULL,18,103);
INSERT INTO PEDIDO VALUES (46,'04-06-2017',NULL,NULL, NULL, NULL, NULL,NULL,NULL,NULL,NULL,18,104);
INSERT INTO PEDIDO VALUES (47,'05-07-2017',NULL,NULL, NULL, NULL, NULL,NULL,NULL,NULL,NULL,18,105);
INSERT INTO PEDIDO VALUES (48,'06-08-2017',NULL,NULL, NULL, NULL, NULL,NULL,NULL,NULL,NULL,20,106);
INSERT INTO PEDIDO VALUES (49,'07-09-2017',NULL,NULL, NULL, NULL, NULL,NULL,NULL,NULL,NULL,20,106);
INSERT INTO PEDIDO VALUES (50,'08-04-2017',NULL,'Indaiá dos Nobres', 1066, 'Lapa', 'Próximo à Mangueira','Alto das Garças','MT','73100-002',NULL,30,102);
INSERT INTO PEDIDO VALUES (51,'09-04-2017',NULL,'Indaiá dos Nobres', 1066, 'Lapa', 'Próximo à Mangueira','Alto das Garças','MT','73100-002',NULL,30,102);
INSERT INTO PEDIDO VALUES (52,'03-05-2017',NULL,'Alfredo Justino', 1122, 'Colina', 'Final da rua','Sobral','BA','51101-000',NULL,31,103);
INSERT INTO PEDIDO VALUES (53,'04-05-2017',NULL,'Alfredo Justino', 1122, 'Colina', 'Final da rua','Sobral','BA','51101-000',NULL,31,104);
INSERT INTO PEDIDO VALUES (54,'05-07-2017',NULL,NULL, NULL, NULL, NULL,NULL,NULL,NULL,NULL,31,105);
INSERT INTO PEDIDO VALUES (55,'06-07-2017',NULL,NULL, NULL, NULL, NULL,NULL,NULL,NULL,NULL,31,106);
INSERT INTO PEDIDO VALUES (56,'08-10-2017',NULL,NULL, NULL, NULL, NULL,NULL,NULL,NULL,NULL,32,106);
INSERT INTO PEDIDO VALUES (57,'10-04-2017',NULL,NULL, NULL, NULL, NULL,NULL,NULL,NULL,NULL,33,102);
INSERT INTO PEDIDO VALUES (58,'11-11-2017',NULL,'Jorge Amado', 180, 'Lamaçal', '','Lagoas','ES','75106-109',NULL,34,102);
INSERT INTO PEDIDO VALUES (59,'13-05-2017',NULL,'Jorge Amado', 180, 'Lamaçal', '','Lagoas','ES','75106-109',NULL,34,103);
INSERT INTO PEDIDO VALUES (60,'14-05-2017',NULL,NULL, NULL, NULL, NULL,NULL,NULL,NULL,NULL,34,104);
INSERT INTO PEDIDO VALUES (61,'15-07-2017',NULL,NULL, NULL, NULL, NULL,NULL,NULL,NULL,NULL,35,105);
INSERT INTO PEDIDO VALUES (62,'16-12-2017',NULL,'Xique Xique', 1999, 'Mangueiral', '','Tapera','AM','86170-000',NULL,36,106);
INSERT INTO PEDIDO VALUES (63,'18-10-2017',NULL,'Xique Xique', 1999, 'Mangueiral', '','Tapera','AM','86170-000',NULL,36,106);

/* TABELA ITEM PRODUTO */
-- INSERT INTO ITEM_PRODUTO VALUES (200,1,10,5.00,NULL);

-- Produto 207 para todos os pedidos pares e ano menor 2018, quantidade 100, preço 10.00
-- Produto 206 para todos os pedidos impares e ano igual 2018,quantidade 50, preço 12.00
-- Produto 207 para todos os pedidos pares e ano igual 2018, quantidade 150, preço 14.00
-- Produto 206 para todos os pedidos impares e ano menor 2018,quantidade 200, preço 8.00
-- Produto 208 para todos sem endereço de entrega e ano igual 2017, quanbtidade 80, preço 18
-- Produto 208 para todos sem endereço de entrega e ano igual 2018, quanbtidade 70, preço 20
-- Produto 202 para todos pedidos com endereço de entrega e dia impar de entrega, quantidade 60, preço 15
-- Produto 205 para todos pedidos com endereço de entrega e dia impar de entrega, quantidade 90, preço 11
-- Produto 203 para todos pedidos com endereço de entrega e dia par de entrega, quantidade 550, preço 21
-- Produto 204 para todos pedidos com endereço de entrega e dia par de entrega, quantidade 150, preço 25

/* TABELA PRATELEIRA */
INSERT INTO PRATELEIRA VALUES (300, 'Aço inoxidável reforçada', 4);
INSERT INTO PRATELEIRA VALUES (301, 'Aço inoxidável robusta', 3);
INSERT INTO PRATELEIRA VALUES (302, 'Madeira reforçada', 5);
INSERT INTO PRATELEIRA VALUES (303, 'Madeira larga', 6);
INSERT INTO PRATELEIRA VALUES (304, 'Aço inoxidável', 5);
INSERT INTO PRATELEIRA VALUES (305, 'Concreto', 8);
INSERT INTO PRATELEIRA VALUES (306, 'Concreto revestido', 6);

/* TABELA ESTOQUE */
INSERT INTO ESTOQUE VALUES ('10-01-2017',200,300,600,NULL);
INSERT INTO ESTOQUE VALUES ('11-01-2017',201,300,700,NULL);
INSERT INTO ESTOQUE VALUES ('12-01-2017',202,300,800,'10-01-2021');
INSERT INTO ESTOQUE VALUES ('13-01-2017',203,305,510,NULL);
INSERT INTO ESTOQUE VALUES ('14-01-2017',204,306,520,NULL);
INSERT INTO ESTOQUE VALUES ('15-01-2017',205,301,530,'10-01-2022');
INSERT INTO ESTOQUE VALUES ('16-01-2017',206,303,400,'10-01-2019');
INSERT INTO ESTOQUE VALUES ('17-01-2017',207,303,550,'10-01-2019');
INSERT INTO ESTOQUE VALUES ('18-01-2017',208,302,560,'10-01-2020');
INSERT INTO ESTOQUE VALUES ('10-01-2017',209,302,700,'10-01-2020');
INSERT INTO ESTOQUE VALUES ('10-01-2017',210,302,800,'10-01-2020');
INSERT INTO ESTOQUE VALUES ('10-01-2010',200,300,900,NULL);
INSERT INTO ESTOQUE VALUES ('18-01-2010',201,300,400,NULL);
INSERT INTO ESTOQUE VALUES ('10-01-2010',202,300,300,'10-01-2014');
INSERT INTO ESTOQUE VALUES ('20-01-2010',203,305,590,NULL);
INSERT INTO ESTOQUE VALUES ('14-01-2010',204,306,580,NULL);
INSERT INTO ESTOQUE VALUES ('12-01-2010',205,301,570,'10-01-2015');
INSERT INTO ESTOQUE VALUES ('06-01-2010',206,303,400,'10-01-2015');
INSERT INTO ESTOQUE VALUES ('10-01-2010',207,303,300,'10-01-2012');
INSERT INTO ESTOQUE VALUES ('22-01-2010',208,302,800,'10-01-2011');
INSERT INTO ESTOQUE VALUES ('25-01-2010',209,302,590,'10-01-2013');
INSERT INTO ESTOQUE VALUES ('10-01-2010',210,302,200,'10-01-2016');
INSERT INTO ESTOQUE VALUES ('13-02-2016',200,300,100,NULL);
INSERT INTO ESTOQUE VALUES ('14-03-2015',201,300,200,NULL);
INSERT INTO ESTOQUE VALUES ('11-01-2014',202,300,300,'11-01-2018');
INSERT INTO ESTOQUE VALUES ('13-06-2015',203,305,500,NULL);
INSERT INTO ESTOQUE VALUES ('10-08-2014',204,306,500,NULL);
INSERT INTO ESTOQUE VALUES ('18-06-2016',205,301,700,'10-01-2021');
INSERT INTO ESTOQUE VALUES ('10-01-2018',206,303,590,'10-01-2020');
INSERT INTO ESTOQUE VALUES ('04-05-2017',207,303,580,'10-01-2019');
INSERT INTO ESTOQUE VALUES ('10-09-2016',208,302,570,'10-01-2019');
INSERT INTO ESTOQUE VALUES ('17-03-2015',209,302,560,'10-01-2018');
INSERT INTO ESTOQUE VALUES ('20-02-2016',210,302,400,'10-01-2019');

/* TABELA CAPACIDADE ESTOQUE */
INSERT INTO CAPACIDADE_ESTOQUE VALUES (200,300,1000);
INSERT INTO CAPACIDADE_ESTOQUE VALUES (201,300,1000);
INSERT INTO CAPACIDADE_ESTOQUE VALUES (202,300,800);
INSERT INTO CAPACIDADE_ESTOQUE VALUES (203,305,2000);
INSERT INTO CAPACIDADE_ESTOQUE VALUES (204,305,100);
INSERT INTO CAPACIDADE_ESTOQUE VALUES (205,300,1500);
INSERT INTO CAPACIDADE_ESTOQUE VALUES (206,303,2500);
INSERT INTO CAPACIDADE_ESTOQUE VALUES (207,303,2500);
INSERT INTO CAPACIDADE_ESTOQUE VALUES (208,300,10050);
INSERT INTO CAPACIDADE_ESTOQUE VALUES (209,300,10050);
INSERT INTO CAPACIDADE_ESTOQUE VALUES (210,300,10050);
INSERT INTO CAPACIDADE_ESTOQUE VALUES (200,301,2000);
INSERT INTO CAPACIDADE_ESTOQUE VALUES (201,301,2000);
INSERT INTO CAPACIDADE_ESTOQUE VALUES (202,301,1800);
INSERT INTO CAPACIDADE_ESTOQUE VALUES (203,306,1000);
INSERT INTO CAPACIDADE_ESTOQUE VALUES (204,306,50);
INSERT INTO CAPACIDADE_ESTOQUE VALUES (205,301,2500);
INSERT INTO CAPACIDADE_ESTOQUE VALUES (206,306,2500);
INSERT INTO CAPACIDADE_ESTOQUE VALUES (207,304,2500);
INSERT INTO CAPACIDADE_ESTOQUE VALUES (208,301,20050);
INSERT INTO CAPACIDADE_ESTOQUE VALUES (209,301,20050);
INSERT INTO CAPACIDADE_ESTOQUE VALUES (210,301,20050);
INSERT INTO CAPACIDADE_ESTOQUE VALUES (200,302,800);
INSERT INTO CAPACIDADE_ESTOQUE VALUES (201,302,800);
INSERT INTO CAPACIDADE_ESTOQUE VALUES (202,302,800);
INSERT INTO CAPACIDADE_ESTOQUE VALUES (203,302,500);
INSERT INTO CAPACIDADE_ESTOQUE VALUES (204,302,20);
INSERT INTO CAPACIDADE_ESTOQUE VALUES (205,302,800);
INSERT INTO CAPACIDADE_ESTOQUE VALUES (206,302,1700);
INSERT INTO CAPACIDADE_ESTOQUE VALUES (207,302,1700);
INSERT INTO CAPACIDADE_ESTOQUE VALUES (208,302,7050);
INSERT INTO CAPACIDADE_ESTOQUE VALUES (209,302,7050);
INSERT INTO CAPACIDADE_ESTOQUE VALUES (210,302,7050);
INSERT INTO CAPACIDADE_ESTOQUE VALUES (200,305,1500);
INSERT INTO CAPACIDADE_ESTOQUE VALUES (201,305,1500);
INSERT INTO CAPACIDADE_ESTOQUE VALUES (202,305,1500);
INSERT INTO CAPACIDADE_ESTOQUE VALUES (203,300,1000);
INSERT INTO CAPACIDADE_ESTOQUE VALUES (204,300,50);
INSERT INTO CAPACIDADE_ESTOQUE VALUES (205,305,1900);
INSERT INTO CAPACIDADE_ESTOQUE VALUES (206,304,2500);
INSERT INTO CAPACIDADE_ESTOQUE VALUES (207,306,2500);
INSERT INTO CAPACIDADE_ESTOQUE VALUES (208,305,15050);
INSERT INTO CAPACIDADE_ESTOQUE VALUES (209,305,15050);
INSERT INTO CAPACIDADE_ESTOQUE VALUES (210,305,15050);
