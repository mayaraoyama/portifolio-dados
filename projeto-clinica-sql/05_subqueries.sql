-- Projeto Clínica | Subqueries
-- Pré-requisito: rodar 01_criar_e_popular.sql

USE clinica_biomed;

-- 1. Clientes que fizeram Fios de PDO (versão com JOIN)
SELECT DISTINCT c.nome
FROM clientes c
JOIN atendimentos a ON c.id_cliente = a.id_cliente
JOIN procedimentos p ON p.id_procedimento = a.id_procedimento
WHERE p.nome_procedimento = 'Fios de PDO';

-- 2. Procedimentos com preço de tabela acima da média
SELECT nome_procedimento, valor_venda
FROM procedimentos
WHERE valor_venda > (SELECT AVG(valor_venda) FROM procedimentos)
ORDER BY valor_venda DESC;

-- 3. Procedimentos não realizados em outubro de 2026
SELECT nome_procedimento
FROM procedimentos
WHERE id_procedimento NOT IN (
    SELECT id_procedimento
    FROM atendimentos
    WHERE data_atendimento >= '2026-10-01'
      AND data_atendimento <  '2026-11-01'
);

-- 4. Atendimentos com valor cobrado acima da média cobrada no Botox
SELECT id_atendimento, valor_cobrado
FROM atendimentos
WHERE valor_cobrado > (
    SELECT AVG(a.valor_cobrado)
    FROM atendimentos a
    JOIN procedimentos p ON p.id_procedimento = a.id_procedimento
    WHERE p.nome_procedimento = 'Botox'
)
ORDER BY id_atendimento;

-- 5. Todos os atendimentos da cliente que mais gastou
SELECT id_atendimento, valor_cobrado
FROM atendimentos
WHERE id_cliente = (
    SELECT id_cliente
    FROM atendimentos
    GROUP BY id_cliente
    ORDER BY SUM(valor_cobrado) DESC
    LIMIT 1
)
ORDER BY id_atendimento;

-- 6. Clientes que gastaram acima da média de gasto por cliente
SELECT c.id_cliente, c.nome, SUM(a.valor_cobrado) AS total_gasto
FROM atendimentos a
JOIN clientes c ON c.id_cliente = a.id_cliente
GROUP BY c.id_cliente, c.nome
HAVING SUM(a.valor_cobrado) > (
    SELECT AVG(totais.total_gasto)
    FROM (
        SELECT id_cliente, SUM(valor_cobrado) AS total_gasto
        FROM atendimentos
        GROUP BY id_cliente
    ) AS totais
)
ORDER BY total_gasto DESC;
