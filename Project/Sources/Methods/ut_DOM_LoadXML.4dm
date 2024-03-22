//%attributes = {"invisible":true}
//Method: ut_DOM_LoadXML
//Description
// Return the parsed XML reference from a resource file or from a 
// record in the [Parameters] table. Will use parameter RES_PARAM_XREF
// to determine which parameter to use
// Parameters
// $0 : $ParsedXML
// $1 : $Resource file Folder
// $2 : $Resourcefile
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/21/19, 17:04:41
	// ----------------------------------------------------
	//Created : 
	
	Mods_2019_03
	
	C_TEXT:C284(ut_DOM_LoadXML; $0)
	C_TEXT:C284(ut_DOM_LoadXML; $1)
	C_TEXT:C284(ut_DOM_LoadXML; $2)
	
End if 
//

C_TEXT:C284($0)
C_TEXT:C284($1)
C_TEXT:C284($2)

C_TEXT:C284($Dom_txt; $ResFolder_txt; $ResFile_txt; $ParamName_txt; $ParameterSource_txt; $resParamTree_txt)

$ResFolder_txt:=$1
$ResFile_txt:=$2

$ParamName_txt:=RES_Find_Parameter($ResFolder_txt; $ResFile_txt)

$ParameterSource_txt:=ut_GetSysParameter($ParamName_txt)
C_BOOLEAN:C305(XMLError_b)
XMLError_b:=False:C215
ON ERR CALL:C155("XMLErrorHandler")

If ($ParameterSource_txt#"")
	//found a parameter to use
	
	$Dom_txt:=DOM Parse XML variable:C720($ParameterSource_txt)
	
Else 
	//use the resource file
	
	If (Test path name:C476(Get 4D folder:C485(Current resources folder:K5:16)+$ResFolder_txt+<>PL_DirectorySep_s+$ResFile_txt)=Is a document:K24:1)
		$Dom_txt:=DOM Parse XML source:C719(Get 4D folder:C485(Current resources folder:K5:16)+$ResFolder_txt+<>PL_DirectorySep_s+$ResFile_txt)
	Else 
		$Dom_txt:=DOM Create XML Ref:C861("Blank")
	End if 
	
End if 
If (XMLError_b)
	//if there was an error - return a blank DOM
	$Dom_txt:=DOM Create XML Ref:C861("Blank")
End if 

ON ERR CALL:C155("")

$0:=$Dom_txt
//End ut_DOM_LoadXML