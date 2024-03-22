//Method: Object Method: [Inspections].CustomInput.bValidate
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/07/13, 16:54:37
	// ----------------------------------------------------
	//Created : 
	Mods_2013_06
	// Modified by: Costas Manousakis-(Designer)-(12/13/19 15:49:51)
	Mods_2019_12
	//  `declare vsForward for interpreted mode
	Mods_NewDownloadCode  //Make changes to address new upload and download code
	//Add call to Synch_ReturnForward to reset new style vsForward
	//Modified by: Chuck Miller (1/11/22 14:31:13)
	// Modified by: Costas Manousakis-(Designer)-(2023-03-22 18:39:26)
	Mods_2023_03
	//  `after saving - unload and reload record in RO mode - disable the save abd edit type btns
End if 
//
InitChangeStack(1)
//find changes to all fields
PushAllChanges(1; ->[Inspections:27]; ->[Inspections:27]BIN:1; ->[Inspections:27]InspID:2)  //Just in case skip the key fields

If (Size of array:C274(ptr_changes{1})>0)
	C_TEXT:C284($msg_txt)
	$msg_txt:=""
	C_LONGINT:C283($loop_L)
	$msg_txt:=Field name:C257(ptr_changes{1}{1})
	
	For ($loop_L; 2; Size of array:C274(ptr_changes{1}))
		$msg_txt:=$msg_txt+", "+Field name:C257(ptr_changes{1}{$loop_L})
	End for 
	$msg_txt:="Changed fields "+$msg_txt+" - Save them?"
	CONFIRM:C162($msg_txt; "Save"; "Revert")
	If (OK=1)
		C_TEXT:C284(VSFORWARD)  // need this only for interpreted mode
		vsForward:=Synch_ReturnForward([Bridge MHD NBIS:1]Item2:60; [Bridge MHD NBIS:1]InspResp:173; [Inspections:27]Insp Type:6; [Inspections:27]TeamLeader:4)
		FlushGrpChgs(1; ->[Bridge MHD NBIS:1]BIN:3; ->[Inspections:27]BIN:1; ->[Inspections:27]InspID:2; 1)
		SAVE RECORD:C53([Inspections:27])
		UNLOAD RECORD:C212([Inspections:27])
		READ ONLY:C145([Inspections:27])
		LOAD RECORD:C52([Inspections:27])
		OBJECT SET ENABLED:C1123(*; "bValidate"; False:C215)
		OBJECT SET ENABLED:C1123(*; "Button1"; False:C215)
	Else 
		LOAD RECORD:C52([Inspections:27])
	End if 
	
Else 
	ALERT:C41("No Changes made!")
End if 

//End Object Method: [Inspections].CustomInput.bValidate