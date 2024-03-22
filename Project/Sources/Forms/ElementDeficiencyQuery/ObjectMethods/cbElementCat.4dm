//Method: ElementDeficiencyQuery.cbElementCat
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
OBJECT SET ENABLED:C1123(cboInspType; Not:C34(cbElementCat=0))
OBJECT SET ENABLED:C1123(cboElem; Not:C34(cbElementCat=0))
If (cbElmtCond=0)
	cboInspType:=0
	cboElem:=0
	
End if 
OBJECT SET ENABLED:C1123(*; "FindButton"; LSS_EditCheckDefQRY)

//End ElementDeficiencyQuery.cbUrgency1