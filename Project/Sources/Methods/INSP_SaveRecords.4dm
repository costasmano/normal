//%attributes = {"invisible":true}
// Method: INSP_SaveRecords
// Description
// Save the Inspection records [Inspection] [Combined; [BMS Inspection];
// Extracted code from G_InspSaveInspection
// Parameters
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/16/05, 15:08:10
	// ----------------------------------------------------
	// ----------------------------------------------------
	Mods_2005_CM20
	// Modified by: Costas Manousakis-(Designer)-(5/1/13 17:30:33)
	Mods_2013_05
	//  `Added Tunnel Inspection
	// Modified by: Costas Manousakis-(Designer)-(10/24/13 11:19:39)
	Mods_2013_10
	//  `use  method  INSP_IsInspRoutine_b to check if inspection is a routine one
	// Modified by: Costas Manousakis-(Designer)-(8/11/14 12:56:23)
	Mods_2014_08
	//  `Added inspection type TOV to the INSP_IsInspRoutine_b check
	// Modified by: Costas Manousakis-(Designer)-(1/6/15 14:16:23)
	Mods_2015_01
	//  `check for tunnel inspections starting with "T"
	// Modified by: Costas Manousakis-(Designer)-(1/16/19 17:27:40)
	Mods_2019_01_bug
	//  `Make sure there is a BMS Inspection record if there are NBEs for this inspection. 
	//  `Also recalculate HI - CallReference #595
	// Modified by: Costas Manousakis-(Designer)-(5/4/20 13:45:09)
	Mods_2020_05
	//  `remove set cursor commands - added redraw window at the end
	// Modified by: Costas Manousakis-(Designer)-(5/5/20 14:23:28)
	Mods_2020_05
	//  `added a resize of window at the end -  Removed it ; does not help
End if 
//SET CURSOR(4)
//Save changes to sequences
//TRACE
If (NTI_ImageSortNeeded_b)
	
	EXECUTE METHOD IN SUBFORM:C1085("ListOfImages"; "NTI_ApplyImageSort")
	
End if 
If ([Inspections:27]TeamLeader:4#0) & (Old:C35([Inspections:27]TeamLeader:4)=0)
	vsForward:=Synch_ReturnForward([Bridge MHD NBIS:1]Item2:60; [Bridge MHD NBIS:1]InspResp:173; [Inspections:27]Insp Type:6; [Inspections:27]TeamLeader:4)
End if 
//Check if it is a combined inspection
If (INSP_IsInspRoutine_b | ([Inspections:27]Insp Type:6="TOV"))
	C_LONGINT:C283($vlNumSpecMems)
	$vlNumSpecMems:=G_Insp_CountSpMs
	If ([Inspections:27]InspRtnSpcMemFlag:209#($vlNumSpecMems>0))
		[Inspections:27]InspRtnSpcMemFlag:209:=($vlNumSpecMems>0)
		If (Substring:C12(<>Version; 1; (Position:C15(" "; <>Version)-1))>="5.0")
			PushChange(1; ->[Inspections:27]InspRtnSpcMemFlag:209)
		End if 
	End if 
End if 

//check if any changes made
If (Size of array:C274(ptr_Changes{1})>0)
	[Inspections:27]DateModified:137:=Current date:C33(*)
	[Inspections:27]TimeModified:138:=Current time:C178(*)
	PushChange(1; ->[Inspections:27]DateModified:137)
	PushChange(1; ->[Inspections:27]TimeModified:138)
End if 
//##Save changes made to file
FlushGrpChgs(1; ->[Bridge MHD NBIS:1]BIN:3; ->[Inspections:27]BIN:1; ->[Inspections:27]InspID:2; 1)
SAVE RECORD:C53([Inspections:27])

If ([Inspections:27]Insp Type:6="T@")  //tunnel inspections
	FlushGrpChgs(5; ->[Inspections:27]InspID:2; ->[TunnelInspection:152]InspID:1; ->[TunnelInspection:152]TunnelInspID_L:15; 2)
	SAVE RECORD:C53([TunnelInspection:152])
End if 

INSP_CheckLinks

C_LONGINT:C283($NBECount_L; $CurrInspID_L)
$CurrInspID_L:=[Inspections:27]InspID:2
Begin SQL
	select count(*) from [pon_elem_insp] where [pon_elem_insp].INSPID = :$CurrInspID_L
	into :$NBECount_L ;
End SQL
If ($NBECount_L>0) & Not:C34([Combined Inspections:90]BMSInspID:3>0)
	//there are NBEs but no BMS Inspections record - need to add one
	G_AddPontisToCombined
	INSP_HICalcControl("ALL")  //Do a complete calculation 
End if 
If ([Combined Inspections:90]BMSInspID:3>0)
	If (Is record loaded:C669([BMS Inspections:44]))
		If ([BMS Inspections:44]Insp Date:4#[Inspections:27]Insp Date:78)
			[BMS Inspections:44]Insp Date:4:=[Inspections:27]Insp Date:78
			PushChange(3; ->[BMS Inspections:44]Insp Date:4)
		End if 
		FlushGrpChgs(3; ->[Bridge MHD NBIS:1]BIN:3; ->[BMS Inspections:44]BIN:2; ->[BMS Inspections:44]Inspection ID:1; 1)
		SAVE RECORD:C53([BMS Inspections:44])
	End if 
End if 

If ([Combined Inspections:90]InspDate:4#[Inspections:27]Insp Date:78)
	[Combined Inspections:90]InspDate:4:=[Inspections:27]Insp Date:78
	PushChange(4; ->[Combined Inspections:90]InspDate:4)
End if 
FlushGrpChgs(4; ->[Bridge MHD NBIS:1]BIN:3; ->[Combined Inspections:90]BIN:1; ->[Combined Inspections:90]ID:6; 1)
SAVE RECORD:C53([Combined Inspections:90])

VALIDATE TRANSACTION:C240  //validate all changes made in include forms etc.

FLUSH CACHE:C297  //make sure all is saved...
//SET CURSOR(0)