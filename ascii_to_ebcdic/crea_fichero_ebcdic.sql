-- FUNCTION: public.crea_fichero_ebcdic()

-- DROP FUNCTION IF EXISTS public.crea_fichero_ebcdic();

CREATE OR REPLACE FUNCTION public.crea_fichero_ebcdic(
	)
    RETURNS text
    LANGUAGE 'plpgsql'
    COST 1000
    VOLATILE PARALLEL UNSAFE
AS $BODY$
-- hecho por Jessy 23-04-25
DECLARE
	art_p record;
	art_o record;
	vresult text;
	vbit bit(128);
	vcadena_bit text;
	vtemp text;
	var integer;
	vposicion bit;
	vcrlf text;
	vinicio integer;
	vlargo integer;
	vcuerpo text;
	vtrans integer;
BEGIN
	BEGIN
		DROP TABLE t_ebcdic;
		EXCEPTION 
		WHEN undefined_table THEN
	END;
	
	CREATE TABLE t_ebcdic(ebcdic text,id serial);

	-- inicailizando las variables
    vinicio := 1;
	vlargo := 0;
	vcrlf := convert_from('\x0D0A'::bytea,'UTF8');
	vtrans := 0;
	
	FOR art_p in SELECT * FROM prueba as p ORDER BY p.secuencia
	LOOP
		vtrans := vtrans +1;
		vresult :=art_p.ident;
		vbit := art_p.cadena; 
		vcuerpo := art_p.cuerpo;
		--raise notice 'cuerpo prueba %',vcuerpo;
		--vcadena_bit = convert_from((vbit::text)::bytea,'UTF8');
		--raise notice 'Inicio conversion hex clock_timestamp ( ) %',clock_timestamp ( ) ;
		vcadena_bit = representacion_hex_bit(vbit::text);
		--raise notice 'FIN conversion hex clock_timestamp ( ) %',clock_timestamp ( ) ;
		--raise notice 'bit % cadena bit hex %',vbit,vcadena_bit;
		vresult := encode(vresult::bytea,'hex');
		vresult := convert_from_ascii_to_ebcdic(vresult) || vcadena_bit;
		--raise notice 'vresult = ident+128bits %', vresult;
		var:= 1;

		WHILE var < 128 
		LOOP
			vposicion := get_bit(vbit, var);

			IF vposicion = B'1' THEN
				SELECT * INTO art_o FROM o_data_elements_mc WHERE id = var + 1;
				IF substring(art_o.cantidad, 1, 3) = 'LLL' THEN
					vlargo := cast(convert_from(('\x' || substring(vcuerpo, vinicio, 3*2))::bytea,'latin1') as integer);
					vtemp := substring(vcuerpo, vinicio, 3*2);
					vinicio := vinicio + 6;
				ElSIF substring(art_o.cantidad, 1, 2) = 'LL' THEN
					vlargo := cast(convert_from(('\x' || substring(vcuerpo, vinicio, 2*2))::bytea,'latin1')as integer);
					vtemp := substring(vcuerpo, vinicio, 2*2);
					vinicio := vinicio + 4;
				ELSE 
					vlargo := cast(art_o.cantidad as integer);
					vtemp := '';
				END IF;
				
				vresult := vresult || convert_from_ascii_to_ebcdic(vtemp);
				vlargo:= vlargo * 2;
				vtemp := substring(vcuerpo, vinicio, vlargo);
				--raise notice 'vtemp largo cuerpo % inicio %, largo %',vtemp,vinicio,vlargo;

				IF substring(art_o.tipo,1,1) = 'b' THEN
					vtemp := vtemp;
					raise notice 'vtemp campo 55 %',vtemp;
				ELSE 
					vtemp := convert_from_ascii_to_ebcdic(vtemp);
					--raise notice 'vtemp campo %  %',art_o.id,vtemp;
				END IF;

				vresult := vresult || vtemp;
				--raise notice 'tamano agregado %',vresult; 
				vinicio := vinicio + vlargo;
			END IF;
			var := var + 1;
		END LOOP;	
		--vresult := vresult || vcrlf;
		--raise notice 'vresult final %',vresult;
		
		--vresult := convert_from_ascii_to_ebcdic(vresult);-- || vcrlf;
		raise notice 'vresult final convertido a ebcdic %',vresult;
		--raise notice 'inicio clock_timestamp ( ) %  vtrans %',clock_timestamp ( ),vtrans ;
		
		INSERT INTO t_ebcdic(ebcdic) VALUES(vresult);
		--raise notice 'FIN clock_timestamp ( ) %',clock_timestamp ( ) ;
		
		-- actualizacion de variables
    	vinicio := 1;
		vlargo := 0;
		--IF vtrans = 1000 THEN
		--	RETURN '111';
		--END IF;
	END LOOP;	
		
	RETURN vresult;
END;
$BODY$;

ALTER FUNCTION public.crea_fichero_ebcdic()
    OWNER TO postgres;
