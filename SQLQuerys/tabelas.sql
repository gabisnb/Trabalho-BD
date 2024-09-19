-- Tabela Plano
CREATE TABLE Plano (
    id_plano VARCHAR(100) PRIMARY KEY,
    duracao INTEGER NOT NULL,
    valor DECIMAL(10, 2) NOT NULL
);

-- Tabela Usuario
CREATE TABLE Usuario (
    id_usuario VARCHAR(100) PRIMARY KEY,
    nome_usuario VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    senha VARCHAR(100) NOT NULL
);

-- Tabela Estudante
CREATE TABLE Estudante (
    id_usuario VARCHAR(100) PRIMARY KEY REFERENCES Usuario(id_usuario)
);

-- Tabela Administrador
CREATE TABLE Administrador (
    id_usuario VARCHAR(100) PRIMARY KEY REFERENCES Usuario(id_usuario)
);

-- Tabela Assinatura
CREATE TABLE Assinatura (
    id_plano VARCHAR(100) REFERENCES Plano(id_plano),
    id_usuario VARCHAR(100) REFERENCES Estudante(id_usuario),
    data_inicio DATE NOT NULL,
    valor_mensal DECIMAL(10, 2) NOT NULL,
    data_fim DATE,
    PRIMARY KEY (id_plano, id_usuario)
);

-- Tabela Area
CREATE TABLE Area (
    id_area VARCHAR(100) PRIMARY KEY,
    nome_area VARCHAR(100) NOT NULL,
    descricao_area TEXT
);

-- Tabela Curso
CREATE TABLE Curso (
    id_curso VARCHAR(100) PRIMARY KEY,
    nome_curso VARCHAR(100) NOT NULL,
    descricao_curso TEXT,
    id_area VARCHAR(100) REFERENCES Area(id_area),
    id_usuario VARCHAR(100) REFERENCES Administrador(id_usuario)
);

-- Tabela Certificado
CREATE TABLE Certificado (
    id_certificado VARCHAR(100) PRIMARY KEY,
    data_certificado DATE NOT NULL,
    id_usuario VARCHAR(100) REFERENCES Estudante(id_usuario),
    id_curso VARCHAR(100) REFERENCES Curso(id_curso)

);

-- Tabela Servico
CREATE TABLE Servico (
    id_servico VARCHAR(100) PRIMARY KEY,
    url VARCHAR(255) NOT NULL,
    id_curso VARCHAR(100) REFERENCES Curso(id_curso)
);

-- Tabela Aula
CREATE TABLE Aula (
    id_aula VARCHAR(100) PRIMARY KEY,
    nome_aula VARCHAR(100) NOT NULL,
    resumo_aula TEXT,
    professor VARCHAR(100),
    duracao_aula INTEGER,
    url_video VARCHAR(255),
    id_curso VARCHAR(100) REFERENCES Curso(id_curso),
    id_usuario VARCHAR(100) REFERENCES Administrador(id_usuario)
);

-- Tabela Assiste
CREATE TABLE Assiste (
    id_usuario VARCHAR(100) REFERENCES Estudante(id_usuario),
    id_aula VARCHAR(100) REFERENCES Aula(id_aula),
    concluida BOOLEAN NOT NULL,
    PRIMARY KEY (id_usuario, id_aula)
);

-- Tabela Correcao
CREATE TABLE Correcao (
    id_correcao VARCHAR(100) PRIMARY KEY,
    descricao_correcao TEXT,
    resolvido BOOLEAN NOT NULL,
    imagem_anexo VARCHAR(255),
    id_aula VARCHAR(100) REFERENCES Aula(id_aula),
    id_usuario VARCHAR(100) REFERENCES Estudante(id_usuario)

);

-- Tabela Melhoria
CREATE TABLE Melhoria (
    id_correcao VARCHAR(100) PRIMARY KEY REFERENCES Correcao(id_correcao)
);

-- Tabela ErroVideo
CREATE TABLE ErroVideo (
    id_correcao VARCHAR(100) PRIMARY KEY REFERENCES Correcao(id_correcao),
    time_stamp INTEGER NOT NULL
);

-- Tabela ErroConteudo
CREATE TABLE ErroConteudo (
    id_correcao VARCHAR(100) PRIMARY KEY REFERENCES Correcao(id_correcao)
);

-- Tabela ErroInterface
CREATE TABLE ErroInterface (
    id_correcao VARCHAR(100) PRIMARY KEY REFERENCES Correcao(id_correcao)
);
