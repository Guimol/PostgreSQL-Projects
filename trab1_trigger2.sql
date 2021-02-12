CREATE OR REPLACE FUNCTION duracao_voo() 
RETURNS TRIGGER
AS
$$
BEGIN
	
	UPDATE Voo SET duracao_voo = NEW.horario_f - NEW.horario_i WHERE cod_voo = NEW.cod_voo;
	
	RETURN OLD;
END;
$$
LANGUAGE 'plpgsql';

CREATE TRIGGER tg_duracao_voo
AFTER INSERT ON Voo FOR EACH ROW
EXECUTE FUNCTION duracao_voo();