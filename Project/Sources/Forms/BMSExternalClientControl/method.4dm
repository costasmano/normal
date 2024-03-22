//Form Method: "BMSExternalClientControl"
//Description
// form created for user BMSExternal server - will be launched at startup
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 08/11/20, 11:47:17
	// ----------------------------------------------------
	//Created : 
	Mods_2020_08_bug
End if 
//
Case of 
		
	: (Form event code:C388=On Outside Call:K2:11)
		If (<>fQuit)
			CANCEL:C270
		End if 
End case 

//End BMSExternalClientControl