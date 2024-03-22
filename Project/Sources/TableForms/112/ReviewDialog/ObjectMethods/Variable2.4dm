If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(6/7/11 12:18:17)
	Mods_2011_06
	//  `Allow inspection Engineers to look thru all Inspections
	//  `Don't do the rest if user Cancels the query
End if 

If (User in group:C338(Current user:C182; "Design Access Group") | User in group:C338(Current user:C182; "Inspection Engineers"))
	QUERY:C277(Current form table:C627->)
Else 
	QUERY SELECTION:C341(Current form table:C627->)
End if 
If (OK=1)
	INV_DisplayInvInspections(True:C214)
	INV_ReDoSort
	REDRAW WINDOW:C456
	RegionTitle
End if 