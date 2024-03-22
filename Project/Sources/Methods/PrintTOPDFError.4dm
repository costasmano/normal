//%attributes = {"invisible":true}
//Method: PrintTOPDFError
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 02/18/21, 12:05:59
	// ----------------------------------------------------
	//Created : 
	MODS_2021_01
End if 
//
ARRAY LONGINT:C221($ErrorNumbers_al; 0)
ARRAY TEXT:C222($InternalCodes_atxt; 0)
ARRAY TEXT:C222($InternalDescriptions_atxt; 0)
GET LAST ERROR STACK:C1015($ErrorNumbers_al; $InternalCodes_atxt; $InternalDescriptions_atxt)

C_LONGINT:C283($loop_l)
APPEND TO ARRAY:C911(SQL_InternalDescriptions_atxt; "Error Processing "+[Inspections:27]BIN:1+"-"+String:C10([Inspections:27]Insp Date:78; 7)+"-"+[Inspections:27]Insp Type:6)

For ($loop_l; 1; Size of array:C274($InternalDescriptions_atxt))
	APPEND TO ARRAY:C911(SQL_InternalDescriptions_atxt; $InternalDescriptions_atxt{$loop_l})
	
End for 

//End PrintTOPDFError