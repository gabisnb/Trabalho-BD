-- 1) Quais são os IDs e nomes dos estudantes que compraram uma assinatura e emitiram um certificado para algum curso?

select e.id_usuario
	from trabalholiviagabilara.estudante e
	where exists (
		select *
			from trabalholiviagabilara.assinatura a
			where a.id_usuario = e.id_usuario
	) and exists (
		select *
			from trabalholiviagabilara.certificado c
			where c.id_usuario = e.id_usuario
	);

-- 2) Quais são os IDs e nomes dos estudantes que assistiram a uma aula e também enviaram uma sugestão de correção para alguma aula?

select e.id_usuario, u.nome_usuario
	from trabalholiviagabilara.estudante e
	inner join trabalholiviagabilara.usuario u on (u.id_usuario = e.id_usuario)
	where exists (
		select *
			from trabalholiviagabilara.assiste a
			where e.id_usuario = a.id_usuario and a.concluida = true
	) and exists(
		select *
			from trabalholiviagabilara.correcao c
			where c.id_usuario = c.id_usuario
	);

-- 3) Quais são os estudantes que possuem uma assinatura mas ainda não assistiram a nenhuma aula?

select e.*
	from trabalholiviagabilara.estudante e
	inner join trabalholiviagabilara.usuario u on (u.id_usuario = e.id_usuario)
	where not exists (
		select *
			from trabalholiviagabilara.assiste a
			where e.id_usuario = a.id_usuario and a.concluida = true
	) and exists(
		select *
			from trabalholiviagabilara.assinatura a
			where a.id_usuario = e.id_usuario
	);

-- 4) Quais são todas as combinações possíveis  de estudantes e cursos disponíveis independentemente de o estudante estar inscrito no curso ou não?

select *
	from trabalholiviagabilara.estudante
	cross join trabalholiviagabilara.curso;

-- 5) Quais são os cursos na área de finanças?

select c.*
	from trabalholiviagabilara.curso c
	inner join trabalholiviagabilara.area a on (a.id_area = c.id_area and a.nome_area = 'Finanças');

-- 6) Quais são os nomes dos usuários?

select u.nome_usuario from trabalholiviagabilara.usuario u;

-- 7)  Quais são os usuários que assinaram um plano anual?

select u.*
	from trabalholiviagabilara.usuario u
	inner join trabalholiviagabilara.assinatura a on (a.id_usuario = u.id_usuario)
	inner join trabalholiviagabilara.plano p on (a.id_plano = p.id_plano and p.duracao = 12);

-- 8) Quais são os cursos e seus administradores responsáveis?

select *
	from trabalholiviagabilara.curso c
	inner join (
		select u.*
			from trabalholiviagabilara.administrador a
			inner join trabalholiviagabilara.usuario u on (u.id_usuario = a.id_usuario)
	) t on (t.id_usuario = c.id_usuario);

-- 9) Quais são as aulas e os cursos correspondentes?

select *
	from trabalholiviagabilara.aula a
	inner join trabalholiviagabilara.curso c on (c.id_curso = a.id_curso);

-- 10) Quais são os usuários que possuem assinaturas ativas?

select *
	from trabalholiviagabilara.usuario u
	where exists(
		select *
			from trabalholiviagabilara.assinatura a
			where a.data_inicio <= current_date and a.data_fim > current_date and u.id_usuario = a.id_usuario
	);

-- 11) Quais são os estudantes que assistiram a todas as aulas do curso de ‘legislação’?

select e.*
	from trabalholiviagabilara.estudante e
	inner join(
		select ass.id_usuario, count(*)
			from trabalholiviagabilara.aula a
			inner join trabalholiviagabilara.assiste ass on (ass.id_aula = a.id_aula)
			inner join trabalholiviagabilara.curso c on (c.id_curso = a.id_curso and c.nome_curso = 'Legislação')
			where ass.concluida = true
			group by ass.id_usuario
	) t on (t.id_usuario = e.id_usuario)
	where t.count = (
		select count(*)
			from trabalholiviagabilara.aula a
			inner join trabalholiviagabilara.curso c on (c.id_curso = a.id_curso and c.nome_curso = 'Legislação')
	);

-- 12) Quais são os cursos e serviços associados a eles?

select *
	from trabalholiviagabilara.curso c
	inner join trabalholiviagabilara.servico s on (s.id_curso = c.id_curso);

-- 13) Quais são os estudantes que pagam mais de R$100,00 mensais pela sua assinatura?

select *
	from trabalholiviagabilara.estudante e
	inner join trabalholiviagabilara.assinatura a on (e.id_usuario = a.id_usuario and a.valor_mensal > 100.00);

-- 14) Quais são os estudantes que assistiram a aulas de um curso específico, mas ainda não completaram todas as aulas desse curso?

select *
	from trabalholiviagabilara.estudante e
	where exists(
		select *
			from trabalholiviagabilara.aula a
			inner join trabalholiviagabilara.curso c on (c.id_curso = a.id_curso)
			inner join trabalholiviagabilara.assiste ass on (a.id_aula = ass.id_aula)
			where e.id_usuario = ass.id_usuario and ass.concluida = false
	);

-- 15) Quais são os estudantes que completaram todos os cursos disponíveis na plataforma?

select c.id_usuario, count(*)
	from trabalholiviagabilara.certificado c
	group by c.id_usuario
	having (select count(*) from trabalholiviagabilara.curso) = count(*);
