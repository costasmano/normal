If (False:C215)
	//Script: bzSearchLay
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

//M_SearchLayout 
//M_EZSearch 
QUERY:C277([Cons Inspection:64])
ORDER BY:C49([Cons Inspection:64]; [Bridge MHD NBIS:1]BDEPT:1; >)
UNLOAD RECORD:C212(Current form table:C627->)
LB_ResetHeaders("List Box")
RegionTitle