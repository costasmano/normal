If (False:C215)
	Mods_2011_06  // CJ Miller`06/20/11, 11:39:03      ` Type all local variables for v11
End if 
Case of 
	: (Form event code:C388=On Getting Focus:K2:7)
		OBJECT SET ENABLED:C1123(CTRLVForCmmtTxt; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		C_LONGINT:C283($vlsize)
		$vlsize:=Pasteboard data size:C400("TEXT")
		If ($vlsize>0)
			//SET TEXT TO CLIPBOARD(Get text from clipboard)
		End if 
	: (Form event code:C388=On Losing Focus:K2:8)
		OBJECT SET ENABLED:C1123(CTRLVForCmmtTxt; False:C215)  // Command Replaced was o_DISABLE BUTTON 
End case 
