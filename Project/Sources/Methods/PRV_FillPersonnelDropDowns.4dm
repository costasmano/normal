//%attributes = {"invisible":true}
//Method: PRV_FillPersonnelDropDowns
//Description
//
// Parameters
//
//$1 pointer to id array
//$2 pointer to text array which contains name
//$3 text group type
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/06/13, 09:57:12
	// ----------------------------------------------------
	//Created : 
	Mods_2013_02
	// Modified by: Costas Manousakis-(Designer)-(9/25/13 15:02:54)
	Mods_2013_09
	//  `Copied to DEV
End if 
//
C_POINTER:C301($1; $2; $IDArray_ptr; $Namearray_ptr)
$IDArray_ptr:=$1
$Namearray_ptr:=$2
C_TEXT:C284(${3}; $GroupName_txt)
C_LONGINT:C283($i; $NumGroups_L)
$NumGroups_L:=Count parameters:C259-2
//$GroupName_txt:=$3
ARRAY LONGINT:C221($IDArray_ptr->; 0)
ARRAY TEXT:C222($Namearray_ptr->; 0)
For ($i; 1; $NumGroups_L)
	$GroupName_txt:=${$i+2}
	If ($I=1)
		QUERY:C277([PERS_GroupMembers:110]; [PERS_Groups:109]PERS_GroupName_s:2=$GroupName_txt; *)
	Else 
		QUERY:C277([PERS_GroupMembers:110];  | ; [PERS_Groups:109]PERS_GroupName_s:2=$GroupName_txt; *)
	End if 
	
End for 
QUERY:C277([PERS_GroupMembers:110])

SELECTION TO ARRAY:C260([PERS_GroupMembers:110]PersonID_I:2; $PeopleID_al)
QUERY WITH ARRAY:C644([Personnel:42]Person ID:1; $PeopleID_al)
ORDER BY:C49([Personnel:42]; [Personnel:42]Last Name:5; >; [Personnel:42]First Name:3; >)

C_LONGINT:C283($RecordsInSelection_l; $Loop_l)
$RecordsInSelection_l:=Records in selection:C76([Personnel:42])
ARRAY INTEGER:C220($PersID_ai; 0)
ARRAY TEXT:C222($PersLName_atxt; 0)
ARRAY TEXT:C222($PersFName_atxt; 0)
ARRAY TEXT:C222($PersPhone_atxt; 0)
SELECTION TO ARRAY:C260([Personnel:42]Person ID:1; $PersID_ai; [Personnel:42]Last Name:5; $PersLName_atxt; [Personnel:42]First Name:3; $PersFName_atxt; [Personnel:42]Phone_s:13; $PersPhone_atxt)
ARRAY LONGINT:C221($IDArray_ptr->; $RecordsInSelection_l)
ARRAY TEXT:C222($Namearray_ptr->; $RecordsInSelection_l)
For ($Loop_l; 1; $RecordsInSelection_l)
	$IDArray_ptr->{$Loop_l}:=$PersID_ai{$Loop_l}
	$Namearray_ptr->{$Loop_l}:=$PersLName_atxt{$Loop_l}+", "+$PersFName_atxt{$Loop_l}
	If ($PersPhone_atxt{$Loop_l}#"")
		$Namearray_ptr->{$Loop_l}:=$Namearray_ptr->{$Loop_l}+" ("+$PersPhone_atxt{$Loop_l}+")"
	End if 
	
End for 

//End PRV_FillPersonnelDropDowns