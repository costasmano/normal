//%attributes = {"invisible":true}
//Method: INSP_addTeamLeaders
//Description
// will add to the current selection from [Personnel] table people - for CallReference #714
// Parameters
// $1 : $persGrouptoadd - get members of this personnel group
// $2 : $Agency - belonging to this agancy
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/02/20, 15:05:59
	// ----------------------------------------------------
	//Created : 
	Mods_2020_06
	
	C_TEXT:C284(INSP_addTeamLeaders; $1)
	C_TEXT:C284(INSP_addTeamLeaders; $2)
	
End if 
//

C_TEXT:C284($1; $2)

C_TEXT:C284($persGroup_txt; $Agency_txt)
$persGroup_txt:=$1
$Agency_txt:=$2

CREATE SET:C116([Personnel:42]; "TEAMLEADERS_START")
ARRAY LONGINT:C221($memberIDs_aL; 0)
ARRAY INTEGER:C220($memberIDs_ai; 0)
ARRAY TEXT:C222($membNames_atxt; 0)

GRP_GetMembersOfGrps(->$memberIDs_aL; ->$membNames_atxt; ""; $persGroup_txt)
ARRAY INTEGER:C220($memberIDs_ai; Size of array:C274($memberIDs_aL))
C_LONGINT:C283($loop_L)
For ($loop_L; 1; Size of array:C274($memberIDs_aL))
	$memberIDs_ai{$loop_L}:=$memberIDs_aL{$loop_L}
End for 

QUERY WITH ARRAY:C644([Personnel:42]Person ID:1; $memberIDs_ai)
If ($Agency_txt#"")
	QUERY SELECTION:C341([Personnel:42]; [Personnel:42]Employer:9=$Agency_txt)
	CREATE SET:C116([Personnel:42]; "TEAMLEADERS_ADD")
End if 

UNION:C120("TEAMLEADERS_START"; "TEAMLEADERS_ADD"; "TEAMLEADERS_START")
USE SET:C118("TEAMLEADERS_START")
CLEAR SET:C117("TEAMLEADERS_START")
CLEAR SET:C117("TEAMLEADERS_ADD")
//End INSP_addTeamLeaders