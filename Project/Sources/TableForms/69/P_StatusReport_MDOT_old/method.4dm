If (False:C215)
	
	// Modified by: costasmanousakis-(Designer)-(10/4/09 22:35:57)
	Mods_2009_10("MASSDOT")
	// Modified by: costasmanousakis-(Designer)-(6/16/10 11:17:38)
	Mods_2010_06
	//  `Fixed wrong fields showing for District 6 -
	//  `Added 6 Districts to the title
End if 

Case of 
	: (Form event code:C388=On Printing Detail:K2:18)
		PrepStatusRep
		Startup_PL
		OBJECT SET VISIBLE:C603(*; "Win@"; <>WindowsPL_b)
		OBJECT SET VISIBLE:C603(*; "Mac@"; <>MacPL_b)
End case 