-- View que contém os cursos que tiveram todas as aulas assistidas por completo por cada estudante
-- Usada para gerar certificados dos cursos
create view trabalholiviagabilara.cursos_concluidos_por_estudante as
	select e.id_usuario, s.id_curso
		from trabalholiviagabilara.estudante e
		inner join(
			select ass.id_usuario, c.id_curso, count(*)
				from trabalholiviagabilara.aula a
				inner join trabalholiviagabilara.assiste ass on (ass.id_aula = a.id_aula)
				inner join trabalholiviagabilara.curso c on (c.id_curso = a.id_curso)
				where ass.concluida = true
				group by ass.id_usuario, c.id_curso
		) t on (t.id_usuario = e.id_usuario) -- aulas assistidas por curso
		inner join(
			select c.id_curso, count(*)
				from trabalholiviagabilara.aula a
				inner join trabalholiviagabilara.curso c on (c.id_curso = a.id_curso)
				group by c.id_curso
		) s on (s.id_curso = t.id_curso and t.count = s.count); -- cursos concluídos

-- View que contém os cursos e suas aulas correspondentes
-- Usada para exibir os cursos e suas aulas correspondentes
select *
	from trabalholiviagabilara.aula a
	inner join trabalholiviagabilara.curso c on (c.id_curso = a.id_curso);
