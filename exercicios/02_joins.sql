-- ============================================================
-- EXERCÍCIOS 15-24
-- JOINs, EXISTS e agregações relacionadas
-- ============================================================

-- 15. Mostrar pedidos junto com o nome do cliente.
SELECT
    pedido.id_pedido,
    cliente.nome,
    pedido.data_pedido,
    pedido.status
FROM pedido
INNER JOIN cliente
    ON cliente.id_cliente = pedido.id_cliente;


-- 16. Mostrar os doces junto com seus respectivos tipos.
SELECT
    doce.id_doce,
    doce.nome AS nome_doce,
    tipo_doce.nome AS tipo_doce
FROM doce
INNER JOIN tipo_doce
    ON tipo_doce.id_tipo = doce.id_tipo;


-- 17. Mostrar os itens dos pedidos com nome do doce e quantidade.
SELECT
    itens_pedido.id_pedido,
    doce.nome,
    itens_pedido.quantidade
FROM itens_pedido
INNER JOIN doce
    ON itens_pedido.id_doce = doce.id_doce;


-- 18. Mostrar cliente, pedido, doce e quantidade em uma única consulta.
SELECT
    cliente.nome AS nome_cliente,
    pedido.id_pedido,
    doce.nome AS nome_doce,
    itens_pedido.quantidade
FROM cliente
INNER JOIN pedido
    ON cliente.id_cliente = pedido.id_cliente
INNER JOIN itens_pedido
    ON pedido.id_pedido = itens_pedido.id_pedido
INNER JOIN doce
    ON itens_pedido.id_doce = doce.id_doce;


-- 19. Mostrar clientes que possuem pelo menos um pedido usando EXISTS.
SELECT
    cliente.id_cliente,
    cliente.nome
FROM cliente
WHERE EXISTS (
    SELECT 1
    FROM pedido
    WHERE pedido.id_cliente = cliente.id_cliente
);


-- 20. Mostrar a quantidade de pedidos de cada cliente.
SELECT
    cliente.id_cliente,
    cliente.nome,
    COUNT(pedido.id_pedido) AS quantidade_pedidos
FROM cliente
LEFT JOIN pedido
    ON cliente.id_cliente = pedido.id_cliente
GROUP BY cliente.id_cliente, cliente.nome
ORDER BY quantidade_pedidos DESC;


-- 21. Mostrar clientes que possuem mais de 1 pedido.
SELECT
    cliente.id_cliente,
    cliente.nome,
    COUNT(pedido.id_pedido) AS quantidade_pedidos
FROM cliente
INNER JOIN pedido
    ON cliente.id_cliente = pedido.id_cliente
GROUP BY cliente.id_cliente, cliente.nome
HAVING COUNT(pedido.id_pedido) > 1;


-- 22. Mostrar o valor de cada item de pedido.
SELECT
    itens_pedido.id_pedido,
    doce.nome AS nome_doce,
    itens_pedido.quantidade,
    doce.preco,
    doce.preco * itens_pedido.quantidade AS valor_item
FROM itens_pedido
INNER JOIN doce
    ON itens_pedido.id_doce = doce.id_doce;


-- 23. Mostrar o valor total de cada pedido.
SELECT
    pedido.id_pedido,
    SUM(doce.preco * itens_pedido.quantidade) AS valor_pedido
FROM pedido
INNER JOIN itens_pedido
    ON pedido.id_pedido = itens_pedido.id_pedido
INNER JOIN doce
    ON itens_pedido.id_doce = doce.id_doce
GROUP BY pedido.id_pedido
ORDER BY pedido.id_pedido;


-- 24. Mostrar o doce mais vendido em quantidade.
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
