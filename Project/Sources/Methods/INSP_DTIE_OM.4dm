//%attributes = {"invisible":true}
// Method: INSP_DTIE_OM
// Description
// Object method for District Tunnel Inspection Engineer pulldown in Inspection forms
// copied from INSP_Insp_DTIE_atxt_OM
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 04/24/13, 16:48:54
	// ----------------------------------------------------
	// First Release
	Mods_2013_04
	// Modified by: Costas Manousakis-(Designer)-(4/9/14 11:59:46)
	Mods_2014_04_bug
	//  `used Case statement
	// Modified by: Costas Manousakis-(Designer)-(2021-10-22T00:00:00 11:51:44)
	Mods_2021_10_bug
	//  `change code to get the name from the aPeople array instead of cleaning names from the Insp_DTIE_atxt array.
End if 

REDRAW:C174(Insp_DTIE_atxt)
Case of 
	: (Form event code:C388=On Load:K2:1)
		
	: ((Form event code:C388=On Clicked:K2:4) & (Insp_DTIE_atxt>0))
		If ((Form event code:C388=On Clicked:K2:4) & (Insp_DTIE_atxt>0))
			C_LONGINT:C283($indx_L; $peopleIndx_L)
			$indx_L:=Insp_DTIE_atxt
			$peopleIndx_L:=Find in array:C230(apeople_ID; Insp_DTIE_aL{$indx_L})
			If ($peopleIndx_L>0)
				vBIE:=apeople{$peopleIndx_L}
			Else 
				vBIE:="Unknown Person ID"
			End if 
		End if 
		POPUPMENUC(->Insp_DTIE_atxt; ->Insp_DTIE_aL; ->[Inspections:27]DBrInspEngr:3)
		If (Form event code:C388=On Clicked:K2:4)
			LogLink(->[Inspections:27]DBrInspEngr:3; ->[Bridge MHD NBIS:1]BIN:3; ->[Inspections:27]BIN:1; ->[Inspections:27]InspID:2; 1; ->[Personnel:42]Person ID:1)
		End if 
		
End case 