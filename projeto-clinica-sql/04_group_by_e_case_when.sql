-- Projeto Clínica | GROUP BY, HAVING e CASE WHEN
-- Pré-requisito: rodar 01_criar_e_popular.sql

USE clinica_biomed;

-- 1. Faturamento por mês
SELECT DATE_FORMAT(data_atendimento, '%Y-%m') AS mes,
       SUM(valor_cobrado) AS faturamento
FROM atendimentos
GROUP BY DATE_FORMAT(data_atendimento, '%Y-%m')
ORDER BY mes;

-- 2. Procedimentos com faturamento acima de 3500
SELECT p.nome_procedimento,
       SUM(a.valor_cobrado) AS faturamento
FROM procedimentos p
JOIN atendimentos a ON p.id_procedimento = a.id_procedimento
GROUP BY p.nome_procedimento
HAVING SUM(a.valor_cobrado) > 3500;

-- 3. Quantidade de atendimentos por procedimento, do maior para o menor
SELECT p.nome_procedimento,
       COUNT(a.id_atendimento) AS quantidade
FROM procedimentos p
JOIN atendimentos a ON p.id_procedimento = a.id_procedimento
GROUP BY p.nome_procedimento
ORDER BY COUNT(a.id_atendimento) DESC, p.nome_procedimento;

-- 4. Ticket médio por cliente (arredondado em 2 casas)
SELECT c.nome,
       ROUND(AVG(a.valor_cobrado), 2) AS ticket_medio
FROM atendimentos a
JOIN clientes c ON a.id_cliente = c.id_cliente
GROUP BY c.id_cliente, c.nome;

-- 5. Clientes com mais de 4 atendimentos
SELECT c.nome,
       COUNT(a.id_atendimento) AS quantidade_atendimentos
FROM atendimentos a
JOIN clientes c ON a.id_cliente = c.id_cliente
GROUP BY c.id_cliente, c.nome
HAVING COUNT(a.id_atendimento) > 4;

-- 6. Atendimentos por mês e por procedimento
SELECT DATE_FORMAT(a.data_atendimento, '%Y-%m') AS mes,
       p.nome_procedimento,
       COUNT(a.id_atendimento) AS atendimentos
FROM atendimentos a
JOIN procedimentos p ON a.id_procedimento = p.id_procedimento
GROUP BY DATE_FORMAT(a.data_atendimento, '%Y-%m'), p.nome_procedimento
ORDER BY mes, p.nome_procedimento;

-- 7. Tipo de cada atendimento: preço cheio ou com desconto
SELECT a.id_atendimento,
       CASE
         WHEN a.valor_cobrado = p.valor_venda THEN 'Preço cheio'
         WHEN a.valor_cobrado < p.valor_venda THEN 'Com desconto'
         ELSE 'Acima do preço de tabela'
       END AS tipo
FROM atendimentos a
JOIN procedimentos p ON p.id_procedimento = a.id_procedimento
ORDER BY a.id_atendimento;

-- 8. Faixa de valor de cada atendimento
-- (condições testadas de cima para baixo: sem buracos entre as faixas)
SELECT id_atendimento,
       valor_cobrado,
       CASE
         WHEN valor_cobrado <= 500  THEN 'Até 500'
         WHEN valor_cobrado <= 1500 THEN 'De 501 a 1500'
         ELSE 'Acima de 1500'
       END AS faixa
FROM atendimentos
ORDER BY valor_cobrado;

-- 9. Quantidade de atendimentos em cada faixa de valor
SELECT faixa,
       COUNT(*) AS quantidade
FROM (
  SELECT CASE
           WHEN valor_cobrado <= 500  THEN 'Até 500'
           WHEN valor_cobrado <= 1500 THEN 'De 501 a 1500'
           ELSE 'Acima de 1500'
         END AS faixa
  FROM atendimentos
) AS faixas
GROUP BY faixa
ORDER BY quantidade DESC;

-- 10. Por procedimento: atendimentos com e sem desconto (SUM + CASE WHEN)
SELECT p.nome_procedimento,
       SUM(CASE WHEN a.valor_cobrado < p.valor_venda THEN 1 ELSE 0 END) AS com_desconto,
       SUM(CASE WHEN a.valor_cobrado = p.valor_venda THEN 1 ELSE 0 END) AS sem_desconto,
       SUM(CASE WHEN a.valor_cobrado > p.valor_venda THEN 1 ELSE 0 END) AS acima_do_preco
FROM atendimentos a
JOIN procedimentos p ON p.id_procedimento = a.id_procedimento
GROUP BY p.nome_procedimento;
