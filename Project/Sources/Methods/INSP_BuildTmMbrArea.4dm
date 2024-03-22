//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/18/06, 16:18:40
	// ----------------------------------------------------
	// Method: Method: INSP_BuildTmMbrArea
	// Description
	// Build the area for the aInspTeam Scrollable area in Inspection forms
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CMy2
End if 
C_POINTER:C301($1; $PersonID_ptr)
If (Count parameters:C259=1)
	$PersonID_ptr:=$1
Else 
	$PersonID_ptr:=->[Field Trip:43]Person ID:2
End if 

C_LONGINT:C283($i; $j; $k)
//Team Member scrollable area
ARRAY INTEGER:C220(aInspTeamID; 0)
SELECTION TO ARRAY:C260($PersonID_ptr->; aInspTeamID)
$j:=Size of array:C274(aInspTeamID)
ARRAY TEXT:C222(aInspTeam; $j)  //Command Replaced was o_ARRAY string length was 44
For ($i; 1; $j)
	//Should do this find in entire personnel file, not just current team members.    
	$k:=Find in array:C230(aPeople_ID; aInspTeamID{$i})
	If ($k>0)
		aInspTeam{$i}:=aPeople{$k}
	Else 
		aInspTeam{$i}:="Invalid Person ID"
	End if 
End for 
