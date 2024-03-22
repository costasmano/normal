//%attributes = {"invisible":true}
//Method: INSP_SaveTunnelInsp
//Description
// NOT IN USE**********
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/29/13, 10:50:09
	// ----------------------------------------------------
	//Created : 
	Mods_2013_04
End if 
//
SET CURSOR:C469(4)
//Check if it is a combined inspection
If (([Inspections:27]Insp Type:6="TAL") | ([Inspections:27]Insp Type:6="TOV"))
	C_LONGINT:C283($vlNumSpecMems)
	$vlNumSpecMems:=G_Insp_CountSpMs
	If ([Inspections:27]InspRtnSpcMemFlag:209#($vlNumSpecMems>0))
		[Inspections:27]InspRtnSpcMemFlag:209:=($vlNumSpecMems>0)
		PushChange(1; ->[Inspections:27]InspRtnSpcMemFlag:209)
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

FlushGrpChgs(5; ->[Inspections:27]InspID:2; ->[TunnelInspection:152]InspID:1; ->[TunnelInspection:152]TunnelInspID_L:15; 2)
SAVE RECORD:C53([TunnelInspection:152])

INSP_CheckLinks

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
SET CURSOR:C469(0)
//End INSP_SaveTunnelInsp