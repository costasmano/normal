If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/21/06, 16:46:15
	// ----------------------------------------------------
	// Method: Form Method: Output
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CM04
	// Modified by: costasmanousakis-(Designer)-(8/21/2007 13:19:49)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(1/25/08 10:59:58)
	Mods_2007_CM_5401
	//  `Added sorts to all relevant buttons.
End if 

Case of 
		
	: (Form event code:C388=On Load:K2:1)
		C_TEXT:C284(vGEN_AddRecord_txt)
		vGEN_AddRecord_txt:="Record. Hold Shift key to copy first Highlighted record."
		C_TEXT:C284(MainTitle)  // Command Replaced was o_C_STRING length was 255
	: (Form event code:C388=On Validate:K2:3)
		
	: (Form event code:C388=On Close Detail:K2:24)
		C_TEXT:C284($RecSel)  // Command Replaced was o_C_STRING length was 10
		$RecSel:=String:C10(Records in selection:C76(Current form table:C627->))
		SET WINDOW TITLE:C213(MainTitle+" ["+$RecSel+"]")
		
		//: (Form event=On Clicked )
		//C_STRING(10;$RecSel)
		//$RecSel:=String(Records in selection(Current form table->))
		//SET WINDOW TITLE(MainTitle+" ["+$RecSel+"]")
		
	: (Form event code:C388=On Outside Call:K2:11)
		If (<>fQuit)
			CANCEL:C270
		End if 
		
End case 