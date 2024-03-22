//Method: Form Method: [LSS_Inventory];'CustomSearch"
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/22/15, 13:59:19
	// ----------------------------------------------------
	//Created : 
	Mods_2015_05
	
	// Modified by: Costas Manousakis-(Designer)-(1/28/16 21:03:04)
	Mods_2016_01_bug
	//  `replaced LSS_Townname_atxt , etc with  variables aTownName_, ◊aBDEPT, ◊aDistrict
	// Modified by: Costas Manousakis-(Designer)-(5/13/16 16:21:57)
	Mods_2016_05_bug
	//  `added check box for route suffix
	
End if 
//
Case of 
	: (Form event code:C388=On Load:K2:1)
		utl_SetSpellandContextMenu
		
		OBJECT SET ENABLED:C1123(*; "LSS_DoneSearch"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		COPY ARRAY:C226(<>aTownName; aTownName_)
		aTownName_:=-1
		LSS_StructureClass_atxt:=-1
		LSS_RouteDesignation_atxt:=-1
		LSS_RouteDirection_as:=-1
		LSS_SearchDistr_aL:=-1
		LSS_SearchTwnCode_txt:=""
		LSS_SearchRouteNum_L:=0
		LSS_SearchStartMile_r:=0
		LSS_SearchEndMile_r:=0
		LSS_SearchSIN_L:=0
		LSS_SearchNumFound_L:=0
		LSS_SearchStrClass_txt:=""
		LSS_SearchRoutType_txt:=""
		LSS_SearchRoutDir_txt:=""
		LSS_RouteSuffix_L:=0
		
	: (Form event code:C388=On Validate:K2:3)
		
End case 

//End Form Method: [LSS_Inventory]CustomSearch