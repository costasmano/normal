If (False:C215)
	//Script: bzSearchLay
	//ACI University Programming Classes
	//Generic ACI Shell Programming
	//Created By: Kent Wilbur
	//Date:  10/1/95
	
	//Purpose: 
	
	// Modified by: Costas Manousakis-(Designer)-(2021-10-05T00:00:00 09:28:58)
	Mods_2021_10
	//  ` unload record and reset headers
	
End if 

//M_SearchLayout 
//M_EZSearch 
QUERY:C277([Conslt Rating:63])
If (OK=1)
	ORDER BY:C49([Conslt Rating:63]; [Bridge MHD NBIS:1]BDEPT:1; >)
	UNLOAD RECORD:C212(Current form table:C627->)
	LB_ResetHeaders("List box")
	RegionTitle
End if 
//End of script