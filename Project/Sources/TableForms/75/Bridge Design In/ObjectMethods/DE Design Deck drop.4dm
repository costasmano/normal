POPUPMENUC(->aDesign_Deck; ->aDesign_Deck; ->[Bridge Design:75]Deck:13)

If (Form event code:C388=On Clicked:K2:4)
	
	PushChange(1; ->[Bridge Design:75]Deck:13)
	
	If ([Bridge MHD NBIS:1]Item8 BridgeCat:207="DES")
		[Bridge MHD NBIS:1]Item107:79:=aTrans_Deck{aDesign_Deck}
		PushChange(2; ->[Bridge MHD NBIS:1]Item107:79)
		[Bridge MHD NBIS:1]Item108A:80:=aTrans_WearingSurface{aDesign_Deck}
		PushChange(2; ->[Bridge MHD NBIS:1]Item108A:80)
	End if 
End if 
If (aDesign_Deck#-1)
	C_TEXT:C284(item107)  // Command Replaced was o_C_STRING length was 3//This must not be a local variable!
	C_TEXT:C284(item108a)  // Command Replaced was o_C_STRING length was 3//This must not be a local variable!
	C_TEXT:C284(v107; v108A)
	
	item107:=Substring:C12(aTrans_Deck{aDesign_Deck}; 1; 1)
	item108a:=Substring:C12(aTrans_WearingSurface{aDesign_Deck}; 1; 1)
	
	v107:=Get_Description(-><>aDeck; -><>aDeckCod; ->item107)
	v108A:=Get_Description(-><>aWearing; -><>aWearCod; ->item108a)
	
Else 
	v107:=""
	v108A:=""
End if 