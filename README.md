# ecommerce

Foi solicitado o refinamento de um modelo conceitual de Banco de Dados considerando os seguintes pontos,a partir do levantamento de requisitos realizado no início do desafio:

- Cliente PJ e PF – Uma conta pode ser PJ ou PF, mas não pode ter as duas informações;
- Pagamento – Pode ter cadastrado mais de uma forma de pagamento;
- Entrega – Possui status e código de rastreio;

Para atender essa solicitação, foram criadas as entidades:

- Cliente PJ e Cliente PF, as quais possuem relacionamento 1:1 com a entidade Cliente, porém esta entidade pode se relacionar exclusivamente com uma OU outra. Além disso, essas novas entidades possuem atributos como nome, CPF/CNPJ, razão social (de acordo com cada uma);
- Entrega: Possui relacionamento do tipo 1:1 com a entidade Pedido, a qual permite rastrear o status e código de envio do pedido;
- Pagamento: Possui relacionamento com a entidade Cliente, em que especifica qual o tipo de pagamento (cartão de crédito,boleto,etc) cadastrado pelo Cliente e sua descrição (por exemplo, número do cartão de crédito).

No arquivo "esquema_relacional_sql" estão organizadas as criações de entidades que compõem o contexto da narrativa tratada neste desafio.
Além disso,no arquivo "queries_and_data_insertion" foi realizada a persitência dos dados nas respectivas entidades já criadas, bem como a criação de queries para responder perguntas de negócio,como as listadas abaixo:
1) Quantos pedidos foram feitos por cada cliente?
2) Algum vendedor também é fornecedor?
3) Qual a relação de produtos,fornecedores e  estoque?
4) Relação de nomes dos fornecedores e nomes dos produtos?
5) Quais são todos os clientes cadastrados na Base de dados ECOMMERCE?
6) Quais são todos os produtos da categoria Eletrônico?
7)Quais clientes fizeram mais de 3 pedidos?
8) Quais produtos foram comprados por cada cliente e em qual pedido?
9) Há quanto tempo, em média, os clientes estão cadastrados?

