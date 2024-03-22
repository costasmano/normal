If (False:C215)
	//Script: bzAdd
	//ACI University Programming Classes
	//Generic ACI Shell Programming
	//Created By: Kent Wilbur
	//Date:  10/1/95
	
	//Purpose: 
	
	<>fGeneric:=False:C215
	<>f_Ver1x10:=False:C215
	
End if 

//M_AddRecords

//GP M_AddRecords has been disabled;
//the following lines duplicate its original function.
//Repeat 
ADD RECORD:C56(pFile->)
//Until (OK=0)  `Until the user clicks a Cancel button

WindowTitle
//End of script
