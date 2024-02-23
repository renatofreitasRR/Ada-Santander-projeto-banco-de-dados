

--IMPORTAÇÕES CSV
DROP TABLE IF EXISTS tb_produtos;
CREATE TABLE tb_produtos (
	codigo VARCHAR(100),
	produto VARCHAR(100),
	preco NUMERIC
);

COPY tb_produtos(
	codigo, produto, preco)
FROM
    -- caminho absoluto do arquivo .csv
	'C:\csv\produtos_formatados.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM tb_produtos tt;

DROP TABLE IF EXISTS tb_vendas;
CREATE TABLE tb_vendas (
	orderid VARCHAR(100),
	date DATE,
	ship_service_level VARCHAR(100),
	style VARCHAR(100),
	codigo VARCHAR(100),
	courier_status VARCHAR(100), 
	qty integer, 
	ship_country VARCHAR(100), 
	fulfillment VARCHAR(100)
	
);

COPY tb_vendas(
	orderid, date, ship_service_level, style, codigo, courier_status, qty, ship_country, fulfillment)
FROM
    -- caminho absoluto do arquivo .csv
	'C:\csv\vendas_formatadas.csv'
DELIMITER ','
CSV header;


SELECT * FROM tb_vendas tv;