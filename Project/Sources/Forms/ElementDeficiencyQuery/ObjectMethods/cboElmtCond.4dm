//Method: ElementDeficiencyQuery.cboElmtCond
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 02/14/19, 16:17:05
	// ----------------------------------------------------
	//Created : 
	Mods_2019_02
End if 
//
C_TEXT:C284($ConfirmMessage_txt)

Case of 
	: (cboElmtCond{cboElmtCond}="H@")
		$ConfirmMessage_txt:="You can only Choose = when selecting "+cboElmtCond{cboElmtCond}
	: (cboElmtCond{cboElmtCond}="R@")
		$ConfirmMessage_txt:="You can only Choose = when selecting "+cboElmtCond{cboElmtCond}
	: (cboElmtCond{cboElmtCond}="X@")
		$ConfirmMessage_txt:="You can only Choose = when selecting "+cboElmtCond{cboElmtCond}
		
	Else 
		$ConfirmMessage_txt:=""
		
		
End case 
If (vElmtCondOp="") | (vElmtCondOp="=") | ($ConfirmMessage_txt="")
	
Else 
	CONFIRM:C162($ConfirmMessage_txt; "Change to ="; "Reset Condition")
	If (OK=1)
		cboElmtCondOp:=2
		vElmtCondOp:="="
	Else 
		cboElmtCond:=0
	End if 
End if 
OBJECT SET ENABLED:C1123(*; "FindButton"; LSS_EditCheckDefQRY)

//End ElementDeficiencyQuery.cboElmtCond