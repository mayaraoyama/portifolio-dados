-- Projeto Clínica | Consultas de agregação
-- Pré-requisito: rodar 01_criar_e_popular.sql

USE clinica_biomed;

-- 1. Total de atendimentos
SELECT COUNT(*) AS total_atendimentos
FROM atendimentos;

-- 2. Faturamento total
SELECT SUM(valor_cobrado) AS faturamento_total
FROM atendimentos;

-- 3. Ticket médio (arredondado em 2 casas)
SELECT ROUND(AVG(valor_cobrado), 2) AS ticket_medio
FROM atendimentos;

-- 4. Faturamento por procedimento
SELECT p.nome_procedimento,
       SUM(a.valor_cobrado) AS faturamento
FROM atendimentos a
JOIN procedimentos p ON a.id_procedimento = p.id_procedimento
GROUP BY p.nome_procedimento;

-- 5. Quantidade de atendimentos por cliente (inclui quem tem 0)
SELECT c.id_cliente,
       c.nome,
       COUNT(a.id_atendimento) AS quantidade_atendimentos
FROM clientes c
LEFT JOIN atendimentos a ON c.id_cliente = a.id_cliente
GROUP BY c.id_cliente, c.nome;

-- 6. Faturamento por mês
SELECT DATE_FORMAT(data_atendimento, '%Y-%m') AS mes,
       SUM(valor_cobrado) AS faturamento
FROM atendimentos
GROUP BY DATE_FORMAT(data_atendimento, '%Y-%m')
ORDER BY mes;

-- 7. Procedimentos com faturamento acima de 2500
SELECT p.nome_procedimento,
       SUM(a.valor_cobrado) AS faturamento
FROM procedimentos p
JOIN atendimentos a ON p.id_procedimento = a.id_procedimento
GROUP BY p.nome_procedimento
HAVING SUM(a.valor_cobrado) > 2500;

-- 8. Desconto médio por procedimento
SELECT p.nome_procedimento,
       ROUND(AVG(p.valor_venda - a.valor_cobrado), 2) AS media_desconto
FROM atendimentos a
JOIN procedimentos p ON a.id_procedimento = p.id_procedimento
GROUP BY p.nome_procedimento;

-- 9. Cliente que mais gastou
SELECT c.nome,
       SUM(a.valor_cobrado) AS valor_gasto
FROM clientes c
JOIN atendimentos a ON c.id_cliente = a.id_cliente
GROUP BY c.id_cliente, c.nome
ORDER BY valor_gasto DESC
LIMIT 1;

-- 10. Margem total por procedimento
-- Obs.: o Microagulhamento está sem valor_custo (NULL), então sua margem não é calculada.
SELECT p.nome_procedimento,
       SUM(a.valor_cobrado - p.valor_custo) AS margem
FROM atendimentos a
JOIN procedimentos p ON a.id_procedimento = p.id_procedimento
GROUP BY p.nome_procedimento;
