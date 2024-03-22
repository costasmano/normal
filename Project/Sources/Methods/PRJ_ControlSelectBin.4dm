//%attributes = {"invisible":true}
// ----------------------------------------------------
// PRJ_ControlSelectBin
// User name (OS): cjmiller
// Date and time: 11/27/07, 11:22:55
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2007_CJM_v54  //r003 `11/27/07, 11:22:56
End if 
C_TEXT:C284($search_txt)
$search_txt:=PRJ_DEBin_s+"@"
QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=$search_txt)
Case of 
	: (Records in selection:C76([Bridge MHD NBIS:1])=0)
		ALERT:C41("No bridge found for this bin")
		GOTO OBJECT:C206(PRJ_DEBin_s)
	: (Records in selection:C76([Bridge MHD NBIS:1])=1)
		PRJ_OneBridgeFound
		PRJ_LoadPage2Bins
		PRJ_SetEntryCheckBoxes
		If (False:C215)
			[PRJ_ProjectDetails:115]PRJ_NonBridge_s:7:=""
			PRJ_DEBridgeNo_s:=[Bridge MHD NBIS:1]BDEPT:1
			PRJ_AdditionalBridges
			[PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5:=PRJ_DEBridgeNo_s
			[PRJ_ProjectDetails:115]PRJ_CityOrTown_s:8:=Get_Town_Name(Substring:C12([PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5; 1; 6))
			OBJECT SET ENTERABLE:C238([PRJ_ProjectDetails:115]PRJ_CityOrTown_s:8; False:C215)
			OBJECT SET RGB COLORS:C628([PRJ_ProjectDetails:115]PRJ_CityOrTown_s:8; Col_paletteToRGB(Abs:C99(<>PRJ_Color_Not_editable)%256); Col_paletteToRGB(Abs:C99(<>PRJ_Color_Not_editable)\256))  // **Replaced o OBJECT SET COLOR([PRJ_ProjectDetails]PRJ_CityOrTown_s; <>PRJ_Color_Not_editable)
		End if 
		PRJ_BD_BuildBrgDataShtList
	Else 
		C_LONGINT:C283(<>ProjectSelectionProcess_l)
		<>SelectionOption_txt:="Bridge"
		<>ProjectProcess_l:=Current process:C322
		<>PRJ_SelectedData_txt:=PRJ_DEBridgeNo_s
		PRJ_StartOrResumeProjSelection
End case 

//End PRJ_ControlSelectBin