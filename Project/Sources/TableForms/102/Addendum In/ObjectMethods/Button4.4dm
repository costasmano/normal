If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 08/31/07, 11:40:14
	// ----------------------------------------------------
	// Method: Object Method: ViewWorkHrs
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
		FORM SET INPUT:C55([Work_Estimate:103]; "Input")
		C_LONGINT:C283(WKHR_InputStatus)  //Command Replaced was o_C_INTEGER
		WKHR_InputStatus:=1  //Allow only edit of Accepted checkbox
		MODIFY RECORD:C57([Work_Estimate:103])
		CM_RelateWorkHour(Is new record:C668([Addendum_Maintenance:102]); [Addendum_Maintenance:102]AddendumNo:2)
		UNLOAD RECORD:C212([Work_Estimate:103])
End case 
