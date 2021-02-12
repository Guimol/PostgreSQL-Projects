CREATE OR REPLACE FUNCTION vendas_diarias (dia DATE)
RETURNS NUMERIC
AS
$$
	DECLARE
		v_cod_voo Voo%ROWTYPE;
		qtde NUMERIC;
		somatorio NUMERIC;
	
	BEGIN
	
		qtde := 0;
		somatorio := 0;
		
		FOR v_cod_voo IN SELECT * FROM Voo WHERE data_i = dia LOOP
			qtde := qtde + 1;
			somatorio := v_cod_voo.preco_passag + somatorio;
		END LOOP;
		
		RAISE NOTICE 'Quantidade de Passagens: %  Lucro Liquido: %', qtde, somatorio;  
		
		RETURN somatorio;
	END;
$$
LANGUAGE 'plpgsql';