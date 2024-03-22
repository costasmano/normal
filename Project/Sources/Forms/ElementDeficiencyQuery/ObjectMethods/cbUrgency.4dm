//Method: ElementDeficiencyQuery.cbUrgency1
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 12/11/18, 16:49:40
	// ----------------------------------------------------
	//Created : 
	Mods_2018_12
End if 
//
OBJECT SET ENABLED:C1123(*; "Urgency"; Not:C34(cbUrgency=0))
//OBJECT SET ENABLED(cboUrgency;Not(cbUrgency=0))

If (cbUrgency=0)
	cboUrgOp:=0
	cboUrgency:=0
	vUrgOp:=""
	vUrg:=""
	OBJECT SET TITLE:C194(*; "UrgencyDesc"; "")
End if 
OBJECT SET ENABLED:C1123(*; "FindButton"; LSS_EditCheckDefQRY)

//End ElementDeficiencyQuery.cbUrgency1