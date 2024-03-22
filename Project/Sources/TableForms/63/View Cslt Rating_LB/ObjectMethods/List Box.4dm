//Method: [Conslt Rating].View Cslt Rating_LB.List Box
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 06/04/20, 13:43:36
	// ----------------------------------------------------
	//Created : 
	
	// Modified by: Costas Manousakis-(Designer)-(2021-10-04T00:00:00 17:50:06)
	Mods_2021_10
	//  `return result from method LB_CSLT_Rating to handle sorting - made number of static columns = 13
	//  `fixed data source for NBIS Letter column
End if 
//
C_LONGINT:C283($0)

$0:=LB_CSLT_Rating
//End [Conslt Rating].View Cslt Rating_LB.List Box