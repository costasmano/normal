//%attributes = {"invisible":true}
//Method: SIA_ResetWidths
//Description
//
// Parameters
// $1 : $ListboxObjectName_txt
// $2 : $Setup_b (optional) = called during setup phase or not- default = false
// ----------------------------------------------------
If (False:C215)
	//----------------------------------------------------
	//User name (OS): Charles Miller
	//Date and time: 02/28/12, 16:19:13
	//----------------------------------------------------
	Mods_2012_02  //r003
	//Modified by: Charles Miller (2/28/12 16:19:14)
	Mods_2012_03  //r003  `Add code to use list box for Inventory button on 
	//Modified by: Charles Miller (3/29/12 14:36:15)
	// Modified by: Costas Manousakis-(Designer)-(4/25/12 11:25:16)
	Mods_2012_04
	//  `Removed re-initialization of the arrays if  [LB_QueryTable]ColumnWidths_txt#""
	// Modified by: Costas Manousakis-(Designer)-(5/1/19 11:00:23)
	Mods_2019_05_bug
	//  `added code to adjust the width of listbox object to match the column widths
	// Modified by: Costas Manousakis-(Designer)-(11/5/19 16:57:10)
	Mods_2019_11
	//  `dont't make listbox wider than the window width - leave 5 pixel right margin  
	//  `and keep LB width to not exceed the calculated width
	// Modified by: Costas Manousakis-(Designer)-(12/4/19 13:11:48)
	Mods_2019_12
	//  `Added optional param $2 : setup - indicates if we are called during the setup phase or not
	//  `if during setup - make listbox object as large as required by column widths
End if 
C_TEXT:C284($ListBoxArea_txt)

C_TEXT:C284($1)
$ListBoxArea_txt:=$1
C_BOOLEAN:C305($Setup_b)
If (Count parameters:C259>1)
	C_BOOLEAN:C305($2)
	$Setup_b:=$2
End if 
ARRAY TEXT:C222(arrColNames; 0)
ARRAY TEXT:C222(arrHeaderNames; 0)
ARRAY POINTER:C280(arrColVars; 0)
ARRAY POINTER:C280(arrHeaderVars; 0)
ARRAY BOOLEAN:C223(arrColsVisible; 0)
ARRAY POINTER:C280(arrStyles; 0)
LISTBOX GET ARRAYS:C832(*; $ListBoxArea_txt; arrColNames; arrHeaderNames; arrColVars; arrHeaderVars; arrColsVisible; arrStyles)

If ([LB_QueryTable:147]ColumnWidths_txt:2#"")
	ColumnWidths_txt:=[LB_QueryTable:147]ColumnWidths_txt:2
	ARRAY TEXT:C222($Widths_atxt; 0)
	ut_TextToArray(ColumnWidths_txt; ->$Widths_atxt; ",")
	C_LONGINT:C283($Loop_l; $total_w)
	$total_w:=0
	For ($Loop_l; 1; Size of array:C274(arrColNames))
		If (Size of array:C274($Widths_atxt)>=Size of array:C274(arrColNames))
			LISTBOX SET COLUMN WIDTH:C833(*; arrColNames{$Loop_l}; Num:C11($Widths_atxt{$Loop_l}))
			$total_w:=$total_w+Num:C11($Widths_atxt{$Loop_l})
		End if 
	End for 
	$total_w:=$total_w+15  //add for vert scroll bar
	C_LONGINT:C283($LB_L; $LB_T; $LB_R; $LB_B; $LB_W)
	OBJECT GET COORDINATES:C663(*; $ListBoxArea_txt; $LB_L; $LB_T; $LB_R; $LB_B)
	$LB_W:=$LB_R-$LB_L
	C_LONGINT:C283($WL; $WT; $WR; $WB; $WW; $MaxLBW)
	GET WINDOW RECT:C443($WL; $WT; $WR; $WB)
	$WW:=$WR-$WL
	$MaxLBW:=$WW-$LB_L-5  //5 pix margin on right
	
	If (($total_w>$MaxLBW) & Not:C34($Setup_b))
		$total_w:=$MaxLBW
	End if 
	If ($LB_W<$total_w)
		OBJECT MOVE:C664(*; $ListBoxArea_txt; 0; 0; ($total_w-$LB_W); 0)
	Else 
		OBJECT MOVE:C664(*; $ListBoxArea_txt; 0; 0; ($total_w-$LB_W); 0)
	End if 
	
Else 
	
	If (Size of array:C274(SIA_ListBoxWidths_atxt)=0)
		For ($Loop_l; 1; Size of array:C274(arrColNames))
			LISTBOX SET COLUMN WIDTH:C833(*; arrColNames{$Loop_l}; 50)
			If ($Loop_l>1)
				ColumnWidths_txt:=ColumnWidths_txt+" ,50"
			Else 
				ColumnWidths_txt:="50"
			End if 
		End for 
	Else 
		
		Case of 
			: ($ListBoxArea_txt="ConsutantInspections")
				ColumnWidths_txt:=SIA_ListBoxWidths_atxt{1}
			: ($ListBoxArea_txt="ConsutantRatings")
				ColumnWidths_txt:=SIA_ListBoxWidths_atxt{2}
			: ($ListBoxArea_txt="RatingReports")
				ColumnWidths_txt:=SIA_ListBoxWidths_atxt{3}
			: ($ListBoxArea_txt="Secondary")
				ColumnWidths_txt:=SIA_ListBoxWidths_atxt{4}
			: ($ListBoxArea_txt="BridgeDesign")
				ColumnWidths_txt:=SIA_ListBoxWidths_atxt{5}
			: ($ListBoxArea_txt="Inspections")
				ColumnWidths_txt:=SIA_ListBoxWidths_atxt{6}
			: ($ListBoxArea_txt="InventoryPhotos")
				ColumnWidths_txt:=SIA_ListBoxWidths_atxt{7}
		End case 
		ARRAY TEXT:C222($Widths_atxt; 0)
		
		ut_TextToArray(ColumnWidths_txt; ->$Widths_atxt; ",")
		For ($Loop_l; 1; Size of array:C274(arrColNames))
			If (Size of array:C274($Widths_atxt)>=Size of array:C274(arrColNames))
				LISTBOX SET COLUMN WIDTH:C833(*; arrColNames{$Loop_l}; Num:C11($Widths_atxt{$Loop_l}))
			End if 
		End for 
		
		
	End if 
End if 
//End SIA_ResetWidths