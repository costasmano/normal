//%attributes = {"invisible":true}
//Method: NTI_CreateParams
//Description
// Create the XML parameters used in Inspection...
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 08/16/16, 12:38:35
	// ----------------------------------------------------
	//Created : 
	Mods_2016_08
	// Modified by: Costas Manousakis-(Designer)-(1/11/18 12:03:09)
	Mods_2018_01
	//  `added parameter NTI_CSWTFACTORS
End if 
//

C_TEXT:C284(vsforward)  // Command Replaced was o_C_STRING length was 80
C_TEXT:C284($Tree_txt; $TheDom_txt; $Param_name_txt; $Type_txt; $Group_txt)
$Param_name_txt:="NTI_INSPREQ"
$Tree_txt:=DOM Create XML Ref:C861($Param_name_txt)
$Type_txt:=DOM Create XML element:C865($Tree_txt; "INSPTYPE")
DOM SET XML ATTRIBUTE:C866($Type_txt; "DBIEREQ"; "true")
DOM SET XML ATTRIBUTE:C866($Type_txt; "AreaREQ"; "true")
DOM SET XML ELEMENT VALUE:C868($Type_txt; "ZRN")

DOM EXPORT TO VAR:C863($Tree_txt; $TheDom_txt)

DOM CLOSE XML:C722($Tree_txt)
CONFIRM:C162("Update database parameter "+$Param_name_txt; "Update"; "Leave as is")

If (OK=1)
	ut_SaveSysParam($Param_name_txt; $TheDom_txt; "D")
End if 

C_TEXT:C284($Tree_txt; $TheDom_txt; $Param_name_txt)
$Param_name_txt:="NTI_REVIEWPERMS"
$Tree_txt:=DOM Create XML Ref:C861($Param_name_txt)
C_LONGINT:C283($Dist_L)
For ($Dist_L; 1; 6)
	$Type_txt:=DOM Create XML element:C865($Tree_txt; "INSPRESP")
	$Group_txt:=DOM Create XML element:C865($Type_txt; "DBIEGRP")
	DOM SET XML ELEMENT VALUE:C868($Group_txt; "TunnelInspEngD"+String:C10($Dist_L))
	$Group_txt:=DOM Create XML element:C865($Type_txt; "AreaGRP")
	DOM SET XML ELEMENT VALUE:C868($Group_txt; "TunnelEngineerD"+String:C10($Dist_L))
	
	DOM SET XML ELEMENT VALUE:C868($Type_txt; "DIST"+String:C10($Dist_L))
	
End for 

DOM EXPORT TO VAR:C863($Tree_txt; $TheDom_txt)

DOM CLOSE XML:C722($Tree_txt)
CONFIRM:C162("Update database parameter "+$Param_name_txt; "Update"; "Leave as is")

If (OK=1)
	ut_SaveSysParam($Param_name_txt; $TheDom_txt; "D")
	
End if 

C_TEXT:C284($Tree_txt; $TheDom_txt; $Param_name_txt)
$Param_name_txt:="NTI_CSWTFACTORS"
$Tree_txt:=DOM Create XML Ref:C861($Param_name_txt)
ARRAY REAL:C219($CsWeights_ar; 4)
$CsWeights_ar{1}:=8.5
$CsWeights_ar{2}:=6.5
$CsWeights_ar{3}:=5.5
$CsWeights_ar{4}:=3.5

C_LONGINT:C283($Dist_L)
For ($Dist_L; 1; 4)
	$Type_txt:=DOM Create XML element:C865($Tree_txt; "CS"+String:C10($Dist_L))
	DOM SET XML ELEMENT VALUE:C868($Type_txt; $Dist_L)
	DOM SET XML ATTRIBUTE:C866($Type_txt; "WEIGHT"; $CsWeights_ar{$Dist_L})
	
End for 

DOM EXPORT TO VAR:C863($Tree_txt; $TheDom_txt)
DOM CLOSE XML:C722($Tree_txt)

CONFIRM:C162("Update database parameter "+$Param_name_txt; "Update"; "Leave as is")

If (Ok=1)
	ut_SaveSysParam($Param_name_txt; $TheDom_txt; "D")
End if 

//End NTI_CreateParams