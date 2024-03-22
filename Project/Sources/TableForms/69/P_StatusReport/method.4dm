If (False:C215)
	//modified 2-nov-2000 :CM
	//    added check for DEM bridges when total DEM=0
	//modified 1-feb-2001 :CM
	//    added check for DNR bridges when total DNR=0
	//modified feb-2002 :CM
	//    use the global procedure PrepStatusRep instead of code in here
	// Modified by: costasmanousakis-(Designer)-(3/2/2007 16:12:39)
	Mods_2007_CM07
End if 

Case of 
	: (Form event code:C388=On Printing Detail:K2:18)
		PrepStatusRep
End case 