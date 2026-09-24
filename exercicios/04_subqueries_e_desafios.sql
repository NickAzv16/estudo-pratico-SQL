-- ============================================================
-- EXERCÍCIOS 29-36
-- Subconsultas, médias, totais e relatórios
-- ============================================================

-- 29. Mostrar o cliente que mais gastou.
SELECT
    cliente.id_cliente,
    cliente.nome,
    SUM(doce.preco * itens_pedido.quantidade) AS total_gasto
FROM cliente
INNER JOIN pedido
    ON cliente.id_cliente = pedido.id_cliente
INNER JOIN itens_pedido
    ON pedido.id_pedido = itens_pedido.id_pedido
INNER JOIN doce
    ON itens_pedido.id_doce = doce.id_doce
GROUP BY cliente.id_cliente, cliente.nome
ORDER BY total_gasto DESC
LIMIT 1;


-- 30. Mostrar o doce que gerou mais dinheiro para a doceria.
SELECT
    doce.id_doce,
    doce.nome,
    SUM(itens_pedido.quantidade) AS quantidade_vendida,
    SUM(doce.preco * itens_pedido.quantidade) AS valor_total_doce_vendido
FROM doce
INNER JOIN itens_pedido
    ON doce.id_doce = itens_pedido.id_doce
GROUP BY doce.id_doce, doce.nome
ORDER BY valor_total_doce_vendido DESC
LIMIT 1;


-- 31. Mostrar tipos de doce cujo total de vendas seja maior que R$50.
SELECT
    tipo_doce.nome,
    SUM(doce.preco * itens_pedido.quantidade) AS total_vendas
FROM tipo_doce
INNER JOIN doce
    ON tipo_doce.id_tipo = doce.id_tipo
INNER JOIN itens_pedido
    ON doce.id_doce = itens_pedido.id_doce
GROUP BY tipo_doce.id_tipo, tipo_doce.nome
HAVING SUM(doce.preco * itens_pedido.quantidade) > 50;


-- 32. Mostrar clientes com mais de 1 pedido.
SELECT
    cliente.id_cliente,
    cliente.nome,
    COUNT(pedido.id_pedido) AS quantidade_pedidos
FROM cliente
INNER JOIN pedido
    ON cliente.id_cliente = pedido.id_cliente
GROUP BY cliente.id_cliente, cliente.nome
HAVING COUNT(pedido.id_pedido) > 1;


-- 33. Mostrar o doce mais vendido considerando quantidade.
SELECT
    doce.id_doce,
    doce.nome,
    SUM(itens_pedido.quantidade) AS quantidade_vendida
FROM doce
INNER JOIN itens_pedido
    ON doce.id_doce = itens_pedido.id_doce
GROUP BY doce.id_doce, doce.nome
ORDER BY quantidade_vendida DESC
LIMIT 1;


-- 34. Calcular o valor médio dos pedidos.
-- Primeiro calculamos o total de cada pedido.
-- Depois calculamos a média desses totais.
SELECT AVG(valor_pedido) AS valor_medio_pedidos
FROM (
    SELECT
        pedido.id_pedido,
        SUM(doce.preco * itens_pedido.quantidade) AS valor_pedido
    FROM pedido
    INNER JOIN itens_pedido
        ON pedido.id_pedido = itens_pedido.id_pedido
    INNER JOIN doce
        ON itens_pedido.id_doce = doce.id_doce
    GROUP BY pedido.id_pedido
) AS totais;


-- 35. Mostrar somente os clientes cujo total gasto
-- seja maior que o valor médio gasto pelos clientes.
SELECT
    c.id_cliente,
    c.nome,
    c.total_gasto_cliente
FROM (
    SELECT
        cliente.id_cliente,
        cliente.nome,
        SUM(doce.preco * itens_pedido.quantidade) AS total_gasto_cliente
    FROM cliente
    INNER JOIN pedido
        ON cliente.id_cliente = pedido.id_cliente
    INNER JOIN itens_pedido
        ON itens_pedido.id_pedido = pedido.id_pedido
    INNER JOIN doce
        ON itens_pedido.id_doce = doce.id_doce
    GROUP BY cliente.id_cliente, cliente.nome
) AS c
WHERE c.total_gasto_cliente > (
    SELECT AVG(t.total_gasto_cliente)
    FROM (
        SELECT
            cliente.id_cliente,
            SUM(doce.preco * itens_pedido.quantidade) AS total_gasto_cliente
        FROM cliente
        INNER JOIN pedido
            ON cliente.id_cliente = pedido.id_cliente
        INNER JOIN itens_pedido
            ON itens_pedido.id_pedido = pedido.id_pedido
        INNER JOIN doce
            ON itens_pedido.id_doce = doce.id_doce
        GROUP BY cliente.id_cliente
    ) AS t
);


-- 36. Relatório final por cliente:
-- quantidade de pedidos, quantidade de itens e total gasto.
-- LEFT JOIN mantém clientes que não possuem compras.
SELECT
    cliente.id_cliente,
    cliente.nome,
    COUNT(DISTINCT pedido.id_pedido) AS quantidade_pedidos,
    COALESCE(SUM(itens_pedido.quantidade), 0) AS quantidade_itens,
    COALESCE(
        SUM(doce.preco * itens_pedido.quantidade),
        0
    ) AS total_gasto
FROM cliente
LEFT JOIN pedido
    ON cliente.id_cliente = pedido.id_cliente
LEFT JOIN itens_pedido
    ON pedido.id_pedido = itens_pedido.id_pedido
LEFT JOIN doce
    ON itens_pedido.id_doce = doce.id_doce
GROUP BY cliente.id_cliente, cliente.nome
HAVING COALESCE(SUM(doce.preco * itens_pedido.quantidade), 0) > 40
ORDER BY total_gasto DESC;
