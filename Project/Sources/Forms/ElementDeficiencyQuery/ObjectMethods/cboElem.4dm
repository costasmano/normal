//Method: ElementDeficiencyQuery.cboElem
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 02/19/19, 15:00:44
	// ----------------------------------------------------
	//Created : 
	Mods_2019_02
End if 
//
If (cboElem>0) & (cboInspType=0)
	cboInspType:=1
End if 
OBJECT SET ENABLED:C1123(*; "FindButton"; LSS_EditCheckDefQRY)
//End ElementDeficiencyQuery.cboElem