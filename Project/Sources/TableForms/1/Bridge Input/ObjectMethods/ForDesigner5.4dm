
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 12/27/11, 16:12:05
//----------------------------------------------------
//Method: Object Method: [Bridge MHD NBIS].Bridge Input.Button 
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2011_12  //r003
	//Modified by: Charles Miller (12/27/11 16:12:07)
	// Modified by: Costas Manousakis-(Designer)-(4/25/12 12:02:14)
	Mods_2012_04
	//  `Added pages 7, (Inspections) and 8  (InventoryPhotos)
End if 
C_TEXT:C284($ListBoxArea_txt)
[LB_QueryTable:147]ColumnWidths_txt:2:=ColumnWidths_txt
Case of 
	: (FORM Get current page:C276=2)
		$ListBoxArea_txt:="ConsutantInspections"
	: (FORM Get current page:C276=3)
		$ListBoxArea_txt:="ConsutantRatings"
	: (FORM Get current page:C276=4)
		$ListBoxArea_txt:="RatingReports"
	: (FORM Get current page:C276=5)
		$ListBoxArea_txt:="Secondary"
	: (FORM Get current page:C276=6)
		$ListBoxArea_txt:="BridgeDesign"
	: (FORM Get current page:C276=7)
		$ListBoxArea_txt:="Inspections"
	: (FORM Get current page:C276=8)
		$ListBoxArea_txt:="InventoryPhotos"
End case 

SIA_ResetWidths($ListBoxArea_txt)

If (Modified record:C314([LB_QueryTable:147]))
	
	InitChangeStack(1)
	
	If (Old:C35([LB_QueryTable:147]ColumnWidths_txt:2)#[LB_QueryTable:147]ColumnWidths_txt:2)
		PushChange(1; ->[LB_QueryTable:147]ColumnWidths_txt:2)
	End if 
	If (Old:C35([LB_QueryTable:147]QueryName_s:1)#[LB_QueryTable:147]QueryName_s:1)
		PushChange(1; ->[LB_QueryTable:147]QueryName_s:1)
	End if 
	If (Old:C35([LB_QueryTable:147]TableName_s:4)#[LB_QueryTable:147]TableName_s:4)
		PushChange(1; ->[LB_QueryTable:147]TableName_s:4)
	End if 
	If (Old:C35([LB_QueryTable:147]TableNumber_l:3)#[LB_QueryTable:147]TableNumber_l:3)
		PushChange(1; ->[LB_QueryTable:147]TableNumber_l:3)
	End if 
	If (Old:C35([LB_QueryTable:147]WindowTitle_s:5)#[LB_QueryTable:147]WindowTitle_s:5)
		PushChange(1; ->[LB_QueryTable:147]WindowTitle_s:5)
	End if 
	FlushGrpChgs(1; ->[LB_QueryTable:147]UniqueKey_l:6; ->[LB_QueryTable:147]UniqueKey_l:6; ->[LB_QueryTable:147]UniqueKey_l:6; 0)
	SAVE RECORD:C53([LB_QueryTable:147])
End if 
//End Object Method: SelectListBox.Button