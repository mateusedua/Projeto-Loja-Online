create procedure cadastra_cliente
	@email varchar(120),
	@senha varchar(60)

as



declare @cli_id_cliente numeric(18,0) = null



begin try
	begin transaction 
		
		select @cli_id_cliente = next value for cliente_seq

		insert into cliente(cli_email,
							cli_senha)
		values(	@email,
				@senha)

	commit transaction
end try

begin catch
	rollback transaction 

	insert into log_procedimentos(	error_line,
									error_procedure,
									error_message)
	values(	error_line(),
			ERROR_PROCEDURE(),
			ERROR_MESSAGE())

end catch