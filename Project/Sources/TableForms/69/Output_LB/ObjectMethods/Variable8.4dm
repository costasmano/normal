If (False:C215)
	//Script: bzDelete
	//ACI University Programming Classes
	//Generic ACI Shell Programming
	//Created By: Kent Wilbur
	//Date:  10/1/95
	
	//Purpose: 
	
	<>fGeneric:=False:C215
	<>f_Ver1x10:=False:C215
	
End if 

M_DelUserSet
M_ShowAllRecs
ORDER BY:C49([Status Report:69]; [Status Report:69]Date_Created:1; <)
//End of script


