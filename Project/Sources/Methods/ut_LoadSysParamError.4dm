//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/09/10, 11:40:16
	// ----------------------------------------------------
	// Method: ut_LoadSysParamError
	// Description
	//  ` Attempt to load a parameter using the ut_GetSysParameter method
	//  ` Return error if not found
	// 
	// Parameters
	// $0 : $Error_b
	// $1 : $ParamCode_txt
	// $2 : $Target_ptr
	// $3 : Default value (Optional)
	// $4 : $Value_Desc_txt (optional) ("VALUE" | "DESC" (default)) `retrieve the value or the descr
	
	// ----------------------------------------------------
	
	Mods_2010_11
End if 
C_BOOLEAN:C305($0; $Error_b)
C_TEXT:C284($1; $ParamCode_txt; $Result_txt; $3; $Default_txt; $Value_Desc_txt)
C_POINTER:C301($2; $Target_ptr)
$ParamCode_txt:=$1
$Target_ptr:=$2
$Error_b:=False:C215
If (Count parameters:C259>2)
	$Default_txt:=$3
Else 
	$Default_txt:=""
End if 
If (Count parameters:C259>2)
	C_TEXT:C284($4)
	$Value_Desc_txt:=$4
Else 
	$Value_Desc_txt:="DESC"
End if 

$Result_txt:=ut_GetSysParameter($ParamCode_txt; $Default_txt; $Value_Desc_txt)
If ($Result_txt="")
	$Error_b:=False:C215
	ALERT:C41("Error!: Could not load requested parameter: "+$ParamCode_txt)
Else 
	$Error_b:=True:C214
	$Target_ptr->:=$Result_txt
End if 

$0:=$Error_b