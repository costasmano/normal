//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 04/16/15, 15:58:11
//----------------------------------------------------
//Method: LSS_AddUTRecord
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (4/16/15 15:58:13)
End if 

FORM SET INPUT:C55([LSS_UT:175]; "Input")
//ut_OpenNewWindow ($Width_L;$Height_l;0;Plain window )
C_LONGINT:C283($wl; $wt; $wr; $wb; $ol; $ot; $or; $ob; $olt; $ott; $ort; $obt; $olr; $otr; $orr; $obr)
GET WINDOW RECT:C443($wl; $wt; $wr; $wb)
OBJECT GET COORDINATES:C663(*; "UT_LB"; $ol; $ot; $or; $ob)
OBJECT GET COORDINATES:C663(*; "UTResults_LB"; $olr; $otr; $orr; $obr)

OBJECT GET COORDINATES:C663(*; "LSS_InpectionTabs_as"; $olt; $ott; $ort; $obt)

ADD RECORD:C56([LSS_UT:175])

QUERY:C277([LSS_UT:175]; [LSS_UT:175]LSS_InspectionId_s:2=[LSS_Inspection:164]LSS_InspectionId_s:1)

REDRAW:C174(UT_LB)
C_TEXT:C284($ERORMETHOD_TXT)

COPY NAMED SELECTION:C331([LSS_UT:175]; "UT_LB")
$ERORMETHOD_TXT:=Method called on error:C704
ON ERR CALL:C155("MissingSetError")
CLEAR NAMED SELECTION:C333("UTResults_LB")
ON ERR CALL:C155($ERORMETHOD_TXT)
OBJECT SET VISIBLE:C603(*; "UTResults_LB"; False:C215)
OBJECT SET VISIBLE:C603(*; "PlusButton1_L"; False:C215)

SET WINDOW RECT:C444($wl; $wt; $wr; $wb)
OBJECT GET COORDINATES:C663(*; "UT_LB"; $wl; $wt; $wr; $wb)

OBJECT MOVE:C664(*; "UT_LB"; 0; 0; $or-$wr; $ob-$wb)

OBJECT GET COORDINATES:C663(*; "UTResults_LB"; $wl; $wt; $wr; $wb)
OBJECT MOVE:C664(*; "UTResults_LB"; 0; 0; $orr-$wr; $obr-$wb)

OBJECT GET COORDINATES:C663(*; "LSS_InpectionTabs_as"; $wl; $wt; $wr; $wb)

OBJECT MOVE:C664(*; "LSS_InpectionTabs_as"; 0; 0; $ort-$wr; $obt-$wb)

//End LSS_AddUTRecord