//%attributes = {"invisible":true}
//Method: GRP_GetMembersOfGrps
//Description
//
// Parameters
// $1 : $IDarray_ptr
// $2 : $NameArray_ptr
// $3 : $GrpSuffix_txt ; blank for no suffix
// ${4} : $GroupName(s)
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/02/13, 09:43:19
	// ----------------------------------------------------
	//Created : 
	Mods_2013_05
	// Modified by: Costas Manousakis-(Designer)-(3/18/19 16:46:44)
	Mods_2019_03_bug
	//  `if the GrpSuffix is "@" , strip the base groupname passed in args 4 when building the name array.
End if 
//
C_POINTER:C301($1; $IDarray_ptr)
$IDarray_ptr:=$1
C_POINTER:C301($2; $NameArray_ptr)
$NameArray_ptr:=$2
C_TEXT:C284($3; $GrpSuffix_txt)
$GrpSuffix_txt:=$3
C_TEXT:C284(${4})
C_LONGINT:C283($NumGroups_L)
$NumGroups_L:=Count parameters:C259
C_TEXT:C284($groupname_txt; $MembDisplName_txt)
READ ONLY:C145([PERS_Groups:109])
ut_Read_Write_Tables("READ"; ->[PERS_Groups:109]; ->[PERS_GroupMembers:110]; ->[Personnel:42])
ARRAY LONGINT:C221($groupmem_aL; 0)
ARRAY TEXT:C222($groupnames_atxt; 0)
ARRAY LONGINT:C221($IDarray_ptr->; 0)
ARRAY TEXT:C222($NameArray_ptr->; 0)
C_LONGINT:C283($Grloop_L; $loop_L)
C_TEXT:C284($patt_txt)
$patt_txt:="(.*)\\, (.*)"

For ($Grloop_L; 4; $NumGroups_L)
	$groupname_txt:=${$Grloop_L}
	QUERY:C277([PERS_Groups:109]; [PERS_Groups:109]PERS_GroupName_s:2=($groupname_txt+$GrpSuffix_txt+"@"))
	
	If (Records in selection:C76([PERS_Groups:109])>0)
		ORDER BY:C49([PERS_Groups:109]; [PERS_Groups:109]PERS_GroupName_s:2)
		FIRST RECORD:C50([PERS_Groups:109])
		While (Not:C34(End selection:C36([PERS_Groups:109])))
			PRJ_FillPersonnelDropDowns(->$groupmem_aL; ->$groupnames_atxt; [PERS_Groups:109]PERS_GroupName_s:2)
			If (Size of array:C274($groupmem_aL)>0)
				C_LONGINT:C283($loop_L)
				C_TEXT:C284($GrpIndex_txt)
				For ($loop_L; 1; Size of array:C274($groupmem_aL))
					APPEND TO ARRAY:C911($IDarray_ptr->; $groupmem_aL{$loop_L})
					$MembDisplName_txt:=$groupnames_atxt{$loop_L}
					ARRAY LONGINT:C221($arrPos_aL; 0)
					ARRAY LONGINT:C221($ArrLen_aL; 0)
					If (Match regex:C1019($patt_txt; $MembDisplName_txt; 1; $arrPos_aL; $ArrLen_aL))
						If (Size of array:C274($arrPos_aL)=2)
							$MembDisplName_txt:=Substring:C12($MembDisplName_txt; $arrPos_aL{2}; $ArrLen_aL{2})+" "+Substring:C12($MembDisplName_txt; $arrPos_aL{1}; $ArrLen_aL{1})
						End if 
						
					End if 
					
					If ($GrpSuffix_txt#"")
						//Find the "index" after the suffix
						
						If ($GrpSuffix_txt="@")
							$GrpIndex_txt:=Replace string:C233([PERS_Groups:109]PERS_GroupName_s:2; $groupname_txt; "")
						Else 
							$GrpIndex_txt:=Replace string:C233([PERS_Groups:109]PERS_GroupName_s:2; ($groupname_txt+$GrpSuffix_txt); "")
						End if 
						
						If ($GrpIndex_txt#"")
							//$MembDisplName_txt:=$GrpSuffix_txt+"-"+$GrpIndex_txt+" "+$MembDisplName_txt
							$MembDisplName_txt:=$GrpIndex_txt+" "+$MembDisplName_txt
							
						Else 
						End if 
						
					End if 
					APPEND TO ARRAY:C911($NameArray_ptr->; $MembDisplName_txt)
				End for 
			End if 
			NEXT RECORD:C51([PERS_Groups:109])
		End while 
	End if 
	
End for 

//End GRP_GetMembersOfGrps