//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 04/16/15, 16:06:06
//----------------------------------------------------
//Method: LSS_AddTowerDistanceRecord
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (4/16/15 16:06:07)
	// Modified by: Costas Manousakis-(Designer)-(5/19/16 12:49:20)
	Mods_2016_05_bug
	//  `ORDER BY([LSS_TowerDistance];[LSS_TowerDistance]LSS_TowerOrPost_txt;>;[LSS_TowerDistance]LSS_SignPanel_s;>)
	Mods_2017_06_bug  ////Fix error where errors occur and tranaction not cancelled
	//Modified by: Chuck Miller (6/21/17 13:44:29)
End if 
FORM SET INPUT:C55([LSS_TowerDistance:174]; "Input")
//C_LONGINT($Width_L;$Height_l)
//GET FORM PROPERTIES([LSS_TowerDistance];"Input";$Width_L;$Height_l)
//ut_OpenNewWindow ($Width_L;$Height_l;0;Plain window )
C_LONGINT:C283($wl; $wt; $wr; $wb; $ol; $ot; $or; $ob; $olt; $ott; $ort; $obt; $olr; $otr; $orr; $obr)
GET WINDOW RECT:C443($wl; $wt; $wr; $wb)

OBJECT GET COORDINATES:C663(*; "LSS_InpectionTabs_as"; $olt; $ott; $ort; $obt)

ADD RECORD:C56([LSS_TowerDistance:174])
SET WINDOW RECT:C444($wl; $wt; $wr; $wb)
OBJECT GET COORDINATES:C663(*; "LSS_InpectionTabs_as"; $wl; $wt; $wr; $wb)

OBJECT MOVE:C664(*; "LSS_InpectionTabs_as"; 0; 0; $ort-$wr; $obt-$wb)

QUERY:C277([LSS_TowerDistance:174]; [LSS_TowerDistance:174]LSS_InspectionId_s:2=[LSS_Inspection:164]LSS_InspectionId_s:1)
ORDER BY:C49([LSS_TowerDistance:174]; [LSS_TowerDistance:174]LSS_TowerOrPost_txt:3; >; [LSS_TowerDistance:174]LSS_SignPanel_s:4; >)
LSS_SetSaveandDelete
//End LSS_AddTowerDistanceRecord