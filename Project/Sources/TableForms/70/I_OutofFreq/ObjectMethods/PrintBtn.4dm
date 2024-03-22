//Method: [Out of Freq];"I_OutofFreq".PrintBtn
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): manousakisc
	//User (4D) : Designer
	//Date and time: 09/07/23, 11:04:05
	// ----------------------------------------------------
	//Created : 
	Mods_2023_09
End if 
//
SET PRINT OPTION:C733(Orientation option:K47:2; 1)  // portrait
PRINT SETTINGS:C106(Print dialog:K47:17)

If (OK=1)
	C_LONGINT:C283($L)
	$L:=Print form:C5([Out of Freq:70]; "P_OutofFreq")
	PAGE BREAK:C6
	
End if 

//End [Out of Freq];"I_OutofFreq".PrintBtn