-- criação do banco de dados para cenário E-commerce
-- drop database ecommerce;
create database ecommerce;
use ecommerce;

-- criar tabela CLiente
create table clients(
  idClient int auto_increment primary key,
  Fname varchar(10),
  Minit char(3),
  Lname varchar(20),
  CPF char(11) not null,
  Address varchar(30),
  constraint unique_cpf_client unique (CPF)  
);
alter table clients auto_increment=1; -- incrementa a partir daqui
alter table clients drop column CPF;

-- Tabela Pessoa Física
create table client_pf (
  idClient int primary key,
  CPF char(11) not null unique,
  constraint fk_pf_client foreign key (idClient) references clients(idClient)
);

-- Tabela Pessoa Jurídica
create table client_pj (
  idClient int primary key,
  CNPJ char(14) not null unique,
  constraint fk_pj_client foreign key (idClient) references clients(idClient)
);


-- criar tabela Produto
-- size = dimensão do produto
create table product(
  idProduct int auto_increment primary key,
  Pname varchar(10),
  classification_kids bool default false,
  category enum('Eletrônico','Vestimenta','Brinquedos','Cosméticos','Alimentos') not null,
  avaliação float default 0, -- 0 é o valor por default
  size varchar(10)
);

-- criar tabela pagamento
create table payments(
   idClient int,
   idPayment int,
   typePayment enum('Boleto','Cartão','Dois cartões'),
   limitAvailable float,
   primary key(idCLient, idPayment)
);

-- criar tabela pedido
create table orders(
  idOrder int auto_increment primary key,
  idOrderClient int,
  orderStatus enum('Cancelado','Confirmado','Em processamento') default 'Em processamento',
  orderDescription varchar(255),
  sendValue float default 10, -- valor mínimo de frete de R$ 10,00
  paymentCash boolean default false,
  constraint fk_orders_client foreign key (idOrderClient) references clients(idClient)
             on update cascade
);

-- desc orders;
-- criar tabela estoque
create table productStorage(
  idProdStorage int auto_increment primary key,
  storageLocation varchar(255),
  quantity int default 0
);

-- criar tabela fornecedor
create table supplier(
  idSupplier int auto_increment primary key,
  SocialName varchar(255) not null,
  CNPJ char(15) not null,
  contact char(11) not null,
  constraint unique_supplier unique(CNPJ)
);
desc supplier;
-- criar tabela vendedor-terceiro
create table seller(
  idSeller int auto_increment primary key,
  SocialName varchar(255) not null,
  AbstName varchar(255), -- nome fantasia
  CNPJ char(15),
  CPF char(9),
  location varchar(255),
  contact varchar(255),
  constraint unique_cnpj_seller unique (CNPJ),
  constraint unique_cpf_seller unique (CPF)
);
-- criando tabela Entrega
create table shipping (
  idShipping int auto_increment primary key,
  idOrder int,
  trackingCode varchar(100),
  status enum('Postado', 'Em trânsito', 'Entregue', 'Cancelado') default 'Postado',
  constraint fk_shipping_order foreign key (idOrder) references orders(idOrder)
);

-- tabela Produtos/Vendedor
create table productSeller(
  idPseller int,
  idPproduct int,
  prodQuantity int default 1,
  primary key (idPseller, idPproduct), -- chave composta
  constraint fk_product_seller foreign key (idPseller) references seller(idSeller),
  constraint fk_product_product foreign key (idPproduct) references product(idProduct)
);
desc productSeller;
-- tabela Produto/Pedido
create table productOrder(
  idPOproduct int,
  idPOorder int,
  poQuantity int default 1,
  poStatus enum('Disponível','Sem estoque')default 'Disponível',
  primary key (idPOproduct, idPOorder), -- chave composta
  constraint fk_productorder_seller foreign key (idPOproduct) references product(idProduct),
  constraint fk_productorder_product foreign key (idPOorder) references orders(idOrder)
);

-- 
create table storageLocation(
  idLproduct int,
  idLstorage int,
  location varchar(255) not null,
  primary key (idLproduct, idLstorage),
  constraint fk_storage_location_product foreign key (idLproduct) references product(idProduct),
  constraint fk_storage_location_storage foreign key (idLstorage) references productStorage(idProdStorage)  
);
-- tabela Produto/Fornecedor
create table productSupplier(
  idPsSupplier int,
  idPsProduct int,
  quantity int not null,
  primary key (idPsSupplier, idPsProduct),
  constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier(idSupplier),
  constraint fk_product_supplier_product foreign key (idPsProduct) references product(idProduct)  
);
desc productSupplier;
show tables;
show databases;
use information_schema;
show tables;
desc referential_constraints;

select * from referential_constraints where constraint_schema = 'ecommerce'; -- comando que mostra as constrainst definidas no banco de dados