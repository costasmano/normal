//LO Procedure [Dialogs];"Search Bridge"
If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(9/28/2007 12:22:41)
	Mods_2007_CM12_5301
End if 

If (Form event code:C388=On Load:K2:1)
	SRC_DeclareBrgVars
	vBIN:=""
	vBDEPT:=""
	vBridgeKey:=""
	vAddTo:=False:C215
	vsSearchResults:=""
	CBAddTo:=0
	Case of 
		: (SRC_StartFieldArea_s="BI")
			GOTO OBJECT:C206(vBIN)
		: (SRC_StartFieldArea_s="BD")
			GOTO OBJECT:C206(vBDEPT)
		: (SRC_StartFieldArea_s="BK")
			GOTO OBJECT:C206(vBridgeKey)
	End case 
	
End if 