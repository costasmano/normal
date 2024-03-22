//%attributes = {"invisible":true}
If (False:C215)
	//Procedure: P_ExportData(pointer;longint;longint;string;string)
	//ACI University Programming Classes
	//Generic ACI Shell Programming
	//Created By: Jim Steinman
	//Date:  10/5/95
	
	// Legend:
	// $1 - pointer - pointer to an array of field pointers
	// $2 - longint - 0 = Text format, 1=Merge Format, 2=4D Format
	// $3 - longint - 0 = No LF after CR; 1= LF after CR
	// $4 - string - Field delimiter
	// $5 - string - Record delimiter
	
	//Purpose: Find out if the database is compiled and call the correct code
	
	<>fGeneric:=False:C215
	<>f_Ver1x10:=False:C215
	<>f_Ver1x20:=False:C215
	<>fJ_Steinman:=False:C215
	
End if 

C_POINTER:C301($1)
C_LONGINT:C283($LParms; $2; $3)
C_TEXT:C284($4; $5)  // Command Replaced was o_C_STRING length was 3

$LParms:=Count parameters:C259

If (<>fCompiled)
	If ($LParms=0)
		ExportDataOpt
	Else 
		ExportDataOpt($1; $2; $3; $4; $5)
	End if 
Else 
	If ($LParms=0)
		ExportData
	Else 
		ExportData($1; $2; $3; $4; $5)
	End if 
End if 
//End of procedure