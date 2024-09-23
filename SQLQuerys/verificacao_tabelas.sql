-- Verificações de Integridade

-- 1. Verificação de integridade de chave primária (Tabela Plano)
-- Este insert deve gerar um erro porque o id_plano já existe (chave primária duplicada)
INSERT INTO trabalholiviagabilara.Plano (id_plano, duracao, valor)
VALUES ('plano_mensal', 3, 99.99); -- Falha esperada

-- 2. Verificação de integridade de NOT NULL (Tabela Usuario)
-- Tentar inserir um valor NULL em uma coluna que não permite nulos
INSERT INTO trabalholiviagabilara.Usuario (id_usuario, nome_usuario, email, senha)
VALUES ('user_invalido', NULL, 'user.invalid@email.com', 'senha123'); -- Falha esperada (nome_usuario não pode ser NULL)

-- 3. Verificação de integridade de chave estrangeira (Tabela Assinatura)
-- Tentar inserir um id_usuario que não existe na tabela Estudante
INSERT INTO trabalholiviagabilara.Assinatura (id_plano, id_usuario, data_inicio, valor_mensal, data_fim)
VALUES ('plano_mensal', 'user_inexistente', '2024-09-01', 49.90, '2024-09-30'); -- Falha esperada (violação de chave estrangeira)

-- 4. Verificação de integridade de UNIQUE (Tabela Usuario)
-- Tentar inserir dois usuários com o mesmo email (que é UNIQUE)
INSERT INTO trabalholiviagabilara.Usuario (id_usuario, nome_usuario, email, senha)
VALUES ('user_dup_email', 'Joana Silva', 'joao.silva@email.com', 'senha789'); -- Falha esperada (email duplicado)

-- 5. Verificação de integridade de chave estrangeira (Tabela Curso)
-- Tentar inserir um curso com id_area que não existe na tabela Area
INSERT INTO trabalholiviagabilara.Curso (id_curso, nome_curso, descricao_curso, id_area, id_usuario)
VALUES ('curso_invalido', 'Curso Teste', 'Descrição Teste', 'area_inexistente', 'admin1'); -- Falha esperada (violação de chave estrangeira)

-- 6. Verificação de integridade de DELETE (Tabela Curso e Aula)
-- Tentar deletar um Curso que tem aulas associadas
DELETE FROM trabalholiviagabilara.Curso
WHERE id_curso = 'curso_java'; -- Falha esperada (violação de integridade referencial, há Aulas dependentes de Curso)

-- 7. Verificação de integridade de integridade referencial (Tabela Correcao)
-- Tentar inserir uma correção para uma aula que não existe

INSERT INTO trabalholiviagabilara.Correcao (id_correcao, descricao_correcao, resolvido, imagem_anexo, id_aula, id_usuario)
VALUES
    ('correcao_001', 'Dificuldade de achar onde fica a descrição do vídeo. Seria melhor se estivesse mais destacado.', FALSE, 'https://rb.gy/d2vvn3', 'aula_que_nao_existe', 'user1'),

-- Falha esperada (violação de chave estrangeira, aula não existe)

-- 8. Verificação de restrição de FK com DELETE (Tabela Assinatura)
-- Se tentarmos deletar um estudante com uma assinatura, ele não será deletado devido à FK
DELETE FROM trabalholiviagabilara.Estudante WHERE id_usuario = 'user1'; -- Falha esperada (há assinaturas dependentes deste estudante)

-- 9. Verificação de integridade ao tentar deletar um Administrador com cursos associados
DELETE FROM trabalholiviagabilara.Administrador WHERE id_usuario = 'admin1'; -- Falha esperada (há cursos associados a este administrador)
