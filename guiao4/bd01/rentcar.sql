CREATE TABLE cliente (
	nif				CHAR(9),
	nome			VARCHAR(30) NOT NULL,
	numero_carta	CHAR(9),
	endereco		VARCHAR(30) NOT NULL,
	PRIMARY KEY(nif),
	UNIQUE(numero_carta)
);

CREATE TABLE balcao (
	numero		INT,
	nome		VARCHAR(30) NOT NULL,
	endereco	VARCHAR(30) NOT NULL,
	PRIMARY KEY(numero),
	CHECK(numero >= 0)
);

CREATE TABLE tipo_veiculo (
	codigo			INT,
	desigacao		VARCHAR(30) NOT NULL,
	ar_condicionado	BIT NOT NULL,
	PRIMARY KEY(codigo),
	CHECK(codigo >= 0)
);

CREATE TABLE tipo_ligeiro (
	codigo_veiculo	INT,
	numero_lugares	INT NOT NULL,
	portas			INT NOT NULL,
	combustivel		REAL NOT NULL,
	PRIMARY KEY(codigo_veiculo),
	FOREIGN KEY(codigo_veiculo) REFERENCES tipo_veiculo(codigo),
	CHECK(numero_lugares >= 0),
	CHECK(portas >= 0),
	CHECK(combustivel >= 0)
);

CREATE TABLE tipo_pesado (
	codigo_veiculo	INT,
	peso			INT NOT NULL,
	passageiros		INT NOT NULL,
	PRIMARY KEY(codigo_veiculo),
	FOREIGN KEY(codigo_veiculo) REFERENCES tipo_veiculo(codigo),
	CHECK(peso >= 0),
	CHECK(passageiros >= 0)
);

CREATE TABLE similaridade (
	codigo_veiculo1	INT,
	codigo_veiculo2	INT,
	PRIMARY KEY(codigo_veiculo1, codigo_veiculo2),
	FOREIGN KEY(codigo_veiculo1) REFERENCES tipo_veiculo(codigo),
	FOREIGN KEY(codigo_veiculo2) REFERENCES tipo_veiculo(codigo)
);

CREATE TABLE veiculo (
	matricula		CHAR(6),
	marca			VARCHAR(30) NOT NULL,
	ano				INT NOT NULL,
	codigo_veiculo	INT NOT NULL,
	PRIMARY KEY(matricula),
	FOREIGN KEY(codigo_veiculo) REFERENCES tipo_veiculo(codigo),
	CHECK(ano >= 0)
);

CREATE TABLE aluger (
	numero				INT,
	duracao				INT NOT NULL,
	data_aluger			DATE NOT NULL,
	nif_client			CHAR(9) NOT NULL,
	numero_balcao		INT NOT NULL,
	matricula_veiculo	CHAR(6) NOT NULL,
	PRIMARY KEY(numero),
	FOREIGN KEY(nif_client) REFERENCES cliente(nif),
	FOREIGN KEY(numero_balcao) REFERENCES balcao(numero),
	FOREIGN KEY(matricula_veiculo) REFERENCES veiculo(matricula),
	CHECK(duracao >= 0)
);