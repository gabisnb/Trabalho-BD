-- 1) Quais são os IDs e nomes dos estudantes que compraram uma assinatura e emitiram um certificado para algum curso?

select e.id_usuario
	from estudante e
	where exists (
		select *
			from assinatura a
			where a.id_usuario = e.id_usuario
	) and exists (
		select *
			from certificado c
			where c.id_usuario = e.id_usuario
	);

-- 2) Quais são os IDs e nomes dos estudantes que assistiram a uma aula e também enviaram uma sugestão de correção para alguma aula?

select e.id_usuario, u.nome_usuario
	from estudante e
	inner join usuario u on (u.id_usuario = e.id_usuario)
	where exists (
		select *
			from assiste a
			where e.id_usuario = a.id_usuario and a.concluida = true
	) and exists(
		select *
			from correcao c
			where c.id_usuario = c.id_usuario
	);

-- 3) Quais são os estudantes que possuem uma assinatura mas ainda não assistiram a nenhuma aula?

select e.*
	from estudante e
	inner join usuario u on (u.id_usuario = e.id_usuario)
	where not exists (
		select *
			from assiste a
			where e.id_usuario = a.id_usuario and a.concluida = true
	) and exists(
		select *
			from assinatura a
			where a.id_usuario = e.id_usuario
	);

-- 4) Quais são todas as combinações possíveis  de estudantes e cursos disponíveis independentemente de o estudante estar inscrito no curso ou não?

select *
	from estudante
	cross join curso;

-- 5) Quais são os cursos na área de finanças?

select c.*
	from curso c
	inner join area a on (a.id_area = c.id_area and a.nome_area = 'Finanças');

-- 6) Quais são os nomes dos usuários?

select u.nome_usuario from usuario u;

-- 7)  Quais são os usuários que assinaram um plano anual?

select u.*
	from usuario u
	inner join assinatura a on (a.id_usuario = u.id_usuario)
	inner join plano p on (a.id_plano = p.id_plano and p.duracao = 12);

-- 8) Quais são os cursos e seus administradores responsáveis?

select *
	from curso c
	inner join (
		select u.*
			from administrador a
			inner join usuario u on (u.id_usuario = a.id_usuario)
	) t on (t.id_usuario = c.id_usuario);

-- 9) Quais são as aulas e os cursos correspondentes?

select *
	from aula a
	inner join curso c on (c.id_curso = a.id_curso);

-- 10) Quais são os usuários que possuem assinaturas ativas?

select *
	from usuario u
	where exists(
		select *
			from assinatura a
			where a.data_inicio <= current_date and a.data_fim > current_date and u.id_usuario = a.id_usuario
	);

-- 11) Quais são os estudantes que assistiram a todas as aulas do curso de ‘legislação’?

select e.*
	from estudante e
	inner join(
		select ass.id_usuario, count(*)
			from aula a
			inner join assiste ass on (ass.id_aula = a.id_aula)
			inner join curso c on (c.id_curso = a.id_curso and c.nome_curso = 'Legislação')
			where ass.concluida = true
			group by ass.id_usuario
	) t on (t.id_usuario = e.id_usuario)
	where t.count = (
		select count(*)
			from aula a
			inner join curso c on (c.id_curso = a.id_curso and c.nome_curso = 'Legislação')
	);

-- 12) Quais são os cursos e serviços associados a eles?

select *
	from curso c
	inner join servico s on (s.id_curso = c.id_curso);

-- 13) Quais são os estudantes que pagam mais de R$100,00 mensais pela sua assinatura?

select *
	from estudante e
	inner join assinatura a on (e.id_usuario = a.id_usuario and a.valor_mensal > 100.00);

-- 14) Quais são os estudantes que assistiram a aulas de um curso específico, mas ainda não completaram todas as aulas desse curso?

select *
	from estudante e
	where exists(
		select *
			from aula a
			inner join curso c on (c.id_curso = a.id_curso)
			inner join assiste ass on (a.id_aula = ass.id_aula)
			where e.id_usuario = ass.id_usuario and ass.concluida = false
	);

-- 15) Quais são os estudantes que completaram todos os cursos disponíveis na plataforma?

select c.id_usuario, count(*)
	from certificado c
	group by c.id_usuario
	having (select count(*) from curso) = count(*);

