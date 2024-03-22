Case of 
	: (Form event code:C388=On Data Change:K2:15)
		C_TEXT:C284($tempName_txt)
		C_BLOB:C604($docBlob_x)
		C_LONGINT:C283($offset_L)
		$offset_L:=0
		C_LONGINT:C283(TMPL_HList_L)
		If (Is a list:C621(TMPL_HList_L))
			CLEAR LIST:C377(TMPL_HList_L; *)
		Else 
			TMPL_HList_L:=New list:C375
		End if 
		TMPL_HList_L:=Load list:C383(TMPL_FileName_txt)
		
		LIST TO BLOB:C556(TMPL_HList_L; [Templates:86]Template_:3)
		PushChange(1; ->[Templates:86]Template_:3)
		Template_Size_L:=BLOB size:C605([Templates:86]Template_:3)
End case 
