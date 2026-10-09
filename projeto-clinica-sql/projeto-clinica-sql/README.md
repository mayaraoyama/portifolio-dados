# Projeto Clínica: SQL com dados fictícios

Banco de dados relacional de uma clínica de estética, com dados 100% fictícios,
criado para praticar SQL.

## Tabelas
- `clientes`: dados cadastrais
- `procedimentos`: nome, custo e preço de tabela
- `atendimentos`: cada atendimento realizado (liga clientes e procedimentos)

## Arquivos
| Arquivo | O que faz |
|---|---|
| `01_criar_e_popular.sql` | Cria o banco, as tabelas e os dados fictícios |
| `02_consultas.sql` | Filtros, ordenação e JOINs |
| `03_agregacoes.sql` | Totais, médias, GROUP BY e HAVING |

## Perguntas de negócio respondidas
- Qual o faturamento total e o ticket médio?
- Quanto cada procedimento fatura?
- Quantos atendimentos cada cliente fez (incluindo quem nunca veio)?
- Qual o faturamento por mês?
- Quais atendimentos tiveram desconto?

## Conceitos praticados
JOIN com 3 tabelas, LEFT JOIN + IS NULL, ORDER BY, LIMIT, LIKE, IN, BETWEEN,
COUNT, SUM, AVG, ROUND, GROUP BY, HAVING e formatação de datas.

## Como rodar
1. Execute `01_criar_e_popular.sql` (cria o banco e os dados)
2. Execute as consultas dos outros arquivos, uma por vez
