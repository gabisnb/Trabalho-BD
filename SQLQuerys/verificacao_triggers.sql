-- 1) Trigger que gera o certificado de um aluno que concluiu um curso
-- deve retornar “UPDATE 1” e inserir linha na tabela certificado para o usuário com id ‘user2’
update trabalholiviagabilara.assiste
	set concluida = true where (id_usuario = 'user2') and (id_aula = 'aula_photoshop_01');

select * from trabalholiviagabilara.certificado;
--2) Trigger que atualiza o valor de assinatura se a mesma for alterada no plano
-- deve retornar a tabela Assinatura devidamente atualizada com os planos_anuais com o novo valor.
update trabalholiviagabilara.plano
set valor = 500.00
where id_plano = 'plano_anual';

select * from trabalholiviagabilara.assinatura
where id_plano = 'plano_anual';
