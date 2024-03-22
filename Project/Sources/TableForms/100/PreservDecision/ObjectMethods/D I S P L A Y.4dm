//Method: Object Method: [Contract_Project_Maintenance].PreservDecision.Button
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 07/05/12, 18:11:11
	// ----------------------------------------------------
	//Created : 
	Mods_2012_07
End if 
//
READ ONLY:C145([Bridge MHD NBIS:1])
SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=[Contract_Project_Maintenance:100]BIN:5)

If (Records in selection:C76([Bridge MHD NBIS:1])=1)
	LOAD RECORD:C52([Bridge MHD NBIS:1])
	DIALOG:C40([Bridge MHD NBIS:1]; "SI & A Input")
Else 
	ALERT:C41("This is not a valid BIN")
	
End if 
//End Object Method: [Contract_Project_Maintenance].PreservDecision.Button