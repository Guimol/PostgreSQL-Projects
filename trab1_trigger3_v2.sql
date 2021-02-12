CREATE OR REPLACE FUNCTION pagamento_tripu()
RETURNS TRIGGER 
AS
$$	
	DECLARE 
		cs_tripu CURSOR FOR SELECT * FROM Tripulação_voo WHERE voo_cod_voo = NEW.voo_cod_voo;
		reg RECORD;
		pagam NUMERIC;
		info_func Funcionário%ROWTYPE;
		
	BEGIN
		OPEN cs_tripu;
		FETCH cs_tripu INTO reg;
		
		WHILE FOUND LOOP
		
			SELECT INTO info_func * FROM Funcionário WHERE id_func = reg.tripulação_funcionário_id_func;
		
			IF info_func.tipo LIKE 'Pilot%' THEN
				
				SELECT INTO pagam 50 * EXTRACT(epoch from duracao_voo)/3600 FROM Voo WHERE cod_voo = reg.voo_cod_voo;
				
			ELSE
				IF info_func.tipo LIKE 'Copilot%' THEN
				
				SELECT INTO pagam 42 * EXTRACT(epoch from duracao_voo)/3600 FROM Voo WHERE cod_voo = reg.voo_cod_voo;
				
				ELSE
					IF info_func.tipo LIKE 'Aeromoç%' THEN
				
					SELECT INTO pagam 35 * EXTRACT(epoch from duracao_voo)/3600 FROM Voo WHERE cod_voo = reg.voo_cod_voo;
					
					END IF;
				END IF;
			END IF;
			
			RAISE NOTICE 'Pagamento de % %  Profissão: %  em R$%', info_func.prim_nome, info_func.sobrenome, info_func.tipo, pagam;
			
			FETCH cs_tripu INTO reg;
		END LOOP;
		
		CLOSE cs_tripu;		
		RETURN OLD;
	END;
$$
LANGUAGE 'plpgsql';

CREATE TRIGGER tg_pagamento_tripu
AFTER INSERT ON Tripulação_voo FOR EACH ROW
EXECUTE FUNCTION pagamento_tripu();