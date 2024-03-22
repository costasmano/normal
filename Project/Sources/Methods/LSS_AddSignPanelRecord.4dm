//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 04/16/15, 16:04:30
//----------------------------------------------------
//Method: LSS_AddSignPanelRecord
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (4/16/15 16:04:31)
	// Modified by: Costas Manousakis-(Designer)-(5/16/16 11:35:17)
	Mods_2016_05_bug
	//  `order by Panel_s
	Mods_2017_06_bug  ////Fix error where errors occur and tranaction not cancelled
	//Modified by: Chuck Miller (6/21/17 13:44:29)
End if 
FORM SET INPUT:C55([LSS_SignPanel:172]; "Input")
//C_LONGINT($Width_L;$Height_l)
//GET FORM PROPERTIES([LSS_SignPanel];"Input";$Width_L;$Height_l)
//ut_OpenNewWindow ($Width_L;$Height_l;0;Plain window )
C_LONGINT:C283($wl; $wt; $wr; $wb; $ol; $ot; $or; $ob; $olt; $ott; $ort; $obt; $olr; $otr; $orr; $obr)
GET WINDOW RECT:C443($wl; $wt; $wr; $wb)

OBJECT GET COORDINATES:C663(*; "LSS_InpectionTabs_as"; $olt; $ott; $ort; $obt)

ADD RECORD:C56([LSS_SignPanel:172])
SET WINDOW RECT:C444($wl; $wt; $wr; $wb)
OBJECT GET COORDINATES:C663(*; "LSS_InpectionTabs_as"; $wl; $wt; $wr; $wb)

OBJECT MOVE:C664(*; "LSS_InpectionTabs_as"; 0; 0; $ort-$wr; $obt-$wb)

//LSS_ControlModification (->[LSS_SignPanel];"Input")

QUERY:C277([LSS_SignPanel:172]; [LSS_SignPanel:172]LSS_InspectionId_s:2=[LSS_Inspection:164]LSS_InspectionId_s:1)
ORDER BY:C49([LSS_SignPanel:172]; [LSS_SignPanel:172]LSS_Panel_s:3; >)
LSS_SetSaveandDelete

//End LSS_AddSignPanelRecord