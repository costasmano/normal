//Method: Object Method: [Contract_Assignment_Maintenance].PreservationInput.Button
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/05/13, 14:58:27
	// ----------------------------------------------------
	//Created : 
	Mods_2013_03
End if 
//
//_O_PAGE SETUP([Contract_Assignment_Maintenance]; "Preserv_Summary_print")
FORM SET OUTPUT:C54([Contract_Assignment_Maintenance:101]; "Preserv_Summary_print")
PRINT SETTINGS:C106
C_LONGINT:C283($ht)
$ht:=Print form:C5([Contract_Assignment_Maintenance:101]; "Preserv_Summary_print"; Form detail:K43:1)

If (Records in selection:C76([Contract_Project_Maintenance:100])>0)
	FIRST RECORD:C50([Contract_Project_Maintenance:100])
	$ht:=Print form:C5([Contract_Project_Maintenance:100]; "Preserv_Summary_print"; Form header:K43:3)
	While (Not:C34(End selection:C36([Contract_Project_Maintenance:100])))
		$ht:=Print form:C5([Contract_Project_Maintenance:100]; "Preserv_Summary_print"; Form detail:K43:1)
		NEXT RECORD:C51([Contract_Project_Maintenance:100])
	End while 
	
End if 

$ht:=Print form:C5([Contract_Assignment_Maintenance:101]; "Preserv_Summary_print"; Form footer:K43:2)
PAGE BREAK:C6
//End Object Method: [Contract_Assignment_Maintenance].PreservationInput.Button