If (False:C215)
	//Object Method: InspUtilTool 
	// Modified by: costasmanousakis-(Designer)-(8/25/11 10:07:51)
	Mods_2011_08
	//New button mapped to CMD-Alt-U
End if 

If (User in group:C338(Current user:C182; "Design Access Group"))
	G_Insp_ReviewUtils
	REDRAW WINDOW:C456
	RegionTitle
End if 