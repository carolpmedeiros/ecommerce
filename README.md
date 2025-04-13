# ecommerce

Foi solicitado o refinamento de um modelo conceitual de Banco de Dados considerando os seguintes pontos:

- Cliente PJ e PF – Uma conta pode ser PJ ou PF, mas não pode ter as duas informações;
- Pagamento – Pode ter cadastrado mais de uma forma de pagamento;
- Entrega – Possui status e código de rastreio;

Para atender essa solicitação, foram criadas as entidades:

- Cliente PJ e Cliente PF, as quais possuem relacionamento 1:1 com a entidade Cliente, porém esta entidade pode se relacionar exclusivamente com uma OU outra. Além disso, essas novas entidades possuem atributos como nome, CPF/CNPJ, razão social (de acordo com cada uma);
- Entrega: Possui relacionamento do tipo 1:1 com a entidade Pedido, a qual permite rastrear o status e código de envio do pedido;
- Pagamento: Possui relacionamento com a entidade Cliente, em que especifica qual o tipo de pagamento (cartão de crédito,boleto,etc) cadastrado pelo Cliente e sua descrição (por exemplo, número do cartão de crédito).
