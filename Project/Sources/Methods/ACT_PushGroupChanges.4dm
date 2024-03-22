//%attributes = {"invisible":true}
//Method: ACT_PushGroupChanges
//Description
//
// Parameters
// $1 : $TableNumber_L
// $2 : $ChangeLogLevel_L
// $3 : $Array_ptr pointer to array of names of fields to skip
// $4 : $CompareFields_B : true will compare old and new fields (log only changes) - False will log all fields
// ----------------------------------------------------
If (False:C215)
	
	//----------------------------------------------------
	//User name (OS): administrator
	//Date and time: 12/16/14, 17:06:05
	//----------------------------------------------------
	Mods_2014_Lighting  // 
	//Modified by: administrator (12/16/14 17:06:06)
	Mods_2017_12  //Change name from LSS_ to ACT_ as it used in more than LSS
	//Modified by: Chuck Miller (12/14/17 15:58:26)
	
	
End if 
C_LONGINT:C283($1; $2; $TableNumber_L; $ChangeLogLevel_L; $Type_l; $Length_l)
C_BOOLEAN:C305($Indexed_b; $Unique_b; $Invisible_b; $0)
$TableNumber_L:=$1
$ChangeLogLevel_L:=$2
C_POINTER:C301($3; $Array_ptr)
$Array_ptr:=$3
C_BOOLEAN:C305($CompareFields_B)
$CompareFields_B:=True:C214
If (Count parameters:C259=4)
	C_BOOLEAN:C305($4)
	$CompareFields_B:=$4
End if 
C_POINTER:C301($Field_ptr)
$0:=False:C215
C_LONGINT:C283($Loop_l)
C_LONGINT:C283($Pos_L)

For ($Loop_l; 1; Get last field number:C255($TableNumber_l))
	If (Is field number valid:C1000($TableNumber_l; $Loop_l))
		$Field_ptr:=Field:C253($TableNumber_l; $Loop_l)
		If (Find in array:C230($Array_ptr->; Field name:C257($Field_ptr))>0)
		Else 
			GET FIELD PROPERTIES:C258($TableNumber_l; $Loop_l; $Type_l; $Length_l; $Indexed_b; $Unique_b; $Invisible_b)
			Case of 
				: ($Type_l=Is picture:K8:10)
				: ($Type_l=Is BLOB:K8:12)
				: (Not:C34($CompareFields_B))
					PushChange($ChangeLogLevel_L; $Field_ptr)
					$0:=True:C214
				: ($Type_l=Is text:K8:3) | ($Type_l=Is alpha field:K8:1)
					If (Length:C16($Field_ptr->)=Length:C16(Old:C35($Field_ptr->)))
						If (Length:C16($Field_ptr->)>0)
							$Pos_L:=Position:C15($Field_ptr->; Old:C35($Field_ptr->); *)
							If ($Pos_L=0)
								PushChange($ChangeLogLevel_L; $Field_ptr)
								$0:=True:C214
							End if 
						End if 
					Else 
						PushChange($ChangeLogLevel_L; $Field_ptr)
						$0:=True:C214
					End if 
				Else 
					
					If (($Field_ptr->)#Old:C35($Field_ptr->))
						PushChange($ChangeLogLevel_L; $Field_ptr)
						$0:=True:C214
					End if 
					
			End case 
		End if 
	End if 
End for 
//End ACT_PushGroupChanges

