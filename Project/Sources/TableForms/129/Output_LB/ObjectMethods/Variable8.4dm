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
ALL RECORDS:C47([Scour Report:129])
ORDER BY:C49([Scour Report:129]; [Scour Report:129]ReportDate:1; <)

//End of script