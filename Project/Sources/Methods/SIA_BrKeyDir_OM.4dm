//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/22/09, 09:10:07
	// ----------------------------------------------------
	// Method: SIA_BrKeyDir_OM
	// Description
	//SC aDirDescr_ on layout [Bridge MHD NBIS];"BDEPT Input".
	//Copyright © 1997, Thomas D. Nee, All Rights Reserved.
	
	//Pop up menu for Structure Number Directional Indicator.
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2009_12
End if 

REDRAW:C174(aDirDescr_)
Case of 
	: ((Form event code:C388=On Load:K2:1) | (aDirDescr_=0))
		aDirDescr_:=Find in array:C230(aDirIndex_; Substring:C12([Bridge MHD NBIS:1]Bridge Key:2; 11; 1))
		If (aDirDescr_<=0)  //Just in case nothing was found in array
			aDirDescr_:=0
		End if 
	: (Form event code:C388=On Clicked:K2:4)
		[Bridge MHD NBIS:1]Bridge Key:2:=Change string:C234([Bridge MHD NBIS:1]Bridge Key:2; aDirIndex_{aDirDescr_}; 11)
		PushChange(1; ->[Bridge MHD NBIS:1]Bridge Key:2)
End case 
