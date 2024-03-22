
Case of 
	: (Form event code:C388=On Load:K2:1)
		Self:C308->:=0
	: (Form event code:C388=On Data Change:K2:15)
		
	: (Form event code:C388=On Clicked:K2:4)
		[NTI_ELEM_TIN_INSP:185]ELEM_QorP:16:=False:C215
		//PON_ELEMINPUTIL ("QUANTPERCENT")
		NTI_ELEMINPUTIL_TIN("QUANTPERCENT")
End case 
