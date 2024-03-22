// ----------------------------------------------------
// Form Method: Selection.o
// User name (OS): cjmiller
// Date and time: 01/19/06, 11:29:30
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		
		PRJ_PerformSelectionSetUp
	: (Form event code:C388=On Outside Call:K2:11)
		If (<>fQuit)
			CANCEL:C270
		Else 
			PRJ_PerformSelectionSetUp
		End if 
	: (Form event code:C388=On Unload:K2:2)
		
End case 
//End Form Method: Selection.o