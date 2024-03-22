//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/18/06, 11:23:57
	// ----------------------------------------------------
	// Method: INSP_SortByTmLeader
	// Description
	// Sort the list of pending inspections by Team Leader name.
	// 
	// Parameters
	// $1 : Sort order : Integer = value of sort button on list when clicked.
	// ----------------------------------------------------
	Mods_2006_CM04
End if 
C_LONGINT:C283($1; $vSortButton)  //Command Replaced was o_C_INTEGER
$vSortButton:=$1
ARRAY LONGINT:C221($RecordNumber_aL; 0)
ARRAY INTEGER:C220($TeamLdrID_aI; 0)
SELECTION TO ARRAY:C260([Inspections:27]; $RecordNumber_aL; [Inspections:27]TeamLeader:4; $TeamLdrID_aI)
ARRAY TEXT:C222($TeamLeaderN_as; Size of array:C274($TeamLdrID_aI))  //Command Replaced was o_ARRAY string length was 44
C_LONGINT:C283($i; $k)
For ($i; 1; Size of array:C274($TeamLdrID_aI))
	$k:=Find in array:C230(aPeople_ID; $TeamLdrID_aI{$i})
	If ($k>0)
		$TeamLeaderN_as{$i}:=aPeople{$k}
	End if 
End for 
If (($vSortButton=0) | ($vSortButton=1))
	SORT ARRAY:C229($TeamLeaderN_as; $RecordNumber_al; >)
Else 
	SORT ARRAY:C229($TeamLeaderN_as; $RecordNumber_al; <)
End if 

CREATE SELECTION FROM ARRAY:C640([Inspections:27]; $RecordNumber_al; "SelectedInspections")
USE NAMED SELECTION:C332("SelectedInspections")
CLEAR NAMED SELECTION:C333("SelectedInspections")
ARRAY LONGINT:C221($RecordNumber_aL; 0)
ARRAY INTEGER:C220($TeamLdrID_aI; 0)
ARRAY TEXT:C222($TeamLeaderN_as; 0)  //Command Replaced was o_ARRAY string length was 44