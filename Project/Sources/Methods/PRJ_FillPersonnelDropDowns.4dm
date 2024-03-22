//%attributes = {"invisible":true}
// PRJ_FillPersonnelDropDowns
// Description
// Fill arrays used in dropdowns from groups in [Pers_groups]
// Parameters
//$1 pointer to id array
//$2 pointer to text array which contains name
//$3 text group type
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): cjmiller
	// Date and time: 11/30/06, 15:36:22
	// ----------------------------------------------------
	Mods_2006_CJMv2
	// Modified by: costasmanousakis-(Designer)-(10/29/2007 08:45:15)
	Mods_2007_CM12_5302  // accept muliple group names; use arrays for [Personnel] fields
	// Modified by: Costas Manousakis-(Designer)-(2022-03-29T00:00:00 17:35:19)
	Mods_2022_03
	//  `account for groups being members of groups
End if 
C_POINTER:C301($1; $2; $IDArray_ptr; $Namearray_ptr)
$IDArray_ptr:=$1
$Namearray_ptr:=$2
C_TEXT:C284(${3}; $GroupName_txt)
C_LONGINT:C283($i; $NumGroups_L)
$NumGroups_L:=Count parameters:C259-2
//$GroupName_txt:=$3
ARRAY LONGINT:C221($IDArray_ptr->; 0)
ARRAY TEXT:C222($Namearray_ptr->; 0)

//get ids of current groups
For ($i; 1; $NumGroups_L)
	$GroupName_txt:=${$i+2}
	If ($I=1)
		QUERY:C277([PERS_Groups:109]; [PERS_Groups:109]PERS_GroupName_s:2=$GroupName_txt; *)
	Else 
		QUERY:C277([PERS_Groups:109];  | ; [PERS_Groups:109]PERS_GroupName_s:2=$GroupName_txt; *)
	End if 
End for 
QUERY:C277([PERS_Groups:109])
ARRAY INTEGER:C220($GroupIds_aI; 0)
SELECTION TO ARRAY:C260([PERS_Groups:109]PERS_GroupID_I:1; $GroupIds_aI)  // keep track of groups that have been scanned

For ($i; 1; $NumGroups_L)
	$GroupName_txt:=${$i+2}
	If ($I=1)
		QUERY:C277([PERS_GroupMembers:110]; [PERS_Groups:109]PERS_GroupName_s:2=$GroupName_txt; *)
	Else 
		QUERY:C277([PERS_GroupMembers:110];  | ; [PERS_Groups:109]PERS_GroupName_s:2=$GroupName_txt; *)
	End if 
	
End for 
QUERY:C277([PERS_GroupMembers:110];  & ; [PERS_GroupMembers:110]PersonID_I:2>0)  // get persons

SELECTION TO ARRAY:C260([PERS_GroupMembers:110]PersonID_I:2; $PeopleID_al)  // save the IDs

ARRAY INTEGER:C220($GroupsToScan_aI; 0)

For ($i; 1; $NumGroups_L)
	$GroupName_txt:=${$i+2}
	If ($I=1)
		QUERY:C277([PERS_GroupMembers:110]; [PERS_Groups:109]PERS_GroupName_s:2=$GroupName_txt; *)
	Else 
		QUERY:C277([PERS_GroupMembers:110];  | ; [PERS_Groups:109]PERS_GroupName_s:2=$GroupName_txt; *)
	End if 
	
End for 
QUERY:C277([PERS_GroupMembers:110];  & ; [PERS_GroupMembers:110]PersonID_I:2<0)  // get groups

If (Records in selection:C76([PERS_GroupMembers:110])>0)
	
	SELECTION TO ARRAY:C260([PERS_GroupMembers:110]PersonID_I:2; $GroupsToScan_aI)
	C_LONGINT:C283($loop_L)
	
	While (Size of array:C274($GroupsToScan_aI)>0)
		
		//remove ones that have been scanned already
		For ($loop_L; Size of array:C274($GroupsToScan_aI); 1; -1)
			$GroupsToScan_aI{$loop_L}:=(-1*$GroupsToScan_aI{$loop_L})  // convert to positive numbers
			If (Find in array:C230($GroupIds_aI; $GroupsToScan_aI{$loop_L})>0)
				//we have it - remove from list to scan
				DELETE FROM ARRAY:C228($GroupsToScan_aI; $loop_L; 1)
			Else 
				APPEND TO ARRAY:C911($GroupIds_aI; $GroupsToScan_aI{$loop_L})  //add it to list of scanned
			End if 
		End for 
		
		If (Size of array:C274($GroupsToScan_aI)>0)
			
			QUERY WITH ARRAY:C644([PERS_GroupMembers:110]GroupID_I:1; $GroupsToScan_aI)
			QUERY SELECTION:C341([PERS_GroupMembers:110]; [PERS_GroupMembers:110]PersonID_I:2>0)  // get people
			If (Records in selection:C76([PERS_GroupMembers:110])>0)
				ARRAY INTEGER:C220($addPeopleID_aI; 0)
				SELECTION TO ARRAY:C260([PERS_GroupMembers:110]PersonID_I:2; $addPeopleID_aI)
				//add to starting list of IDs
				C_LONGINT:C283($toAdd_L; $currSize_L)
				$toAdd_L:=Size of array:C274($addPeopleID_aI)
				$currSize_L:=Size of array:C274($PeopleID_al)
				//resize start list
				ARRAY INTEGER:C220($PeopleID_al; ($currSize_L+$toAdd_L))
				C_LONGINT:C283($loop_L)
				For ($loop_L; 1; Size of array:C274($addPeopleID_aI))
					$PeopleID_al{$currSize_L+$loop_L}:=$addPeopleID_aI{$loop_L}
				End for 
			End if 
			
			QUERY WITH ARRAY:C644([PERS_GroupMembers:110]GroupID_I:1; $GroupsToScan_aI)
			QUERY SELECTION:C341([PERS_GroupMembers:110]; [PERS_GroupMembers:110]PersonID_I:2<0)  // get groups
			ARRAY INTEGER:C220($GroupsToScan_aI; 0)
			If (Records in selection:C76([PERS_GroupMembers:110])>0)
				SELECTION TO ARRAY:C260([PERS_GroupMembers:110]PersonID_I:2; $GroupsToScan_aI)
			End if 
			
		End if 
		
	End while 
	
End if 

QUERY WITH ARRAY:C644([Personnel:42]Person ID:1; $PeopleID_al)
ORDER BY:C49([Personnel:42]; [Personnel:42]Last Name:5; >; [Personnel:42]First Name:3; >)

C_LONGINT:C283($RecordsInSelection_l; $Loop_l)
$RecordsInSelection_l:=Records in selection:C76([Personnel:42])
ARRAY INTEGER:C220($PersID_ai; 0)
ARRAY TEXT:C222($PersLName_atxt; 0)
ARRAY TEXT:C222($PersFName_atxt; 0)
SELECTION TO ARRAY:C260([Personnel:42]Person ID:1; $PersID_ai; [Personnel:42]Last Name:5; $PersLName_atxt; [Personnel:42]First Name:3; $PersFName_atxt)
ARRAY LONGINT:C221($IDArray_ptr->; $RecordsInSelection_l)
ARRAY TEXT:C222($Namearray_ptr->; $RecordsInSelection_l)
For ($Loop_l; 1; $RecordsInSelection_l)
	$IDArray_ptr->{$Loop_l}:=$PersID_ai{$Loop_l}
	$Namearray_ptr->{$Loop_l}:=$PersLName_atxt{$Loop_l}+", "+$PersFName_atxt{$Loop_l}
End for 

//
//End PRJ_FillPersonnelDropDowns