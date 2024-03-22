//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/18/06, 15:28:34
	// ----------------------------------------------------
	// Method: INSP_aUOE_OM
	// Description
	// Object method for the aUOE Pulldown in Dive Insp forms.
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CMy2
	// Modified by: Costas Manousakis-(Designer)-(4/10/14 16:36:36)
	Mods_2014_04
	//  `removed check for app version (◊LNK_CHANGE_Vers ) - use LogLink for all cases
	// Modified by: Costas Manousakis-(Designer)-(9/25/17 17:19:58)
	Mods_2017_09
	//  `loglink is done in  INSP_UWSaveInsp method 
End if 
C_LONGINT:C283($k)
If (Form event code:C388=On Load:K2:1)
	//Sep-2002 Removed pulldown for UOE.
	$k:=Find in array:C230(aPeople_ID; [Inspections:27]DBrInspEngr:3)
	If ($k>0)
		vUOE:=aPeople{$k}
	Else 
		If ([Inspections:27]DBrInspEngr:3>0)
			vUOE:="Unknown UnderWater Engr."
		Else 
			[Inspections:27]DBrInspEngr:3:=<>UOEID
			//LogLink (->[Inspections]DBrInspEngr;->[Bridge MHD NBIS]BIN;->[Inspections]BIN;->[Inspections]InspID;1;->[Personnel]Person ID)
			vUOE:=<>UOEName
		End if 
	End if 
End if 
POPUPMENUC(->aUOE; ->aUOEID; ->[Inspections:27]DBrInspEngr:3)
If ((Form event code:C388=On Clicked:K2:4) & (aUOE>0))
	vUOE:=aUOE{aUOE}
End if 
If (Form event code:C388=On Clicked:K2:4)
	//LogLink (->[Inspections]DBrInspEngr;->[Bridge MHD NBIS]BIN;->[Inspections]BIN;->[Inspections]InspID;1;->[Personnel]Person ID)
End if 
REDRAW:C174(aUOE)