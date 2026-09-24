-- ============================================================
-- DATABASE: DOCERIA
-- 01_schema.sql
-- PostgreSQL
-- ============================================================

CREATE TABLE cliente (
    id_cliente SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    cidade VARCHAR(70),
    ativo BOOLEAN DEFAULT FALSE
);

CREATE TABLE tipo_doce (
    id_tipo SERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE doce (
    id_doce SERIAL PRIMARY KEY,
    nome VARCHAR(70) NOT NULL,
    preco NUMERIC(10,2) NOT NULL,
    id_tipo INTEGER NOT NULL REFERENCES tipo_doce(id_tipo),
    estoque INTEGER NOT NULL
);

CREATE TABLE pedido (
    id_pedido SERIAL PRIMARY KEY,
    id_cliente INTEGER NOT NULL REFERENCES cliente(id_cliente),
    data_pedido DATE NOT NULL,
    status VARCHAR(25) NOT NULL,
);

CREATE TABLE itens_pedido (
    id_item SERIAL PRIMARY KEY,
    id_pedido INTEGER NOT NULL REFERENCES pedido(id_pedido),
    id_doce INTEGER NOT NULL REFERENCES doce(id_doce),
    quantidade INTEGER NOT NULL
);
