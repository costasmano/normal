//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 12/04/14, 15:58:47
//----------------------------------------------------
//Method: LSS_CReatePhotoRecord
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (12/4/14 15:58:49)
	Mods_2017_06_bug  ////Fix error where errors occur and tranaction not cancelled
	//Modified by: Chuck Miller (6/21/17 13:44:29)
	Mods_2020_09  //Make changes so that UT and d-meter pictures Added and modified using the [LSS_Photos];"Input" form
	//Modified by: CJ (9/3/20 15:39:44)
End if 

FORM SET INPUT:C55([LSS_Photos:166]; "Input")
//C_LONGINT($Width_L;$Height_l)
//GET FORM PROPERTIES([LSS_Photos];"Input";$Width_L;$Height_l)
//ut_OpenNewWindow ($Width_L;$Height_l;0;Plain window )
C_LONGINT:C283($wl; $wt; $wr; $wb; $ol; $ot; $or; $ob; $olt; $ott; $ort; $obt; $olr; $otr; $orr; $obr)
GET WINDOW RECT:C443($wl; $wt; $wr; $wb)
OBJECT GET COORDINATES:C663(*; "LSS_InpectionTabs_as"; $olt; $ott; $ort; $obt)
OBJECT GET COORDINATES:C663(*; "PHotos_LB"; $ol; $ot; $or; $ob)

ADD RECORD:C56([LSS_Photos:166])

SET WINDOW RECT:C444($wl; $wt; $wr; $wb)


OBJECT GET COORDINATES:C663(*; "PHotos_LB"; $wl; $wt; $wr; $wb)

OBJECT MOVE:C664(*; "PHotos_LB"; 0; 0; $or-$wr; $ob-$wb)

OBJECT GET COORDINATES:C663(*; "LSS_InpectionTabs_as"; $wl; $wt; $wr; $wb)

OBJECT MOVE:C664(*; "LSS_InpectionTabs_as"; 0; 0; $ort-$wr; $obt-$wb)
Case of 
	: (v_166_003_txt="Sketch UT")
	: (v_166_003_txt="Sketch D Meter")
	Else 
		LSS_GetImages
End case 
LSS_SetSaveandDelete
//End LSS_CReatePhotoRecord

