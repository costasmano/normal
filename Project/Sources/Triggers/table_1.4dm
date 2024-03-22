If (False:C215)
	// ----------------------------------------------------
	// Trigger: Bridge MHD NBIS
	// User name (OS): 
	// Date and time: 05/24/05, 16:26:09
	// ----------------------------------------------------
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2005_CJM04
	Mods_2009_10  //v451 r001 CJ Miller`10/22/09, 11:50:43   `Add check to make sure triggers run only on inside data base
End if 

If (<>DatabaseStructureName_txt="MHD BMS")
	Case of 
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)
			[Bridge MHD NBIS:1]DateModified:194:=Current date:C33(*)
			[Bridge MHD NBIS:1]TimeModified:195:=Current time:C178(*)
		: (Trigger event:C369=On Saving New Record Event:K3:1)
			[Bridge MHD NBIS:1]DateModified:194:=Current date:C33(*)
			[Bridge MHD NBIS:1]TimeModified:195:=Current time:C178(*)
			
		: (Trigger event:C369=On Deleting Record Event:K3:3)
	End case 
End if 
//End Trigger: Bridge MHD NBIS