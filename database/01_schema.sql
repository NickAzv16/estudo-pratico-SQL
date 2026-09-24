-- ============================================================
-- DATABASE: DOCERIA
-- 01_schema.sql
-- PostgreSQL
-- ============================================================

DROP TABLE IF EXISTS itens_pedido;
DROP TABLE IF EXISTS pedido;
DROP TABLE IF EXISTS doce;
DROP TABLE IF EXISTS tipo_doce;
DROP TABLE IF EXISTS cliente;

CREATE TABLE cliente (
    id_cliente SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(150),
    cidade VARCHAR(100),
    ativo BOOLEAN DEFAULT TRUE
);

CREATE TABLE tipo_doce (
    id_tipo SERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE doce (
    id_doce SERIAL PRIMARY KEY,
    nome VARCHAR(70) NOT NULL,
    preco NUMERIC(10,2) NOT NULL CHECK (preco >= 0),
    id_tipo INTEGER NOT NULL,
    estoque INTEGER NOT NULL DEFAULT 0 CHECK (estoque >= 0),

    CONSTRAINT fk_doce_tipo
        FOREIGN KEY (id_tipo)
        REFERENCES tipo_doce(id_tipo)
);

CREATE TABLE pedido (
    id_pedido SERIAL PRIMARY KEY,
    id_cliente INTEGER NOT NULL,
    data_pedido DATE NOT NULL,
    status VARCHAR(25) NOT NULL,

    CONSTRAINT fk_pedido_cliente
        FOREIGN KEY (id_cliente)
        REFERENCES cliente(id_cliente)
);

CREATE TABLE itens_pedido (
    id_item SERIAL PRIMARY KEY,
    id_pedido INTEGER NOT NULL,
    id_doce INTEGER NOT NULL,
    quantidade INTEGER NOT NULL CHECK (quantidade > 0),

    CONSTRAINT fk_item_pedido
        FOREIGN KEY (id_pedido)
        REFERENCES pedido(id_pedido),

    CONSTRAINT fk_item_doce
        FOREIGN KEY (id_doce)
        REFERENCES doce(id_doce)
);
