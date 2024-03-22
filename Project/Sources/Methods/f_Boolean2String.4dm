//%attributes = {}
If (False:C215)
	
	//Project method : f_Boolean2String  
	//Created to convert a boolean to a string value
	//Arguments :
	// $1 : Boolean value
	// $2 : 2 char string. Function will return 1st char if
	//         boolean is True, 2nd char if boolean is False
	//Created Feb-2002
	
End if 

C_TEXT:C284($0; $2)  // Command Replaced was o_C_STRING length was 2
C_BOOLEAN:C305($1)

If ($1)
	$0:=Substring:C12($2; 1; 1)
Else 
	If (Length:C16($2)>1)  //added Oct-2002
		$0:=Substring:C12($2; 2; 1)
	Else 
		$0:=""
	End if 
End if 