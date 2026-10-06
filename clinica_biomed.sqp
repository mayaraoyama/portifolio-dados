-- Projeto: Clínica fictícia (estudo de SQL)
-- Dados 100% fictícios.

CREATE DATABASE IF NOT EXISTS clinica_biomed;
USE clinica_biomed;

-- 1. ESTRUTURA
DROP TABLE IF EXISTS atendimentos;
DROP TABLE IF EXISTS procedimentos;
DROP TABLE IF EXISTS clientes;

CREATE TABLE clientes (
  id_cliente INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(100) NOT NULL,
  telefone VARCHAR(20),
  data_nasc DATE
);

CREATE TABLE procedimentos (
  id_procedimento INT PRIMARY KEY AUTO_INCREMENT,
  nome_procedimento VARCHAR(100) NOT NULL,
  valor_custo DECIMAL(10,2),
  valor_venda DECIMAL(10,2)
);

CREATE TABLE atendimentos (
  id_atendimento INT PRIMARY KEY AUTO_INCREMENT,
  data_atendimento DATE NOT NULL,
  id_cliente INT NOT NULL,
  id_procedimento INT NOT NULL,
  valor_cobrado DECIMAL(10,2),
  FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
  FOREIGN KEY (id_procedimento) REFERENCES procedimentos(id_procedimento)
);

-- 2. DADOS FICTÍCIOS
INSERT INTO clientes (nome, telefone, data_nasc)
VALUES ('Ana Maria', '48900000001', '1984-01-03'),
       ('Marina Silva', '11900000002', '1963-04-13'),
       ('Pedro Paulo', '44900000003', '1992-05-29'),
       ('Patricia Luz', '47900000004', '1989-11-12');

INSERT INTO procedimentos (nome_procedimento, valor_custo, valor_venda)
VALUES ('Botox', 580, 1200),
       ('Preenchimento', 650, 1400),
       ('Bioestimulador', 980, 2100);

INSERT INTO atendimentos (data_atendimento, id_cliente, id_procedimento, valor_cobrado)
VALUES ('2026-10-05', 1, 1, 1120),
       ('2026-09-29', 2, 2, 1400),
       ('2026-10-01', 3, 3, 2000),
       ('2026-09-30', 1, 2, 1200),
       ('2026-10-05', 3, 1, 1150);

-- 3. CONSULTAS

-- Clientes e as datas dos seus atendimentos (inclui quem não tem atendimento)
SELECT c.nome, a.data_atendimento
FROM clientes c
LEFT JOIN atendimentos a ON c.id_cliente = a.id_cliente;

-- Clientes que nunca fizeram atendimento
SELECT c.nome
FROM clientes c
LEFT JOIN atendimentos a ON c.id_cliente = a.id_cliente
WHERE a.id_atendimento IS NULL;

-- Atendimento mais caro, com cliente e procedimento
SELECT c.nome, p.nome_procedimento, a.valor_cobrado
FROM atendimentos a
JOIN clientes c ON c.id_cliente = a.id_cliente
JOIN procedimentos p ON p.id_procedimento = a.id_procedimento
ORDER BY a.valor_cobrado DESC
LIMIT 1;
