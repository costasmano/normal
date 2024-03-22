//%attributes = {"invisible":true}
If (False:C215)
	//Procedure: M_AddRecords
	//ACI University Programming Classes
	//Generic ACI Shell Programming
	//Created By: Jim Steinman
	//Date:   10/1/95
	
	//Purpose: Allows the user to enter records repeatedly until cancel is pressed
	
	<>fGeneric:=False:C215
	<>f_Ver1x10:=False:C215
	<>fJ_Steinman:=False:C215
	
	Repeat 
		ADD RECORD:C56(pFile->)
	Until (OK=0)  //Until the user clicks a Cancel button
	
End if 


WindowTitle
//End of procedure