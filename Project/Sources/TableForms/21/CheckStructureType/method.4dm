If (False:C215)
	//[Dialogs]CheckStructreType
	//July 21, 2003
	//Albert Leung
	//Resolve differences between values in inspection report and other reports.  
	//Checks only Item 43 and Item 107.
	//Called by CheckStructureType
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		If (Not:C34(vblnChkItem43))
			OBJECT SET ENABLED:C1123(*; "cbStructureType"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		End if 
		If (Not:C34(vblnChkItem107))
			OBJECT SET ENABLED:C1123(*; "cbItem107"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		End if 
End case 