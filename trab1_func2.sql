CREATE OR REPLACE FUNCTION mudar_preco_pass (p_cod_voo Voo.cod_voo%TYPE, preco_novo NUMERIC)
RETURNS boolean
AS
$$
	DECLARE
		porcentagem FLOAT;
		preco_antigo Voo.preco_passag%TYPE;
	
	BEGIN
		SELECT INTO preco_antigo preco_passag FROM Voo WHERE cod_voo = p_cod_voo;
		porcentagem := ((preco_novo / preco_antigo) - 1) * 100;
		IF preco_antigo IS null THEN
			RETURN 'f';
		ELSE 
			IF porcentagem = 0 THEN 
				RAISE NOTICE 'Preço não alterado!';
			ELSE
			
				UPDATE Voo SET preco_passag = preco_novo WHERE cod_voo = p_cod_voo;
			
				IF porcentagem > 0 THEN
					RAISE NOTICE 'Preço Antigo: %  Preço Novo: %  Aumento de % %%', preco_antigo, preco_novo, porcentagem;
				ELSE
					RAISE NOTICE 'Preço Antigo: %  Preço Novo: %  Desconto de % %%', preco_antigo, preco_novo, ABS(porcentagem);
				END IF;
				
			END IF;
			
			RETURN 't';
		
		END IF;
	END
$$
LANGUAGE 'plpgsql';