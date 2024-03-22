//Method: Form Method: [Contract_Project_Maintenance]Preserv_Summary_print
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/10/13, 21:39:03
	// ----------------------------------------------------
	//Created : 
	Mods_2013_10
End if 
//
Case of 
	: (Form event code:C388=On Load:K2:1)
		
		
	: (Form event code:C388=On Printing Detail:K2:18)
		
		READ ONLY:C145([Bridge MHD NBIS:1])
		QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=[Contract_Project_Maintenance:100]BIN:5)
		C_TEXT:C284(LB_BRIDGES_Det06_txt; LB_BRIDGES_Det07_txt)
		Case of 
			: ([Bridge MHD NBIS:1]StructDef:103)
				LB_BRIDGES_Det06_txt:="SD"
			: ([Bridge MHD NBIS:1]FunctObs:106)
				LB_BRIDGES_Det06_txt:="FO"
			Else 
				LB_BRIDGES_Det06_txt:=""
		End case 
		LB_BRIDGES_Det07_txt:=QR_Item26OnOff
		
End case 

//End Form Method: [Contract_Project_Maintenance]Preserv_Summary_print