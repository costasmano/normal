//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 10/22/15, 12:21:04
//----------------------------------------------------
//Method: LB_ResizeWindow
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2015_10  // 
	//Modified by: administrator (10/22/15 12:21:05)
	
End if 
C_LONGINT:C283($1; $TotalWidth_L; $scrWdth_l; $OBJLeft_l; $Top_l; $OBJRight_l; $Bottom_l; $NewWidth_l; $CurrentWidth_l; $WindowLeft_l; $WindowRight_l)
C_TEXT:C284($2; $LBObjectName_txt)
$LBObjectName_txt:=$2
$TotalWidth_l:=$1+20
$scrWdth_l:=Screen width:C187
C_BOOLEAN:C305($DisplayHorizontalScrollBar_b)
$DisplayHorizontalScrollBar_b:=False:C215
OBJECT GET COORDINATES:C663(*; $LBObjectName_txt; $OBJLeft_l; $Top_l; $OBJRight_l; $Bottom_l)
$CurrentWidth_l:=$OBJRight_l-$OBJLeft_l
Case of 
	: ($TotalWidth_l>($scrWdth_l-150))
		$NewWidth_l:=$scrWdth_l-150
		$NewWidth_l:=$NewWidth_l-$CurrentWidth_l
	: ($CurrentWidth_l>$TotalWidth_l)
		$NewWidth_l:=($CurrentWidth_l-$TotalWidth_l)*-1
	: ($CurrentWidth_l<$TotalWidth_l)
		$NewWidth_l:=$TotalWidth_l-$CurrentWidth_l
	Else 
		$NewWidth_l:=0
End case 

OBJECT MOVE:C664(*; $LBObjectName_txt; 0; 0; $NewWidth_l; 0)
OBJECT GET COORDINATES:C663(*; $LBObjectName_txt; $OBJLeft_l; $Top_l; $OBJRight_l; $Bottom_l)
GET WINDOW RECT:C443($WindowLeft_l; $Top_l; $WindowRight_l; $Bottom_l)
$CurrentWidth_l:=$OBJRight_l+20+($OBJLeft_l-$WindowLeft_l)
If ($CurrentWidth_l>$scrWdth_l)
	$CurrentWidth_l:=$scrWdth_l-100
	$DisplayHorizontalScrollBar_b:=True:C214
End if 
If ($CurrentWidth_l<800)
	$CurrentWidth_l:=800
	$DisplayHorizontalScrollBar_b:=True:C214
End if 

OBJECT SET SCROLLBAR:C843(*; "SelectListBox"; $DisplayHorizontalScrollBar_b; True:C214)
ut_ResizeWindow(Frontmost window:C447; $CurrentWidth_l; $Bottom_l-$Top_l)
//End LB_ResizeWindow

