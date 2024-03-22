If (False:C215)
	//Script: bzSearchLay
	//ACI University Programming Classes
	//Generic ACI Shell Programming
	//Created By: Kent Wilbur
	//Date:  10/1/95
	
	//Purpose: 
	
	
	// Modified by: Costas Manousakis-(Designer)-(2021-10-06)
	Mods_2021_10
	//  `unload record at end - reset LB headers
End if 

//M_SearchLayout 
//M_EZSearch 
QUERY:C277([Conslt Address:77])
ORDER BY:C49([Conslt Address:77]; [Conslt Address:77]ConsltName:2; >)
UNLOAD RECORD:C212(Current form table:C627->)
LB_ResetHeaders("SelectListBox")
RegionTitle
