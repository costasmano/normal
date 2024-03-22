If (False:C215)
	//Object Method: [LSS_Inventory].CustomSearch.LSS_RouteDirection_as 
	// Modified by: Costas Manousakis-(Designer)-(7/8/15 17:13:35)
	Mods_2015_07_bug
	//  `Workaround for bug in Choose command running compiled. First value(0) must be at least as long as any of the other values~ 
End if 

If (True:C214)
	LSS_SearchRoutDir_txt:=Replace string:C233(Choose:C955(LSS_RouteDirection_as; " "; ""; "N"; "S"; "E"; "W"; "N"; "E"); " "; "")
Else 
	
	Case of 
		: (LSS_RouteDirection_as=2)
			LSS_SearchRoutDir_txt:="N"
		: (LSS_RouteDirection_as=3)
			LSS_SearchRoutDir_txt:="S"
		: (LSS_RouteDirection_as=4)
			LSS_SearchRoutDir_txt:="E"
		: (LSS_RouteDirection_as=5)
			LSS_SearchRoutDir_txt:="W"
		: (LSS_RouteDirection_as=6)
			LSS_SearchRoutDir_txt:="N"
		: (LSS_RouteDirection_as=7)
			LSS_SearchRoutDir_txt:="E"
			
	End case 
	
End if 