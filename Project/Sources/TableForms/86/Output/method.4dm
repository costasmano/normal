If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/21/06, 15:40:54
	// ----------------------------------------------------
	// Method: Form Method: [Templates];"Output"
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CM04
	// Modified by: costasmanousakis-(Designer)-(6/22/10 15:57:27)
	Mods_2010_06
	//  `Added the description field and made form resizable
End if 
Case of 
	: (Form event code:C388=On Outside Call:K2:11)
		If (<>fQuit)
			CANCEL:C270
		End if 
	: (Form event code:C388=On Load:K2:1)
		
	: (Form event code:C388=On Validate:K2:3)
		
	: (Form event code:C388=On Close Detail:K2:24)
		C_TEXT:C284($RecSel)  // Command Replaced was o_C_STRING length was 10
		$RecSel:=String:C10(Records in selection:C76([Templates:86]))
		SET WINDOW TITLE:C213(MainTitle+" ["+$RecSel+"]")
	: (Form event code:C388=On Activate:K2:9)
		UpdatFilesPalet
	: (Form event code:C388=On Deactivate:K2:10)
		UpdatFilesPalet
End case 
