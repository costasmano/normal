//%attributes = {"invisible":true}
// Method: INSP_aBIE_OM
// Description
// Object method for District Bridge Engineer pulldown in Inspection forms
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/06/06, 09:34:41
	// ----------------------------------------------------
	Mods_2006_CMy2
	// Modified by: Costas Manousakis-(Designer)-(1/7/13 11:51:17)
	Mods_2013_01
	//  `Present better display of vDBIE variable
	// Modified by: Costas Manousakis-(Designer)-(4/10/14 16:36:36)
	Mods_2014_04
	//  `removed check for app version (◊LNK_CHANGE_Vers ) - use LogLink for all cases
	// Modified by: Costas Manousakis-(Designer)-(2021-10-22 11:51:44)
	Mods_2021_10_bug
	//  `change code to get the name from the aPeople array instead of cleaning names from the aBIE array.
End if 

REDRAW:C174(aBIE)
If ((Form event code:C388=On Clicked:K2:4) & (aBIE>0))
	C_LONGINT:C283($indx_L; $peopleIndx_L)
	$indx_L:=aBIE
	$peopleIndx_L:=Find in array:C230(apeople_ID; aBIE_ID{$indx_L})
	If ($peopleIndx_L>0)
		vBIE:=apeople{$peopleIndx_L}
	Else 
		vBIE:="Unknown Person ID"
	End if 
	
End if 
POPUPMENUC(->aBIE; ->aBIE_ID; ->[Inspections:27]DBrInspEngr:3)
If (Form event code:C388=On Clicked:K2:4)
	LogLink(->[Inspections:27]DBrInspEngr:3; ->[Bridge MHD NBIS:1]BIN:3; ->[Inspections:27]BIN:1; ->[Inspections:27]InspID:2; 1; ->[Personnel:42]Person ID:1)
	PushChange(1; ->[Inspections:27]DateModified:137)
	If ([BMS Inspections:44]Inspection ID:1>0)
		[BMS Inspections:44]DBrInspEngr:5:=[Inspections:27]DBrInspEngr:3
		LogLink(->[BMS Inspections:44]DBrInspEngr:5; ->[Bridge MHD NBIS:1]BIN:3; ->[BMS Inspections:44]BIN:2; ->[BMS Inspections:44]Inspection ID:1; 1; ->[Personnel:42]Person ID:1)
		PushChange(3; ->[BMS Inspections:44]DateModified:10)
		SAVE RECORD:C53([BMS Inspections:44])
	End if 
End if 