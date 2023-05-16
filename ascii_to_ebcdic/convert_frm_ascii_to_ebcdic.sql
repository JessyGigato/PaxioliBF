-- FUNCTION: public.convert_from_ascii_to_ebcdic(text)

-- DROP FUNCTION IF EXISTS public.convert_from_ascii_to_ebcdic(text);

CREATE OR REPLACE FUNCTION public.convert_from_ascii_to_ebcdic(
	vascii text)
    RETURNS text
    LANGUAGE 'plpgsql'
    COST 1000
    VOLATILE PARALLEL UNSAFE
AS $BODY$
-- hecho por Jessy 23-04-25
declare
	vresult text;
	vlength integer;
	vpos integer;
	vtemp text;
	vconv text;
BEGIN
	vresult := '';
	vpos := 1;
	vlength := LENGTH(vascii);
	WHILE vpos < vlength
	LOOP
		vtemp := substring(vascii,vpos,2);
		--raise notice 'substring %',vtemp;
		SELECT ebcdic INTO vconv FROM ascii_to_ebcdic AS c WHERE c.ascii = vtemp;
		--raise notice 'conversion substring %', vconv;
		--raise notice 'inicio clock_timestamp ( ) %',clock_timestamp ( ) ;
		vresult := vresult || vconv;
		--raise notice 'FIN clock_timestamp ( ) %',clock_timestamp ( ) ;
		
	 	--raise notice 'vresult actual %',vresult;
		vpos := vpos + 2;
	END LOOP;
	--raise notice 'vresult en converter %',vresult;
	RETURN vresult;
END;
$BODY$;

ALTER FUNCTION public.convert_from_ascii_to_ebcdic(text)
    OWNER TO postgres;
