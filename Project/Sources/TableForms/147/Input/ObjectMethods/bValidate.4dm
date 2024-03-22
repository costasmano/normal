
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 01/05/12, 14:35:36
//----------------------------------------------------
//Method: Object Method: [LB_QueryTable].Input.bValidate
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2012_01  //r001
	//Modified by: Charles Miller (1/5/12 14:35:37)
	// Modified by: Costas Manousakis-(Designer)-(3/6/12 14:15:23)
	Mods_2012_03
	//  `make sure that for a new record or zero unique key a new key is created and logged
End if 

If (Modified record:C314([LB_QueryTable:147]))
	
	If ((Is new record:C668([LB_QueryTable:147])) | ([LB_QueryTable:147]UniqueKey_l:6=0))
		
		If ([LB_QueryTable:147]UniqueKey_l:6=0)
			Inc_Sequence("LB_QueryTable"; ->[LB_QueryTable:147]UniqueKey_l:6)
		End if 
		
		LogNewRecord(->[LB_QueryTable:147]UniqueKey_l:6; ->[LB_QueryTable:147]UniqueKey_l:6; ->[LB_QueryTable:147]UniqueKey_l:6; 0; "LB_QueryTable")
		
	End if 
	
	InitChangeStack(1)
	
	If ([LB_QueryTable:147]ColumnWidths_txt:2#(Old:C35([LB_QueryTable:147]ColumnWidths_txt:2)))
		PushChange(1; ->[LB_QueryTable:147]ColumnWidths_txt:2)
	End if 
	If ([LB_QueryTable:147]QueryName_s:1#(Old:C35([LB_QueryTable:147]QueryName_s:1)))
		PushChange(1; ->[LB_QueryTable:147]QueryName_s:1)
	End if 
	
	If ([LB_QueryTable:147]TableNumber_l:3#Old:C35([LB_QueryTable:147]TableNumber_l:3))
		PushChange(1; ->[LB_QueryTable:147]TableNumber_l:3)
	End if 
	If ([LB_QueryTable:147]WindowTitle_s:5#Old:C35([LB_QueryTable:147]WindowTitle_s:5))
		PushChange(1; ->[LB_QueryTable:147]WindowTitle_s:5)
	End if 
	
	FlushGrpChgs(1; ->[LB_QueryTable:147]UniqueKey_l:6; ->[LB_QueryTable:147]UniqueKey_l:6; ->[LB_QueryTable:147]UniqueKey_l:6; 0)
End if 
//End Object Method: [LB_QueryTable].Input.bValidate