//%attributes = {"invisible":true}
//Method: TININSP_ConsProjMgr_OM
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/12/16, 12:47:18
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
End if 
//
REDRAW:C174(TnlInspPrjMgr_atxt)
POPUPMENUC(->TnlInspPrjMgr_atxt; ->TnlInspPrjMgrID_aL; ->[TIN_Inspections:184]ProjManager:14)
If (Form event code:C388=On Load:K2:1)
	C_LONGINT:C283($indx_L)
	$indx_L:=TnlInspPrjMgr_atxt
	If ($indx_L>1)
		vTnlInspProjMgr:=TnlInspPrjMgr_atxt{TnlInspPrjMgr_atxt}
	Else 
		TnlInspPrjMgr_atxt:=0
		If ([TIN_Inspections:184]ProjManager:14>0)
			TnlInspPrjMgr_atxt{0}:=Get_Description(->aPeople; ->aPeople_ID; ->[TIN_Inspections:184]ProjManager:14)
		Else 
			TnlInspPrjMgr_atxt{0}:="Select Proj. Mgr."
		End if 
		vTnlInspProjMgr:=""
	End if 
End if 
If (Form event code:C388=On Clicked:K2:4)
	If (TnlInspPrjMgr_atxt>0)
		vTnlInspProjMgr:=TnlInspPrjMgr_atxt{TnlInspPrjMgr_atxt}
	End if 
End if 

//End TININSP_ConsProjMgr_OM