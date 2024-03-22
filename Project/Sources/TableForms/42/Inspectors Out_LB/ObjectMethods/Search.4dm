If (False:C215)
	//Script: bzSearchLay
	//ACI University Programming Classes
	//Generic ACI Shell Programming
	//Created By: Kent Wilbur
	//Date:  10/1/95
	
	//Purpose: 
	
	<>fGeneric:=False:C215
	<>f_Ver1x10:=False:C215
	Mods_2005_CM16
	// Modified by: costasmanousakis-(Designer)-(11/24/2006 12:09:16)
	Mods_2006_CM07
	// Modified by: Costas Manousakis-(Designer)-(2021-10-06)
	Mods_2021_10
	//  `unload record at end
End if 
M_SearchEditor
ORDER BY:C49([Personnel:42]; [Personnel:42]Last Name:5; >; [Personnel:42]First Name:3; >; [Personnel:42]Middle Name:4; >; [Personnel:42]Employer:9; >)
UNLOAD RECORD:C212(Current form table:C627->)
//End of script
