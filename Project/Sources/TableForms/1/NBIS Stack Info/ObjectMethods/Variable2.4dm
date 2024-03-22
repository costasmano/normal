If (False:C215)
	//Script: bzSearchLay
	//ACI University Programming Classes
	//Generic ACI Shell Programming
	//Created By: Kent Wilbur
	//Date:  10/1/95
	
	//Purpose: 
	
	<>fGeneric:=False:C215
	<>f_Ver1x10:=False:C215
	// Modified by: costasmanousakis-(Designer)-(4/2/08 12:38:55)
	Mods_2008_CM_5403  //Removed resetting of sort buttons
	// Modified by: costasmanousakis-(Designer)-(11/29/10 14:09:35)
	Mods_2010_11
	//  `change CMD-S to 4D Query instead of EZSearch for Designer
End if 


//M_SearchLayout 
If (Current user:C182="Designer")
	M_SearchSel
Else 
	M_EZSearch
End if 
//End of script