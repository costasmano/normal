// ----------------------------------------------------
// Form Method: ProjectDetails.new
// User name (OS): cjmiller
// Date and time: 11/20/07, 15:41:59
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2007_CJM_v54  //r002 `11/20/07, 15:42:02`Add record - made it so outside call is a method so add record form uses exact same call
	Mods_2007_CJM_v54  //r003 `11/27/07, 10:43:09`Make sure that bridge, proj file and consultant always editable
	// Modified by: Costas Manousakis-(Designer)-(2021-10-01T00:00:00 20:25:06)
	Mods_2021_10
	//  `do not resize window on Load
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		
		START TRANSACTION:C239
		PRJ_DEBridgeNo_s:=""
		PRJ_DEBin_s:=""
		PRJ_ConsultantName_txt:=""
		PRJ_DEProjectFileNo_l:=0
		Inc_Sequence("PRJ_ProjectID_l"; ->[PRJ_ProjectDetails:115]PRJ_ProjectID_l:1)
		OBJECT SET VISIBLE:C603(*; "NonBridgeTitle"; False:C215)
		C_LONGINT:C283($Width_l; $Height_l)
		FORM GET PROPERTIES:C674([PRJ_ProjectDetails:115]; "ProjectDetails.new"; $Width_l; $Height_l)
		
		//ut_ResizeWindow (Frontmost window;$Width_l+0;$Height_l+0)
		PRJ_SetUpPrimaryBinDD
		PRJ_SetAccessPage_2
		OBJECT SET ENTERABLE:C238(PRJ_DEBin_s; True:C214)
		OBJECT SET RGB COLORS:C628(PRJ_DEBin_s; Col_paletteToRGB(Abs:C99(<>PRJ_Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>PRJ_Color_Editable)\256))  // **Replaced o OBJECT SET COLOR(PRJ_DEBin_s; <>PRJ_Color_Editable)
		OBJECT SET ENABLED:C1123(PRJ_BridgeSection_atxt; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		ut_SetStringOrTextFilter(->PRJ_DEBridgeNo_s)
		ut_SetStringOrTextFilter(->PRJ_DEBin_s)
		ut_SetStringOrTextFilter(->PRJ_ConsultantName_txt)
		ut_SetStringOrTextFilter(->[PRJ_ProjectDetails:115]PRJ_CityOrTown_s:8)
		ut_SetStringOrTextFilter(->[PRJ_ProjectDetails:115]PRJ_FederalAid_s:25)
		ut_SetStringOrTextFilter(->[PRJ_ProjectDetails:115]PRJ_Program_s:23)
		
	: (Form event code:C388=On Outside Call:K2:11)
		PRJ_DetailOutsideCall
		OBJECT SET ENTERABLE:C238(PRJ_DEBridgeNo_s; True:C214)
		OBJECT SET RGB COLORS:C628(PRJ_DEBridgeNo_s; Col_paletteToRGB(Abs:C99(<>PRJ_Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>PRJ_Color_Editable)\256))  // **Replaced o OBJECT SET COLOR(PRJ_DEBridgeNo_s; <>PRJ_Color_Editable)
		If (PRJ_Chapter85_l#1)
			OBJECT SET ENTERABLE:C238(PRJ_DEProjectFileNo_l; True:C214)
			OBJECT SET RGB COLORS:C628(PRJ_DEProjectFileNo_l; Col_paletteToRGB(Abs:C99(<>PRJ_Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>PRJ_Color_Editable)\256))  // **Replaced o OBJECT SET COLOR(PRJ_DEProjectFileNo_l; <>PRJ_Color_Editable)
		Else 
			OBJECT SET RGB COLORS:C628(PRJ_ConsultantName_txt; Col_paletteToRGB(Abs:C99(<>PRJ_Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>PRJ_Color_Editable)\256))  // **Replaced o OBJECT SET COLOR(PRJ_ConsultantName_txt; <>PRJ_Color_Editable)
			OBJECT SET ENTERABLE:C238(PRJ_ConsultantName_txt; True:C214)
		End if 
End case 

//End Form Method: ProjectDetails.new