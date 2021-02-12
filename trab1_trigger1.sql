CREATE OR REPLACE FUNCTION demitir()
RETURNS TRIGGER
AS
$$
	BEGIN
		DELETE FROM experiência_línguas WHERE funcionário_id_func = OLD.id_func;
		DELETE FROM presencial WHERE funcionário_id_func = OLD.id_func;
		DELETE FROM tripulação WHERE funcionário_id_func = OLD.id_func;
		DELETE FROM especialidade_voo WHERE tripulação_funcionário_id_func = OLD.id_func;
		
		RETURN OLD;
		
	END;
$$
LANGUAGE 'plpgsql';

CREATE TRIGGER excluir_func
BEFORE DELETE ON Funcionário FOR EACH ROW
EXECUTE FUNCTION demitir();



- todos
	* deletar ele experiencia em línguas

- presencial
	* deletar ele na tabela de presencial
	
- tripulante
    * deletar ele na tabela tripulação
	* deletar ele especialidade voo
	