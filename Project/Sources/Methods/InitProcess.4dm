//%attributes = {"invisible":true}
If (False:C215)
	//Procedure: InitProcess
	//ACI University Programming Classes
	//Generic ACI Shell Programming
	//Created By:  Jim Steinman
	//Date:  10/5/95
	
	
	//Legend:
	//$1 - Pointer = Pointer to main file for the process
	
	//Purpose:   Sets files to read only and read write as necessary
	
	<>fGeneric:=False:C215
	<>f_Ver1x20:=False:C215
	<>fJ_Steinman:=False:C215
	
End if 

C_POINTER:C301($1)

pFile:=$1  //Set pointer go file pointer process variable
READ ONLY:C145(*)  //Set all files to read only
DEFAULT TABLE:C46(pFile->)
//End of procedure 
