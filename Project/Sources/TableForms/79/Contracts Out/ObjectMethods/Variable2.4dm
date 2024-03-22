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
QUERY:C277([Contracts:79])
ORDER BY:C49([Contracts:79]; [Contracts:79]ContractNo:1; >)
RegionTitle
//End of script