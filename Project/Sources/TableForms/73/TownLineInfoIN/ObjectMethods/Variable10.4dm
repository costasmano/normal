If (False:C215)
	//Script aTownName_ on layout [TownLineInfo];"TownLineInfoIN".
	//Copyright © 1997, Albert Leung, All Rights Reserved.
	
	//Scrollable area for Town Name.
	
	// modified 19-mar-2001 : Changed to using Form event ; added check to make sure
	//      a town was selected; and to refresh the BDEPT field.
	
	// Modified by: costasmanousakis-(Designer)-(5/10/11 15:37:57)
	Mods_2011_05
	//Modified to use CASE OF
	// Push the Townline record before getting the bdept and pop after. 
	//Use a temp variable for the bdept.
End if 
C_LONGINT:C283($k)  //Command Replaced was o_C_INTEGER

Case of 
	: (Form event code:C388=On Load:K2:1)
		$k:=Find in array:C230(aTownName_; [Bridge MHD NBIS:1]Town Name:175)
		If ($k>0)
			aTownName_:=$k
		Else 
			aTownName_:=1
		End if 
	: (Form event code:C388=On Clicked:K2:4)
		
		If (aTownName_>0)
			C_TEXT:C284($newbdept)
			PUSH RECORD:C176([TownLineInfo:73])
			$newbdept:=Get_BDEPT(aTownName_{aTownName_})
			POP RECORD:C177([TownLineInfo:73])
			[TownLineInfo:73]BDEPT:2:=$newbdept
			REDRAW:C174([TownLineInfo:73]BDEPT:2)
		End if 
End case 