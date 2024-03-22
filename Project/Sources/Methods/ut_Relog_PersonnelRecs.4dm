//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/14/08, 11:44:26
	// ----------------------------------------------------
	// Method: Method: ut_Relog_PersonnelRecs
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2007_CM_5401
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 
C_LONGINT:C283($TableNum_L; $NumFields_L; $KeyFieldNum_L; $NewTransfer; $OldTRansfer; $i)
C_TEXT:C284($FieldName_txt; $keyFieldName_txt)
C_POINTER:C301($Tbl_ptr; $KeyField_ptr)
C_BOOLEAN:C305($Done; $DelFirst_b)
C_LONGINT:C283($RelCode)
C_TEXT:C284($CurrDest_txt; $FinalDest_txt; $NewRecSeq_txt)
$Done:=False:C215
$Tbl_ptr:=->[Personnel:42]
$KeyField_ptr:=->[Personnel:42]Person ID:1
$TableNum_L:=Table:C252($Tbl_ptr)
$NumFields_L:=Get last field number:C255(Table:C252($TableNum_L))
ARRAY POINTER:C280($a_Ptr_Fields; $NumFields_L)

For ($i; 1; $NumFields_L)
	$a_Ptr_Fields{$i}:=Field:C253($TableNum_L; $i)
End for 
$KeyFieldNum_L:=Find in array:C230($a_Ptr_Fields; $KeyField_ptr)
$NewRecSeq_txt:="Personnel"
$RelCode:=4
$FinalDest_txt:="District 4 BMS.comp"
$NewTransfer:=0
$DelFirst_b:=False:C215
C_TEXT:C284(<>Destination)  // Command Replaced was o_C_STRING length was 80
$CurrDest_txt:=<>Destination
<>Destination:=$FinalDest_txt
$OldTRansfer:=<>Transfer
<>Transfer:=$NewTransfer
If (Type:C295(ptr_Changes)#Array 2D:K8:24)
	ARRAY POINTER:C280(ptr_Changes; 0; 0)
End if 

Repeat 
	QUERY:C277($Tbl_ptr->)
	If (OK=1)
		If (Records in selection:C76($Tbl_ptr->)>0)
			FIRST RECORD:C50($Tbl_ptr->)
			While (Not:C34(End selection:C36($Tbl_ptr->)))
				If ($DelFirst_b)
					LogDeletion($KeyField_ptr; $KeyField_ptr; $KeyField_ptr; 1)
				End if 
				LogNewRecord($KeyField_ptr; $KeyField_ptr; $KeyField_ptr; $RelCode; $NewRecSeq_txt)
				InitChangeStack(1)
				For ($i; 1; $NumFields_L)
					If ($i#$KeyFieldNum_L)
						PushChange(1; $a_Ptr_Fields{$i})
					End if 
				End for 
				FlushGrpChgs(1; $KeyField_ptr; $KeyField_ptr; $KeyField_ptr; 1)
				NEXT RECORD:C51($Tbl_ptr->)
			End while 
		Else 
			ALERT:C41("No Records found in table ["+Table name:C256($Tbl_ptr)+"]")
		End if 
	Else 
		$Done:=True:C214
	End if 
	
Until ($Done)
<>Destination:=$CurrDest_txt
<>Transfer:=$OldTRansfer