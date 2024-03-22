//Method: Object Method: [Contract_Assignment_Maintenance].PreservationInput.PRV_ProjDescr_txt
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 09/23/13, 15:58:22
	// ----------------------------------------------------
	//Created : 
	Mods_2013_09
End if 
//
Case of 
	: (Form event code:C388=On Load:K2:1)
		
	: (Form event code:C388=On Data Change:K2:15)
		
	: (Form event code:C388=On Clicked:K2:4)
		If (Right click:C712 | Macintosh control down:C544)
			If (PRV_ProjDescr_txt#"")
				C_LONGINT:C283($opt_L)
				$opt_L:=Pop up menu:C542(" ;Copy")
				
				If ($opt_L=2)
					SET TEXT TO PASTEBOARD:C523(PRV_ProjDescr_txt)
				End if 
				
			End if 
		End if 
End case 

//End Object Method: [Contract_Assignment_Maintenance].PreservationInput.PRV_ProjDescr_txt