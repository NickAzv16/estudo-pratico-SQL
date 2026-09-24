# 📝 Notas de estudo

## Como pensar uma consulta SQL

Uma sequência mental que funcionou durante os exercícios:

1. **O que eu quero mostrar?** → `SELECT`
2. **De onde vêm os dados?** → `FROM`
3. **Preciso relacionar outra tabela?** → `JOIN`
4. **Preciso filtrar linhas?** → `WHERE`
5. **Preciso agrupar?** → `GROUP BY`
6. **Preciso filtrar o resultado dos grupos?** → `HAVING`
7. **Preciso ordenar?** → `ORDER BY`

### WHERE x HAVING

`WHERE` filtra registros antes do agrupamento.

`HAVING` filtra grupos depois do `GROUP BY`.

Exemplo:

```sql
SELECT cidade, COUNT(*)
FROM cliente
WHERE ativo = TRUE
GROUP BY cidade
HAVING COUNT(*) > 1;
```

### JOIN x UNION

`JOIN` combina colunas de tabelas relacionadas.

`UNION` empilha resultados de consultas diferentes, desde que elas tenham a mesma quantidade de colunas e tipos compatíveis.

### Subconsulta

Quando a pergunta pode ser entendida como:

> "Primeiro faça X. Depois use o resultado de X para fazer Y."

uma subconsulta pode ser uma boa solução.

Exemplo:

```sql
SELECT AVG(valor_pedido)
FROM (
    SELECT
        id_pedido,
        SUM(...) AS valor_pedido
    FROM ...
    GROUP BY id_pedido
) AS totais;
```
