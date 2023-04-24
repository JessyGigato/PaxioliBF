-- select crea_tabla_8583_v2()
-- select * from t_8583;

CREATE OR REPLACE FUNCTION public.crea_tabla_8583_v2(
	)
    RETURNS text
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
-- Actualizado por Jessy 23-04-09
DECLARE
	art_t record;
	art_o record;
	vtexto text;
	var integer;
	vinicio integer;
	vlargo integer;
	vposicion bit;
	vcadena text;
	vsecuencia integer;
    vbit text;
    vtemp text;
	var1 integer;
	varticulos integer;
	vvariable text;
	vnulob bytea;
	
	vmti text;
	vBit_Map_Secondary text;
	vPrimary_Account_Number_PAN	text;
	vProcessing_Code	text;
	vAmount_Transaction	text;
	vAmount_Reconciliation	text;
	vAmount_Cardholder_Billing	text;
	vConversion_Rate_Reconciliation	text;
	vConversion_Rate_Cardholder_Billing		text;
	vDate_and_Time_Local_Transaction	text;
	vDate_Expiration	text;
	vPoint_of_Service_Data_Code	text;
	vCard_Sequence_Number	text;
	vFunction_Code		text;
	vMessage_Reason_Code		text;
	vCard_Acceptor_Business_Code_MCC	text;
	vAmounts_Original	text;
	vAcquirer_Reference_Data	text;
	vAcquiring_Institution_ID_Code	text;
	vForwarding_Institution_ID_Code		text;
	vRetrieval_Reference_Number	text;
	vApproval_Code	text;
	vService_Code	text;
	vCard_Acceptor_Terminal_ID		text;
	vCard_Acceptor_ID_Code		text;
	vCard_Acceptor_Name_Location	text;
	vAdditional_Data	text;
	vCurrency_Code_Transaction	text;
	vCurrency_Code_Reconciliation	text;
	vCurrency_Code_Cardholder_Billing	text;
	vAmounts_Additional	text;
	vIntegrated_Circuit_Card_ICC_System_Related_Data bytea;
	vAdditional_Data_2	text;
	vTransaction_Life_Cycle_ID	text;
	vMessage_Number	text;
	vData_Record	text;
	vDate_Action	text;
	vTransaction_Destination_Institution_ID_Code	text;
	vTransaction_Originator_Institution_ID_Code	text;
	vCard_Issuer_Reference_Data	text;
	vReceiving_Institution_ID_Code	text;
	vAmount_Currency_Conversion_Assessment	text;
	vAdditional_Data_3		text;
	vAdditional_Data_4		text;
	vAdditional_Data_5		text;
BEGIN
	BEGIN
		DROP TABLE t_8583;
		EXCEPTION 
		WHEN undefined_table THEN
	END;
    vcadena := 'MTI varchar(4),';
    FOR art_t IN SELECT * FROM o_data_elements_mc order by id
	LOOP
		IF substring(art_t.tipo,1,1) = 'b' AND art_t.id > 1  THEN
			vcadena := vcadena || art_t.nombre || ' bytea ,';
		ELSE
			vcadena := vcadena || art_t.nombre || ' text ,';
		END IF;
		--raise notice 'art_t.nombre % art_t.id %',art_t.nombre,art_t.id;
	END LOOP; 
	vcadena := substring(vcadena,1,length(vcadena) - 1);
	EXECUTE 'CREATE TABLE t_8583(' || vcadena || ')';
	--DELETE FROM t_8583;
	--return 'aqui0';
	var1 := 1;
    FOR art_t IN SELECT * FROM prueba order by secuencia
	LOOP
   		vinicio := 1;
		vlargo := 0;
		vmti := art_t.ident;
		vBit_Map_Secondary = NULL;
		vPrimary_Account_Number_PAN	= NULL;
		vProcessing_Code	 = NULL;
		vAmount_Transaction	 = NULL;
		vAmount_Reconciliation	 = NULL;
		vAmount_Cardholder_Billing	 = NULL;
		vConversion_Rate_Reconciliation	 = NULL;
		vConversion_Rate_Cardholder_Billing		 = NULL;
		vDate_and_Time_Local_Transaction	 = NULL;
		vDate_Expiration	 = NULL;
		vPoint_of_Service_Data_Code	 = NULL;
		vCard_Sequence_Number	 = NULL;
		vFunction_Code		 = NULL;
		vMessage_Reason_Code		 = NULL;
		vCard_Acceptor_Business_Code_MCC	 = NULL;
		vAmounts_Original	 = NULL;
		vAcquirer_Reference_Data	 = NULL;
		vAcquiring_Institution_ID_Code	 = NULL;
		vForwarding_Institution_ID_Code		 = NULL;
		vRetrieval_Reference_Number	 = NULL;
		vApproval_Code	 = NULL;
		vService_Code	 = NULL;
		vCard_Acceptor_Terminal_ID		 = NULL;
		vCard_Acceptor_ID_Code		 = NULL;
		vCard_Acceptor_Name_Location	 = NULL;
		vAdditional_Data	 = NULL;
		vCurrency_Code_Transaction	 = NULL;
		vCurrency_Code_Reconciliation	 = NULL;
		vCurrency_Code_Cardholder_Billing	 = NULL;
		vAmounts_Additional	 = NULL;
		--vnulob := cast('00' as bytea);
		--raise notice 'vnulob %',vnulob;
		vIntegrated_Circuit_Card_ICC_System_Related_Data = NULL::bytea;
		--raise notice 'vIntegrated_Circuit_Card_ICC_System_Related_Data %',vIntegrated_Circuit_Card_ICC_System_Related_Data;
		--return 'aquip';
		vAdditional_Data_2	 = NULL;
		vTransaction_Life_Cycle_ID	 = NULL;
		vMessage_Number	 = NULL;
		vData_Record	 = NULL;
		vDate_Action	 = NULL;
		vTransaction_Destination_Institution_ID_Code	 = NULL;
		vTransaction_Originator_Institution_ID_Code	 = NULL;
		vCard_Issuer_Reference_Data	 = NULL;
		vReceiving_Institution_ID_Code	 = NULL;
		vAmount_Currency_Conversion_Assessment	 = NULL;
		vAdditional_Data_3		 = NULL;
		vAdditional_Data_4		 = NULL;
		vAdditional_Data_5		 = NULL;
		raise notice 'inicio clock_timestamp ( ) %',clock_timestamp ( ) ;
		var := 1;
		--return 'aqui';
		while var < 128
		LOOP
			--raise NOTICE 'var %',var;
			--return 'aqui2';
			vposicion := get_bit(art_t.cadena, var);
			--raise NOTICE 'vposicion % var %',vposicion,var;
			--return 'aqui3';
			IF vposicion = B'1' THEN
				select * into art_o FROM o_data_elements_mc WHERE id = var + 1;
				vvariable = 'v'||art_o.nombre;
				--raise notice 'art_o.nombre % var + 1 %',art_o.nombre,var + 1;
				--return 'aqui4';
				IF substring(art_o.cantidad, 1, 3) = 'LLL' THEN
					vlargo := cast(convert_from(('\x' || substring(art_t.cuerpo, vinicio, 3*2))::bytea,'latin1') as integer);
					vinicio := vinicio + 6;
				ElSIF substring(art_o.cantidad, 1, 2) = 'LL' THEN
					vlargo := cast(convert_from(('\x' || substring(art_t.cuerpo, vinicio, 2*2))::bytea,'latin1')as integer);
					vinicio := vinicio + 4;
				ELSE 
					vlargo := cast(art_o.cantidad as integer);
				END IF;
				vlargo:= vlargo * 2;
                vtemp := substring(art_t.cuerpo, vinicio, vlargo);
				--raise notice 'vinicio % vlargo % vtemp %',vinicio,vlargo,vtemp;
                IF substring(art_o.tipo,1,1) = 'b' THEN
                    vbit :=  ('\x'||vtemp)::bytea;
                ELSE 
                    vbit := convert_from(('\x'||vtemp)::bytea,'latin1');
					vbit := vbit;
				END IF;
				--var := var + 1;
				--raise notice 'vbit % var + 1 %',vbit,var + 1;
				IF var + 1 = 2	THEN VPrimary_Account_Number_PAN := vbit;
				ELSIF var + 1 = 3	THEN vProcessing_Code := vbit;
				ELSIF var + 1 = 4	THEN vAmount_Transaction := vbit;
				ELSIF var + 1 = 5	THEN vAmount_Reconciliation := vbit;
				ELSIF var + 1 = 6	THEN vAmount_Cardholder_Billing := vbit;
				ELSIF var + 1 = 9	THEN vConversion_Rate_Reconciliation := vbit;
				ELSIF var + 1 = 10	THEN vConversion_Rate_Cardholder_Billing := vbit;
				ELSIF var + 1 = 12	THEN vDate_and_Time_Local_Transaction := vbit;
				ELSIF var + 1 = 14	THEN vDate_Expiration := vbit;
				ELSIF var + 1 = 22	THEN vPoint_of_Service_Data_Code := vbit;
				ELSIF var + 1 = 23	THEN vCard_Sequence_Number := vbit;
				ELSIF var + 1 = 24	THEN 	vFunction_Code := vbit;
				ELSIF var + 1 = 25	THEN 	vMessage_Reason_Code := vbit;
				ELSIF var + 1 = 26	THEN 	vCard_Acceptor_Business_Code_MCC := vbit;
				ELSIF var + 1 = 30	THEN 	vAmounts_Original := vbit;
				ELSIF var + 1 = 31	THEN 	vAcquirer_Reference_Data := vbit;
				ELSIF var + 1 = 32	THEN 	vAcquiring_Institution_ID_Code := vbit;
				ELSIF var + 1 = 33	THEN 	vForwarding_Institution_ID_Code := vbit;
				ELSIF var + 1 = 37	THEN 	vRetrieval_Reference_Number := vbit;
				ELSIF var + 1 = 38	THEN 	vApproval_Code := vbit;
				ELSIF var + 1 = 40	THEN 	vService_Code := vbit;
				ELSIF var + 1 = 41	THEN 	vCard_Acceptor_Terminal_ID := vbit;
				ELSIF var + 1 = 42	THEN 	vCard_Acceptor_ID_Code := vbit;
				ELSIF var + 1 = 43	THEN 	vCard_Acceptor_Name_Location := vbit;
				ELSIF var + 1 = 48	THEN 	vAdditional_Data := vbit;
				ELSIF var + 1 = 49	THEN 	vCurrency_Code_Transaction := vbit;
				ELSIF var + 1 = 50	THEN 	vCurrency_Code_Reconciliation := vbit;
				ELSIF var + 1 = 51	THEN 	vCurrency_Code_Cardholder_Billing := vbit;
				ELSIF var + 1 = 54	THEN 	vAmounts_Additional := vbit;
				ELSIF var + 1 = 55	THEN 	vIntegrated_Circuit_Card_ICC_System_Related_Data := vbit;
				ELSIF var + 1 = 62	THEN 	vAdditional_Data_2 := vbit;
				ELSIF var + 1 = 63	THEN 	vTransaction_Life_Cycle_ID := vbit;
				ELSIF var + 1 = 71	THEN 	vMessage_Number := vbit;
				ELSIF var + 1 = 72	THEN 	vData_Record := vbit;
				ELSIF var + 1 = 73	THEN 	vDate_Action := vbit;
				ELSIF var + 1 = 93	THEN 	vTransaction_Destination_Institution_ID_Code := vbit;
				ELSIF var + 1 = 94	THEN 	vTransaction_Originator_Institution_ID_Code := vbit;
				ELSIF var + 1 = 95	THEN 	vCard_Issuer_Reference_Data := vbit;
				ELSIF var + 1 = 100	THEN 	vReceiving_Institution_ID_Code := vbit;
				ELSIF var + 1 = 111	THEN 	vAmount_Currency_Conversion_Assessment := vbit;
				ELSIF var + 1 = 123	THEN 	vAdditional_Data_3 := vbit;
				ELSIF var + 1 = 124	THEN 	vAdditional_Data_4 := vbit;
				ELSIF var + 1 = 125	THEN 	vAdditional_Data_5 := vbit;	
				END IF;
				vinicio := vinicio + vlargo;
				raise notice 'ciclo clock_timestamp ( ) %',clock_timestamp ( ) ;
			END IF;
			var := var + 1;
		END LOOP;
		--return 'aqui5';
		INSERT INTO t_8583 VALUES(
		vmti,
		vBit_Map_Secondary,
		vPrimary_Account_Number_PAN	,
		vProcessing_Code	 ,
		vAmount_Transaction	 ,
		vAmount_Reconciliation	 ,
		vAmount_Cardholder_Billing	 ,
		vConversion_Rate_Reconciliation	 ,
		vConversion_Rate_Cardholder_Billing		 ,
		vDate_and_Time_Local_Transaction	 ,
		vDate_Expiration	 ,
		vPoint_of_Service_Data_Code	 ,
		vCard_Sequence_Number	 ,
		vFunction_Code		 ,
		vMessage_Reason_Code		 ,
		vCard_Acceptor_Business_Code_MCC	 ,
		vAmounts_Original	 ,
		vAcquirer_Reference_Data	 ,
		vAcquiring_Institution_ID_Code	 ,
		vForwarding_Institution_ID_Code		 ,
		vRetrieval_Reference_Number	 ,
		vApproval_Code	 ,
		vService_Code	 ,
		vCard_Acceptor_Terminal_ID		 ,
		vCard_Acceptor_ID_Code		 ,
		vCard_Acceptor_Name_Location	 ,
		vAdditional_Data	 ,
		vCurrency_Code_Transaction	 ,
		vCurrency_Code_Reconciliation	 ,
		vCurrency_Code_Cardholder_Billing	 ,
		vAmounts_Additional	 ,
		vIntegrated_Circuit_Card_ICC_System_Related_Data ,
		vAdditional_Data_2	 ,
		vTransaction_Life_Cycle_ID	 ,
		vMessage_Number	 ,
		vData_Record	 ,
		vDate_Action	 ,
		vTransaction_Destination_Institution_ID_Code	 ,
		vTransaction_Originator_Institution_ID_Code	 ,
		vCard_Issuer_Reference_Data	 ,
		vReceiving_Institution_ID_Code	 ,
		vAmount_Currency_Conversion_Assessment	 ,
		vAdditional_Data_3		 ,
		vAdditional_Data_4		 ,
		vAdditional_Data_5		
		);
		var1 := var1 + 1;
		select count(*) into varticulos from t_8583;
		--raise notice 'varticulos % var1 %',varticulos,var1;
		-- actualizacion de variables
		--vsecuencia := vsecuencia + 1;
    	vinicio := 1;
		vlargo := 0;
		--return 'aqui6';
		--IF var1 > 2 THEN
		--	RETURN '111';
		--END IF;

	END LOOP;
	return '000';

END;
$BODY$;

ALTER FUNCTION public.crea_tabla_8583_v2()
    OWNER TO postgres;
