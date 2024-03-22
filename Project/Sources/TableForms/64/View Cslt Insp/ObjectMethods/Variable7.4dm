If (False:C215)
	//Script: bzOmit
	//ACI University Programming Classes
	//Generic ACI Shell Programming
	//Created By: Kent Wilbur
	//Date:  10/1/95
	
	//Purpose: 
	
	<>fGeneric:=False:C215
	<>f_Ver1x10:=False:C215
	
End if 

M_OmitSubset
ORDER BY:C49([Cons Inspection:64]; [Bridge MHD NBIS:1]BDEPT:1; >)
//End of script