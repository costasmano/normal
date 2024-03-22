//%attributes = {"invisible":true}
// Method: ut_GetSysParameter
// Description
//  ` Retrieve a parameter from the [Parameters] table, using a default
//  ` if not found.
// 
// Parameters
// $0 : Parameter description
// $1 : Parameter name
// $2 : Default value (Optional)
// $3 : $Value_Desc_txt (optional) ("VALUE" | "DESC" (default)) `retrieve the value or the descr
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 08/30/07, 10:52:39
	// ----------------------------------------------------
	
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(10/3/08 10:30:20)
	Mods_2008_CM_5404  // ("DESIGNMODS")
	//  `Added the third optional parameter
	// Modified by: Costas Manousakis-(Designer)-(9/8/14 10:05:43)
	Mods_2014_09
	//  `account for blank in $3
End if 
C_TEXT:C284($0; $Description_txt; $1; $Param_txt; $2; $Default_txt; $Value_Desc_txt)
$Param_txt:=$1
If (Count parameters:C259>1)
	$Default_txt:=$2
Else 
	$Default_txt:=""
End if 
$Value_Desc_txt:="DESC"
If (Count parameters:C259>2)
	C_TEXT:C284($3)
	If ($3#"")
		$Value_Desc_txt:=$3
	End if 
End if 

READ ONLY:C145([Parameters:107])
QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1=$Param_txt)
If (Records in selection:C76([Parameters:107])=1)
	Case of 
		: ($Value_Desc_txt="VALU@")
			$Description_txt:=[Parameters:107]Value:3
		: ($Value_Desc_txt="DESC@")
			$Description_txt:=[Parameters:107]Description:2
	End case 
Else 
	$Description_txt:=$Default_txt
End if 

$0:=$Description_txt