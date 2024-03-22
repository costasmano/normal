
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 12/27/11, 16:12:05
//----------------------------------------------------
//Method: Object Method: SelectListBox.Button
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2011_12  //r003
	//Modified by: Charles Miller (12/27/11 16:12:07)
	
End if 
LB_SetColumnWidths
[LB_QueryTable:147]ColumnWidths_txt:2:=ColumnWidths_txt
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