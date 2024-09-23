-- Teste da consulta por email com e sem índice

-- Para que a diferença ficasse mais notável, adicionei mais usuários

-- Inserindo dados na tabela Usuario
DO $$ 
DECLARE 
    i INT := 1; 
BEGIN 
    WHILE i <= 5000000 LOOP
        INSERT INTO trabalholiviagabilara.Usuario (id_usuario, nome_usuario, email, senha)
        VALUES (
            'user_' || i, 
            'Usuario ' || i, 
            'usuario' || i || '@email.com', 
            'senha' || i
        );
        i := i + 1; 
    END LOOP; 
END $$;

-- Agora sim, testamos os tempos antes e depois do índice


SELECT * FROM trabalholiviagabilara.Usuario u 
WHERE u.email = 'joao.silva@email.com';

SELECT u.nome_usuario, u.email, a.data_fim 
FROM trabalholiviagabilara.Usuario u 
INNER JOIN trabalholiviagabilara.Assinatura a ON u.id_usuario = a.id_usuario WHERE u.email LIKE 'usuario%@email.com'



-- Índice para acelerar consultas que buscam usuários por email
CREATE INDEX idx_usuario_email ON trabalholiviagabilara.Usuario(email);


SELECT * FROM trabalholiviagabilara.Usuario u 
WHERE u.email = 'joao.silva@email.com';

SELECT u.nome_usuario, u.email, a.data_fim 
FROM trabalholiviagabilara.Usuario u 
INNER JOIN trabalholiviagabilara.Assinatura a ON u.id_usuario = a.id_usuario WHERE u.email LIKE 'usuario%@email.com'


-- Teste da consulta por nome do usuário com e sem índice

SELECT * FROM trabalholiviagabilara.Usuario u 
WHERE u.nome_usuario = 'João Silva';

SELECT u.nome_usuario, u.email, a.data_fim 
FROM trabalholiviagabilara.Usuario u 
INNER JOIN trabalholiviagabilara.Assinatura a ON u.id_usuario = a.id_usuario WHERE u.nome_usuario LIKE 'user_%'


-- Índice para acelerar consultas que buscam usuários por nome
CREATE INDEX idx_usuario_nome ON trabalholiviagabilara.Usuario(nome_usuario);


SELECT * FROM trabalholiviagabilara.Usuario u 
WHERE u.nome_usuario = 'João Silva';

SELECT u.nome_usuario, u.email, a.data_fim 
FROM trabalholiviagabilara.Usuario u 
INNER JOIN trabalholiviagabilara.Assinatura a ON u.id_usuario = a.id_usuario WHERE u.nome_usuario LIKE 'user_%';
