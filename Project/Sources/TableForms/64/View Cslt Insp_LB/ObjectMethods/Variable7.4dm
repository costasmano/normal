If (False:C215)
	
	// Modified by: Costas Manousakis-(Designer)-(2021-10-04T00:00:00 19:40:40)
	Mods_2021_10
	//  `unload record and reset headers of LB
End if 

M_OmitSubset
ORDER BY:C49([Cons Inspection:64]; [Bridge MHD NBIS:1]BDEPT:1; >)
UNLOAD RECORD:C212(Current form table:C627->)
LB_ResetHeaders("List Box")

//End of script