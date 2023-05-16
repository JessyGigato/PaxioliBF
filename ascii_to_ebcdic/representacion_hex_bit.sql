-- FUNCTION: public.representacion_hex_bit(text)

-- DROP FUNCTION IF EXISTS public.representacion_hex_bit(text);

CREATE OR REPLACE FUNCTION public.representacion_hex_bit(
	vbit text)
    RETURNS text
    LANGUAGE 'plpgsql'
    COST 1000
    VOLATILE PARALLEL UNSAFE
AS $BODY$
-- hecho por Jessy 23-04-25
declare
	vresult text;
	vsub text;
	vpos integer;
	vlen integer;
	vconv text;
BEGIN
	vresult := '';
	vpos := 1;
	vlen := LENGTH(vbit);
	--raise notice 'vbit %',vbit;
	WHILE vpos < vlen
	LOOP
		vsub := substring(vbit,vpos,4);
		--raise notice 'vsub %', vsub;
		--SELECT b.hex INTO vconv FROM bit4_hex as b WHERE b.bit4 = vsub ;
		
		IF vsub = '0000' THEN vconv =  '0';
		ELSEIF vsub = '0001' THEN vconv =  '1';
		ELSEIF vsub = '0010' THEN vconv =  '2';
		ELSEIF vsub = '0011' THEN vconv =  '3';
		ELSEIF vsub = '0100' THEN vconv =  '4';
		ELSEIF vsub = '0101' THEN vconv =  '5';
		ELSEIF vsub = '0110' THEN vconv =  '6';
		ELSEIF vsub = '0111' THEN vconv =  '7';
		ELSEIF vsub = '1000' THEN vconv =  '8';
		ELSEIF vsub = '1001' THEN vconv =  '9';
		ELSEIF vsub = '1010' THEN vconv =  'A';
		ELSEIF vsub = '1011' THEN vconv =  'B';
		ELSEIF vsub = '1100' THEN vconv =  'C';
		ELSEIF vsub = '1101' THEN vconv =  'D';
		ELSEIF vsub = '1110' THEN vconv =  'E';
		ELSEIF vsub = '1111' THEN vconv =  'F';
		END IF;
		
		--raise notice 'vconv %', vconv;
		vresult = vresult || vconv;
		vpos := vpos + 4;
	END LOOP;
	--raise notice 'vresult %', vresult;
	RETURN vresult;
END;
$BODY$;

ALTER FUNCTION public.representacion_hex_bit(text)
    OWNER TO postgres;
