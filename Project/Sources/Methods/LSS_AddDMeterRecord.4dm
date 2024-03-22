//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 04/16/15, 16:02:23
//----------------------------------------------------
//Method: LSS_AddDMeterRecord
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (4/16/15 16:02:24)
	// Modified by: Costas Manousakis-(Designer)-(5/13/16 16:08:07)
	Mods_2016_05_bug
	//  `sort order for DMeter should be by location
	// Modified by: Costas Manousakis-(Designer)-(5/19/16 13:13:28)
	Mods_2016_05_bug
	//  `ORDER BY([LSS_DMeter];[LSS_DMeter]LSS_DMeterDate_d;>;[LSS_DMeter]LSS_Location_s;>)
	Mods_2017_06_bug  ////Fix error where errors occur and tranaction not cancelled
	//Modified by: Chuck Miller (6/21/17 13:44:29)
End if 

FORM SET INPUT:C55([LSS_DMeter:161]; "Input")
C_LONGINT:C283($wl; $wt; $wr; $wb; $ol; $ot; $or; $ob; $olt; $ott; $ort; $obt)
GET WINDOW RECT:C443($wl; $wt; $wr; $wb)
OBJECT GET COORDINATES:C663(*; "DMeter_LB"; $ol; $ot; $or; $ob)
OBJECT GET COORDINATES:C663(*; "LSS_InpectionTabs_as"; $olt; $ott; $ort; $obt)
//ut_OpenNewWindow ($Width_L;$Height_l;0;Plain window )

ADD RECORD:C56([LSS_DMeter:161])

QUERY:C277([LSS_DMeter:161]; [LSS_DMeter:161]LSS_InspectionId_s:2=[LSS_Inspection:164]LSS_InspectionId_s:1)
ORDER BY:C49([LSS_DMeter:161]; [LSS_DMeter:161]LSS_DMeterDate_d:9; >; [LSS_DMeter:161]LSS_Location_s:3; >)
SET WINDOW RECT:C444($wl; $wt; $wr; $wb)
OBJECT GET COORDINATES:C663(*; "DMeter_LB"; $wl; $wt; $wr; $wb)

OBJECT MOVE:C664(*; "DMeter_LB"; 0; 0; $or-$wr; $ob-$wb)

OBJECT GET COORDINATES:C663(*; "LSS_InpectionTabs_as"; $wl; $wt; $wr; $wb)

OBJECT MOVE:C664(*; "LSS_InpectionTabs_as"; 0; 0; $ort-$wr; $obt-$wb)
LSS_SetSaveandDelete
//End LSS_AddDMeterRecord