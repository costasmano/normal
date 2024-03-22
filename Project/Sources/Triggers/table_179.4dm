// Method: Trigger: PON_ELEM_INSP
// Description
// 
// 
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 02/25/15, 09:25:07
	// ----------------------------------------------------
	// First Release
	Mods_2015_02
End if 

If (<>DatabaseStructureName_txt="MHD BMS")
	
	Case of 
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)
			[PON_ELEM_INSP:179]ELEM_MODTIME:18:=ISODateTime(Current date:C33(*); Current time:C178(*))
		: (Trigger event:C369=On Saving New Record Event:K3:1)
			[PON_ELEM_INSP:179]ELEM_MODTIME:18:=ISODateTime(Current date:C33(*); Current time:C178(*))
		: (Trigger event:C369=On Deleting Record Event:K3:3)
	End case 
End if 
