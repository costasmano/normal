If (False:C215)
	//Object Method: [LSS_Inventory].CustomSearch.LSS_RouteDesignation_atxt 
	// Modified by: Costas Manousakis-(Designer)-(7/8/15 17:13:35)
	Mods_2015_07_bug
	//  `Workaround for bug in Choose command running compiled. First value(0) must be at least as long as any of the other values~ 
End if 

If (True:C214)
	LSS_SearchRoutType_txt:=Replace string:C233(Choose:C955(LSS_RouteDesignation_atxt; " "; ""; "I"; "M"; "U"); " "; "")
Else 
	
	Case of 
		: (LSS_RouteDesignation_atxt=2)
			LSS_SearchRoutType_txt:="I"
		: (LSS_RouteDesignation_atxt=3)
			LSS_SearchRoutType_txt:="M"
		: (LSS_RouteDesignation_atxt=4)
			LSS_SearchRoutType_txt:="U"
	End case 
	
End if 