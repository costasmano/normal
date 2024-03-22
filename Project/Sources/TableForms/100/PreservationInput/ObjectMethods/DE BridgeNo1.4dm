//Method: Object Method: [Contract_Project_Maintenance].PreservationInput.BIN
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/07/12, 12:29:13
	// ----------------------------------------------------
	//Created : 
	Mods_2012_06
End if 
//
Case of 
		
	: (Form event code:C388=On Load:K2:1)
		
	: (Form event code:C388=On Data Change:K2:15)
		C_TEXT:C284($message)
		C_TEXT:C284(vBIN)  // Command Replaced was o_C_STRING length was 3
		C_TEXT:C284(vBridgeNo)  // Command Replaced was o_C_STRING length was 50
		C_TEXT:C284(vLocation)  // Command Replaced was o_C_STRING length was 100
		C_TEXT:C284(vTown)  // Command Replaced was o_C_STRING length was 26
		
		$message:="You have entered an incorrect BIN number. Please reenter it again."
		vBridgeNo:=""
		[Contract_Project_Maintenance:100]District:8:=""
		[Contract_Project_Maintenance:100]Location:6:=""
		[Contract_Project_Maintenance:100]Town:7:=""
		READ ONLY:C145([Bridge MHD NBIS:1])
		QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=[Contract_Project_Maintenance:100]BIN:5)
		
		If (Records in selection:C76([Bridge MHD NBIS:1])=0)
			ALERT:C41($message)
		Else 
			PRV_ProjBridgeInput_FM(PRV_GETBRIDGEBININFO_L)
		End if 
		
	: (Form event code:C388=On Clicked:K2:4)
		
End case 


//End Object Method: [Contract_Project_Maintenance].PreservationInput.BIN