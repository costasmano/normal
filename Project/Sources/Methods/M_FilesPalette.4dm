//%attributes = {"invisible":true}
If (False:C215)
	//Procedure: M_FilesPalette
	//ACI University Programming Classes
	//Created by: Jim Steinman
	//Date: 10/5/95
	
	//Purpose: This procedure creates or brings to front the Customers Process
	
	<>f_Ver1x20:=False:C215
	<>fJ_Steinman:=False:C215
	
End if 

<>LFilePalPID:=LSpawnProcess("P_FilesPalette"; 0; "$FilesPalette"; True:C214; False:C215)

//End of procedure 