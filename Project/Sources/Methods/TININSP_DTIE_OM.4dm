//%attributes = {"invisible":true}
//Method: TININSP_DTIE_OM
//Description
// Object method for District Tunnel Inspection Engineer pulldown in Inspection forms
// copied from INSP_Insp_DTIE_atxt_OM
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/12/16, 12:36:18
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
	
	// Modified by: Costas Manousakis-(Designer)-(2021-10-22T00:00:00 17:17:51)
	Mods_2021_10
	//  `change code to get the name from the aPeople array instead of cleaning names from the Insp_DTIE_atxt array.
End if 
//

REDRAW:C174(Insp_DTIE_atxt)
Case of 
	: (Form event code:C388=On Load:K2:1)
		If ([TIN_Inspections:184]DistrTnlInspEng:22>0)
			POPUPMENUC(->Insp_DTIE_atxt; ->Insp_DTIE_aL; ->[TIN_Inspections:184]DistrTnlInspEng:22)
			C_LONGINT:C283($indx_L)
			$indx_L:=Insp_DTIE_atxt
			If (Insp_DTIE_atxt<0)  //nothing in the Insp_DTIE_atxt list
				Insp_DTIE_atxt:=0
				Insp_DTIE_atxt{0}:=Get_Description(->aPeople; ->aPeople_ID; ->[TIN_Inspections:184]DistrTnlInspEng:22)
			End if 
		Else 
			Insp_DTIE_atxt:=0
			Insp_DTIE_atxt{0}:="Select Dist.Tnl.Insp.Eng."
		End if 
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
		POPUPMENUC(->Insp_DTIE_atxt; ->Insp_DTIE_aL; ->[TIN_Inspections:184]DistrTnlInspEng:22)
		If (Form event code:C388=On Clicked:K2:4)
			LogLink(->[TIN_Inspections:184]DistrTnlInspEng:22; ->[NTI_TunnelInfo:181]NTI_i1_s:6; ->[TIN_Inspections:184]NTI_i1_S:1; ->[TIN_Inspections:184]InspectionID:2; 1; ->[Personnel:42]Person ID:1)
		End if 
		
End case 
//End TININSP_DTIE_OM