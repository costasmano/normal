If (False:C215)
	//Script: bzPrint
	//ACI University Programming Classes
	//Generic ACI Shell Programming
	//Created By: Kent Wilbur
	//Date:  10/1/95
	
	//Purpose: 
	
	<>fGeneric:=False:C215
	<>f_Ver1x10:=False:C215
	
End if 

OK:=1
If (Records in selection:C76([Activity Log:59])>70)
	CONFIRM:C162("Do you want to print "+String:C10(Records in selection:C76([Activity Log:59]))+" records of Activity Log table?"; "Print")
End if 
If (OK=1)
	FORM SET OUTPUT:C54([Activity Log:59]; "Print")
	PRINT SELECTION:C60([Activity Log:59])
End if 