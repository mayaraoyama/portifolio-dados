USE clinica_biomed;

-- 1. Todos os atendimentos, do mais caro ao mais barato, com cliente e procedimento
SELECT a.id_atendimento, c.nome, p.nome_procedimento, a.valor_cobrado
FROM atendimentos a
JOIN clientes c ON a.id_cliente = c.id_cliente
JOIN procedimentos p ON a.id_procedimento = p.id_procedimento
ORDER BY a.valor_cobrado DESC;

-- 2. Os 5 atendimentos mais recentes (desempate pelo ID)
SELECT id_atendimento,
       DATE_FORMAT(data_atendimento, '%d/%m/%Y') AS data_br
FROM atendimentos
ORDER BY data_atendimento DESC, id_atendimento DESC
LIMIT 5;

-- 3. Procedimentos cujo nome começa com "B"
SELECT nome_procedimento
FROM procedimentos
WHERE nome_procedimento LIKE 'B%';

-- 4. Procedimentos cujo nome contém "Limpeza"
SELECT nome_procedimento
FROM procedimentos
WHERE nome_procedimento LIKE '%Limpeza%';

-- 5. Atendimentos de dois clientes específicos
SELECT c.nome, a.id_atendimento
FROM atendimentos a
JOIN clientes c ON a.id_cliente = c.id_cliente
WHERE c.nome IN ('Ana Maria', 'Pedro Paulo');

-- 6. Atendimentos de setembro de 2026
SELECT id_atendimento,
       DATE_FORMAT(data_atendimento, '%d/%m/%Y') AS data_br
FROM atendimentos
WHERE data_atendimento BETWEEN '2026-09-01' AND '2026-09-30';

-- 7. Atendimentos com desconto (cobrado abaixo do preço de tabela)
SELECT a.id_atendimento, a.valor_cobrado, p.valor_venda
FROM atendimentos a
JOIN procedimentos p ON a.id_procedimento = p.id_procedimento
WHERE a.valor_cobrado < p.valor_venda;

-- 8. Atendimentos de setembro com valor entre 1000 e 1500, ordenados por data
SELECT id_atendimento, valor_cobrado,
       DATE_FORMAT(data_atendimento, '%d/%m/%Y') AS data_br
FROM atendimentos
WHERE valor_cobrado BETWEEN 1000 AND 1500
  AND data_atendimento BETWEEN '2026-09-01' AND '2026-09-30'
ORDER BY data_atendimento;
