-- 1) Trigger que gera o certificado de um aluno que concluiu um curso
create or replace function entregar_certificado() returns trigger as
$$
declare
	curso varchar(100);
	concluiu boolean;
begin
	select c.id_curso from curso c
		inner join aula a on (a.id_curso = c.id_curso)
		where a.id_aula = new.id_aula into curso;
		
	select (v.id_usuario = new.id_usuario and curso = v.id_curso)
		from cursos_concluidos_por_estudante v
		where not exists(
			select from certificado c
				where new.id_usuario = c.id_usuario and curso = c.id_curso
		) into concluiu;
		
	if(concluiu) then
		insert into certificado values(
			concat('cert_', curso, '_', new.id_usuario),
			current_date,
			new.id_usuario,
			curso
		);
	end if;
	return new;
end;
$$
language plpgsql;

create trigger gerar_certificados
	after insert or update on assiste
	for each row
	execute procedure entregar_certificado();

--2) Trigger que atualiza o valor de assinatura se a mesma for alterada no plano

create or replace function atualiza_assinatura_historico()
returns trigger as $$
declare
    meses_passados int;
    meses_restantes int;
    nova_versao int;
    rec_assinatura record;
    valor_mensal numeric;
begin 
    for rec_assinatura in
        select * 
        from assinatura
        where id_plano = new.id_plano
    loop
        meses_passados := extract(year from age(current_date, rec_assinatura.data_inicio)) * 12 + extract(month from age(current_date, rec_assinatura.data_inicio));
  
        meses_restantes := extract(year from age(rec_assinatura.data_fim, current_date)) * 12 + extract(month from age(rec_assinatura.data_fim, current_date));
        update assinatura
        set data_fim = current_date  
        where id_plano = rec_assinatura.id_plano 
          and id_usuario = rec_assinatura.id_usuario
          and versao = rec_assinatura.versao;

        if new.duracao = 12 then  
            valor_mensal := new.valor / 12;
        elsif new.duracao = 6 then  
            valor_mensal := new.valor / 6;
        else 
            valor_mensal := new.valor;
        end if;

        select coalesce(max(versao), 0) + 1 into nova_versao
        from assinatura
        where id_plano = rec_assinatura.id_plano 
          and id_usuario = rec_assinatura.id_usuario;

        insert into assinatura (id_plano, id_usuario, data_inicio, valor_mensal, data_fim, versao)
        values (new.id_plano, rec_assinatura.id_usuario, current_date, valor_mensal, current_date + interval '1 month' * meses_restantes, nova_versao);
    end loop;

    return new;
end;
$$ language plpgsql;

create trigger atualiza_assinatura_trigger
after update on plano
for each row
execute function atualiza_assinatura_historico();
