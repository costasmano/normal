//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 04/16/15, 16:05:12
//----------------------------------------------------
//Method: LSS_AddVerticalClearanceRecord
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (4/16/15 16:05:13)
	// Modified by: Costas Manousakis-(Designer)-(5/19/16 12:48:03)
	Mods_2016_05_bug
	//  `order by [LSS_VerticalClearance]LSS_Panel_txt
	Mods_2017_06_bug  ////Fix error where errors occur and tranaction not cancelled
	//Modified by: Chuck Miller (6/21/17 13:44:29)
End if 
FORM SET INPUT:C55([LSS_VerticalClearance:177]; "Input")
//C_LONGINT($Width_L;$Height_l)
//GET FORM PROPERTIES([LSS_VerticalClearance];"Input";$Width_L;$Height_l)
//ut_OpenNewWindow ($Width_L;$Height_l;0;Plain window )
C_LONGINT:C283($wl; $wt; $wr; $wb; $ol; $ot; $or; $ob; $olt; $ott; $ort; $obt; $olr; $otr; $orr; $obr)
GET WINDOW RECT:C443($wl; $wt; $wr; $wb)

OBJECT GET COORDINATES:C663(*; "LSS_InpectionTabs_as"; $olt; $ott; $ort; $obt)

ADD RECORD:C56([LSS_VerticalClearance:177])
SET WINDOW RECT:C444($wl; $wt; $wr; $wb)
OBJECT GET COORDINATES:C663(*; "LSS_InpectionTabs_as"; $wl; $wt; $wr; $wb)

OBJECT MOVE:C664(*; "LSS_InpectionTabs_as"; 0; 0; $ort-$wr; $obt-$wb)

QUERY:C277([LSS_VerticalClearance:177]; [LSS_VerticalClearance:177]LSS_InspectionId_s:2=[LSS_Inspection:164]LSS_InspectionId_s:1)
ORDER BY:C49([LSS_VerticalClearance:177]; [LSS_VerticalClearance:177]LSS_Panel_txt:3; >)
LSS_SetSaveandDelete
//End LSS_AddVerticalClearanceRecord