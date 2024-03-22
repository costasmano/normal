//Method: [Bridge MHD NBIS];"RemovedBridge".Item6A_2
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/25/20, 10:15:36
	// ----------------------------------------------------
	//Created : 
	Mods_2020_02_bug
End if 
//

Case of 
	: (Form event code:C388=On After Keystroke:K2:26)
		If (Length:C16(Get edited text:C655)>18)
			IDv6Descr:=Substring:C12(Get edited text:C655; 1; 18)
		End if 
		
End case 

//End [Bridge MHD NBIS];"RemovedBridge".Item6A_2