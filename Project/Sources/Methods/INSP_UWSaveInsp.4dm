//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/19/06, 14:03:46
	// ----------------------------------------------------
	// Method: INSP_UWSaveInsp
	// Description
	// Execute code for saving a UW inspection
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CMy2
	// Modified by: Costas Manousakis-(Designer)-(4/10/14 16:36:36)
	Mods_2014_04
	//  `removed check for app version (◊LNK_CHANGE_Vers ) - use LogLink for all cases
	// Modified by: Costas Manousakis-(Designer)-(9/22/17 17:34:48)
	Mods_2017_09
	//  `if DBIE or TMldr are zeroed out, just do a pushchange
	// Modified by: Costas Manousakis-(Designer)-(5/4/20 14:23:28)
	Mods_2020_05
	//  `added resequence of images and a redraw window at the end
	// Modified by: Costas Manousakis-(Designer)-(5/5/20 14:23:28)
	Mods_2020_05
	//  `added a resize of window at the end  -  Removed it does not help
	
End if 
//Save changes to sequences
If (NTI_ImageSortNeeded_b)
	EXECUTE METHOD IN SUBFORM:C1085("ListOfImages"; "NTI_ApplyImageSort")
End if 


TimeStamp_ut(->[Inspections:27]; ->[Inspections:27]DateCreated:135; ->[Inspections:27]TimeCreated:136; ->[Inspections:27]DateModified:137; ->[Inspections:27]TimeModified:138)
PushChange(1; ->[Inspections:27]DateModified:137)
PushChange(1; ->[Inspections:27]TimeModified:138)
If ([Inspections:27]DBrInspEngr:3#Old:C35([Inspections:27]DBrInspEngr:3))
	
	If ([Inspections:27]DBrInspEngr:3>0)
		LogLink(->[Inspections:27]DBrInspEngr:3; ->[Bridge MHD NBIS:1]BIN:3; ->[Inspections:27]BIN:1; ->[Inspections:27]InspID:2; 1; ->[Personnel:42]Person ID:1)
	Else 
		PushChange(1; ->[Inspections:27]DBrInspEngr:3)
	End if 
	
End if 
If ([Inspections:27]TeamLeader:4#Old:C35([Inspections:27]TeamLeader:4))
	
	If ([Inspections:27]TeamLeader:4>0)
		LogLink(->[Inspections:27]TeamLeader:4; ->[Bridge MHD NBIS:1]BIN:3; ->[Inspections:27]BIN:1; ->[Inspections:27]InspID:2; 1; ->[Personnel:42]Person ID:1)
	Else 
		PushChange(1; ->[Inspections:27]TeamLeader:4)
	End if 
	
End if 

//##Save changes made to file
//3-3-2001 ASL this was missing
FlushGrpChgs(1; ->[Bridge MHD NBIS:1]BIN:3; ->[Inspections:27]BIN:1; ->[Inspections:27]InspID:2; 1)
FlushGrpChgs(4; ->[Bridge MHD NBIS:1]BIN:3; ->[Combined Inspections:90]BIN:1; ->[Combined Inspections:90]ID:6; 1)
SAVE RECORD:C53([Combined Inspections:90])

//REDRAW WINDOW
//C_LONGINT($wL;$wT;$WR;$Wb)
//GET WINDOW RECT($wL;$wT;$WR;$Wb)
//SET WINDOW RECT($wL;$wT;$WR+1;$Wb)
//SET WINDOW RECT($wL;$wT;$WR;$Wb)