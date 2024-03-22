//%attributes = {"invisible":true}
If (False:C215)
	//Procedure: Set2ReadOnly(pointer;longint)
	//ACI University Programming Classes
	//Generic ACI Shell Programming
	//Created By:  Jim Steinman
	//Date:  10/5/95
	
	//Legend:
	//$1 - pointer to file to set to read only
	//$2 - longint - 1= restore file to read only 0= leave file read write
	
	//Purpose:   Sets files to read only as necessary
	
	<>fGeneric:=False:C215
	<>f_Ver1x20:=False:C215
	<>fJ_Steinman:=False:C215
	
End if 

C_POINTER:C301($1; $pFile)
C_LONGINT:C283($2)

$pFile:=$1
If ($2=1)
	UNLOAD RECORD:C212($pFile->)
	READ ONLY:C145($pFile->)
	LOAD RECORD:C52($pFile->)
End if 
//End of procedure 