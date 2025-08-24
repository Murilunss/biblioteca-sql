-- Tabela de autores
CREATE TABLE Autores (
    id SERIAL PRIMARY KEY,               -- Identificador único do autor
    nome VARCHAR(100) NOT NULL,          -- Nome do autor
    nacionalidade VARCHAR(50),           -- Nacionalidade do autor
    data_nascimento DATE                 -- Data de nascimento
);

-- Tabela de livros
CREATE TABLE Livros (
    id SERIAL PRIMARY KEY,               -- Identificador único do livro
    titulo VARCHAR(150) NOT NULL,        -- Título do livro
    autor_id INT REFERENCES Autores(id), -- Chave estrangeira para autores
    ano_publicacao INT,                  -- Ano de publicação
    genero VARCHAR(50)                   -- Gênero do livro
);

-- Tabela de usuários
CREATE TABLE Usuarios (
    id SERIAL PRIMARY KEY,               -- Identificador único do usuário
    nome VARCHAR(100) NOT NULL,          -- Nome do usuário
    email VARCHAR(100),                  -- E-mail
    telefone VARCHAR(20)                 -- Telefone
);

-- Tabela de empréstimos
CREATE TABLE Emprestimos (
    id SERIAL PRIMARY KEY,               -- Identificador único do empréstimo
    usuario_id INT REFERENCES Usuarios(id),  -- Chave estrangeira para usuário
    livro_id INT REFERENCES Livros(id),       -- Chave estrangeira para livro
    data_emprestimo DATE NOT NULL,       -- Data do empréstimo
    data_devolucao DATE                  -- Data de devolução (pode ser NULL se não devolvido)
);

-- ======================================================
-- 2️⃣ Inserção de Dados de Exemplo
-- ======================================================

-- Inserir autores
INSERT INTO Autores (nome, nacionalidade, data_nascimento)
VALUES
('J.K. Rowling', 'Reino Unido', '1965-07-31'),
('George R.R. Martin', 'Estados Unidos', '1948-09-20'),
('Machado de Assis', 'Brasil', '1839-06-21');

-- Inserir livros
INSERT INTO Livros (titulo, autor_id, ano_publicacao, genero)
VALUES
('Harry Potter e a Pedra Filosofal', 1, 1997, 'Fantasia'),
('Game of Thrones', 2, 1996, 'Fantasia'),
('Dom Casmurro', 3, 1899, 'Romance');

-- Inserir usuários
INSERT INTO Usuarios (nome, email, telefone)
VALUES
('Murilo Silva', 'murilo@email.com', '11999999999'),
('Ana Souza', 'ana@email.com', '11988888888');

-- Registrar empréstimos
INSERT INTO Emprestimos (usuario_id, livro_id, data_emprestimo, data_devolucao)
VALUES
(1, 1, '2025-08-24', NULL),   -- Livro ainda não devolvido
(2, 3, '2025-08-20', '2025-08-23'); -- Livro devolvido

-- ======================================================
-- 3️⃣ Consultas Básicas
-- ======================================================

-- a) Listar todos os livros com seus autores
SELECT l.titulo, a.nome AS autor, l.genero
FROM Livros l
JOIN Autores a ON l.autor_id = a.id;

-- b) Empréstimos ativos (não devolvidos)
SELECT u.nome AS usuario, l.titulo AS livro, e.data_emprestimo
FROM Emprestimos e
JOIN Usuarios u ON e.usuario_id = u.id
JOIN Livros l ON e.livro_id = l.id
WHERE e.data_devolucao IS NULL;

-- c) Quantidade de livros emprestados por usuário
SELECT u.nome, COUNT(*) AS total_emprestimos
FROM Emprestimos e
JOIN Usuarios u ON e.usuario_id = u.id
GROUP BY u.nome;

-- d) Livros de um determinado autor
SELECT l.titulo
FROM Livros l
JOIN Autores a ON l.autor_id = a.id
WHERE a.nome = 'J.K. Rowling';

-- ======================================================
-- 4️⃣ Atualizações (UPDATE)
-- ======================================================

-- a) Registrar a devolução de um livro
UPDATE Emprestimos
SET data_devolucao = '2025-08-25'
WHERE id = 1;

-- b) Alterar o telefone de um usuário
UPDATE Usuarios
SET telefone = '11977777777'
WHERE nome = 'Ana Souza';

-- ======================================================
-- 5️⃣ Exclusões (DELETE)
-- ======================================================

-- a) Deletar um usuário
DELETE FROM Usuarios
WHERE nome = 'Ana Souza';

-- b) Deletar um livro específico
DELETE FROM Livros
WHERE titulo = 'Game of Thrones';

-- ======================================================
-- FIM do Script
-- ======================================================
