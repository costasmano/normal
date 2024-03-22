//%attributes = {"invisible":true}
//Method: PRV_ut_defReviewTypes
//Description
//  ` Define and xml tree with the Review types and some associated attributes
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/06/12, 09:44:41
	// ----------------------------------------------------
	//Created : 
	Mods_2012_06
End if 
//
C_TEXT:C284(vsforward)  // Command Replaced was o_C_STRING length was 80
C_TEXT:C284($Tree_txt; $ReviewType_txt; $TheDom_txt)
$Tree_txt:=DOM Create XML Ref:C861("PRV_ReviewTypes")
$ReviewType_txt:=DOM Create XML element:C865($Tree_txt; "STR25")
DOM SET XML ELEMENT VALUE:C868($ReviewType_txt; "25% Structural Review")
$ReviewType_txt:=DOM Create XML element:C865($Tree_txt; "HWY25")
DOM SET XML ELEMENT VALUE:C868($ReviewType_txt; "25% Highway Review")
$ReviewType_txt:=DOM Create XML element:C865($Tree_txt; "STR90")
DOM SET XML ELEMENT VALUE:C868($ReviewType_txt; "90% Structural Review")
$ReviewType_txt:=DOM Create XML element:C865($Tree_txt; "HWY75")
DOM SET XML ELEMENT VALUE:C868($ReviewType_txt; "75% Highway Review")
$ReviewType_txt:=DOM Create XML element:C865($Tree_txt; "FINALPSE")
DOM SET XML ELEMENT VALUE:C868($ReviewType_txt; "25% Structural Review")
$ReviewType_txt:=DOM Create XML element:C865($Tree_txt; "FINALPSEASST")
DOM SET XML ELEMENT VALUE:C868($ReviewType_txt; "25% Structural Review")
$ReviewType_txt:=DOM Create XML element:C865($Tree_txt; "ROW")
DOM SET XML ELEMENT VALUE:C868($ReviewType_txt; "Right of Way (R.O.W.)")
DOM SET XML ATTRIBUTE:C866($ReviewType_txt; "CERT"; True:C214; "SENDTO"; "R.O.W."; "SUBMRCD"; False:C215)
$ReviewType_txt:=DOM Create XML element:C865($Tree_txt; "ENV")
DOM SET XML ELEMENT VALUE:C868($ReviewType_txt; "Enviromental")
DOM SET XML ATTRIBUTE:C866($ReviewType_txt; "CERT"; True:C214; "SENDTO"; "Enviromental"; "SUBMRCD"; False:C215; "CERTTYPE"; True:C214)
$ReviewType_txt:=DOM Create XML element:C865($Tree_txt; "TRA")
DOM SET XML ELEMENT VALUE:C868($ReviewType_txt; "Traffic T.M.P.")
DOM SET XML ATTRIBUTE:C866($ReviewType_txt; "SENDTO"; "Traffic"; "SUBMRCD"; "FALSE")
$ReviewType_txt:=DOM Create XML element:C865($Tree_txt; "CONSTR")
DOM SET XML ELEMENT VALUE:C868($ReviewType_txt; "Construction")
DOM SET XML ATTRIBUTE:C866($ReviewType_txt; "CERT"; False:C215; "SENDTO"; "Construction"; "SUBMRCD"; False:C215)
$ReviewType_txt:=DOM Create XML element:C865($Tree_txt; "OTHER")
DOM SET XML ELEMENT VALUE:C868($ReviewType_txt; "OTHER")
$ReviewType_txt:=DOM Create XML element:C865($Tree_txt; "FHWA")
DOM SET XML ELEMENT VALUE:C868($ReviewType_txt; "FHWA Review")
DOM SET XML ATTRIBUTE:C866($ReviewType_txt; "SENDTO"; "FHWA"; "SUBMRCD"; False:C215)
DOM EXPORT TO VAR:C863($Tree_txt; $TheDom_txt)

QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="PRV_REVIEWTYPEDESCXM")
If (Records in selection:C76([Parameters:107])=1)
	If (ut_LoadRecordInteractiveV2(->[Parameters:107])=1)
		[Parameters:107]Description:2:=$TheDom_txt
		LogChanges(->[Parameters:107]Description:2; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; 0)
		SAVE RECORD:C53([Parameters:107])
	End if 
Else 
	CREATE RECORD:C68([Parameters:107])
	[Parameters:107]ParamCode:1:="PRV_REVIEWTYPEDESCXM"
	[Parameters:107]Description:2:=$TheDom_txt
	LogNewRecord(->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; 0; "")
	LogChanges(->[Parameters:107]Description:2; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; ->[Parameters:107]ParamCode:1; 0)
	SAVE RECORD:C53([Parameters:107])
End if 

DOM CLOSE XML:C722($Tree_txt)
//End PRV_ut_defReviewTypes