If (False:C215)
	//Object Method: [LSS_Inventory].CustomSearch.LSS_StructureClass_atxt 
	// Modified by: Costas Manousakis-(Designer)-(7/8/15 17:13:35)
	Mods_2015_07_bug
	//  `Workaround for bug in Choose command running compiled. First value(0) must be at least as long as any of the other values~ 
End if 


If (True:C214)
	LSS_SearchStrClass_txt:=Replace string:C233(Choose:C955(LSS_StructureClass_atxt; 20*(" "); ""; "Sign"; "Light"; "Signal"; "ITS"); " "; "")
Else 
	Case of 
		: (LSS_StructureClass_atxt=2)
			LSS_SearchStrClass_txt:="Sign"
		: (LSS_StructureClass_atxt=3)
			LSS_SearchStrClass_txt:="Light"
		: (LSS_StructureClass_atxt=4)
			LSS_SearchStrClass_txt:="Signal"
		: (LSS_StructureClass_atxt=5)
			LSS_SearchStrClass_txt:="ITS"
			
	End case 
	
End if 