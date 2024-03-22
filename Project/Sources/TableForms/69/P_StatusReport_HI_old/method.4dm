If (False:C215)
	//Form methd [Status Report];"P_StatusReport_HI" 
	//Created : Feb-2002
	// Modified by: costasmanousakis-(Designer)-(3/2/2007 16:12:39)
	Mods_2007_CM07
	// Modified by: costasmanousakis-(Designer)-(11/20/07 16:28:55)
	Mods_2007_CM_5401
	// Modified by: costasmanousakis-(Designer)-(12/11/08 08:33:22)
	Mods_2008_CM_5404
	//changed spelling of Health Indexes to Indices.
	// Modified by: Costas Manousakis-(Designer)-(8/13/12 16:10:33)
	Mods_2012_08
	//  `Added "Pre MADOT" to the label, changed logo to MADOT per request of T. Broderick
	
End if 

Case of 
	: (Form event code:C388=On Printing Detail:K2:18)
		PrepStatusRep
		Startup_PL
		OBJECT SET VISIBLE:C603(*; "Win_@"; <>WindowsPL_b)
		OBJECT SET VISIBLE:C603(*; "Mac_@"; <>MacPL_b)
End case 