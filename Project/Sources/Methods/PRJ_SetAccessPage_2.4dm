//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// PRJ_SetAccessPage_2
	// User name (OS): cjmiller
	// Date and time: 05/16/07, 12:24:27
	// ----------------------------------------------------
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2007_CJMv2  //r060   `05/16/07, 12:24:52` `Add code to control access 
	Mods_2007_CJM_v5303  //r004  `Code to account access to consultant inputs
	// Modified by: costasmanousakis-(Designer)-(6/29/08 10:09:35)
	Mods_2008_CM_5404  //for Access allowed enable the PRJ_BridgeSection_atxt button
End if 

OBJECT SET ENTERABLE:C238(*; "PRJ_DataEntry@"; False:C215)
OBJECT SET RGB COLORS:C628(*; "PRJ_DataEntry@"; Col_paletteToRGB(Abs:C99(<>PRJ_Color_Not_editable)%256); Col_paletteToRGB(Abs:C99(<>PRJ_Color_Not_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "PRJ_DataEntry@"; <>PRJ_Color_Not_editable)
C_BOOLEAN:C305($AccessAllowed_b)
$AccessAllowed_b:=PRJ_ReturnAccessAllowed
OBJECT SET ENABLED:C1123(PRJ_BridgeSection_atxt; False:C215)  // Command Replaced was o_DISABLE BUTTON 
OBJECT SET ENTERABLE:C238([PRJ_ProjectDetails:115]PRJ_RatingRequest_d:38; False:C215)
OBJECT SET RGB COLORS:C628([PRJ_ProjectDetails:115]PRJ_RatingRequest_d:38; Col_paletteToRGB(Abs:C99(<>PRJ_Color_Not_editable)%256); Col_paletteToRGB(Abs:C99(<>PRJ_Color_Not_editable)\256))  // **Replaced o OBJECT SET COLOR([PRJ_ProjectDetails]PRJ_RatingRequest_d; <>PRJ_Color_Not_editable)

If ($AccessAllowed_b)
	OBJECT SET ENTERABLE:C238(*; "PRJ_DataEntry@"; True:C214)
	OBJECT SET RGB COLORS:C628(*; "PRJ_DataEntry@"; Col_paletteToRGB(Abs:C99(<>PRJ_Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>PRJ_Color_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "PRJ_DataEntry@"; <>PRJ_Color_Editable)
	If (PRJ_DEBridgeNo_s="")
		OBJECT SET VISIBLE:C603(PRJ_AllowBridgeEntry_l; False:C215)
		OBJECT SET ENTERABLE:C238(PRJ_DEBridgeNo_s; True:C214)
		OBJECT SET RGB COLORS:C628(PRJ_DEBridgeNo_s; Col_paletteToRGB(Abs:C99(<>PRJ_Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>PRJ_Color_Editable)\256))  // **Replaced o OBJECT SET COLOR(PRJ_DEBridgeNo_s; <>PRJ_Color_Editable)
		OBJECT SET VISIBLE:C603(*; "PRJ_BridgeButton"; True:C214)
	Else 
		OBJECT SET ENTERABLE:C238(PRJ_DEBridgeNo_s; False:C215)
		OBJECT SET VISIBLE:C603(PRJ_AllowBridgeEntry_l; True:C214)
		OBJECT SET RGB COLORS:C628(PRJ_DEBridgeNo_s; Col_paletteToRGB(Abs:C99(<>PRJ_Color_Not_editable)%256); Col_paletteToRGB(Abs:C99(<>PRJ_Color_Not_editable)\256))  // **Replaced o OBJECT SET COLOR(PRJ_DEBridgeNo_s; <>PRJ_Color_Not_editable)
		OBJECT SET VISIBLE:C603(*; "PRJ_BridgeButton"; False:C215)
	End if 
	OBJECT SET ENABLED:C1123(PRJ_BridgeSection_atxt; True:C214)  // Command Replaced was o_ENABLE BUTTON 
	OBJECT SET ENTERABLE:C238([PRJ_ProjectDetails:115]PRJ_RatingRequest_d:38; True:C214)
	OBJECT SET RGB COLORS:C628([PRJ_ProjectDetails:115]PRJ_RatingRequest_d:38; Col_paletteToRGB(Abs:C99(<>PRJ_Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>PRJ_Color_Editable)\256))  // **Replaced o OBJECT SET COLOR([PRJ_ProjectDetails]PRJ_RatingRequest_d; <>PRJ_Color_Editable)
	
End if 
PRJ_SetUpFederalReview($AccessAllowed_b)


If (Size of array:C274(PRJ_SelectedBins_as)>0) | ([PRJ_ProjectDetails:115]PRJ_PrimaryBin_s:34#"")
	OBJECT SET VISIBLE:C603(*; "AllowBinEntry1"; False:C215)
	OBJECT SET VISIBLE:C603(*; "PRJ_DataEntry1"; False:C215)
	OBJECT SET VISIBLE:C603(*; "SelPrimaryBin@"; True:C214)
Else 
	OBJECT SET VISIBLE:C603(*; "AllowBinEntry@"; True:C214)
	OBJECT SET VISIBLE:C603(*; "PRJ_DataEntry1"; True:C214)
	OBJECT SET VISIBLE:C603(*; "SelPrimaryBin@"; False:C215)
	OBJECT SET ENTERABLE:C238(PRJ_DEBin_s; False:C215)
	OBJECT SET RGB COLORS:C628(PRJ_DEBin_s; Col_paletteToRGB(Abs:C99(<>PRJ_Color_Not_editable)%256); Col_paletteToRGB(Abs:C99(<>PRJ_Color_Not_editable)\256))  // **Replaced o OBJECT SET COLOR(PRJ_DEBin_s; <>PRJ_Color_Not_editable)
End if 

If (PRJ_DEProjectFileNo_l=0)
	OBJECT SET VISIBLE:C603(PRJ_SelectByDesignContract_l; False:C215)
	OBJECT SET VISIBLE:C603(PRJ_AllowProjectEntry_l; False:C215)
	If ($AccessAllowed_b)
		OBJECT SET ENTERABLE:C238(PRJ_DEProjectFileNo_l; True:C214)
		OBJECT SET RGB COLORS:C628(PRJ_DEProjectFileNo_l; Col_paletteToRGB(Abs:C99(<>PRJ_Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>PRJ_Color_Editable)\256))  // **Replaced o OBJECT SET COLOR(PRJ_DEProjectFileNo_l; <>PRJ_Color_Editable)
		OBJECT SET VISIBLE:C603(*; "PRJ_ProjectFileButton"; True:C214)
		OBJECT SET VISIBLE:C603(PRJ_SelectByDesignContract_l; True:C214)
	End if 
Else 
	OBJECT SET ENTERABLE:C238(PRJ_DEProjectFileNo_l; False:C215)
	If ($AccessAllowed_b)
		OBJECT SET VISIBLE:C603(PRJ_AllowProjectEntry_l; True:C214)
	End if 
	OBJECT SET RGB COLORS:C628(PRJ_DEProjectFileNo_l; Col_paletteToRGB(Abs:C99(<>PRJ_Color_Not_editable)%256); Col_paletteToRGB(Abs:C99(<>PRJ_Color_Not_editable)\256))  // **Replaced o OBJECT SET COLOR(PRJ_DEProjectFileNo_l; <>PRJ_Color_Not_editable)
	OBJECT SET VISIBLE:C603(*; "PRJ_ProjectFileButton"; False:C215)
	OBJECT SET VISIBLE:C603(PRJ_SelectByDesignContract_l; False:C215)
End if 
If ($AccessAllowed_b)
	If ([PRJ_ProjectDetails:115]PRJ_PrimaryBin_s:34="")
		OBJECT SET ENTERABLE:C238([PRJ_ProjectDetails:115]PRJ_CityOrTown_s:8; True:C214)
		OBJECT SET RGB COLORS:C628([PRJ_ProjectDetails:115]PRJ_CityOrTown_s:8; Col_paletteToRGB(Abs:C99(<>PRJ_Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>PRJ_Color_Editable)\256))  // **Replaced o OBJECT SET COLOR([PRJ_ProjectDetails]PRJ_CityOrTown_s; <>PRJ_Color_Editable)
	Else 
		OBJECT SET ENTERABLE:C238([PRJ_ProjectDetails:115]PRJ_CityOrTown_s:8; False:C215)
		OBJECT SET RGB COLORS:C628([PRJ_ProjectDetails:115]PRJ_CityOrTown_s:8; Col_paletteToRGB(Abs:C99(<>PRJ_Color_Not_editable)%256); Col_paletteToRGB(Abs:C99(<>PRJ_Color_Not_editable)\256))  // **Replaced o OBJECT SET COLOR([PRJ_ProjectDetails]PRJ_CityOrTown_s; <>PRJ_Color_Not_editable)
	End if 
End if 
PRJ_SetAccessButtonsPage_2($AccessAllowed_b)
PRJ_SetChapter85Access($AccessAllowed_b)
//End PRJ_SetAccessPage_2