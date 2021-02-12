CREATE OR REPLACE FUNCTION list_trip (p_cod voo.cod_voo%TYPE)
RETURNS boolean 
AS
$$
	DECLARE
		cs_tripu CURSOR FOR SELECT tripulação_funcionário_id_func FROM Tripulação_voo WHERE voo_cod_voo = p_cod;
		v_func Funcionário%ROWTYPE;
		v_tripu Tripulação_voo.tripulação_funcionário_id_func%TYPE;
		
	BEGIN
		OPEN cs_tripu;
		
		FETCH cs_tripu INTO v_tripu;
		
		IF v_tripu IS null THEN
			
			RETURN 'f';
		
		ELSE 
			
			WHILE FOUND LOOP
				SELECT INTO v_func * FROM Funcionário WHERE v_tripu = id_func;
				RAISE NOTICE 'ID FUNC: %  Nome: % %  Tipo: %', v_func.id_func, v_func.prim_nome, v_func.sobrenome, v_func.tipo;
				FETCH cs_tripu INTO v_tripu;
			END LOOP;
			
			RETURN 't';
			
		END IF;
		
		CLOSE cs_tripu;
	END
$$
LANGUAGE 'plpgsql';