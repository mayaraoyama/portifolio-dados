-- Projeto Clínica (dados 100% fictícios)
-- Rodar o arquivo inteiro cria o banco do zero.
-- Pode rodar quantas vezes quiser: as tabelas são recriadas, sem duplicar dados.

CREATE SCHEMA IF NOT EXISTS clinica_biomed;
USE clinica_biomed;

-- Apaga primeiro a tabela com chaves estrangeiras
DROP TABLE IF EXISTS atendimentos;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS procedimentos;

-- 1. Criação das tabelas
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

-- 2. Dados iniciais
-- Clientes 1 a 4 (a Patricia, ID 4, não tem nenhum atendimento)
INSERT INTO clientes (nome, telefone, data_nasc)
VALUES ('Ana Maria', '48900000001', '1988-04-12'),
       ('Marina Silva', '48900000002', '1991-09-03'),
       ('Pedro Paulo', '48900000003', '1985-01-25'),
       ('Patricia Luz', '48900000004', '1989-11-12');

-- Procedimentos 1 a 3
INSERT INTO procedimentos (nome_procedimento, valor_custo, valor_venda)
VALUES ('Botox', 580, 1200),
       ('Preenchimento Labial', 450, 1500),
       ('Fios de PDO', 900, 2000);

-- Atendimentos 1 a 5
INSERT INTO atendimentos (data_atendimento, id_cliente, id_procedimento, valor_cobrado)
VALUES ('2026-10-05', 1, 1, 1120),
       ('2026-09-29', 2, 2, 1400),
       ('2026-10-01', 3, 3, 2000),
       ('2026-09-30', 1, 2, 1200),
       ('2026-10-05', 3, 1, 1150);

-- 3. Dados adicionais
-- Procedimentos 4 a 6
INSERT INTO procedimentos (nome_procedimento, valor_custo, valor_venda)
VALUES ('Limpeza Facial', 90, 250),
       ('Peeling Químico', 120, 400);

-- Este fica SEM valor_custo de propósito (para treinar IS NULL)
INSERT INTO procedimentos (nome_procedimento, valor_venda)
VALUES ('Microagulhamento', 600);

-- Clientes 5 a 7
INSERT INTO clientes (nome, telefone, data_nasc)
VALUES ('Carla Mendes', '48900000005', '1985-03-14'),
       ('Julia Ramos', '48900000006', '1992-07-22'),
       ('Renata Souza', '48900000007', '1978-11-30');

-- Atendimentos 6 a 30
INSERT INTO atendimentos (data_atendimento, id_cliente, id_procedimento, valor_cobrado)
VALUES ('2026-08-03', 5, 4, 250),
       ('2026-08-05', 6, 5, 400),
       ('2026-08-07', 1, 1, 1200),
       ('2026-08-10', 7, 6, 600),
       ('2026-08-12', 2, 4, 230),
       ('2026-08-14', 3, 5, 380),
       ('2026-08-18', 5, 1, 1150),
       ('2026-08-20', 6, 4, 250),
       ('2026-08-24', 1, 6, 540),
       ('2026-08-26', 7, 5, 400),
       ('2026-08-28', 3, 4, 225),
       ('2026-09-01', 2, 1, 1100),
       ('2026-09-03', 5, 5, 360),
       ('2026-09-08', 6, 6, 600),
       ('2026-09-10', 7, 4, 250),
       ('2026-09-12', 1, 5, 400),
       ('2026-09-15', 3, 6, 570),
       ('2026-09-17', 2, 5, 380),
       ('2026-09-19', 5, 4, 230),
       ('2026-09-22', 6, 1, 1080),
       ('2026-09-24', 7, 1, 1200),
       ('2026-09-26', 1, 4, 250),
       ('2026-10-01', 2, 6, 540),
       ('2026-10-02', 3, 4, 225),
       ('2026-10-05', 5, 6, 600);

-- Conferência: deve aparecer 7, 6 e 30
SELECT (SELECT COUNT(*) FROM clientes) AS clientes,
       (SELECT COUNT(*) FROM procedimentos) AS procedimentos,
       (SELECT COUNT(*) FROM atendimentos) AS atendimentos;
