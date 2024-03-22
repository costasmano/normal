//Method: ElementDeficiencyQuery.cbElmtCond
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 12/11/18, 16:56:37
	// ----------------------------------------------------
	//Created : 
	Mods_2018_12
	
End if 
//
OBJECT SET ENABLED:C1123(*; "Rating"; Not:C34(cbElmtCond=0))

//OBJECT SET ENABLED(cboElmtCondOp;Not(cbElmtCond=0))
//OBJECT SET ENABLED(cboElmtCond;Not(cbElmtCond=0))
If (cbElmtCond=0)
	cboElmtCondOp:=0
	cboElmtCond:=0
	vElmtCondOp:=""
	OBJECT SET TITLE:C194(*; "RatingDesc"; "")
End if 
OBJECT SET ENABLED:C1123(*; "FindButton"; LSS_EditCheckDefQRY)

//End ElementDeficiencyQuery.cbElmtCond