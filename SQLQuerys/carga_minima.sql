-- Inserção na Tabela Plano
INSERT INTO trabalholiviagabilara.Plano (id_plano, duracao, valor)
VALUES
    ('plano_mensal', 1, 49.99),
    ('plano_semestral', 6, 269.99),
    ('plano_anual', 12, 449.99);

-- Inserção na Tabela Usuario
INSERT INTO trabalholiviagabilara.Usuario (id_usuario, nome_usuario, email, senha)
VALUES
    ('user1', 'João Silva', 'joao.silva@email.com', 'senha123'),
    ('user2', 'Maria Oliveira', 'maria.oliveira@email.com', 'senha456'),
    ('admin1', 'Carlos Souza', 'carlos.souza@email.com', 'admin789');

-- Inserção na Tabela Estudante
INSERT INTO trabalholiviagabilara.Estudante (id_usuario)
VALUES
    ('user1'),
    ('user2');

-- Inserção na Tabela Administrador
INSERT INTO trabalholiviagabilara.Administrador (id_usuario)
VALUES
    ('admin1');

-- Inserção na Tabela Assinatura
INSERT INTO trabalholiviagabilara.Assinatura (id_plano, id_usuario, data_inicio, valor_mensal, data_fim)
VALUES
    ('plano_mensal', 'user1', '2024-09-01', 49.90, '2024-10-01'),
    ('plano_anual', 'user2', '2024-09-01', 37.50, '2025-09-01');

-- Inserção na Tabela Area
INSERT INTO trabalholiviagabilara.Area (id_area, nome_area, descricao_area)
VALUES
    ('area_ti', 'Tecnologia da Informação', 'Cursos voltados para TI e desenvolvimento de software.'),
    ('area_design', 'Design', 'Cursos voltados para design gráfico e UX/UI.');

-- Inserção na Tabela Curso
INSERT INTO trabalholiviagabilara.Curso (id_curso, nome_curso, descricao_curso, id_area, id_usuario)
VALUES
    ('curso_java', 'Java para Iniciantes', 'Curso introdutório de programação em Java.', 'area_ti', 'admin1'),
    ('curso_photoshop', 'Photoshop Avançado', 'Curso avançado de edição de imagens com Photoshop.', 'area_design', 'admin1');

-- Inserção na Tabela Certificado
INSERT INTO trabalholiviagabilara.Certificado (id_certificado, data_certificado, id_usuario, id_curso)
VALUES
    ('cert_java_001', '2024-09-02', 'user1', 'curso_java');

-- Inserção na Tabela Servico
INSERT INTO trabalholiviagabilara.Servico (id_servico, url, id_curso)
VALUES
    ('servico_hosting', 'http://www.blankwebsite.com/', 'curso_java'),
    ('servico_hosting_2', 'http://www.blankwebsite.com/', 'curso_photoshop');

-- Inserção na Tabela Aula
INSERT INTO trabalholiviagabilara.Aula (id_aula, nome_aula, resumo_aula, professor, duracao_aula, url_video, id_curso, id_usuario)
VALUES
    ('aula_java_01', 'Introdução ao Java', 'Visão geral da linguagem Java.', 'Prof. João', 45, 'https://www.youtube.com/watch?v=dQw4w9WgXcQ', 'curso_java', 'admin1'),
    ('aula_photoshop_01', 'Ferramentas Básicas do Photoshop', 'Introdução às ferramentas básicas.', 'Prof. Maria', 60, 'https://www.youtube.com/watch?v=dQw4w9WgXcQ', 'curso_photoshop', 'admin1');

-- Inserção na Tabela Assiste
INSERT INTO trabalholiviagabilara.Assiste (id_usuario, id_aula, concluida)
VALUES
    ('user1', 'aula_java_01', TRUE),
    ('user2', 'aula_photoshop_01', FALSE);

-- Inserção na Tabela Correcao
INSERT INTO trabalholiviagabilara.Correcao (id_correcao, descricao_correcao, resolvido, imagem_anexo, id_aula, id_usuario)
VALUES
    ('correcao_001', 'Dificuldade de achar onde fica a descrição do vídeo. Seria melhor se estivesse mais destacado.', FALSE, 'https://rb.gy/d2vvn3', 'aula_java_01', 'user1'),
    ('correcao_002', 'Erro no tempo de execução do vídeo.', FALSE, 'https://rb.gy/dn4o0r', 'aula_java_01', 'user1'),
    ('correcao_003', 'A sintaxe da função da primeira parte deveria estar com true, e não false.', FALSE, 'https://rb.gy/w6vho7', 'aula_java_01', 'user1'),
    ('correcao_004', 'O botão de acelerar o vídeo no player não faz a ação que deveria fazer.', FALSE, 'https://rb.gy/raw6pr', 'aula_java_01', 'user1');

-- Inserção na Tabela Melhoria
INSERT INTO trabalholiviagabilara.Melhoria (id_correcao)
VALUES
    ('correcao_001');

-- Inserção na Tabela ErroVideo
INSERT INTO trabalholiviagabilara.ErroVideo (id_correcao, time_stamp)
VALUES
    ('correcao_002', 120);

-- Inserção na Tabela ErroConteudo
INSERT INTO trabalholiviagabilara.ErroConteudo (id_correcao)
VALUES
    ('correcao_003');

-- Inserção na Tabela ErroInterface
INSERT INTO trabalholiviagabilara.ErroInterface (id_correcao)
VALUES
    ('correcao_004');
