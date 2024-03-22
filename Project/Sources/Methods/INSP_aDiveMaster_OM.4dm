//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/18/06, 15:32:21
	// ----------------------------------------------------
	// Method: Method: INSP_aDiveMaster_OM
	// Description
	// Object method for the aDiveMaster Pulldown in Dive forms.
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CMy2
	// Modified by: Costas Manousakis-(Designer)-(4/10/14 16:36:36)
	Mods_2014_04
	//  `removed check for app version (◊LNK_CHANGE_Vers ) - use LogLink for all cases
	// Modified by: Costas Manousakis-(Designer)-(9/25/17 17:19:20)
	Mods_2017_09
	//  `loglink is done in  INSP_UWSaveInsp method 
End if 
C_LONGINT:C283($k)
If (Form event code:C388=On Load:K2:1)
	$k:=Find in array:C230(aPeople_ID; [Inspections:27]TeamLeader:4)
	If ($k>0)
		vDiveMaster:=aPeople{$k}
	Else 
		If ([Inspections:27]TeamLeader:4>0)
			vDiveMaster:="Unknown Dive Master"
		Else 
			vDiveMaster:="Select Dive Master"
		End if 
	End if 
End if 
POPUPMENUC(->aDiveMaster; ->aDiveMasterID; ->[Inspections:27]TeamLeader:4)
If ((Form event code:C388=On Clicked:K2:4) & (aDiveMaster>0))
	vDiveMaster:=aDiveMaster{aDiveMaster}
End if 
If (Form event code:C388=On Clicked:K2:4)
	//LogLink (->[Inspections]TeamLeader;->[Bridge MHD NBIS]BIN;->[Inspections]BIN;->[Inspections]InspID;1;->[Personnel]Person ID)
End if 
REDRAW:C174(aDiveMaster)