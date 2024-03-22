//%attributes = {"invisible":true}
// Method: INSP_DIE_OM
// Description
// Copied from INSP_aBIE_OM
// 
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 04/24/13, 16:32:05
	// ----------------------------------------------------
	// First Release
	Mods_2013_04
End if 

REDRAW:C174(Insp_DIE_atxt)
If ((Form event code:C388=On Clicked:K2:4) & (Insp_DIE_atxt>0))
	Insp_DIE_txt:=Insp_DIE_atxt{Insp_DIE_atxt}
	If (Substring:C12(Insp_DIE_txt; 1; 4)="D-@")
		Insp_DIE_txt:=Substring:C12(Insp_DIE_txt; 5)
	End if 
	Insp_DIE_txt:=f_TrimStr(Insp_DIE_txt; True:C214; True:C214)
End if 
POPUPMENUC(->Insp_DIE_atxt; ->Insp_DIE_aL; ->[TunnelInspection:152]QA_QC_L:2)
If (Form event code:C388=On Load:K2:1)
	C_LONGINT:C283($indx_L)
	$indx_L:=Insp_DIE_atxt
	If ($indx_L>0)
		Insp_DIE_txt:=Insp_DIE_atxt{Insp_DIE_atxt}
		If (Substring:C12(Insp_DIE_txt; 1; 4)="D-@")
			Insp_DIE_txt:=Substring:C12(Insp_DIE_txt; 5)
		End if 
		Insp_DIE_txt:=f_TrimStr(Insp_DIE_txt; True:C214; True:C214)
	Else 
		Insp_DIE_txt:=""
	End if 
End if 
If (Form event code:C388=On Clicked:K2:4)
	LogLink(->[TunnelInspection:152]QA_QC_L:2; ->[Inspections:27]InspID:2; ->[TunnelInspection:152]InspID:1; ->[TunnelInspection:152]TunnelInspID_L:15; 2; ->[Personnel:42]Person ID:1)
End if 