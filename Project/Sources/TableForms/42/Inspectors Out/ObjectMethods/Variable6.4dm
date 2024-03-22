If (False:C215)
	//Script: bzSub
	//ACI University Programming Classes
	//Generic ACI Shell Programming
	//Created By: Kent Wilbur
	//Date:  10/1/95
	
	//Purpose: 
	
	<>fGeneric:=False:C215
	<>f_Ver1x10:=False:C215
	Mods_2005_CM16
	
End if 

M_ShowSubset
ORDER BY:C49([Personnel:42]; [Personnel:42]Last Name:5; >; [Personnel:42]First Name:3; >; [Personnel:42]Middle Name:4; >; [Personnel:42]Employer:9; >)
//End of script