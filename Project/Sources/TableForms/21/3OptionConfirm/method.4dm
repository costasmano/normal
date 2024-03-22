If (False:C215)
	
	Mods_2004_CM12
	
	C_LONGINT:C283(vbChoice_1; vbChoice_2; vbChoice_3)  //Command Replaced was o_C_INTEGER
	
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		SET WINDOW TITLE:C213("Confirm")
		vbChoice_1:=0
		vbChoice_2:=0
		vbChoice_3:=0
		
		If (vtChoice_1_STR#"")
			OBJECT SET TITLE:C194(vbChoice_1; vtChoice_1_STR)
		End if 
		If (vtChoice_2_STR#"")
			OBJECT SET TITLE:C194(vbChoice_2; vtChoice_2_STR)
		End if 
		If (vtChoice_3_STR#"")
			OBJECT SET TITLE:C194(vbChoice_3; vtChoice_3_STR)
		End if 
		
End case 