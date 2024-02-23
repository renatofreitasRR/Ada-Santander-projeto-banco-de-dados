--Perguntas

--Produtos----------------------------------

-- 1) Qual o produto de maior valor
create view produto_maior_valor as
	select * from tb_produtos order by preco desc limit 1;


-- 2) Qual o produto de menor valor
create view produto_menor_valor as
	select * from tb_produtos order by preco limit 1;


-- 3) Qual a média de preço dos produtos
create view media_preco_produto as
	select AVG(preco) from tb_produtos;


-- 4) Qual a mediana de preço dos produto
create view mediana_preco_produto as
	select percentile_cont(0.5) within group(order by preco) from tb_produtos;


--Produtos----------------------------------

--Vendas----------------------------------

-- 5) Qual a quantidade de vendas por status
create view qt_vendas_status as
	select 
		courier_status, count(*) as total 
	from tb_vendas 
	group by courier_status 
	order by total;


-- 6) Qual o produto com maior faturamento
create view produto_maior_faturamento as
	select 
		tp.codigo, tp.produto, tp.preco*
		sum(tv.qty) as total_vendas
	from tb_produtos tp
	join tb_vendas tv on tp.codigo = tv.codigo
	group by tp.codigo, tp.produto, tp.preco
	order by total_vendas desc
	limit 1;

-- 7) Faturamento por produto
create view faturamento_produto as
	select 
		tp.codigo, tp.produto, tp.preco*
		sum(tv.qty) as total_vendas
	from tb_produtos tp
	join tb_vendas tv on tp.codigo = tv.codigo
	group by tp.codigo, tp.produto, tp.preco
	order by total_vendas desc;

	
-- 8) Qual o produto menos vendido
create view produto_menos_vendido as
	select 
		tp.codigo, tp.produto, sum(tv.qty) as total_vendas
	from tb_produtos tp
	join tb_vendas tv on tp.codigo = tv.codigo
	group by tp.codigo, tp.produto
	order by total_vendas
	limit 1;

	
-- 9) Faturamento por pais e produto
create view faturamento_produto_pais as
	select 
		tv.ship_country, 
		tv.codigo, 
		sum(tv.qty) as qtd_venda_produto, 
		tp.preco, 
		sum(tv.qty) * tp.preco as faturamento
	from tb_vendas tv
	inner join tb_produtos tp
	on tv.codigo = tp.codigo
	group by tv.ship_country, tv.codigo, tp.preco
	order by tv.ship_country, qtd_venda_produto;
	
-- 10) Faturamento total por pais
create view faturamento_total_pais as 
	select ship_country, sum(faturamento_produto) as faturamento_total from 
	(
		select 
			tv.ship_country, 
			tv.codigo, 
			sum(tv.qty) as qtd_venda_produto, 
			tp.preco, 
			sum(tv.qty) * tp.preco as faturamento_produto
		from tb_vendas tv
		inner join tb_produtos tp
		on tv.codigo = tp.codigo
		group by tv.ship_country, tv.codigo, tp.preco
		order by tv.ship_country, qtd_venda_produto
	) as faturamento_pais_produto
	group by ship_country;
	
-- 11) Qual a data com maior número de vendas
create view data_maior_numero_vendas as 
	select 
		date, sum(qty) as total 
	from tb_vendas
	group by date 
	order by total desc
	limit 1;

-- 12) Número de vendas por data
create view numero_vendas_data as 
	select 
		date, sum(qty) as total 
	from tb_vendas
	group by date 
	order by total desc
	
-- 13) Qual a quantidade de pedidos por produto e por pais
create view quantidade_pedidos_produto_pais as
	select 
		tv.ship_country, 
		tv.codigo, 
		sum(tv.qty) as qtd_venda_produto, 
		sum(tv.qty) * tp.preco as faturamento
	from tb_vendas tv
	inner join tb_produtos tp
	on tv.codigo = tp.codigo
	group by tv.ship_country, tv.codigo, tp.preco
	order by tv.ship_country, qtd_venda_produto;


-- 14) Quais são os tipos de nível de serviço e qual a quantidade de vendas para cada um
create view niveis_servico_quantidade as
	select
		courier_status, sum(qty) as qtd_venda_produto
	from tb_vendas
	group by courier_status
	order by qtd_venda_produto desc;


-- 15) Quais são os tipos de estilo e qual a quantidade de vendas para cada um
create view estilos_quantidade as
	select
		style, sum(qty) as qtd_venda_produto
	from tb_vendas
	group by style
	order by qtd_venda_produto desc;


-- 16) Qual é o serviço de envio mais utilizado
create view servico_mais_utilizado as
	select 
		ship_service_level, count(*) as total
	from tb_vendas
	group by ship_service_level
	order by total desc;

-- 17) Qual o produto mais comprado em cada país
create view produto_mais_comprado as
	select 
		ship_country, produto
	from 
	(
		select 
			tv.ship_country, 
			tv.codigo, 
			tp.produto, 
			count(*) as total,
			ROW_NUMBER() OVER (PARTITION by ship_country ORDER BY tv.ship_country, count(*) desc) as row_number
		from tb_vendas tv
		join tb_produtos tp
		on tv.codigo = tp.codigo
		group by tv.ship_country, tv.codigo, tp.produto
		order by tv.ship_country, total desc
	) as vendas
	where row_number = 1;


-- 18) Qual o produto com maior faturamento por país
create view produto_maior_faturamento_pais as
	select 
		ship_country, produto, total_faturamento
	from 
	(
		select 
			tv.ship_country, 
			tv.codigo, 
			tp.produto, 
			count(*) as total,
			sum(qty) * max(tp.preco) as total_faturamento,
			ROW_NUMBER() 
			OVER 
			(PARTITION by ship_country ORDER BY tv.ship_country, sum(qty) * max(tp.preco) desc) as row_number
		from tb_vendas tv
		join tb_produtos tp
		on tv.codigo = tp.codigo
		group by tv.ship_country, tv.codigo, tp.produto
		order by tv.ship_country, total_faturamento desc
	) as vendas
	where row_number = 1
--Vendas----------------------------------
