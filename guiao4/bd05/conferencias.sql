CREATE TABLE Artigo(
	NREGISTO	INT,
	TITULO		VARCHAR(20),

	PRIMARY KEY(NREGISTO)
);

CREATE TABLE Instituicao(
	NOME		VARCHAR(20),
	ENDERECO	VARCHAR(20),

	PRIMARY KEY(NOME)
);

CREATE TABLE Autor(
	NOME		VARCHAR(20),
	EMAIL		VARCHAR(20),
	INSTITUICAO	VARCHAR(20),

	PRIMARY KEY(NOME),
	FOREIGN KEY(INSTITUICAO) REFERENCES Instituicao(NOME)
);
CREATE TABLE Tem(
	NARTIGO		INT,
	NOMEAUTOR	VARCHAR(20),

	PRIMARY KEY(NARTIGO,NOMEAUTOR),
	FOREIGN KEY(NARTIGO) REFERENCES Artigo(NREGISTO),
	FOREIGN KEY(NOMEAUTOR) REFERENCES Autor(NOME)
);

CREATE TABLE Participante(
	NOME		VARCHAR(20),
	INSTITUICAO	VARCHAR(20),
	NOMEE		VARCHAR(20),
	DATA		DATE,
	EMAIL		VARCHAR(20),
	MORADA		VARCHAR(20),
	NINSTITUICAO	VARCHAR(20),

	PRIMARY KEY(NOME),
	FOREIGN KEY(NINSTITUICAO) REFERENCES Instituicao(NOME)
);

CREATE TABLE Estudante(
	NOME			VARCHAR(20),
	COMPROVATIVO	VARCHAR(20),
	LOCALIZACAO		VARCHAR(20),

	PRIMARY KEY(NOME),
	FOREIGN KEY(NOME) REFERENCES Participante(NOME)
);

CREATE TABLE N_Estudante(
	NOME		VARCHAR(20),
	REFERENCIA	INT,

	PRIMARY KEY(NOME),
	FOREIGN KEY(NOME) REFERENCES Participante(NOME)
);