//%attributes = {"invisible":true}
If (False:C215)
	//Procedure: LProcessID(string) -> longint
	//ACI University Programming Classes
	//Generic ACI Shell Programming
	//Created By:  Jim Steinman
	//Date:  10/5/95
	
	//Purpose: This procedure checks to see if an existing process is already created 
	
	//Returns  -> longint -  process id if active or -1 if aborted or not created
	
	<>fGeneric:=False:C215
	<>f_Ver1x20:=False:C215
	<>fJ_Steinman:=False:C215
	
End if 

C_TEXT:C284($sProcName)  // Command Replaced was o_C_STRING length was 31
C_LONGINT:C283($i; $LState; $LTime)
$0:=-1
For ($i; 2; Count tasks:C335)
	PROCESS PROPERTIES:C336($i; $sProcName; $LState; $LTime)
	If ($1=$sProcName)  //Is the name of the process the same
		If ($LState#-1)  //Is the process aborted
			$0:=$i
			$i:=Count tasks:C335+1
		End if 
	End if 
End for 
//End of procedure
