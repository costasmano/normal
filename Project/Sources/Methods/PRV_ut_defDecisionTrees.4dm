//%attributes = {"invisible":true}
//Method: PRV_ut_defDecisionTrees
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 08/22/12, 08:54:43
	// ----------------------------------------------------
	//Created : 
	Mods_2012_08
	// Modified by: Costas Manousakis-(Designer)-(9/25/13 15:02:54)
	Mods_2013_09
	//  `Copied to DEV
	
End if 
//

C_TEXT:C284(vsforward)  // Command Replaced was o_C_STRING length was 80
C_TEXT:C284($Tree_txt; $RowTree_txt; $TheDom_txt)
$Tree_txt:=DOM Create XML Ref:C861("PRV_ADTTable")
$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "Row")
DOM SET XML ATTRIBUTE:C866($RowTree_txt; "HighLimit"; 999; "ValueLimit"; 1)
$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "Row")
DOM SET XML ATTRIBUTE:C866($RowTree_txt; "HighLimit"; 4999; "ValueLimit"; 2)
$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "Row")
DOM SET XML ATTRIBUTE:C866($RowTree_txt; "HighLimit"; 9999; "ValueLimit"; 3)
$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "Row")
DOM SET XML ATTRIBUTE:C866($RowTree_txt; "HighLimit"; 19999; "ValueLimit"; 4)
$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "Row")
DOM SET XML ATTRIBUTE:C866($RowTree_txt; "HighLimit"; 999999; "ValueLimit"; 5)
DOM EXPORT TO VAR:C863($Tree_txt; $TheDom_txt)

QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="PRV_ADTTABLE")
If (Records in selection:C76([Parameters:107])=1)
	If (ut_LoadRecordInteractiveV2(->[Parameters:107])=1)
		[Parameters:107]Description:2:=$TheDom_txt
		LogChanges(->[Parameters:107]Description:2; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; 0)
		SAVE RECORD:C53([Parameters:107])
	End if 
Else 
	CREATE RECORD:C68([Parameters:107])
	[Parameters:107]ParamCode:1:="PRV_ADTTABLE"
	[Parameters:107]Description:2:=$TheDom_txt
	LogNewRecord(->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; 0; "")
	LogChanges(->[Parameters:107]Description:2; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; 0)
	SAVE RECORD:C53([Parameters:107])
End if 

DOM CLOSE XML:C722($Tree_txt)

$Tree_txt:=DOM Create XML Ref:C861("PRV_DetourTable")
$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "Row")
DOM SET XML ATTRIBUTE:C866($RowTree_txt; "HighLimit"; 1; "ValueLimit"; 1)
$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "Row")
DOM SET XML ATTRIBUTE:C866($RowTree_txt; "HighLimit"; 3; "ValueLimit"; 2)
$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "Row")
DOM SET XML ATTRIBUTE:C866($RowTree_txt; "HighLimit"; 5; "ValueLimit"; 3)
$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "Row")
DOM SET XML ATTRIBUTE:C866($RowTree_txt; "HighLimit"; 9; "ValueLimit"; 4)
$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "Row")
DOM SET XML ATTRIBUTE:C866($RowTree_txt; "HighLimit"; 999999; "ValueLimit"; 5)
DOM EXPORT TO VAR:C863($Tree_txt; $TheDom_txt)

QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="PRV_DetourTable")
If (Records in selection:C76([Parameters:107])=1)
	If (ut_LoadRecordInteractiveV2(->[Parameters:107])=1)
		[Parameters:107]Description:2:=$TheDom_txt
		LogChanges(->[Parameters:107]Description:2; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; 0)
		SAVE RECORD:C53([Parameters:107])
	End if 
Else 
	CREATE RECORD:C68([Parameters:107])
	[Parameters:107]ParamCode:1:="PRV_DetourTable"
	[Parameters:107]Description:2:=$TheDom_txt
	LogNewRecord(->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; 0; "")
	LogChanges(->[Parameters:107]Description:2; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; 0)
	SAVE RECORD:C53([Parameters:107])
End if 

DOM CLOSE XML:C722($Tree_txt)

$Tree_txt:=DOM Create XML Ref:C861("PRV_ClassTable")
$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "Row")
DOM SET XML ATTRIBUTE:C866($RowTree_txt; "CodeList"; "09,19"; "ValueLimit"; 1)
$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "Row")
DOM SET XML ATTRIBUTE:C866($RowTree_txt; "CodeList"; "08"; "ValueLimit"; 2)
$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "Row")
DOM SET XML ATTRIBUTE:C866($RowTree_txt; "CodeList"; "07,17"; "ValueLimit"; 3)
$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "Row")
DOM SET XML ATTRIBUTE:C866($RowTree_txt; "CodeList"; "06,16"; "ValueLimit"; 4)
$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "Row")
DOM SET XML ATTRIBUTE:C866($RowTree_txt; "CodeList"; "01,02,03,11,12,14"; "ValueLimit"; 5)
DOM EXPORT TO VAR:C863($Tree_txt; $TheDom_txt)

QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="PRV_ClassTable")
If (Records in selection:C76([Parameters:107])=1)
	If (ut_LoadRecordInteractiveV2(->[Parameters:107])=1)
		[Parameters:107]Description:2:=$TheDom_txt
		LogChanges(->[Parameters:107]Description:2; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; 0)
		SAVE RECORD:C53([Parameters:107])
	End if 
Else 
	CREATE RECORD:C68([Parameters:107])
	[Parameters:107]ParamCode:1:="PRV_ClassTable"
	[Parameters:107]Description:2:=$TheDom_txt
	LogNewRecord(->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; 0; "")
	LogChanges(->[Parameters:107]Description:2; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; 0)
	SAVE RECORD:C53([Parameters:107])
End if 

DOM CLOSE XML:C722($Tree_txt)

$Tree_txt:=DOM Create XML Ref:C861("PRV_FormulaFactors")
$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "ADTFactor")
DOM SET XML ELEMENT VALUE:C868($RowTree_txt; 0.3333333)
$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "DetourFactor")
DOM SET XML ELEMENT VALUE:C868($RowTree_txt; 0.3333333)
$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "ClassFactor")
DOM SET XML ELEMENT VALUE:C868($RowTree_txt; 0.3333333)
$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "EmergReplPoints")
DOM SET XML ELEMENT VALUE:C868($RowTree_txt; 2)
$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "ActiveRRPoints")
DOM SET XML ELEMENT VALUE:C868($RowTree_txt; 2)
$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "EvacRoutePoints")
DOM SET XML ELEMENT VALUE:C868($RowTree_txt; 1)
$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "EmergReplFactor")
DOM SET XML ELEMENT VALUE:C868($RowTree_txt; 1)
$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "ActiveRRFactor")
DOM SET XML ELEMENT VALUE:C868($RowTree_txt; 1)
$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "EvacRouteFactor")
DOM SET XML ELEMENT VALUE:C868($RowTree_txt; 1)
$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "HWYEvalFactor")
DOM SET XML ELEMENT VALUE:C868($RowTree_txt; (0.6*2))
$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "OtherFactor")
DOM SET XML ELEMENT VALUE:C868($RowTree_txt; (0.4*2))
DOM EXPORT TO VAR:C863($Tree_txt; $TheDom_txt)

QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="PRV_FormulaFactors")
If (Records in selection:C76([Parameters:107])=1)
	If (ut_LoadRecordInteractiveV2(->[Parameters:107])=1)
		[Parameters:107]Description:2:=$TheDom_txt
		LogChanges(->[Parameters:107]Description:2; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; 0)
		SAVE RECORD:C53([Parameters:107])
	End if 
Else 
	CREATE RECORD:C68([Parameters:107])
	[Parameters:107]ParamCode:1:="PRV_FormulaFactors"
	[Parameters:107]Description:2:=$TheDom_txt
	LogNewRecord(->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; 0; "")
	LogChanges(->[Parameters:107]Description:2; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; 0)
	SAVE RECORD:C53([Parameters:107])
End if 

DOM CLOSE XML:C722($Tree_txt)
C_TEXT:C284($Recomment_txt)

$Tree_txt:=DOM Create XML Ref:C861("PRV_Recommend")
$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "Choise")
$Recomment_txt:="Use Conventional/Traditional construction method"
DOM SET XML ELEMENT VALUE:C868($RowTree_txt; $Recomment_txt)
$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "Choise")
$Recomment_txt:="Strongly Consider Prefab. Construction and/or Accelerated Procurement Methods"
DOM SET XML ELEMENT VALUE:C868($RowTree_txt; $Recomment_txt)
$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "Choise")
$Recomment_txt:="Strongly Consider Accelerated Construction Techniques (ABC) and/or Procurement Methods (i.e. SPMT, Heavy Lift Cranes, Sliding, etc.)"
DOM SET XML ELEMENT VALUE:C868($RowTree_txt; $Recomment_txt)

DOM EXPORT TO VAR:C863($Tree_txt; $TheDom_txt)

QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="PRV_Recommend")
If (Records in selection:C76([Parameters:107])=1)
	If (ut_LoadRecordInteractiveV2(->[Parameters:107])=1)
		[Parameters:107]Description:2:=$TheDom_txt
		LogChanges(->[Parameters:107]Description:2; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; 0)
		SAVE RECORD:C53([Parameters:107])
	End if 
Else 
	CREATE RECORD:C68([Parameters:107])
	[Parameters:107]ParamCode:1:="PRV_Recommend"
	[Parameters:107]Description:2:=$TheDom_txt
	LogNewRecord(->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; 0; "")
	LogChanges(->[Parameters:107]Description:2; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; 0)
	SAVE RECORD:C53([Parameters:107])
End if 

DOM CLOSE XML:C722($Tree_txt)
C_LONGINT:C283($color_L)
$Tree_txt:=DOM Create XML Ref:C861("PRV_AssignColors")
$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "Color")
$color_L:=16776960
$color_L:=Select RGB color:C956($color_L; "Yellow")
DOM SET XML ATTRIBUTE:C866($RowTree_txt; "Name"; "Yellow"; "Value"; $color_L)
$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "Color")
$color_L:=16748288
$color_L:=Select RGB color:C956($color_L; "Orange")
DOM SET XML ATTRIBUTE:C866($RowTree_txt; "Name"; "Orange"; "Value"; $color_L)
$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "Color")
$color_L:=16726073
$color_L:=Select RGB color:C956($color_L; "Red")
DOM SET XML ATTRIBUTE:C866($RowTree_txt; "Name"; "Red"; "Value"; $color_L)
$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "Color")
$color_L:=65280
$color_L:=Select RGB color:C956($color_L; "Green")
DOM SET XML ATTRIBUTE:C866($RowTree_txt; "Name"; "Green"; "Value"; $color_L)
$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "Color")
$color_L:=16777215
$color_L:=Select RGB color:C956($color_L; "None")
DOM SET XML ATTRIBUTE:C866($RowTree_txt; "Name"; "None"; "Value"; $color_L)

DOM EXPORT TO VAR:C863($Tree_txt; $TheDom_txt)

QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="PRV_AssignColors")
If (Records in selection:C76([Parameters:107])=1)
	If (ut_LoadRecordInteractiveV2(->[Parameters:107])=1)
		[Parameters:107]Description:2:=$TheDom_txt
		LogChanges(->[Parameters:107]Description:2; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; 0)
		SAVE RECORD:C53([Parameters:107])
	End if 
Else 
	CREATE RECORD:C68([Parameters:107])
	[Parameters:107]ParamCode:1:="PRV_AssignColors"
	[Parameters:107]Description:2:=$TheDom_txt
	LogNewRecord(->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; 0; "")
	LogChanges(->[Parameters:107]Description:2; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; 0)
	SAVE RECORD:C53([Parameters:107])
End if 

DOM CLOSE XML:C722($Tree_txt)

$Tree_txt:=DOM Create XML Ref:C861("PRV_ProjectStatus")
$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "Status")
DOM SET XML ATTRIBUTE:C866($RowTree_txt; "Name"; "Initial Field visit done")
$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "Status")
DOM SET XML ATTRIBUTE:C866($RowTree_txt; "Name"; "Initial Scope & Estimate done")
$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "Status")
DOM SET XML ATTRIBUTE:C866($RowTree_txt; "Name"; "Waiting for PRC approval")
$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "Status")
DOM SET XML ATTRIBUTE:C866($RowTree_txt; "Name"; "Waiting for field visit with Consultant")
$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "Status")
DOM SET XML ATTRIBUTE:C866($RowTree_txt; "Name"; "Waiting for Consultant Scope & Estimate")
$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "Status")
DOM SET XML ATTRIBUTE:C866($RowTree_txt; "Name"; "Waiting for 25% Review by Dist.")
$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "Status")
DOM SET XML ATTRIBUTE:C866($RowTree_txt; "Name"; "Waiting for 25% Dists Review Comments by Pres. Reviewer")
$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "Status")
DOM SET XML ATTRIBUTE:C866($RowTree_txt; "Name"; "Waiting for 75-90%")
$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "Status")
DOM SET XML ATTRIBUTE:C866($RowTree_txt; "Name"; "Waiting for 75-90% Review by Dist.")
$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "Status")
DOM SET XML ATTRIBUTE:C866($RowTree_txt; "Name"; "Waiting for 75-90% Dist's Review Comments by Pres. Reviewer")
$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "Status")
DOM SET XML ATTRIBUTE:C866($RowTree_txt; "Name"; "Waiting for FHWA Apporval")
$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "Status")
DOM SET XML ATTRIBUTE:C866($RowTree_txt; "Name"; "Waiting for Final PS&E")
$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "Status")
DOM SET XML ATTRIBUTE:C866($RowTree_txt; "Name"; "Waiting for Final PS&E Review by District")
$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "Status")
DOM SET XML ATTRIBUTE:C866($RowTree_txt; "Name"; "Waiting for Final PS&E Review by Pres. Reviewer")
$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "Status")
DOM SET XML ATTRIBUTE:C866($RowTree_txt; "Name"; "Waiting for Mylar")
$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "Status")
DOM SET XML ATTRIBUTE:C866($RowTree_txt; "Name"; "Waiting for Advertisement")
$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "Status")
DOM SET XML ATTRIBUTE:C866($RowTree_txt; "Name"; "Advertised")
$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "Status")
DOM SET XML ATTRIBUTE:C866($RowTree_txt; "Name"; "Other:")

DOM EXPORT TO VAR:C863($Tree_txt; $TheDom_txt)

QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="PRV_ProjectStatus")
If (Records in selection:C76([Parameters:107])=1)
	If (ut_LoadRecordInteractiveV2(->[Parameters:107])=1)
		[Parameters:107]Description:2:=$TheDom_txt
		LogChanges(->[Parameters:107]Description:2; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; 0)
		SAVE RECORD:C53([Parameters:107])
	End if 
Else 
	CREATE RECORD:C68([Parameters:107])
	[Parameters:107]ParamCode:1:="PRV_ProjectStatus"
	[Parameters:107]Description:2:=$TheDom_txt
	LogNewRecord(->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; 0; "")
	LogChanges(->[Parameters:107]Description:2; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; 0)
	SAVE RECORD:C53([Parameters:107])
End if 

DOM CLOSE XML:C722($Tree_txt)

$Tree_txt:=DOM Create XML Ref:C861("PRV_LateActions")
$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "Action")
DOM SET XML ATTRIBUTE:C866($RowTree_txt; "Name"; "EMailed DBE")
$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "Action")
DOM SET XML ATTRIBUTE:C866($RowTree_txt; "Name"; "Emailed P.M.")
$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "Action")
DOM SET XML ATTRIBUTE:C866($RowTree_txt; "Name"; "Emailed Preservation Reviewer")
$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "Action")
DOM SET XML ATTRIBUTE:C866($RowTree_txt; "Name"; "Emailed Scoping Engineer")
$RowTree_txt:=DOM Create XML element:C865($Tree_txt; "Action")
DOM SET XML ATTRIBUTE:C866($RowTree_txt; "Name"; "Other:")

DOM EXPORT TO VAR:C863($Tree_txt; $TheDom_txt)

QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="PRV_LateActions")
If (Records in selection:C76([Parameters:107])=1)
	If (ut_LoadRecordInteractiveV2(->[Parameters:107])=1)
		[Parameters:107]Description:2:=$TheDom_txt
		LogChanges(->[Parameters:107]Description:2; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; 0)
		SAVE RECORD:C53([Parameters:107])
	End if 
Else 
	CREATE RECORD:C68([Parameters:107])
	[Parameters:107]ParamCode:1:="PRV_LateActions"
	[Parameters:107]Description:2:=$TheDom_txt
	LogNewRecord(->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; 0; "")
	LogChanges(->[Parameters:107]Description:2; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; 0)
	SAVE RECORD:C53([Parameters:107])
End if 

DOM CLOSE XML:C722($Tree_txt)

//End PRV_ut_defDecisionTrees