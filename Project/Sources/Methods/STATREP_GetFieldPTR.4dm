//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/19/09, 09:43:34
	// ----------------------------------------------------
	// Method: STATREP_GetFieldPTR
	// Description
	// get a pointer to a field in [status report] from the name
	// 
	// Parameters
	// $1 : $FieldName_txt
	// $0 : $FieldPtr_ptr
	// ----------------------------------------------------
	
	Mods_2009_10("MASSDOT")
End if 
C_POINTER:C301($0; $FieldPtr_ptr)
C_LONGINT:C283($nameIndex_L)
C_TEXT:C284($1; $FieldName_txt)
$FieldName_txt:=$1
$nameIndex_L:=Find in array:C230(STATREP_FieldNames_atxt; $FieldName_txt)
If ($nameIndex_L>0)
	$0:=STATREP_Fields_aptr{$nameIndex_L}
Else 
	ALERT:C41("Incorrect BRIDGE STATUS REPORT Field Name requested <"+$FieldName_txt+"> !!!")
End if 