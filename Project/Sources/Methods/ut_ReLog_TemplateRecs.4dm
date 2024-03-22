//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 08/09/07, 16:24:33
	// ----------------------------------------------------
	// Method: ut_ReLogTemplateRecs
	// Description
	// Re-Create log entries for a selection of records in the [Templates] table
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2007_CM12_5301
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 
C_LONGINT:C283($TableNum_L; $NumFields_L; $KeyFieldNum_L; $i)
C_TEXT:C284($FieldName_txt; $keyFieldName_txt)
C_POINTER:C301($Tbl_ptr; $KeyField_ptr)
$Tbl_ptr:=->[Templates:86]
$KeyField_ptr:=->[Templates:86]TemplateID:1
$TableNum_L:=Table:C252($Tbl_ptr)
$NumFields_L:=Get last field number:C255(Table:C252($TableNum_L))
ARRAY POINTER:C280($a_Ptr_Fields; $NumFields_L)
For ($i; 1; $NumFields_L)
	$a_Ptr_Fields{$i}:=Field:C253($TableNum_L; $i)
End for 
$KeyFieldNum_L:=Find in array:C230($a_Ptr_Fields; $KeyField_ptr)
If (Type:C295(ptr_Changes)#Array 2D:K8:24)
	ARRAY POINTER:C280(ptr_Changes; 0; 0)
End if 
If (Records in selection:C76($Tbl_ptr->)>0)
	FIRST RECORD:C50($Tbl_ptr->)
	While (Not:C34(End selection:C36($Tbl_ptr->)))
		LogDeletion($KeyField_ptr; $KeyField_ptr; $KeyField_ptr; 0)
		LogNewRecord($KeyField_ptr; $KeyField_ptr; $KeyField_ptr; 0; "TemplateInc")
		InitChangeStack(1)
		For ($i; 1; $NumFields_L)
			If ($i#$KeyFieldNum_L)
				PushChange(1; $a_Ptr_Fields{$i})
			End if 
		End for 
		FlushGrpChgs(1; $KeyField_ptr; $KeyField_ptr; $KeyField_ptr; 0)
		NEXT RECORD:C51($Tbl_ptr->)
	End while 
Else 
	ALERT:C41("No Records Selected in table [Templates]")
End if 

