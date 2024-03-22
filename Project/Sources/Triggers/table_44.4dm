If (False:C215)
	// ----------------------------------------------------
	// Trigger: BMS Inspections
	// User name (OS): 
	// Date and time: 05/24/05, 16:27:12
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
			[BMS Inspections:44]DateModified:10:=Current date:C33(*)
			[BMS Inspections:44]TimeModified:11:=Current time:C178(*)
		: (Trigger event:C369=On Saving New Record Event:K3:1)
			[BMS Inspections:44]DateModified:10:=Current date:C33(*)
			[BMS Inspections:44]TimeModified:11:=Current time:C178(*)
		: (Trigger event:C369=On Deleting Record Event:K3:3)
	End case 
End if 
//End Trigger: BMS Inspections