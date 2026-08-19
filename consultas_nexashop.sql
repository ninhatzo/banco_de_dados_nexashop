Use ecommerce_nexashop;

-- Atividade 0 — Validação do ambiente (entrega individual, rápida)

USE ecommerce_nexashop;
SELECT
'clientes' AS tabela, COUNT(*) AS total FROM clientes
UNION ALL
SELECT
'produtos' AS tabela, COUNT(*) AS total FROM produtos
UNION ALL
SELECT
'pedidos' AS tabela, COUNT(*) AS total FROM pedidos
UNION ALL
SELECT
'avaliacoes' AS tabela, COUNT(*) AS total FROM avaliacoes;

/*Bloco 1 — Reconhecimento do banco
 Esta consulta representa uma visão geral da tabela avaliação, clientes, pedidos, produtos, para fins de conhecer qual os dados contém.*/
 
 /*TAREFA 1-1 -  Primeiro contato com os dados
  Execute um SELECT * com LIMIT 10 em cada uma das quatro tabelas (clientes, produtos, pedidos, avaliacoes). */
  /*Primeira parte traz as informações das tabelas quais os dados cada tabela tem.*/
  SELECT *
 FROM avaliacoes
 limit 10;
 
 SELECT *
 FROM clientes
 limit 10;
 
 SELECT *
 FROM pedidos
 limit 10;
 
 SELECT *
 FROM produtos
 limit 10;
 
 /*TAREFA 1-2  Catálogo de produtos para o marketing
  Liste nome, categoria, marca, preço (com alias "Valor (R$)") e estoque de todos os produtos, sem usar SELECT *. */
 /*Nesta consulta traz as informções de nome, categoria, marca, preco se usar o select* que traz as informações direta da tabela. */
 SELECT
 nome,
 categoria,
 marca,
 preco AS "Valor (R$)",
 estoque
 FROM produtos;
 
  /*TAREFA 1-3 - : Quantas categorias a loja realmente vende.
   Liste as categorias de produtos sem repetição, em ordem alfabética. */
 
 /*Neta consulta traz as informações sem repetições e em ordem alfabetica.*/
  SELECT DISTINCT categoria /* DISTINCT garante que cada categoria apareça apenas uma vez no resultado*/  
  FROM produtos
  ORDER BY categoria ASC; /* ORDER BY categoria ASC faz organizar em ordem de A a Z.*/
 
    /*TAREFA 1-4 -  Formas de pagamento e canais de venda aceitos .
    Liste, sem repetição, todas as formas de pagamento e, em outra consulta, todos os canais de venda registrados nos pedidos. */
  
   /*Nesta consulta traz as formas de pagamento sem duplicada só as existentes. forma_pagaemento, canal_venda. */
   
   SELECT DISTINCT forma_pagamento
    FROM pedidos;
 
    SELECT DISTINCT canal_venda
    from pedidos;
    
-- Tarefa 2.1 — Clientes ativos da região Sul
-- Contexto: O time comercial quer priorizar uma campanha regional.
-- Tarefa: Liste nome, cidade, estado e status dos clientes ativos dos estados SC, PR e RS, ordenando por estado e depois por nome.
-- Evidência esperada: WHERE com status = 'Ativo', IN para os estados, AND e ORDER BY em duas colunas.

SELECT
	nome AS Cliente,
    estado AS Estado,
    cidade AS Cidade, 
    status AS Status -- Determinando os dados que eu quero que apareça
FROM clientes -- De onde eu quero que saia os dados
WHERE estado IN ('SC', 'PR', 'RS') -- Dizendo de quais estados eu quero os dados
AND status = 'Ativo' -- E que eu quero que filtre somente os ativos
ORDER BY estado ASC, nome ASC; -- E que eles apareçam por ordem de estado e nome

---------------------

-- Tarefa 2.2 — Busca de cliente por nome (tela de atendimento)
-- Contexto: O atendimento recebe do cliente apenas parte do nome.
-- Tarefa: Crie uma consulta que encontre clientes cujo nome contenha um termo escolhido pela dupla.
-- Evidência esperada: Uso correto de LIKE com o caractere %.

SELECT
	nome AS Cliente -- Determinando o dado que eu quero que apareça
FROM clientes -- De onde eu quero que ele recolha os dados
WHERE nome LIKE 'sa%'; -- Utilizando WHERE para determinar que eu quero somente pesquisas que iniciem com 'SA'

---------------------

-- Tarefa 2.3 — Clientes sem telefone cadastrado
-- Contexto: Uma campanha de atualização cadastral por e-mail será disparada para quem não tem telefone informado.
-- Tarefa: Liste nome, e-mail, cidade e estado dos clientes com telefone nulo.
-- Evidência esperada: Uso de IS NULL e seleção objetiva de colunas.

SELECT 
	nome AS Cliente,
    email AS Email,
    cidade AS Cidade,
    estado AS Estado -- Determinando os dados que eu quero que apareça
FROM clientes -- De onde eu quero que ele recolha os dados
WHERE telefone IS NULL; -- Utilizando o WHERE para determinar que eu quero que apareça somente quem tem telefone nulo

---------------------

-- Tarefa 2.4 — Pedidos de ticket intermediário aprovados
-- Contexto: A diretoria quer entender o perfil de pedidos "de ticket médio" — nem os menores, nem os maiores.
-- Tarefa: Liste os pedidos aprovados com valor_total entre R$ 100 e R$ 500, ordenados do maior para o menor valor.
-- Evidência esperada: BETWEEN combinado com filtro de status e ORDER BY DESC

SELECT
	cliente_id AS Cliente,
    valor_total AS Valor,
    status AS Status -- Determinando os dados que eu quero que apareça
FROM pedidos -- De onde eu quero que ele recolha os dados
WHERE valor_total BETWEEN 100 AND 500 -- Utilizando WHERE para filtrar pedidos entre R$ 100,00 e R$ 500,00
AND status = 'Aprovado' -- E que o pedido tem que estar aprovado
ORDER BY valor_total DESC; -- Ordenado do maior valor para o menor

---------------------

-- Tarefa 2.5 — Alerta de reposição de estoque
-- Contexto: O time de compras precisa saber quais produtos ativos estão com estoque crítico.
-- Tarefa: Liste nome, categoria e estoque dos produtos ativos com estoque menor que 10, ordenados do menor estoque para o maior.
-- Evidência esperada: WHERE com duas condições unidas por AND e ORDER BY ascendente.

SELECT 
	nome AS Produto,
    categoria AS Categoria,
    estoque AS Estoque -- Determinando os dados que eu quero que apareça
FROM produtos -- De onde eu quero que ele recolha os dados
WHERE estoque <= 10 -- Utilizando o WHERE para separar os que tem estoque igual ou menor que 10
AND ativo = 1 -- Determinando que tem que o produto tem que estar ativo
ORDER BY estoque ASC; -- E que eu quero que seja do menor valor para o maior

---------------------

-- Tarefa 2.6 — Alcance das campanhas de cupom
-- Contexto: O marketing quer avaliar quantos pedidos usaram algum cupom de desconto.
-- Tarefa: Liste id, valor_total e cupom_desconto dos pedidos que tiveram cupom aplicado (não nulo).
-- Evidência esperada: Uso correto de IS NOT NULL.

SELECT
	id, valor_total, cupom_desconto -- Determinando os dados que eu quero que apareça
FROM pedidos -- De onde eu quero que ele recolha os dados
WHERE cupom_desconto IS NOT NULL; -- Utilizando WHERE para filtrar somente os que tem cupom ativo (não nulo)

/*TAREFA 3-1 -  Radar de ticket médio
  Calcule, apenas para pedidos aprovados, a quantidade de pedidos, o ticket médio (arredondado em 2 casas), o menor e o maior valor.
 
  Funcionamento - COUNT(id) IDs dos pedidos filtrados
    ROUND(AVG(valor_total), 2) AS ticket_medio, vai somar e dividir por id tirar e tirar a média
MIN(valor_total) AS menor_valor,  MAX(valor_total) AS maior_valor vai retirar o maior e menor valor
    da tabela pedisos com a WHERE status = 'Aprovado'; a condição de ser os status - Aprovados
   */
   SELECT
   COUNT(*) AS total_pedidos_aprovados,
    COUNT(id) AS total_pedidos,
    ROUND(AVG(valor_total), 2) AS ticket_medio,
    MIN(valor_total) AS menor_valor,
    MAX(valor_total) AS maior_valor
FROM pedidos
WHERE status = 'Aprovado';

/*Tarefa 3.2 — Faturamento por forma de pagamento
Tarefa: Calcule o faturamento total (SUM) de pedidos aprovados, agrupado por forma de pagamento,
do maior para o menor

Funcionamento - SELECT forma_pagamento, seleciona a forma_pagamento da tabela pedidos
ROUND(SUM(valor_total), 2) AS faturamento_por_forma pra fazer a soma dos valores, forma_pagamento cartão de Crédito, pix etc..
WHERE status = 'Aprovado' da codição Aprovado todos os valores Aprovados
GROUP BY forma_pagamento, pega os grupos cartão de Crédito, pix etc..
 ORDER BY faturamento_por_forma DESC ; ordema do maior valor pro menor valor
*/

SELECT forma_pagamento,
ROUND(SUM(valor_total), 2) AS faturamento_por_forma
FROM pedidos
WHERE status = 'Aprovado'
GROUP BY forma_pagamento
ORDER BY faturamento_por_forma DESC ;

/*Tarefa 3.3 — Onde estão os clientes da NexaShop
Tarefa: Mostre a quantidade de clientes por estado, ordenando do estado com mais clientes para o
com menos.

Funcionamento - SELECT  estado, seleciona o campo do estado e conta o id de cada cliente
COUNT(id) AS quantidade_cliente_estado
FROM clientes da tebela clientes faz o filtro atráves do GROUP BY estado
ORDER BY quantidade_cliente_estado DESC; e ordeno do maior para o menor
*/
SELECT  estado,
COUNT(id) AS quantidade_cliente_estado
FROM clientes
GROUP BY estado
ORDER BY quantidade_cliente_estado DESC;

/*Tarefa 3.4 — Estados prioritários para expansão
Tarefa: Liste apenas os estados com mais de 200 clientes cadastrados.

Funcionamento -  SELECT  estado, seleciona o campo do estado e conta o id de cada cliente
FROM clientes da tabela clientes
GROUP BY estado fConsolida os registros individuais, unificando os estados repetidos (como SC, SP, RJ)
em linhas exclusivas de resumo para que a contagem seja processada por localidade.
HAVING COUNT(id) > 200 faz o filtro da contagem com maior de 200 clientes
ORDER BY quantidade_cliente_estado DESC; e ordema do maior para o menor.
*/
SELECT
    estado,
    COUNT(id) AS quantidade_cliente_estado
FROM clientes
GROUP BY estado
HAVING COUNT(id) > 200
ORDER BY quantidade_cliente_estado DESC;

/*Tarefa 3.5 — Perfil etário por segmento de cliente
Tarefa: Calcule a idade média dos clientes (usando TIMESTAMPDIFF) agrupada por segmento (Varejo,
Atacado, Corporativo).

Funcionamento a expressão - (TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE())) faz o calculo
de idade de cada cliente pegando a data da idade cadastrada - (TIMESTAMPDIFF(YEAR, data_nascimento)-
 com a data atual - CURDATE() -  e faz o calculo da idade 20, 35 48 etc.. AVG faz a média atraves desse
 resultado eo ROUND, 1 - arredonda.
*/
SELECT
    segmento,
    ROUND(AVG(TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE())), 1) AS idade_media
FROM clientes
GROUP BY segmento;

/*Tarefa 3.6 — Valor de estoque parado por categoria
Tarefa: Para produtos ativos, calcule o valor total em estoque (preço × estoque) por categoria,
ordenado do maior para o menor

Funcionameto começo selecionando a categoria para saber o valor total em estoque de cada categoria ,Informática, Eletrônicos,
ROUND(2) para arrendondar as casas de depois SUM(preco * estoque) para fazer o cáculo
preco estoque, WHERE ativo = 1 é a condição todos os ativos 1 com 0 não ignora
GROUP BY categoria vai agrupar as categorias Informática, Eletrônicos etc..alter
ORDER BY valor_estoque_parado DESC;  vai ordemar do maior para o menor valor.
*/
SELECT
    categoria,
    ROUND(SUM(preco * estoque), 2) AS valor_estoque_parado
FROM produtos
WHERE ativo = '1'
GROUP BY categoria
ORDER BY valor_estoque_parado DESC;

-- Tarefa 4.1 — Classificando avaliações
-- Tarefa: Usando CASE, classifique cada avaliação (coluna nota) em 'Excelente' (5), 'Boa' (4), 'Regular' (3) ou 'Insatisfatória' (1 ou 2).
-- Evidência esperada: CASE com múltiplas condições e alias para a coluna resultante.

SELECT
	nota,
    comentario, -- Determinando os dados que eu quero que apareça
	CASE
		WHEN nota <= 2 THEN 'Insatisfatória'
		WHEN nota <= 3 THEN 'Regular'
		WHEN nota <= 4 THEN 'Boa'
	ELSE 'Excelente' -- Utilizando CASE para separar as notas
	END AS Notas -- Armazenando elas em uma coluna de resultados
FROM avaliacoes; -- De onde eu quero que ele recolha os dados

---------------------

-- Tarefa 4.2 — Quantas avaliações caem em cada faixa
-- Contexto: A qualidade quer um resumo por faixa, não avaliação por avaliação.
-- Tarefa: A partir da classificação da tarefa 4.1, mostre quantas avaliações existem em cada faixa, da maior para a menor quantidade, em uma única consulta.
-- Evidência esperada: Agrupamento pelo alias definido no CASE (GROUP BY na faixa), sem uso de subconsulta.

SELECT
    CASE
        WHEN nota <= 2 THEN 'Insatisfatória'
        WHEN nota <= 3 THEN 'Regular'
        WHEN nota <= 4 THEN 'Boa'
        ELSE 'Excelente'
    END AS Nota, -- Utilizando CASE para separar as notas em 4 categorias
    COUNT(*) AS Quantidade -- Contando quanto tem em cada categoria
FROM avaliacoes -- De onde eu quero que ele recolha os dados
GROUP BY Nota -- Organizando em um grupo chamado Nota
ORDER BY Quantidade DESC; -- Ordenando da maior quantidade para a menor

---------------------

-- Tarefa 4.3 — Taxa de aprovação de pedidos
-- Contexto: A diretoria pediu, literalmente, "a taxa de aprovação dos pedidos, em percentual" — uma métrica de conversão comum em qualquer negócio digital.
-- Tarefa: Calcule, em uma única consulta, o percentual de pedidos com status = 'Aprovado' em relação ao total de pedidos.
-- Evidência esperada: Uso da técnica AVG(CASE WHEN ... THEN 1 ELSE 0 END) * 100 — uma forma real de calcular taxas sem subconsulta, muito usada em relatórios de mercado.

SELECT 
    AVG(CASE WHEN status = 'Aprovado' THEN 1 ELSE 0 END) * 100 AS Taxa_Aprovacao
FROM pedidos; -- Ordenando da maior quantidade para a menor

---------------------

-- Atividade 4.4
SELECT
    CASE
        WHEN TIMESTAMPDIFF(YEAR, data_cadastro, NOW()) >= 3 THEN 'Veterano'
        WHEN TIMESTAMPDIFF(YEAR, data_cadastro, NOW()) >= 1 THEN 'Fiel'
        ELSE 'Novo'
    END AS perfil_cliente, -- Utiliza o CASE para separar os clientes em 3 categorias
    COUNT(*) AS quantidade_clientes -- Realiza a contagem de quanto tem em cada categoria
FROM clientes -- Ordenando da maior quantidade para a menor
GROUP BY perfil_cliente -- Organiza e armazena todas em um grupo só chamando perfil_cliente
ORDER BY quantidade_clientes DESC; -- Organiza da maior quantidade para a menor

/*Tarefa 5.1 — Ranking de canal de venda e forma de pagamento
Tarefa: Entre os pedidos aprovados, mostre canal_venda, forma_pagamento, quantidade de pedidos e faturamento,
considerando apenas combinações com pelo menos 200 pedidos. Ordene pelo
faturamento e mostre somente as 5 primeiras combinações.
- Filtragem Inicial (WHERE): O banco de dados analisa a tabela bruta e seleciona apenas os
registros com status igual a 'Aprovado', descartando todas as outras vendas.
- Agrupamento Duplo (GROUP BY): Os dados filtrados são organizados em grupos únicos
combinando duas colunas ao mesmo tempo: canal_venda e forma_pagamento.
- Cálculo de Métricas (SELECT): Para cada grupo gerado, o sistema calcula a
quantidade de pedidos (COUNT) e soma o valor total arrecadado (SUM).
- Restrição do Grupo (HAVING): Ocorre um segundo filtro, eliminando da tela qualquer
combinação de canal e pagamento que tenha acumulado menos de 200 pedidos.
- Ordenação e Exibição (ORDER BY + LIMIT): O resultado final é ordenado do maior
para o menor faturamento, exibindo estritamente as 5 combinações mais lucrativas.
*/
  SELECT
  canal_venda,
  forma_pagamento,
  COUNT(*) AS pedidos_aprovados,
  SUM(valor_total) AS faturamento
  FROM pedidos
  WHERE status = 'Aprovado'
   GROUP BY canal_venda, forma_pagamento
  HAVING COUNT(*) >= 200
  ORDER BY faturamento DESC
  LIMIT 5;

  /*Tarefa 5.2 — Categorias "premium" do catálogo
  Tarefa: Entre os produtos ativos, mostre categoria, quantidade de produtos e preço médio, apenas para
  categorias cujo preço médio seja  superior a R$ 300, ordenado do maior para o menor preço médio.
 
  Funcionamento - COUNT(*): Conta a quantidade de linhas (produtos) que pertencem a cada categoria através do agrupamento do GROUP BY.
 - ROUND(AVG(preco), 2): Calcula a média aritmética dos preços dos produtos de cada grupo e arredonda o resultado para 2 casas decimais.
 - WHERE ativo = 1: Aplica a condição inicial de filtrar e selecionar apenas os produtos que estão com o status ativo igual a 1.
 - HAVING AVG(preco) > 300: Filtra as categorias após o agrupamento, exibindo apenas aquelas que possuem a média de preço maior que 300 reais.
 - ORDER BY preco_medio DESC: Ordena a lista final mostrando os resultados do maior preço médio para o menor.
  */

  SELECT
  categoria,
 COUNT(*) AS quantidade_produtos,
  ROUND(AVG(preco),2) AS preco_medio
  FROM produtos
  WHERE ativo = 1
  GROUP BY categoria
  HAVING AVG(preco) > 300
  ORDER BY preco_medio DESC;
  
/*
Tarefa 5.3 — Investigação: o boleto cancela mais que os outros meios de pagamento?
Contexto: Em uma reunião, um gestor da NexaShop afirmou que "pedidos pagos por boleto parecem
cancelar mais". Isso é uma hipótese, não um fato — é trabalho da dupla confirmar ou refutar com
dados, sem aceitar a afirmação apenas porque veio de um gestor.
Tarefa: Construa uma consulta que calcule a taxa de cancelamento (percentual de pedidos com status
= 'Cancelado') para cada forma de pagamento, usando a mesma técnica da tarefa 4.3.
Evidência esperada: Consulta correta (GROUP BY forma_pagamento + AVG(CASE...)) e, no relatório,
um parágrafo estruturado no formato sintoma → evidência → hipótese → validação → conclusão,
indicando se a hipótese do gestor se confirma ou não.
*/

SELECT
  forma_pagamento,
ROUND(AVG(CASE WHEN status = 'Cancelado' THEN 1 ELSE 0 END) * 100, 2) AS taxa_cancelado
  FROM pedidos
  GROUP BY forma_pagamento
  ORDER BY taxa_cancelado DESC;
  /*A consulta nos  evidência que é clara a hipótese que a forma_pagamento com boleto
  teve a  maior taxa_cancelamento de todas as outras formas de pagamento.*/