//%attributes = {"invisible":true}
//Method: INSP_ConsProjMgr_OM
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/24/13, 16:12:21
	// ----------------------------------------------------
	//Created : 
	Mods_2013_04
	// Modified by: Costas Manousakis-(Designer)-(3/22/21 10:17:32)
	Mods_2021_03
	//  `If the ID is not in the list of Prj mgrs, get the name from the global list (aPeople / aPeople_ID)
End if 

REDRAW:C174(TnlInspPrjMgr_atxt)
POPUPMENUC(->TnlInspPrjMgr_atxt; ->TnlInspPrjMgrID_aL; ->[Inspections:27]ConsQCEngrID:205)
If (Form event code:C388=On Load:K2:1)
	C_LONGINT:C283($indx_L)
	$indx_L:=TnlInspPrjMgr_atxt
	If ($indx_L>0)
		vTnlInspProjMgr:=TnlInspPrjMgr_atxt{TnlInspPrjMgr_atxt}
	Else 
		If ([Inspections:27]ConsQCEngrID:205>0)
			//get from all people
			$indx_L:=Find in array:C230(aPeople_ID; [Inspections:27]ConsQCEngrID:205)
			
			If ($indx_L>0)
				vTnlInspProjMgr:=aPeople{$indx_L}
			Else 
				vTnlInspProjMgr:="Unknown Person ID"
			End if 
			
		Else 
			vTnlInspProjMgr:=""
		End if 
		
	End if 
End if 
If (Form event code:C388=On Clicked:K2:4)
	If (TnlInspPrjMgr_atxt>0)
		vTnlInspProjMgr:=TnlInspPrjMgr_atxt{TnlInspPrjMgr_atxt}
		LogLink(->[Inspections:27]ConsQCEngrID:205; ->[Bridge MHD NBIS:1]BIN:3; ->[Inspections:27]BIN:1; ->[Inspections:27]InspID:2; 1; ->[Personnel:42]Person ID:1)
	End if 
End if 
//End INSP_TnlInspProjMgr_OM