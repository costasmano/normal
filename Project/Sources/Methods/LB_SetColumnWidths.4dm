//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 12/29/11, 14:03:33
//----------------------------------------------------
//Method: LB_SetColumnWidths
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2011_12  //r004
	//Modified by: Charles Miller (12/29/11 14:03:34)
	// Modified by: Costas Manousakis-(Designer)-(10/17/13 16:34:00)
	Mods_2013_10
	//  `Fix bug when $TotalWidth_l>($scrWdth_l-150)
End if 
ARRAY TEXT:C222($Widths_atxt; 0)
C_BOOLEAN:C305($DisplayHorizontalScrollBar_b)
$DisplayHorizontalScrollBar_b:=False:C215
ut_TextToArray(ColumnWidths_txt; ->$Widths_atxt; ",")

C_LONGINT:C283($Loop_l; $TotalWidth_l; $WindowLeft_l; $OBJLeft_l; $Top_l; $OBJRight_l; $Bottom_l; $CurrentWidth_l; $NewWidth_l; $WindowRight_l; $Left_l; $scrWdth_l)
$TotalWidth_l:=0
For ($Loop_l; 1; Size of array:C274(arrColNames))
	LISTBOX SET COLUMN WIDTH:C833(*; arrColNames{$Loop_l}; Num:C11($Widths_atxt{$Loop_l}))
	$TotalWidth_l:=$TotalWidth_l+Num:C11($Widths_atxt{$Loop_l})
	
End for 
$TotalWidth_l:=$TotalWidth_l+20
$scrWdth_l:=Screen width:C187

OBJECT GET COORDINATES:C663(*; "SelectListBox"; $OBJLeft_l; $Top_l; $OBJRight_l; $Bottom_l)
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

OBJECT MOVE:C664(*; "SelectListBox"; 0; 0; $NewWidth_l; 0)
OBJECT GET COORDINATES:C663(*; "SelectListBox"; $OBJLeft_l; $Top_l; $OBJRight_l; $Bottom_l)
GET WINDOW RECT:C443($WindowLeft_l; $Top_l; $WindowRight_l; $Bottom_l)
If (False:C215)
	If ($OBJRight_l>($WindowRight_l-$Left_l))
		$CurrentWidth_l:=$OBJRight_l+20
		If ($CurrentWidth_l>$scrWdth_l)
			$CurrentWidth_l:=$scrWdth_l-100
		End if 
	Else 
		$CurrentWidth_l:=$OBJRight_l+20
		If ($CurrentWidth_l<800)
			$CurrentWidth_l:=800
		End if 
	End if 
End if 
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

//End LB_SetColumnWidths