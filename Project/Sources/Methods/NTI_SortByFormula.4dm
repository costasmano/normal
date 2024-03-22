//%attributes = {"invisible":true}
//Method: NTI_SortByFormula
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 06/05/18, 16:00:29
	// ----------------------------------------------------
	//Created : 
	Mods_2018_06  //Add new Column (TIN) and allow for sort on [NTI_TunnelInfo];"ListBoxOutput"
	//Modified by: Chuck Miller (6/5/18 16:50:23)
	C_TEXT:C284(NTI_SortByFormula; $0)
	C_LONGINT:C283(NTI_SortByFormula; $1)
End if 
//
C_TEXT:C284($0)

C_LONGINT:C283($1)

If ($1=1)
	If (Substring:C12([NTI_TunnelInfo:181]NTI_i1_s:6; 4; 1)="T")
		$0:="A"+Substring:C12([NTI_TunnelInfo:181]NTI_i1_s:6; 4; 3)
	Else 
		$0:="Z"+Substring:C12([NTI_TunnelInfo:181]NTI_i1_s:6; 4; 3)
	End if 
Else 
	If (Substring:C12([NTI_TunnelInfo:181]NTI_i1_s:6; 4; 1)="T")
		$0:="Z"+Substring:C12([NTI_TunnelInfo:181]NTI_i1_s:6; 4; 3)
	Else 
		$0:="A"+Substring:C12([NTI_TunnelInfo:181]NTI_i1_s:6; 4; 3)
	End if 
End if 
//End NTI_SortByFormula