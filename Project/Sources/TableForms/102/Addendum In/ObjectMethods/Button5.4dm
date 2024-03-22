If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 08/31/07, 11:40:25
	// ----------------------------------------------------
	// Method: Object Method: CreateWorkHrs
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	
	Mods_2007_CM12_5301
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		
	: (Form event code:C388=On Clicked:K2:4)
		If (Records in selection:C76([Work_Estimate:103])=0)
			CONFIRM:C162("Do you want to create a Work Hour Estimate for this Addendum?")
			If (OK=1)
				WKHR_CreateProposal([Addendum_Maintenance:102]AddendumNo:2)
				OBJECT SET ENABLED:C1123(Self:C308->; False:C215)  // Command Replaced was o_DISABLE BUTTON 
				OBJECT SET ENABLED:C1123(ViewWorkHrs; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			End if 
		Else 
			ALERT:C41("There is a Work Hour Estimate for this Addendum")
		End if 
End case 

