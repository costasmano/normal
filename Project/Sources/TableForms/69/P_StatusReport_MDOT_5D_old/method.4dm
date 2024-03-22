If (False:C215)
	
	// Modified by: costasmanousakis-(Designer)-(10/4/09 22:35:57)
	Mods_2009_10("MASSDOT")
End if 

Case of 
	: (Form event code:C388=On Printing Detail:K2:18)
		PrepStatusRep
		Startup_PL
		OBJECT SET VISIBLE:C603(*; "Win@"; <>WindowsPL_b)
		OBJECT SET VISIBLE:C603(*; "Mac@"; <>MacPL_b)
End case 