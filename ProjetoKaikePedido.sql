CREATE TABLE CLIENTE

(
CODIGO          NUMBER          CONSTRAINT PK_CLIENTE PRIMARY KEY NOT NULL,

NOME            VARCHAR2(60)    NOT NULL,
RUA             VARCHAR2(80)    NOT NULL,
NR              NUMBER(4)       NOT NULL,
BAIRRO          VARCHAR2(50)    NOT NULL,
COMPLEMENTO     VARCHAR2(100)   NULL,
CIDADE          VARCHAR2(50)    NOT NULL,
UF              VARCHAR2(2)     NOT NULL,
CEP             VARCHAR2(10)    NOT NULL
); 

CREATE TABLE PF

(
CODIGO_CLI      NUMBER          CONSTRAINT PK_CLIENTE_PF PRIMARY KEY REFERENCES CLIENTE (CODIGO) NOT NULL,

CNPF            VARCHAR2(14)    NOT NULL,
RG              VARCHAR2(10)    NOT NULL,
DATA_NASCIMENTO DATE            NOT NULL
);

CREATE TABLE PJ

(
CODIGO_CLI      NUMBER          CONSTRAINT PK_CLIENTE_PF PRIMARY KEY REFERENCES CLIENTE (CODIGO) NOT NULL,

CNPJ            VARCHAR2(19)    NOT NULL,
IE              VARCHAR2(10)    NOT NULL,
NOME_FANTASIA   VARCHAR2(60)    NOT NULL
);

CREATE TABLE PRODUTO

(
CODIGO          NUMBER          CONSTRAINT  PK_PRODUTO PRIMARY KEY NOT NULL,

DESCRICAO       VARCHAR2(80)    NOT NULL,
UNID_MEDIDA     VARCHAR2(10)    NOT NULL
);

CREATE TABLE VENDEDOR

(
MATRICULA       NUMBER          CONSTRAINT PK_VENDEDOR PRIMARY KEY NOT NULL,

NOME            VARCHAR2(60)    NOT NULL,
CNPF            VARCHAR2(14)    NOT NULL
);

CREATE TABLE FONE_CLIENTE

(
NUMERO          VARCHAR2(14)    NOT NULL,

CODIGO_CLI      NUMBER          CONSTRAINT      PK_FONE_CLIENTE PRIMARY KEY REFERENCES CLIENTE(NUMERO,CODIGO_CLI) NOT NULL
);

CREATE TABLE FONE_VENDEDOR

(
NUMERO          VARCHAR2(14)    NOT NULL,

MATRICULA_VEN   NUMBER          CONSTRAINT PK_FONE_VENDEDOR PRIMARY KEY REFERENCES VENDEDOR(MATRICULA) NOT NULL
);

CREATE TABLE PRATELEIRA

(
CODIGO          NUMBER(3)       CONSTRAINT PK_PRATELEIRA PRIMARY KEY NOT NULL,

DESCRICAO       VARCHAR2(50)    NOT NULL,
NUMERO_SECOES   NUMBER(2)       NOT NULL
);
