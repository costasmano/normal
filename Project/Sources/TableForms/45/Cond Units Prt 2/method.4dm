//LP [Cond Units];"Cond Units Prt 2".
//Copyright © 1997, Thomas D. Nee, All Rights Reserved.
If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(5/12/09 14:21:46)
	Mods_2009_05
	//modified the form and replaced the [Cond Units]Percent check box with
	// a box and two cross lines called CHKLINE@
	//SET VISIBLE(*;"CHKLINE@";[Cond Units]Percent)
	//use this command to check/uncheck the percent check box since on Windows it comes out grey
	// Modified by: Costas Manousakis-(Designer)-(8/29/16 10:18:01)
	Mods_2016_08
	//  `use new method CU_Print_FM to allow printing using Print Form.
End if 

CU_Print_FM