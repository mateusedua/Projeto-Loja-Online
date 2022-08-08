create procedure sp_cadastra_dados_cliente
	@cli_id_cliente numeric(18,0),
	@cli_nome varchar(100),
	@cli_sobrenome varchar(100),
	@cli_cpf varchar(11),
	@cli_sexo char(1),-- M - Masculino or F - Feminino or PI - Não Informar
	@cli_data_nascimento date,
	@tel_numero varchar(60)

as

declare @tel_id_telefone numeric(18,0) = null

begin try
	
	begin
		update cliente
		set cli_nome = @cli_nome,
			cli_sobrenome = @cli_sobrenome,
			cli_cpf = @cli_cpf,
			cli_sexo = @cli_sexo,
			cli_data_nascimento = @cli_data_nascimento
		where cli_id_cliente = @cli_id_cliente

		--Cadastrando o telefone
		select @tel_id_telefone = next value for telefone_seq

		insert into telefone(	tel_id_telefone,
								tel_id_cliente,
								tel_numero)
		values(	@tel_id_telefone,
				@cli_id_cliente,
				@tel_numeros)


	end

	commit transaction
end try

begin catch
	rollback transaction

		insert into log_procedimentos(	error_line,
										error_message,
										error_procedure)
		values(	ERROR_LINE(),
				ERROR_MESSAGE(),
				ERROR_PROCEDURE())
end catch