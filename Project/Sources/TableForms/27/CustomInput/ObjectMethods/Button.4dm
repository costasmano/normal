//Method: Object Method: [Inspections].CustomInput.Button
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/07/13, 16:14:26
	// ----------------------------------------------------
	//Created : 
	Mods_2013_06
	// Modified by: Costas Manousakis-(Designer)-(7/29/13 10:03:46)
	Mods_2013_07
	//  `Added button and modified object methods to allow editing of inspection type
End if 
//
If (ut_LoadRecordInteractive(->[Inspections:27]))
	QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=[Inspections:27]BIN:1)
	OBJECT SET ENABLED:C1123(bValidate; True:C214)  // Command Replaced was o_ENABLE BUTTON 
	OBJECT SET ENABLED:C1123(Button1; True:C214)  // Command Replaced was o_ENABLE BUTTON 
Else 
	
End if 
//End Object Method: [Inspections].CustomInput.Button