//Method: ElementDeficiencyQuery.cbDeficiency1
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 12/11/18, 16:44:59
	// ----------------------------------------------------
	//Created : 
	Mods_2018_12
	
End if 
//
OBJECT SET ENABLED:C1123(*; "Deficiency"; Not:C34(cbDeficiency=0))
//OBJECT SET ENABLED(cboDefOp;Not(cbDeficiency=0))
//OBJECT SET ENABLED(cboDeficiency;Not(cbDeficiency=0))
If (cbDeficiency=0)
	cboDefOp:=0
	cboDeficiency:=0
	vDefOp:=""
	vDef:=""
	REDRAW:C174(cboDeficiency)
	OBJECT SET TITLE:C194(*; "DeficiencyDesc"; "")
	OBJECT SET VISIBLE:C603(*; "DEF_Warning"; False:C215)
	OBJECT SET VISIBLE:C603(*; "SelectedCategory"; (cbDeficiency=1))
End if 
OBJECT SET ENABLED:C1123(*; "FindButton"; LSS_EditCheckDefQRY)
//End ElementDeficiencyQuery.cbDeficiency1