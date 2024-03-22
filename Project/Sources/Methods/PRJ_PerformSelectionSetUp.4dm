//%attributes = {"invisible":true}
// ----------------------------------------------------
// PRJ_PerformSelectionSetUp
// User name (OS): cjmiller
// Date and time: 01/19/06, 12:00:38
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
End if 
ARRAY TEXT:C222(PRJ_Item1_atxt; 0)
ARRAY TEXT:C222(PRJ_Item2_atxt; 0)
ARRAY TEXT:C222(PRJ_Item3_atxt; 0)
ARRAY TEXT:C222(PRJ_Item4_atxt; 0)
ARRAY TEXT:C222(PRJ_ItemDescription_atxt; 0)
RESUME PROCESS:C320(Current process:C322)
SHOW PROCESS:C325(Current process:C322)
BRING TO FRONT:C326(Current process:C322)

Case of 
	: (<>SelectionOption_txt="Bridge")
		SET WINDOW TITLE:C213("Select Bridge")
		PRJ_GetSelectedBridges
	: (<>SelectionOption_txt="FederalAid")
		SET WINDOW TITLE:C213("Select Federal Aid")
		PRJ_GetTableofListsSelection("FederalAid")
		
	: (<>SelectionOption_txt="Program")
		SET WINDOW TITLE:C213("Select Program")
		PRJ_GetTableofListsSelection("Program")
		
	: (<>SelectionOption_txt="ProjectFile")
		SET WINDOW TITLE:C213("Select Project Fiile")
		PRJ_GetSelectedProjectFiles
End case 


//End PRJ_PerformSelectionSetUp