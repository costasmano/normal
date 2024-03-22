//Method: [Conslt Rating].View Cslt Rating_LB.List Box
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 06/09/20, 13:43:36
	// ----------------------------------------------------
	//Created : 
	Mods_2020_06
	//Modified by: CJ (6/18/20 14:07:25)
	//Move code from single user to this to upgrade to use list boxes
	// Modified by: Costas Manousakis-(Designer)-(2021-10-04T00:00:00 17:50:06)
	Mods_2021_10
	//  `return result from method LB_CSLT_Inspection to handle sorting - made number of static columns = 11
End if 
//
C_LONGINT:C283($0)

$0:=LB_CSLT_Inspection
//End [Conslt Rating].View Cslt Rating_LB.List Box