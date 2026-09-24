-- ============================================================
-- DATABASE: DOCERIA
-- 02_dados.sql
-- Dados fictícios utilizados nos exercícios
-- ============================================================

INSERT INTO cliente (nome, email, cidade, ativo) VALUES
('Ana', 'ana@email.com', 'Mogi das Cruzes', TRUE),
('Bruno', 'bruno@email.com', 'Suzano', TRUE),
('Carla', 'carla@email.com', 'Mogi das Cruzes', FALSE),
('Diego', 'diego@email.com', 'Suzano', TRUE),
('Elisa', 'elisa@email.com', 'Guararema', TRUE);

INSERT INTO tipo_doce (nome) VALUES
('Bolo'),
('Torta'),
('Brigadeiro'),
('Doce'),
('Salgado');

INSERT INTO doce (nome, preco, id_tipo, estoque) VALUES
('Bolo de Chocolate', 45.00, 1, 10),
('Bolo de Morango', 50.00, 1, 5),
('Torta de Limão', 35.00, 2, 8),
('Brigadeiro Gourmet', 4.50, 3, 50),
('Beijinho', 3.50, 3, 40),
('Brownie', 8.00, 4, 20),
('Coxinha', 6.00, 5, 30);

INSERT INTO pedido (id_cliente, data_pedido, status) VALUES
(1, '2026-09-01', 'Entregue'),
(2, '2026-09-02', 'Entregue'),
(1, '2026-09-05', 'Pendente'),
(4, '2026-09-06', 'Entregue'),
(5, '2026-09-07', 'Cancelado');

INSERT INTO itens_pedido (id_pedido, id_doce, quantidade) VALUES
(1, 1, 1),
(1, 4, 5),
(2, 3, 1),
(2, 6, 2),
(3, 2, 1),
(3, 4, 3),
(4, 7, 5),
(5, 1, 1);
