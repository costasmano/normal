//%attributes = {"invisible":true}
// ----------------------------------------------------
// PRJ_MakeSelection
// User name (OS): cjmiller
// Date and time: 01/19/06, 14:18:43
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
End if 
C_LONGINT:C283($1)  // item selected
PRJ_Item1_atxt:=$1
If (PRJ_Item1_atxt>1)
	Case of 
		: (<>SelectionOption_txt="Bridge")
			<>PRJ_SelectedData_txt:=PRJ_Item1_atxt{$1}
			
			
		: (<>SelectionOption_txt="FederalAid")
			<>PRJ_SelectedData_txt:=PRJ_Item1_atxt{$1}
			
	End case 
	If (Form event code:C388=On Double Clicked:K2:5)
		POST OUTSIDE CALL:C329(<>ProjectProcess_l)
		HIDE PROCESS:C324(Current process:C322)
		PAUSE PROCESS:C319(Current process:C322)
		
	End if 
End if 
//End PRJ_MakeSelection