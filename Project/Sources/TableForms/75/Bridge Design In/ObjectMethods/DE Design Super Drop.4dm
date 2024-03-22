POPUPMENUC(->aDesign_SuperStr; ->aDesign_SuperStr; ->[Bridge Design:75]SuperStruct:11)

If (Form event code:C388=On Clicked:K2:4)
	PushChange(1; ->[Bridge Design:75]SuperStruct:11)
	If ([Bridge MHD NBIS:1]Item8 BridgeCat:207="DES")
		[Bridge MHD NBIS:1]Item43:75:=aTrans_SuperStr{aDesign_SuperStr}
		PushChange(2; ->[Bridge MHD NBIS:1]Item43:75)
	End if 
End if 
If (aDesign_SuperStr#-1)
	
	C_TEXT:C284(item43a)  // Command Replaced was o_C_STRING length was 1//This must not be a local variable!
	C_TEXT:C284(item43b)  // Command Replaced was o_C_STRING length was 2//This must not be a local variable!
	C_TEXT:C284(v43A; v43B; $vtTranslator)
	$vtTranslator:=aTrans_SuperStr{aDesign_SuperStr}
	item43a:=Substring:C12($vtTranslator; 1; 1)
	item43b:=Substring:C12($vtTranslator; 2; 2)
	
	v43A:=Get_Description(-><>aMaterial; -><>aMatCode; ->item43a)
	v43B:=Get_Description(-><>aDesign; -><>aDesignCod; ->item43b)
	
Else 
	v43A:=""
	v43B:=""
End if 