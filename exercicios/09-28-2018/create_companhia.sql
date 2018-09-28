CREATE DATABASE COMPANHIA;
go

USE COMPANHIA;
go

CREATE SCHEMA ADMINISTRACAO;
go

CREATE TABLE ADMINISTRACAO.EMPREGADO (
	Pnome		VARCHAR(15)		NOT NULL,
	Mnome		CHAR,
	Unome		VARCHAR(15)		NOT NULL,
	CPF			CHAR(9)			NOT NULL,
	Data_nasc	DATE,
	Endereco	VARCHAR(30),
	Sexo		CHAR,
	Salario		DECIMAL(10,2),
	CPF_super	CHAR(9),
	Dnum		INT				NOT NULL,
	CONSTRAINT pk_empregado	PRIMARY KEY (CPF),
	CONSTRAINT fk_emp_super FOREIGN KEY (CPF_super) REFERENCES ADMINISTRACAO.EMPREGADO (CPF)
);

CREATE TABLE ADMINISTRACAO.DEPARTAMENTO (
	Dnome			VARCHAR(15)		NOT NULL,
	Dnumero			INT				NOT NULL,
	CPF_ger			CHAR(9)			NOT NULL,
	Data_ini_ger	DATE,
	CONSTRAINT pk_departamento PRIMARY KEY (Dnumero),
	CONSTRAINT uq_nome_depto UNIQUE (Dnome),
	CONSTRAINT fk_depto_ger FOREIGN KEY (CPF_ger) REFERENCES ADMINISTRACAO.EMPREGADO(CPF)
);

-- Depois que cria a tabela DEPARTAMENTO, pode-se inserir a chave estrangeira de empregado
-- que referencia a tabela DEPARTAMENTO.
ALTER TABLE ADMINISTRACAO.EMPREGADO ADD CONSTRAINT fk_emp_depto FOREIGN KEY (Dnum) REFERENCES ADMINISTRACAO.DEPARTAMENTO (Dnumero);

CREATE TABLE ADMINISTRACAO.DEPTO_LOCAL (
	Dnumero			INT				NOT NULL,
	Dlocal			VARCHAR(15)		NOT NULL,
	CONSTRAINT pk_depto_local PRIMARY KEY (Dnumero, Dlocal),
	CONSTRAINT fk_depto_local_depto FOREIGN KEY (Dnumero) REFERENCES ADMINISTRACAO.DEPARTAMENTO (Dnumero)
);

CREATE TABLE ADMINISTRACAO.PROJETO (
	Pnome			VARCHAR(15)		NOT NULL,
	Pnumero			INT				NOT NULL,
	Plocal			VARCHAR(15),
	Dnum			INT				NOT NULL,
	CONSTRAINT pk_projeto PRIMARY KEY (Pnumero),
	CONSTRAINT uk_nome_proj UNIQUE (Pnome),
	CONSTRAINT fk_proj_depto FOREIGN KEY (Dnum) REFERENCES ADMINISTRACAO.DEPARTAMENTO (Dnumero)
);

CREATE TABLE ADMINISTRACAO.TRABALHA_EM (
	ECPF			CHAR(9)			NOT NULL,
	Pno				INT				NOT NULL,
	Horas			DECIMAL(3,1),
	CONSTRAINT pk_trabalha_em PRIMARY KEY (ECPF, Pno),
	CONSTRAINT fk_trabalha_em_emp FOREIGN KEY (ECPF) REFERENCES ADMINISTRACAO.EMPREGADO (CPF),
	CONSTRAINT fk_trabalha_em_pjto FOREIGN KEY (Pno) REFERENCES ADMINISTRACAO.PROJETO (Pnumero)
);

CREATE TABLE ADMINISTRACAO.DEPENDENTE (
	ECPF			CHAR(9)			NOT NULL,
	Nome_dep		VARCHAR(15),
	Sexo			CHAR,
	Data_nasc		DATE,
	Relacionamento	VARCHAR(8),
	CONSTRAINT pk_dependente PRIMARY KEY (ECPF, Nome_dep),
	CONSTRAINT fk_dep_emp FOREIGN KEY (ECPF) REFERENCES ADMINISTRACAO.EMPREGADO (CPF)
);

/*
USE master;
DROP DATABASE COMPANHIA;
*/