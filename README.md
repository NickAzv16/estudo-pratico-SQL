# 📚 Estudos de SQL com PostgreSQL — Projeto Doceria

Repositório criado para documentar meus estudos e exercícios práticos de **SQL com PostgreSQL**.

Durante este projeto, pratiquei consultas envolvendo filtros, agregações, relacionamentos entre tabelas, subconsultas, `JOIN`, `UNION`, `VIEW`, `EXISTS` e outras funcionalidades importantes de SQL.

> **Observação:** os exercícios foram organizados e documentados a partir das práticas realizadas durante o curso. O banco utiliza dados fictícios.

---

## 🗂️ Estrutura do projeto

```text
sql-estudos-doceria/
│
├── README.md
│
├── database/
│   ├── 01_schema.sql
│   └── 02_dados.sql
│
└── exercicios/
    ├── 01_basicos.sql
    ├── 02_joins.sql
    ├── 03_union_e_views.sql
    └── 04_subqueries_e_desafios.sql
```

---

## 🛠️ Tecnologias

- PostgreSQL
- SQL
- pgAdmin 4

---

## 🗃️ Banco de dados

O projeto simula o banco de dados de uma **doceria**.

### Tabelas

- `cliente` — informações dos clientes
- `tipo_doce` — categorias dos doces
- `doce` — produtos vendidos pela doceria
- `pedido` — pedidos realizados
- `itens_pedido` — itens pertencentes a cada pedido

### Relacionamentos principais

```text
cliente
   │
   └── pedido
          │
          └── itens_pedido
                    │
                    └── doce
                          │
                          └── tipo_doce
```

---

## 📌 Conteúdos praticados

### Consultas e filtros
- `SELECT`
- `WHERE`
- `LIKE`
- `BETWEEN`
- `IN`
- operadores de comparação
- `ORDER BY`

### Agregações
- `COUNT`
- `SUM`
- `AVG`
- `MAX`
- `MIN`
- `GROUP BY`
- `HAVING`
- `TRUNC`

### Relacionamentos
- `INNER JOIN`
- `LEFT JOIN`
- múltiplos `JOINs`

### Consultas mais avançadas
- `EXISTS`
- subconsultas
- consultas com agregações em diferentes níveis
- comparação de valores agregados

### Outros recursos
- `UNION`
- `VIEW`
- `CONSTRAINT`
- chaves primárias e estrangeiras

---

## ▶️ Como executar

### 1. Criar o banco

Crie um banco PostgreSQL, por exemplo:

```text
doceria
```

### 2. Criar as tabelas

Execute:

```text
database/01_schema.sql
```

### 3. Inserir os dados

Depois execute:

```text
database/02_dados.sql
```

### 4. Executar os exercícios

Os exercícios estão separados por assunto dentro da pasta `exercicios`.

---

## 💡 Alguns exemplos de consultas praticadas

### Clientes ativos

```sql
SELECT COUNT(id_cliente) AS quantidade_clientes_ativos
FROM cliente
WHERE ativo = true;
```

### Quantidade de clientes por cidade

```sql
SELECT cidade, COUNT(id_cliente) AS quantidade_clientes
FROM cliente
GROUP BY cidade;
```

### Clientes que possuem pedidos usando EXISTS

```sql
SELECT cliente.id_cliente, cliente.nome
FROM cliente
WHERE EXISTS (
    SELECT 1
    FROM pedido
    WHERE pedido.id_cliente = cliente.id_cliente
);
```

### Total de cada pedido

```sql
SELECT
    pedido.id_pedido,
    SUM(doce.preco * itens_pedido.quantidade) AS valor_pedido
FROM pedido
INNER JOIN itens_pedido
    ON pedido.id_pedido = itens_pedido.id_pedido
INNER JOIN doce
    ON itens_pedido.id_doce = doce.id_doce
GROUP BY pedido.id_pedido;
```

### Doce que gerou mais receita

```sql
SELECT
    doce.id_doce,
    doce.nome,
    SUM(itens_pedido.quantidade) AS quantidade_vendida,
    SUM(doce.preco * itens_pedido.quantidade) AS valor_total_doce_vendido
FROM doce
INNER JOIN itens_pedido
    ON doce.id_doce = itens_pedido.id_doce
GROUP BY doce.id_doce, doce.nome
ORDER BY valor_total_doce_vendido DESC;
```

---

## 🎯 Objetivo

O objetivo deste repositório é registrar minha evolução prática em **Banco de Dados e SQL**, mostrando consultas desenvolvidas durante os estudos e servindo também como material de revisão.

Os exercícios trabalham desde consultas simples até problemas que exigem combinação de diferentes recursos do SQL.

---

## 👩‍💻 Sobre

Estudante de **Análise e Desenvolvimento de Sistemas**, atualmente aprofundando conhecimentos em desenvolvimento e banco de dados.

Este repositório faz parte da minha rotina de estudos e prática em tecnologia.
