-- inserção de dados e queries
-- drop database ecommerce;
use ecommerce;
show tables;
-- idCLient, Fname, Minit, Lname, CPF, Address
insert into clients (Fname, Minit, Lname, CPF, Address)
values('Maria','M','Silva', 123456789, 'rua santos 29, Flores - Manaus'),
      ('Ana','M','Souza', 07587356428, 'rua dias 10, Japiim - Natal'),
      ('Pedro','O','Santos', 741852963, 'rua dias 10, Glória - Natal'),
      ('Lucas','F','Santos', 963258147, 'rua campos 4, Alves - Campinas'),
      ('Alice','G','Medeiros', 96325855, 'rua josé 754, Tirol - Vitória'),
      ('Gabriela','F','Oliveira', 852369159, 'rua carlos 951, Tirol - Natal');

      
insert into product (Pname, classification_kids, category, avaliação, size) values
           ('Fone', false, 'Eletrônico', '4', null),
           ('Barbie', true, 'Brinquedos', '3', null),
           ('Body', true, 'Vestimenta', '5', null),
           ('Microfone', false, 'Eletrônico', '4', null),
	       ('Biscoito', false, 'Alimentos', '2', null),
           ('Shampoo', false, 'Cosméticos', '3', null);
      
select * from clients;
select * from product;
delete from orders where idOrderClient in (1,2,3,4);
insert into orders (idOrderClient, orderStatus, orderDescription, sendValue, paymentCash) values
            (1,default,'compra via app',null,1),
            (2,default,'compra via app',50,0),
            (3,'Confirmado', null, null, 1),
            (4,default,'compra via web site', 150, 0);
            
select * from orders;

insert into productOrder (idPOproduct, idPOorder, poQuantity, poStatus) values
            (1,1,2,null),
            (2,2,2,null),
            (3,3,1,null);
            
insert into productStorage (storageLocation,quantity) values
                           ('Rio de Janeiro','1000'),
                           ('Rio de Janeiro',500),
                           ('Natal',10),
                           ('Natal',100),
                           ('Natal',100),
						   ('Recife',100);
                           
insert into storageLocation (idLproduct, idLstorage, location) values
             (1,3,'RJ'),
             (2,4,'GO');
             
insert into supplier (SocialName, CNPJ, contact) values
                      ('Almeida e Filhos', 123456789123457, '21985454'),    
                      ('L&L Atacado', 123456123456789, '21985464'),  
                      ('SW Logistica', 543216123456789, '21985474');
                      
select * from supplier;

insert into productSupplier (idPsSupplier, idPsProduct, quantity) values
                (1,1,500),
                (1,2,400),
                (2,4,633),
                (3,3,5),
                (2,5,10);
                
insert into seller (SocialName, AbstName, CNPJ, CPF, location, contact) values
                  ('Tech tudo', null, 123456789123454, null, 'Natal',848794726),
                  ('Hello World', null, 123456789654123, null, 'Rio de Janeiro', 848794726),
                  ('Kids Team', null, 754156789654123, null, 'Recife', 818794446);
select * from seller;

INSERT INTO productSeller (idPSeller, idPproduct, prodQuantity) 
VALUES 
  (1,2,80),
  (2,3,10);

insert into productSeller (idPseller, idPproduct, prodQuantity) values
                          (1,6,80),
                          (2,7,10);
 -- PERGUNTAS:
 -- 1.Quantos pedidos foram feitos por cada cliente?
select 
  c.idClient,
  c.Fname,
  c.Lname,
  count(o.idOrder) as total_pedidos
from clients c
left join orders o on c.idClient = o.idOrderClient
group by c.idClient
order by total_pedidos desc;

-- 2. Algum vendedor também é fornecedor?
select 
  s.SocialName
from seller s
join supplier f on s.CNPJ = f.CNPJ or s.contact = f.contact;

-- 3. Relação de produtos,fornecedores e  estoque:
select 
  p.Pname as Produto,
  f.SocialName as Fornecedor,
  ps.quantity as Quantidade_fornecida,
  st.storageLocation,
  stg.quantity as Quantidade_estoque
from product p
join productSupplier ps on p.idProduct = ps.idPsProduct
join supplier f on ps.idPsSupplier = f.idSupplier
left join storageLocation sl on p.idProduct = sl.idLproduct
left join productStorage stg on sl.idLstorage = stg.idProdStorage
left join productStorage st on sl.idLstorage = st.idProdStorage;

-- 4.Relação de nomes dos fornecedores e nomes dos produtos
select 
  f.SocialName as Fornecedor,
  p.Pname as Produto
from supplier f
join productSupplier ps on f.idSupplier = ps.idPsSupplier
join product p on p.idProduct = ps.idPsProduct
order by f.SocialName;

-- 5. Quais são todos os clientes cadastrados na Base de dados ECOMMERCE?
select * from clients;

-- 6. Quais são todos os produtos da categoria Eletrônico?
select * from product where category = 'Eletrônico';

-- 7. Quais pedidos tiveram o frete mais caro?
select * from orders order by sendValue desc;

-- 8. Quais clientes fizeram mais de 3 pedidos?
select 
  idOrderClient,
  count(*) as pedidos
from orders
group by idOrderClient
having count(*) > 3;

-- 9.Quais produtos foram comprados por cada cliente e em qual pedido?
select 
  c.Fname,
  o.idOrder,
  p.Pname,
  po.poQuantity
from clients c
join orders o on c.idClient = o.idOrderClient
join productOrder po on o.idOrder = po.idPOorder
join product p on po.idPOproduct = p.idProduct;

-- 10. Há quanto tempo, em média, os clientes estão cadastrados?
select 
  idClient,
  Fname,
  Lname,
  year(curdate()) - 1990 as tempo_medio_cliente
from clients;