-- Criação do Banco de Dados para o cenário de E-commerce
create database oficina;
use oficina;

-- Criar tabela Cliente
create table cliente(
	idCliente int primary key not null unique auto_increment,
    nomeCliente varchar(15) not null,
    sobrenomeCliente varchar(20) not null,
    CPFCliente char(11) not null unique,
    dataNascimento date not null,
    CEP char(9) not null,
    rua varchar(25) not null,
    numero int not null,
    complemento varchar(10),
    bairro varchar(20) not null,
    cidade varchar(20) not null,
    estado char(2) not null,
    país varchar(10) not null,
    primary key (idCliente)
);

-- Criar tabela Veículos
create table veiculos(
	placaVeiculo char(7) not null unique,
    idClienteV int not null,
    modelo varchar(15) not null,
    ano date not null,
    cor varchar(15),
    primary key (placaVeiculo, idCliente),
    foreign key (idClienteV) references cliente(idCliente)
);

-- Criar tabela Equipe
create table equipe(
	idEquipe int not null unique auto_increment,
    primary key (idEquipe)
);

-- Criar tabela Mecânicos
create table mecanicos(
	idMecanico int not null unique auto_increment,
    especialidade enum('Motor','Eletrica','Sistemas','Freios') not null,
    idEquipeM int not null,
    nomeMecanico varchar(15) not null,
    sobrenomeMecanico varchar(20) not null,
    CPFMecanico char(11) not null unique,
    dataNascimentoMecanico date not null,
    CEPM char(9) not null,
    ruaM varchar(25) not null,
    numeroM int not null,
    complementoM varchar(10),
    bairroM varchar(20) not null,
    cidadeM varchar(20) not null,
    estadoM char(2) not null,
    paísM varchar(10) not null,
    primary key (idProduto, especialidade),
    foreign key (idEquipeM) references equipe(idEquipe)
);

-- Criar tabela Serviços e Peças (ServPec)
create table servicosPecas(
    idServPec int not null unique auto_increment,
    descricao varchar(250) not null unique,
    valor decimal(4,2) not null,
	estoque int not null default 0,
    primary key (idServPec)
);

-- Criar tabela Ordem de Serviço (OS)
create table OS(
	idOS int not null unique auto_increment,
    placaVeiculoOS char(7) not null,
    idClienteVOS int not null,
    idEquipeOS int not null,
    motivo varchar(250) not null,
    dataEntrada date not null,
    primary key (idOS, placaVeiculoOS, idClienteVOS, idEquipeOS),
    foreign key (placaVeiculoOS) references veiculos(placaVeiculo),
    foreign key (idClienteVOS) references veiculos(idClienteV),
    foreign key (idEquipeOS) references equipe(idEquipe)
);

-- Criar tabela Execução da Ordem de Serviço (EOS)
create table EOS(
	idEOS int not null unique auto_increment,
    idOS int not null unique,
    placaVeiculoEOS char(7) not null,
    idClienteVEOS int not null,
    idEquipeEOS int not null,
    idServPecEOS int not null unique,
    valor decimal(4,2) not null,
    statusEOS enum('Cancelada', 'Em Execução', 'Em Espera', 'Concluída') default 'Em Espera',
    dataConclusao date not null,
    primary key (idEOS, idOS, placaVeiculoEOS, idClienteVEOS, idEquipeEOS, idServPecEOS),
    foreign key (idOS) references OS(idOS),
    foreign key (placaVeiculoEOS) references OS(placaVeiculoOS),
    foreign key (idClienteVEOS) references OS(idClienteVOS),
    foreign key (idEquipeEOS) references OS(idEquipeOS),
    foreign key (idServPecEOS) references servicosPecas(idServPec)
);