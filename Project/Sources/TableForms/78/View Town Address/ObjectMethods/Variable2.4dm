If (False:C215)
	//Script: bzSearchLay
	//ACI University Programming Classes
	//Generic ACI Shell Programming
	//Created By: Kent Wilbur
	//Date:  10/1/95
	
	//Purpose: 
	
	<>fGeneric:=False:C215
	<>f_Ver1x10:=False:C215
	
End if 

//M_SearchLayout 
//M_EZSearch 
QUERY:C277([Town Address:78])
ORDER BY:C49([Town Address:78]; [Town Address:78]TownName:2; >)
RegionTitle
