//%attributes = {"invisible":true}
If (False:C215)
	//Procedure: OnCallQuit
	//ACI University Programming Classes
	//Generic ACI Shell Programming
	//Created By:  Jim Steinman
	//Date:  10/5/95
	
	//Purpose:   Checks for users present then sets flag if they are there
	
	<>fGeneric:=False:C215
	<>f_Ver1x20:=False:C215
	<>fJ_Steinman:=False:C215
	
End if 

<>fUsrPresent:=True:C214  //User is here working
DELAY PROCESS:C323(<>LLogOffPID; 0)  //resume process
//End of procedure