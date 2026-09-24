-- ============================================================
-- EXERCÍCIOS 25-28
-- UNION e VIEW
-- ============================================================

-- 25. Criar uma consulta com uma única coluna contendo
-- clientes e doces usando UNION.
SELECT nome
FROM cliente
UNION
SELECT nome
FROM doce;


-- 26. Exemplo de UNION mantendo duplicados.
-- UNION ALL não elimina valores repetidos.
SELECT cidade AS informacao
FROM cliente
UNION ALL
SELECT nome AS informacao
FROM tipo_doce;


-- 27. Criar uma VIEW com os detalhes dos pedidos.
CREATE OR REPLACE VIEW vw_pedido_detalhado AS
SELECT
    pedido.id_pedido,
    cliente.id_cliente,
    cliente.nome AS nome_cliente,
    pedido.data_pedido,
    pedido.status,
    doce.nome AS nome_doce,
    itens_pedido.quantidade,
    doce.preco AS preco_unitario,
    doce.preco * itens_pedido.quantidade AS valor_total_item
FROM pedido
INNER JOIN cliente
    ON pedido.id_cliente = cliente.id_cliente
INNER JOIN itens_pedido
    ON itens_pedido.id_pedido = pedido.id_pedido
INNER JOIN doce
    ON doce.id_doce = itens_pedido.id_doce;

-- Consultar a VIEW:
SELECT *
FROM vw_pedido_detalhado;


-- 28. Criar uma VIEW com o total de cada pedido
-- e consultar somente pedidos acima de R$50.
CREATE OR REPLACE VIEW vw_total_pedidos AS
SELECT
    pedido.id_pedido,
    cliente.nome,
    SUM(doce.preco * itens_pedido.quantidade) AS total_pedido
FROM cliente
INNER JOIN pedido
    ON cliente.id_cliente = pedido.id_cliente
INNER JOIN itens_pedido
    ON pedido.id_pedido = itens_pedido.id_pedido
INNER JOIN doce
    ON itens_pedido.id_doce = doce.id_doce
GROUP BY pedido.id_pedido, cliente.nome;

SELECT *
FROM vw_total_pedidos
WHERE total_pedido > 50;
