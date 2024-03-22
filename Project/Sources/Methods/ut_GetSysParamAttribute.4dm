//%attributes = {"invisible":true}
//Method: ut_GetSysParamAttribute
//Description
// Get an attribute from a system parameter stored as an object (Json)
// Parameters
// $0 : $Attibute_txt
// $1 : $ParameterName_txt
// $2 : $Attribute_txt
// $3 : $DefaultAttr_txt (optional)
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/02/20, 13:41:21
	// ----------------------------------------------------
	//Created : 
	Mods_2020_03_bug
	
	C_TEXT:C284(ut_GetSysParamAttribute; $0)
	C_TEXT:C284(ut_GetSysParamAttribute; $1)
	C_TEXT:C284(ut_GetSysParamAttribute; $2)
	C_TEXT:C284(ut_GetSysParamAttribute; $3)
	
End if 
//

C_TEXT:C284($0; $AttrValue_txt)
C_TEXT:C284($1; $ParamName_txt)
C_TEXT:C284($2; $Attribute_txt)

$AttrValue_txt:=""

If (Count parameters:C259>2)
	C_TEXT:C284($3)
	$AttrValue_txt:=$3
End if 
C_TEXT:C284($paramValue_txt)
$ParamName_txt:=$1
$Attribute_txt:=$2

$paramValue_txt:=ut_GetSysParameter($ParamName_txt)

If ($paramValue_txt#"")
	C_OBJECT:C1216($ParamObj_o)
	C_TEXT:C284($MethCalledOnErr)
	$MethCalledOnErr:=Method called on error:C704
	C_BOOLEAN:C305(4D_ERROR_B)
	4D_ERROR_B:=False:C215
	ON ERR CALL:C155("4D_Errors")
	
	$ParamObj_o:=JSON Parse:C1218($paramValue_txt; Is object:K8:27)
	
	ON ERR CALL:C155($MethCalledOnErr)
	
	If (4D_ERROR_B)
		ALERT:C41("Error Parsing System Parameter "+$ParamName_txt+" to retrieve attribute "+$Attribute_txt+" !!")
	Else 
		ARRAY TEXT:C222($ObjProps_atxt; 0)
		OB GET PROPERTY NAMES:C1232($ParamObj_o; $ObjProps_atxt)
		C_LONGINT:C283($attrIndx_L)
		$attrIndx_L:=Find in array:C230($ObjProps_atxt; $Attribute_txt)
		
		If ($attrIndx_L>0)
			$AttrValue_txt:=OB Get:C1224($ParamObj_o; $ObjProps_atxt{$attrIndx_L}; Is text:K8:3)
		Else 
			ALERT:C41("System Parameter "+$ParamName_txt+" does not have the required attribute "+$Attribute_txt+" !!")
		End if 
		
	End if 
	
End if 

$0:=$AttrValue_txt
//End ut_GetSysParamAttribute