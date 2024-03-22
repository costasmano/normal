//%attributes = {"invisible":true}
// Method: UT_SET_Control
// Description
// Perform Set operations on the current list.
// 
// Parameters
// $1 : $Task_txt ("LOAD"|"ADD"|"SUBTRACT";"SAVE";"INTERSECT")
// $2 : $Tbl_ptr
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/03/08, 08:12:23
	// ----------------------------------------------------
	
	Mods_2008_CM_5404
	// Modified by: Costas Manousakis-(Designer)-(12/16/13 16:06:17)
	Mods_2013_12
	//  `Added the INTERSECTION option
End if 
C_TEXT:C284($1; $Task_txt)
$Task_txt:=$1
C_POINTER:C301($2; $Tbl_ptr)
$Tbl_ptr:=$2
CREATE SET:C116($Tbl_ptr->; "CurSet")
If ($Task_txt="SAVE")
	SAVE SET:C184("CurSet"; "")
Else 
	LOAD SET:C185($Tbl_ptr->; "Temp"; "")
	If (OK=1)
		Case of 
			: ($Task_txt="ADD")
				UNION:C120("CurSet"; "Temp"; "Temp")
			: ($Task_txt="SUBTRACT")
				DIFFERENCE:C122("CurSet"; "Temp"; "Temp")
			: ($Task_txt="INTERSECTION")
				INTERSECTION:C121("CurSet"; "Temp"; "Temp")
		End case 
		USE SET:C118("Temp")
		CLEAR SET:C117("Temp")
		C_TEXT:C284(GEN_SORTLISTCMD_txt)
		If (GEN_SORTLISTCMD_txt#"")
			EXECUTE FORMULA:C63(GEN_SORTLISTCMD_txt)
		End if 
		
	End if 
	
	WindowTitle
End if 

CLEAR SET:C117("CurSet")