If (False:C215)
	// ----------------------------------------------------
	// Trigger: Cond Units
	// User name (OS): 
	// Date and time: 05/24/05, 16:24:46
	// ----------------------------------------------------
	// Description
	// 
	//
	// Parameters
	Mods_2005_CJM04
	Mods_2009_10  //v451 r001 CJ Miller`10/22/09, 11:50:43   `Add check to make sure triggers run only on inside data base
End if 

If (<>DatabaseStructureName_txt="MHD BMS")
	
	Case of 
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)
			[Cond Units:45]DateModified_d:15:=Current date:C33(*)
		: (Trigger event:C369=On Saving New Record Event:K3:1)
			[Cond Units:45]DateModified_d:15:=Current date:C33(*)
		: (Trigger event:C369=On Deleting Record Event:K3:3)
	End case 
End if 
//End Trigger: Cond Units