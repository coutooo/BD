CREATE TABLE fornecedor (
	nif			CHAR(9),
	nome		VARCHAR(30) NOT NULL,
	endereco	VARCHAR(30) NOT NULL,
	fax			CHAR(9) NOT NULL,
	pagamento	MONEY NOT NULL,
	PRIMARY KEY(nif)
);

CREATE TABLE tipo_fornecedor (
	codigo		INT,
	designacao	VARCHAR(30) NOT NULL,
	PRIMARY KEY(codigo)
);

CREATE TABLE tem_tipo (
	nif_fornecedor			CHAR(9),
	codigo_tipo_fornecedor	INT,
	PRIMARY KEY(nif_fornecedor, codigo_tipo_fornecedor),
	FOREIGN KEY(nif_fornecedor) REFERENCES fornecedor(nif),
	FOREIGN KEY(codigo_tipo_fornecedor) REFERENCES tipo_fornecedor(codigo)
);

CREATE TABLE encomenda (
	numero			INT,
	encomenda_data	DATE NOT NULL,
	fornecedor		VARCHAR(30) NOT NULL,
	nif_fornecedor	CHAR(9) NOT NULL,
	PRIMARY KEY(numero),
	FOREIGN KEY(nif_fornecedor) REFERENCES fornecedor(nif)
);

CREATE TABLE processo (
	codigo		INT,
	nome		VARCHAR(30) NOT NULL,
	preco		MONEY NOT NULL,
	iva			NUMERIC(4, 2) DEFAULT 0,
	PRIMARY KEY(codigo)
);

CREATE TABLE item (
	codigo_processo		INT,
	numero_encomenda	INT,
	numero_item			INT NOT NULL,
	PRIMARY KEY(codigo_processo, numero_encomenda),
	FOREIGN KEY(codigo_processo) REFERENCES processo(codigo),
	FOREIGN KEY(numero_encomenda) REFERENCES encomenda(numero),
	CHECK(numero_item > 0)
);