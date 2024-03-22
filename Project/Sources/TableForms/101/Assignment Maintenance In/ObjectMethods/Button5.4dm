If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// ----------------------------------------------------
	// Method: Object Method: CreateWorkHrs
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2005_VN04
	
	// Modified by: costasmanousakis-(Designer)-(8/31/2007 11:36:13)
	Mods_2007_CM12_5301
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		
	: (Form event code:C388=On Clicked:K2:4)
		If (Records in selection:C76([Work_Estimate:103])=0)
			CONFIRM:C162("Do you want to create a Work Hour Estimate for this Assignment?")
			If (OK=1)
				WKHR_CreateProposal
				OBJECT SET ENABLED:C1123(Self:C308->; False:C215)  // Command Replaced was o_DISABLE BUTTON 
				OBJECT SET ENABLED:C1123(ViewWorkHrs; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			End if 
		Else 
			ALERT:C41("There is a Work Hour Estimate for this Assignment")
		End if 
		
End case 