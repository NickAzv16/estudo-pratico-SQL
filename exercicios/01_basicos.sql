-- ============================================================
-- EXERCÍCIOS 01-14
-- Consultas básicas, filtros e agregações
-- ============================================================

-- 01. Mostrar clientes de Mogi das Cruzes ou Suzano.
SELECT *
FROM cliente
WHERE cidade IN ('Mogi das Cruzes', 'Suzano');


-- 02. Mostrar somente clientes ativos.
SELECT *
FROM cliente
WHERE ativo = TRUE;


-- 03. Mostrar a quantidade de clientes por cidade.
SELECT
    cidade,
    COUNT(id_cliente) AS quantidade_clientes
FROM cliente
GROUP BY cidade
ORDER BY quantidade_clientes DESC;


-- 04. Mostrar a quantidade total de clientes.
SELECT COUNT(id_cliente) AS quantidade_clientes
FROM cliente;


-- 05. Somar os preços cadastrados dos doces.
SELECT SUM(preco) AS soma_precos_doces
FROM doce;


-- 06. Mostrar doces com preço entre R$5 e R$40.
SELECT *
FROM doce
WHERE preco BETWEEN 5 AND 40;


-- 07. Mostrar doces cujo nome contém "Bolo".
SELECT *
FROM doce
WHERE nome LIKE '%Bolo%';


-- 08. Mostrar o maior preço de doce.
SELECT MAX(preco) AS maior_preco
FROM doce;


-- 09. Mostrar o menor preço de doce.
SELECT MIN(preco) AS menor_preco
FROM doce;


-- 10. Mostrar o preço médio dos doces.
SELECT AVG(preco) AS preco_medio
FROM doce;


-- 11. Mostrar a soma dos preços dos doces com duas casas decimais.
SELECT TRUNC(SUM(preco), 2) AS soma_precos
FROM doce;


-- 12. Mostrar tipos de doce que possuem mais de 1 doce cadastrado.
SELECT
    tipo_doce.nome,
    COUNT(doce.id_doce) AS quantidade_doces
FROM tipo_doce
INNER JOIN doce
    ON tipo_doce.id_tipo = doce.id_tipo
GROUP BY tipo_doce.nome
HAVING COUNT(doce.id_doce) > 1;


-- 13. Mostrar o preço médio dos doces de cada tipo.
SELECT
    tipo_doce.nome,
    AVG(doce.preco) AS preco_medio
FROM tipo_doce
INNER JOIN doce
    ON tipo_doce.id_tipo = doce.id_tipo
GROUP BY tipo_doce.nome;


-- 14. Mostrar somente os tipos cujo preço médio dos doces seja maior que R$20.
SELECT
    tipo_doce.nome,
    AVG(doce.preco) AS preco_medio
FROM tipo_doce
INNER JOIN doce
    ON tipo_doce.id_tipo = doce.id_tipo
GROUP BY tipo_doce.nome
HAVING AVG(doce.preco) > 20;
