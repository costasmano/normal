Case of 
	: (Form event code:C388=On Data Change:K2:15)
		C_TEXT:C284($tempName_txt)
		C_BLOB:C604($docBlob_x)
		C_LONGINT:C283($offset_L)
		$offset_L:=0
		
		BLOB TO VARIABLE:C533([Templates:86]Template_:3; $tempName_txt; $offset_L)
		BLOB TO VARIABLE:C533([Templates:86]Template_:3; $docBlob_x; $offset_L)
		
		VARIABLE TO BLOB:C532(TMPL_FileName_txt; [Templates:86]Template_:3)
		VARIABLE TO BLOB:C532($docBlob_x; [Templates:86]Template_:3; *)
		PushChange(1; ->[Templates:86]Template_:3)
		Template_Size_L:=BLOB size:C605([Templates:86]Template_:3)
		SET BLOB SIZE:C606($docBlob_x; 0)
End case 
