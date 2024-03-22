//%attributes = {"invisible":true}
If (False:C215)
	//Procedure: fIsCompiled -> Boolean
	//ACI University Programming Classes
	//Generic ACI Shell Programming
	//Created By: Jim Steinman
	//Date:  10/5/95
	
	//Purpose: Find out if the database is compiled.
	
	<>fGeneric:=False:C215
	<>f_Ver1x20:=False:C215
	<>fJ_Steinman:=False:C215
	
End if 

C_BOOLEAN:C305($0)
//C_LONGINT($LTstCMP)

//CLEAR VARIABLE($LTstCMP)
//$0:=Not(Undefined($LTstCMP))

$0:=Is compiled mode:C492

//End of procedure