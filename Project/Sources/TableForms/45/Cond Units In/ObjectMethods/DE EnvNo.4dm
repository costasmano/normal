//SC aEnv: array in popup menu on layout [Cond Units];"Cond Units In".
//Copyright © 1996, Thomas D. Nee, All Rights Reserved.

C_LONGINT:C283($Default)
C_BOOLEAN:C305($New)

//TRACE

REDRAW:C174(aEnv)

If (Form event code:C388=On Load:K2:1) | (Not:C34([BMS Categories:49]Smart Flag:5))
	//Don't allow the environment to be changed if this is a Smart Flag.  
	
	$Default:=2  // Position of default.
	$New:=False:C215  //The array has not been reset.
	POPUP(->aEnv; ->[Cond Units:45]Environment:4; $Default; $New; ->aEnvID)
	
	If (Form event code:C388=On Clicked:K2:4) & ([Cond Units:45]Environment:4#Old:C35([Cond Units:45]Environment:4))
		PushChange(2; ->[Cond Units:45]Environment:4)
	End if 
	
End if 