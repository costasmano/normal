//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/22/09, 09:12:21
	// ----------------------------------------------------
	// Method: SIA_BrKeyNumbered_OM
	// Description
	//SC vNumbrdRt on layout [Bridge MHD NBIS];"BDEPT Input".
	//Copyright © 1997, Thomas D. Nee, All Rights Reserved.
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2009_12
End if 
C_LONGINT:C283(vNumbrdRt)  //Command Replaced was o_C_INTEGER

Case of 
	: (Form event code:C388=On Load:K2:1)
		vNumbrdRt:=0
		If (Substring:C12([Bridge MHD NBIS:1]Bridge Key:2; 12; 1)="1")
			vNumbrdRt:=1
		End if 
	: (Form event code:C388=On Clicked:K2:4)
		//0=Unnumbered Route; 1=Numbered Route.    
		[Bridge MHD NBIS:1]Bridge Key:2:=Change string:C234([Bridge MHD NBIS:1]Bridge Key:2; String:C10(vNumbrdRt); 12)
		PushChange(1; ->[Bridge MHD NBIS:1]Bridge Key:2)
End case 