//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/17/07, 15:28:33
	// ----------------------------------------------------
	// Method: ut_ReLogPERSGroups
	// Description
	// Re-Create Activity Log entries for records in the [PERS_Groups] table
	// and the related records in [PERS_GroupMembers]
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2007_CM_5401
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 
C_LONGINT:C283($TableNum_L; $NumFields_L; $KeyFieldNum_L)
C_TEXT:C284($FieldName_txt; $keyFieldName_txt)
C_POINTER:C301($Tbl_ptr; $KeyField_ptr; $TblMbr_ptr; $TblMbrKeyG_ptr; $TblMbrKeyP_ptr; $TblPersKey_ptr)
$Tbl_ptr:=->[PERS_Groups:109]
$KeyField_ptr:=->[PERS_Groups:109]PERS_GroupID_I:1
$TblMbr_ptr:=->[PERS_GroupMembers:110]
$TblMbrKeyG_ptr:=->[PERS_GroupMembers:110]GroupID_I:1
$TblMbrKeyP_ptr:=->[PERS_GroupMembers:110]PersonID_I:2
$TblPersKey_ptr:=->[Personnel:42]Person ID:1
$TableNum_L:=Table:C252($Tbl_ptr)
$NumFields_L:=Get last field number:C255(Table:C252($TableNum_L))
ARRAY POINTER:C280($a_Ptr_Fields; $NumFields_L)
C_LONGINT:C283($i)
For ($i; 1; $NumFields_L)
	$a_Ptr_Fields{$i}:=Field:C253($TableNum_L; $i)
End for 
If (Type:C295(ptr_Changes)#Array 2D:K8:24)
	ARRAY POINTER:C280(ptr_Changes; 0; 0)
End if 
$KeyFieldNum_L:=Find in array:C230($a_Ptr_Fields; $KeyField_ptr)
QUERY:C277($Tbl_ptr->)
If (Records in selection:C76($Tbl_ptr->)>0)
	FIRST RECORD:C50($Tbl_ptr->)
	While (Not:C34(End selection:C36($Tbl_ptr->)))
		LogDeletion($KeyField_ptr; $KeyField_ptr; $KeyField_ptr; 0)
		LogNewRecord($KeyField_ptr; $KeyField_ptr; $KeyField_ptr; 0; "PersUserGroups")
		InitChangeStack(1)
		For ($i; 1; $NumFields_L)
			If ($i#$KeyFieldNum_L)
				PushChange(1; $a_Ptr_Fields{$i})
			End if 
		End for 
		FlushGrpChgs(1; $KeyField_ptr; $KeyField_ptr; $KeyField_ptr; 0)
		QUERY:C277($TblMbr_ptr->; $TblMbrKeyG_ptr->=$KeyField_ptr->)
		If (Records in selection:C76($TblMbr_ptr->)>0)
			While (Not:C34(End selection:C36($TblMbr_ptr->)))
				LogNewRecord($KeyField_ptr; $TblMbrKeyG_ptr; $TblMbrKeyP_ptr; 3; ""; $TblPersKey_ptr)
				NEXT RECORD:C51($TblMbr_ptr->)
			End while 
			
		End if 
		NEXT RECORD:C51($Tbl_ptr->)
	End while 
Else 
	ALERT:C41("No Records Selected in table ["+Table name:C256($Tbl_ptr)+"]")
End if 