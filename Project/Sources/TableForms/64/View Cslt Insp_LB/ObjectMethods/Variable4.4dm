If (False:C215)
	//Script: bzSort
	//ACI University Programming Classes
	//Generic ACI Shell Programming
	//Created By: Kent Wilbur
	//Date:  10/1/95
	
	//Purpose: 
	
	<>fGeneric:=False:C215
	<>f_Ver1x10:=False:C215
	// Modified by: Costas Manousakis-(Designer)-(2021-10-04T00:00:00 19:40:40)
	Mods_2021_10
	//  `unload record and reset headers of LB
	
End if 

M_SortEditor
UNLOAD RECORD:C212(Current form table:C627->)
LB_ResetHeaders("List Box")
//End of script