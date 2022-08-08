Create Table tipo_pagamento(
	id_tipo_pagamento numeric(18,0) not null,
	tipo_pag_nome varchar(60),
	ativo bit,
	tipo_pag_data_inclusao datetime default current_timestamp,
	tipo_pag_data_alteracao datetime default current_timestamp,
	constraint tipo_pag_id_tipo_pagamento_pk primary key clustered(
		id_tipo_pagamento asc
	)
)

create table tipo_endereco(
	tipo_end_id numeric(18,0) not null,
	tipo_end_descricao varchar(120),
	tipo_end_data_inclusao datetime default current_timestamp,
	tipo_end_data_alteracao datetime default current_timestamp,
	constraint tipo_end_id_pk primary key clustered(
		tipo_end_id asc
	)
)

create table tipo_telefone(
	tipotel_id_tipo numeric(18,0) not null,
	tipotel_descricao varchar(120),
	tipotel_data_inclusao datetime default current_timestamp,
	tipotel_data_altercao datetime default current_timestamp,
	constraint tipotel_id_tipo_pk primary key clustered(
		tipotel_id_tipo desc
	)
)

create table categoria_produto(
	categ_id_categoria numeric(18,0) not null,
	categ_descricao numeric(18,0) not null,
	categ_data_inclusao datetime default current_timestamp,
	constraint categ_id_categira_pk primary key clustered(
		categ_id_categoria asc
	)
)

create table cidade(
	ci_id_cidade numeric(18,0) not null,
	ci_nome varchar(60),
	ci_codestado char(2),
	ci_data_inclusao datetime default current_timestamp,
	ci_data_alteracao datetime default current_timestamp,
	constraint ci_id_cidade_pk primary key clustered(
		ci_id_cidade asc
	)
)

create table status_pedido(
	sta_id_status numeric(18,0) not null,
	sta_descricao varchar(120),
	sta_data_inclusao datetime default current_timestamp,
	sta_data_alteracao datetime default current_timestamp,
	constraint sta_id_status_pk primary key clustered(
		sta_id_status asc
	)
)


Create Table status_tracking(
	id_status_tracking numeric(18,0) not null,
	tr_descricao varchar(60),
	tr_data_inclusao datetime default current_timestamp,
	tr_data_alteracao datetime default current_timestamp,
	constraint tr_id_status_tracking_pk primary key clustered(
		id_status_tracking asc
	)
)

Create Table cliente(
	cli_id_cliente numeric(18,0) not null,
	cli_nome varchar(100),
	cli_sobrenome varchar(100),
	cli_email varchar(120) not null,
	cli_cpf varchar(11),
	cli_sexo char(1) 
	constraint cli_valida_sexo check (cli_sexo in ('M','F')),
	cli_senha varchar(60) not null,
	cli_envia_email bit,
	cli_data_inclusao datetime default current_timestamp,
	cli_data_alteracao datetime default current_timestamp,
	constraint cli_id_cliente_pk primary key clustered(
		cli_id_cliente asc
	)
)

create table telefone(
	tel_id_telefone numeric(18,0) not null,
	tel_id_cliente numeric(18,0) not null,
	tel_numero varchar(60),
	tel_tipo_telefone numeric(18,0),
	tel_data_inclusao datetime default current_timestamp,
	tel_data_alteracao datetime default current_timestamp,
	constraint tel_id_telefone primary key clustered (
		tel_id_telefone asc
	),
	constraint cli_tel_id_cliente_fk foreign key(tel_id_cliente)
	references cliente(cli_id_cliente),
	constraint tipotel_tel_tipo_telefone_fk foreign key(tel_tipo_telefone)
	references tipo_telefone(tipotel_id_tipo)

)

create Table endereco(
	end_id_endereco numeric(18,0) not null,
	end_id_cliente numeric(18,0) not null,
	end_bairro varchar(60),
	end_logradouro varchar(60),
	end_numero varchar(30),
	end_tipo_endereco numeric(18,0) not null,
	end_complemento varchar(30),
	end_cep varchar(20),
	end_id_cidade numeric(18,0) not null,
	end_data_inclusao datetime default current_timestamp,
	end_data_alteracao datetime default current_timestamp,
	constraint end_id_enderco_pk primary key clustered(
		end_id_endereco asc
	),
	constraint end_ci_id_cidade_fk foreign key(end_id_cidade)
	references cidade(ci_id_cidade),
	constraint tipo_end_end_tipo_endereco_fk foreign key(end_tipo_endereco)
	references tipo_endereco(tipo_end_id),
	constraint cli_end_id_cliente_fk foreign key(end_id_cliente)
	references cliente(cli_id_cliente)
)



-- faltando acrescetar algo
create table pedido(
	ped_id_pedido numeric(18,0) not null,
	ped_id_cliente numeric(18,0) not null,
	ped_id_tipo_pagamento numeric(18,0) not null,
	ped_id_status numeric(18,0) not null,
	ped_data_confirmacao datetime,
	ped_data_pedido datetime default current_timestamp,
	ped_data_alteracao datetime default current_timestamp,
	constraint ped_id_pedido_pk primary key clustered(
		ped_id_pedido asc
	),
	constraint cli_ped_id_cliente_fk foreign key(ped_id_cliente)
	references cliente(cli_id_cliente),
	constraint tipo_ped_id_tipo_pagamento_fk foreign key(ped_id_tipo_pagamento)
	references tipo_pagamento(id_tipo_pagamento),
	constraint sta_ped_id_status_fk foreign key(ped_id_status)
	references status_pedido(sta_id_status)
)

--Terminar de fazer
create table lancamento(
	lanc_id_lancamento numeric(18,0) not null,
	lanc_id_produto numeric(18,0) not null,
	lanc_id_pedido numeric(18,0) not null,
	lanc_data_lancamento datetime default current_timestamp,
	lanc_quantidade int,
	constraint lanc_id_lancamento_pk primary key(
		lanc_id_lancamento asc
	)

)


create table produto(
	prod_id_produto numeric(18,0) not null,
	prod_id_categoria numeric(18,0) not null,
	prod_vlrcusto numeric(18,2),
	prod_vlrunitario numeric(18,2),
	prod_descricao varchar(120),
	prod_data_inclusao datetime default current_timestamp,
	prod_data_alteracao datetime default current_timestamp,
	constraint prod_id_produto_pk primary key clustered(
		prod_id_produto asc
	),
	constraint categ_prod_id_categoria_fk foreign key (prod_id_categoria)
	references categoria_produto(categ_id_categoria)
)



create table log_procedimentos(
	log_id numeric(18,0) not null identity(1,1),
	error_message varchar(240),
	error_line int,
	error_procedure varchar(120),
	log_data_inclusao datetime default current_timestamp,
	constraint log_id_pk primary key clustered(
		log_id asc
	)
)