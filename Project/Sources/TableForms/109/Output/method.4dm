If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/24/06, 09:19:45
	// ----------------------------------------------------
	// Method: Form Method: [PERS_Groups]Output
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CMy3
End if 

Case of 
	: (Form event code:C388=On Outside Call:K2:11)
		If (<>fQuit)
			CANCEL:C270
		End if 
	: (Form event code:C388=On Activate:K2:9)
		UpdatFilesPalet
	: (Form event code:C388=On Deactivate:K2:10)
		UpdatFilesPalet
	: (Form event code:C388=On Load:K2:1)
		ARRAY POINTER:C280(ptr_Changes; 0; 0)
		//REDRAW(◊asWindows)
End case 