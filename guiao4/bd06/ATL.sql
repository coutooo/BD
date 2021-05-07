CREATE TABLE Turma(
	ID		INT,
	PROFESSOR	VARCHAR(20),
	DESIGNACAO	VARCHAR(20),
	ANO			INT,
	MAXALUNOS	INT,

	PRIMARY KEY(ID)
);

CREATE TABLE Professor(
	NFUNCIONARIO	INT,
	NOME			VARCHAR(20),
	DATA			DATE,
	NCIDADAO		INT,
	EMAIL			VARCHAR(20),
	MORADA			VARCHAR(20),
	TELEFONE		CHAR(9),
	TURMA			INT,

	PRIMARY KEY(NFUNCIONARIO),
	FOREIGN KEY(TURMA) REFERENCES Turma(ID)
);

CREATE TABLE Atividade(
	ID			INT,
	CUSTO		INT,
	DESIGNACAO	VARCHAR(20),

	PRIMARY KEY(ID)
);

CREATE TABLE Tem(
	TURMA		INT,
	ATIVIDADE	INT,

	PRIMARY KEY(Turma, ATIVIDADE),
	FOREIGN KEY(TURMA) REFERENCES Turma(ID),
	FOREIGN KEY(ATIVIDADE) REFERENCES Atividade(ID)
);

CREATE TABLE Encarregado(
	NCARTAO		INT,
	NOME		VARCHAR(20),
	MORADA		VARCHAR(20),
	DATA		DATE,
	EMAIL		VARCHAR(20),
	TELEFONE	CHAR(9),

	PRIMARY KEY(NCARTAO)
);

CREATE TABLE Aluno(
	NCARTAO		INT,
	NOME		VARCHAR(20),
	MORADA		VARCHAR(20),
	DATA		DATE,
	ESCOLARIDADE	VARCHAR(20),
	RELACAO		VARCHAR(20),
	TURMA		INT,
	ENCARREGADO	INT,

	PRIMARY KEY(NCARTAO),
	FOREIGN KEY(TURMA) REFERENCES Turma(ID),
	FOREIGN KEY(ENCARREGADO) REFERENCES Encarregado(NCARTAO)
);

CREATE TABLE Autorizado(
	NCARTAO		INT,
	NOME		VARCHAR(20),
	MORADA		VARCHAR(20),
	DATA		DATE,
	EMAIL		VARCHAR(20),
	TELEFONE	CHAR(9),
	NALUNO		INT,

	PRIMARY KEY(NCARTAO),
	FOREIGN KEY(NALUNO) REFERENCES Aluno(NCARTAO)
);