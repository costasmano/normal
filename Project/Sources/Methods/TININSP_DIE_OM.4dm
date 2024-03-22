//%attributes = {"invisible":true}
//Method: TININSP_DIE_OM
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/12/16, 12:39:40
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
End if 
//
REDRAW:C174(Insp_DIE_atxt)
If ((Form event code:C388=On Clicked:K2:4) & (Insp_DIE_atxt>0))
	Insp_DIE_txt:=Insp_DIE_atxt{Insp_DIE_atxt}
	If (Substring:C12(Insp_DIE_txt; 1; 4)="D-@")
		Insp_DIE_txt:=Substring:C12(Insp_DIE_txt; 5)
	End if 
	Insp_DIE_txt:=f_TrimStr(Insp_DIE_txt; True:C214; True:C214)
End if 
POPUPMENUC(->Insp_DIE_atxt; ->Insp_DIE_aL; ->[TIN_Inspections:184]DistrInspEng:12)
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
		Insp_DIE_atxt:=0
		
		If ([TIN_Inspections:184]DistrInspEng:12>0)
			Insp_DIE_atxt{0}:=Get_Description(->aPeople; ->aPeople_ID; ->[TIN_Inspections:184]DistrInspEng:12)
		Else 
			Insp_DIE_atxt{0}:="Select...."
		End if 
		Insp_DIE_txt:=""
	End if 
End if 
If (Form event code:C388=On Clicked:K2:4)
	//LogLink (->[TIN_Inspections]DistrInspEng;->[NTI_TunnelInfo]NTI_i1_s;->[TIN_Inspections]NTI_i1_S;->[TIN_Inspections]InspectionID;1;->[Personnel]Person ID)
End if 
//End TININSP_DIE_OM