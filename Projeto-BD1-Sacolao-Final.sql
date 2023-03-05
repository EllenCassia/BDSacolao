--tabelas
CREATE TABLE Cliente(
	id_cliente serial PRIMARY KEY,
	nome varchar(30) NOT NULL,
	id_endereco_fk integer 
);

CREATE TABLE Endereco(
	id_endereco serial PRIMARY KEY,
	cidade varchar(30) NOT NULL,
	cep integer NOT NULL,
	rua varchar(30) NOT NULL,
	numero integer NOT NULL,
	bairro varchar(30) NOT NULL
);

-- Adicionando chave primária
ALTER TABLE Cliente ADD CONSTRAINT id_endereco_fk FOREIGN KEY(id_endereco_fk) REFERENCES Endereco(id_endereco)

CREATE TABLE Telefone(
	id_num serial PRIMARY KEY,
	numero integer UNIQUE,
	id_cliente_fk integer REFERENCES Cliente(id_cliente)

)

CREATE TABLE Funcionario(
	id_func serial PRIMARY KEY,
	nome varchar(30)
)

CREATE TABLE Produto_Local(
	id_prodlocal serial PRIMARY KEY,
	nome varchar(30) NOT NULL,
	tipo varchar(30) NOT NULL,
	preco float NOT NULL

)

CREATE TABLE Fiado(
	id_fiado serial PRIMARY KEY,
	dataFimFiado date NOT NULL
)

CREATE TABLE Compra(
	id_compra serial PRIMARY KEY,
	id_fiado_fk integer UNIQUE REFERENCES Fiado(id_fiado),
	id_cliente_fk integer REFERENCES Cliente(id_cliente) NOT NULL,
	id_func_fk integer REFERENCES Funcionario(id_func) NOT NULL,
	qtd_produto integer NOT NULL,
	data_compra date NOT NULL,
	valor_total float NOT NULL
)

CREATE TABLE CompraPagamento(
	id_Compra integer NOT NULL,
	id_pagamento serial UNIQUE PRIMARY KEY,
	qtd_vezes integer,
	dataPagamento date NOT NULL,
	valorTotal float NOT NULL,
	data_compra date NOT NULL,
	tipo varchar(15) NOT NULL,
	bandeira varchar(20)
)

CREATE TABLE Contem(
	id_prodlocal_fk integer REFERENCES Produto_Local(id_prodlocal),
	id_compra_fk integer REFERENCES Compra(id_compra)
)

CREATE TABLE NotaReposicao(
	id_nota serial PRIMARY KEY,
	nome varchar(30) NOT NULL,
	qtd_produto integer NOT NULL,
	preco float NOT NULL,
	total_pago float NOT NULL

)

CREATE TABLE Func_Nota(
	data date NOT NULL,
	id_nota_fk integer References NotaReposicao(id_nota),
	id_func_fk integer References Funcionario(id_func)
)

CREATE TABLE Nota_Prod(
	id_prod_fk integer REFERENCES Produto(id_prod),
	id_nota_fk integer REFERENCES NotaReposicao(id_nota)
)
CREATE TABLE Produto(
	id_prod serial PRIMARY KEY,
	nome varchar(30) NOT NULL,
	tipo varchar(30) NOT NULL,
	preco float NOT NULL

)

--Deletar Tabela
DROP TABLE Cliente;
DROP TABLE Endereco;
DROP TABLE Telefone;
DROP TABLE Funcionario;
DROP TABLE Compra;
DROP TABLE Contem;
DROP TABLE Produto_Local;
DROP TABLE CompraPagamento;
DROP TABLE Fiado;
DROP TABLE NotaReposicao;
DROP TABLE Nota_Prod;
DROP TABLE Func_Nota;
DROP TABLE Produto;

--DML

--CONTROLE DE REGISTRO DE UMA VENDA

--INSERÇÃO
-- Inserção de Cliente
insert into Cliente (nome,id_endereco_fk) values ('Maria',1);
insert into Cliente (nome,id_endereco_fk) values ('Paula',2);
-- Inserção de Endereço
insert into Endereco (cep,bairro,numero,cidade,rua) values (58500000,'Centro',82,'Monteiro','Rua Borba Filho');
insert into Endereco (cep,bairro,numero,cidade,rua) values (58500000,'Centro',23,'Monteiro','Rua Oliveira Lima');
--Inserção Telefone
insert into Telefone (numero, id_cliente_fk) values ('954127844', 1);
insert into Telefone (numero, id_cliente_fk) values ('956398452', 2);
-- Inserção Funcionario
insert into Funcionario (nome) values('Frederico');
insert into Funcionario (nome) values('Bastião');
-- Inserção Compra
insert into Compra(id_fiado_fk,id_cliente_fk,id_func_fk,qtd_produto,data_compra,valor_total) values (1,1,1,3,'01/11/1990',35.90)
insert into Compra(id_fiado_fk,id_cliente_fk,id_func_fk,qtd_produto,data_compra,valor_total) values (2,2,1,2,'15/12/2022',15.78)
insert into Compra(id_fiado_fk,id_cliente_fk,id_func_fk,qtd_produto,data_compra,valor_total) values (null,1,1,4,'25/01/2023',45.36)
--Inserção Contem (-ProdutoLocalCompra)
--Compra de Maria (Fiado)
insert into Contem (id_prodlocal_fk, id_compra_fk) values (1,1)
insert into Contem (id_prodlocal_fk, id_compra_fk) values (2,1)
insert into Contem (id_prodlocal_fk, id_compra_fk) values (5,1)
--Compra de Paula (Fiado)
insert into Contem (id_prodlocal_fk, id_compra_fk) values (1,2)
insert into Contem (id_prodlocal_fk, id_compra_fk) values (6,2)
--Compra de Maria 
insert into Contem (id_prodlocal_fk, id_compra_fk) values (3,3)
insert into Contem (id_prodlocal_fk, id_compra_fk) values (6,3)
insert into Contem (id_prodlocal_fk, id_compra_fk) values (1,3)
insert into Contem (id_prodlocal_fk, id_compra_fk) values (2,3)
-- Inserção Produto Local
insert into Produto_Local (nome, tipo, preco) values ('Batata', 'legumes', 8.90)
insert into Produto_Local (nome, tipo, preco) values ('Mandioca', 'legumes', 7.45)
insert into Produto_Local (nome, tipo, preco) values ('Biscoito Polvilho', 'variedades', 5.00)
insert into Produto_Local (nome, tipo, preco) values ('Alface', 'verduras', 3.60)
insert into Produto_Local (nome, tipo, preco) values ('Rapadura','variedades' ,10.00)
insert into Produto_Local (nome, tipo, preco) values ('Maça','fruta', 6.98)
-- inserção Fiado
insert into Fiado (dataFimFiado) values ('01/12/1990');
insert into Fiado (dataFimFiado) values ('15/01/2023');
--Inserção Pagamento
insert into  CompraPagamento(id_Compra,qtd_vezes,dataPagamento,valorTotal,data_compra,tipo,bandeira) values (1,2,'01/12/1990',17.95,'01/11/1990','Crédito','Visa');
insert into  CompraPagamento(id_Compra,qtd_vezes,dataPagamento,valorTotal,data_compra,tipo,bandeira) values (2,null,'15/01/2023',15.78,'15/12/2022','Debito','MasterCard');
insert into  CompraPagamento(id_Compra,qtd_vezes,dataPagamento,valorTotal,data_compra,tipo,bandeira) values (3,null,'25/01/2023',45.36,'25/01/2023','',null);

--ALTERAÇÃO
-- Atualização de Cliente
update Cliente set nome = 'Maria Julia' where id_cliente = 1;
-- Atualização de Endereço
update Endereco set numero = 254 where id_endereco = 5;
-- Atualização de Telefone
update Telefone set numero = 962359159 where id_cliente_fk = 1;
-- Atualização de Funcionario
update Funcionario set nome = 'Bastião' where id_func = 1;
-- Atualização de Compra
update Compra set id_compra = 3 where id_compra = 4;
-- Atualização de Produto_Local
update Produto_Local set tipo = 'fruta' where id_prodlocal = 5;
-- Atualização de Pagamento
update CompraPagamento set qtd_vezes = 1 where id_Compra = 1;


--REMOÇÃO
--Deletar um Cliente
delete from Cliente where id_cliente = 1;
--Deletar um Endereco
delete from Endereco where id_endereco = 1;
--Deletar um Telefone
delete from Telefone where id_num = 1;
--Deletar um Funcionario
delete from Funcionario where id_func = 1;
--Deletar um Compra
delete from Compra where id_compra = 1;
--Deletar um Produto_Local
delete from Produto_Local where id_prodlocal = 1;
--Deletar um Pagamento
delete from CompraPagamento where id_pagamento = 6;
-- Deletar 'Contem'
delete from Contem where id_compra_fk =1;


--CONTROLE DE PRODUTO DO ESTOQUE 

--INSERÇÃO
-- Inserção Nota
insert into NotaReposicao(nome,qtd_produto,preco,total_pago) values ('Bastião', 5,2.63,18.60)
insert into NotaReposicao(nome,qtd_produto,preco,total_pago) values ('Frederico', 4,5.06,14.50)
--Inserção NotaProduto
insert into Nota_Prod(id_prod_fk,id_nota_fk) values (1,1)
insert into Nota_Prod(id_prod_fk,id_nota_fk) values (2,1)
--2 nota
insert into Nota_Prod(id_prod_fk,id_nota_fk) values (3,2)
insert into Nota_Prod(id_prod_fk,id_nota_fk) values (4,2)
--Inserção FuncionarioNota
insert into Func_Nota(data,id_nota_fk,id_func_fk) values ('25/05/2004',1,1)
insert into Func_Nota(data,id_nota_fk,id_func_fk) values ('28/05/2004',2,2)
--Inserção Produto
insert into Produto(nome,tipo,preco) values ('Batata', 'legumes', 6.90)
insert into Produto(nome,tipo,preco) values ('Maça', 'fruta', 4.90)
insert into Produto(nome,tipo,preco) values ('Rapadura', 'variedades', 7.90)
insert into Produto(nome,tipo,preco) values ('Alface', 'verduras', 2.90)

--ALTERAÇÃO
--Atualização de NotaReposicao
update NotaReposicao set preco = 2.60 where id_nota = 1;
-- Atualização de Produto
update Produto set nome = 'Batata' where nome = 'Cenoura';


--REMOÇÃO
--Deletar um Nota
delete from NotaReposicao where id_nota = 1;
--Deletar um NotaProduto
delete from Nota_Prod where id_prod_fk = 1;
--Deletar um FuncionarioNota
delete from Func_Nota where id_func_fk = 1;
--Deletar um Produto
delete from Produto where id_prod = 1;

-- DQL

--SELEÇÃO
--Controle de Vendas
select * from Cliente;
select * from Endereco;
select * from Telefone;
select * from Funcionario;
select * from Compra;
select * from Contem;
select * from Produto_Local;
select * from CompraPagamento;
select * from Fiado;
--Controle de Estoque
select * from NotaReposicao;
select * from Nota_Prod;
select * from Func_Nota;
select * from Produto;

INSERT into endereco 
--União

-- Retorna todos os Produtos (entre Produtos e Produtos_locais) de um mesmo tipo( ou todos).
select nome, tipo from Produto
union
select nome, tipo from Produto_Local

--Interseçao
-- produto que é local e recebido através de distrubuição ao mesmo tempo
select nome, tipo from Produto_local
intersect
select nome, tipo from Produto

-- Subtração
-- produtos que são de um determinado tipo e que são apenas local ou distribuido
select nome from Produto_Local where tipo = 'legumes'
except
select nome from Produto


--Junção
--Solucionando os problemas de processamentos não eficazes de busca para registro de venda e controle de compras no sacolão usando a junção 

--Falta de dados necessários do cliente que efetuo uma compra a prazo.
select * from Cliente inner join Endereco on Cliente.id_endereco_fk = Endereco.id_endereco;

--Encontrar o cliente em meio as outras fichas de registro. 
--Ex encontrar compras realizada pelo 2 cliente  
select * from Cliente inner join Compra on Compra.id_cliente_fk = 2 and Cliente.id_cliente = 2;

--Identificar os produtos que cada cliente realizou na compra. 
--Mostra todas as compras e seu respectivos produtos
select id_compra_fk,nome from Contem inner join Produto_Local on Contem.id_prodlocal_fk = Produto_Local.id_prodlocal;
--Ex encontrar produtos que o cliente 2 (paula) realizou numa compra 3 
select id_compra_fk,nome from Contem inner join Produto_Local on Contem.id_prodlocal_fk = Produto_Local.id_prodlocal and Contem.id_compra_fk = 3
select id_compra_fk,nome from Contem inner join Produto_Local on Contem.id_prodlocal_fk = Produto_Local.id_prodlocal and Contem.id_compra_fk = 7

--Controle de pagamento efetuado pelo cliente numa compra 
--Fim do fiado de um cliente
select id_cliente_fk,id_fiado,datafimfiado,id_compra,data_compra,valor_total from Fiado inner join Compra on Fiado.id_fiado = Compra.id_fiado_fk;
select * from Cliente where id_cliente = 1;
--Forma de pagamento de um cliente na compra
select id_cliente_fk, id_compra, id_pagamento, tipo from Compra inner join CompraPagamento using (id_compra);

--Identificar os produtos que foram repostos no estoque
select id_nota_fk,nome,tipo,preco from Nota_Prod inner join Produto on Produto.id_prod = Nota_Prod.id_prod_fk;

--Subconsulta
--Saber qual Funcionario que não atendeu nenhuma compra 
select nome, id_func from Funcionario where not exists (select * from Compra where Compra.id_func_fk = Funcionario.id_func);

-- Retorna os clientes que compraram fiado
select nome, id_endereco_fk from Cliente where Cliente.id_cliente in(select id_cliente_fk from Compra where id_fiado_fk ISNULL)
