If (False:C215)
	//Script: bzSub
	//ACI University Programming Classes
	//Generic ACI Shell Programming
	//Created By: Kent Wilbur
	//Date:  10/1/95
	
	//Purpose: 
	Mods_2005_CM16
	
	// Modified by: Costas Manousakis-(Designer)-(2021-10-06)
	Mods_2021_10
	//  `unload record at end
End if 

M_ShowSubset
ORDER BY:C49([Personnel:42]; [Personnel:42]Last Name:5; >; [Personnel:42]First Name:3; >; [Personnel:42]Middle Name:4; >; [Personnel:42]Employer:9; >)
UNLOAD RECORD:C212(Current form table:C627->)
//End of script