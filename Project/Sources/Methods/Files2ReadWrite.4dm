//%attributes = {"invisible":true}
If (False:C215)
	//Procedure: Files2ReadWrite(pointer;{pointer};...)
	//ACI University Programming Classes
	//Generic ACI Shell Programming
	//Created By:  Jim Steinman
	//Date:  10/5/95
	
	//Purpose:   Sets files for all pointers passed as parameters to Read-Write
	
	<>fGeneric:=False:C215
	<>f_Ver1x20:=False:C215
	<>fJ_Steinman:=False:C215
	
End if 

C_LONGINT:C283($i)

For ($i; 1; Count parameters:C259)
	READ WRITE:C146(${$i}->)  //Use the generic parameter
End for 
//End of procedure 