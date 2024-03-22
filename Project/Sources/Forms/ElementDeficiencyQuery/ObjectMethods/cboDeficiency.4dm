//Method: ElementDeficiencyQuery.cboDeficiency1
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 12/11/18, 16:45:32
	// ----------------------------------------------------
	//Created : 
	Mods_2018_12
End if 
//
//M=Minor Deficiency
//S=Severe/Major Deficiency
//C-S=Critical Structural Deficiency
//C-H=Critical Hazard Deficiency


Case of 
	: (Form event code:C388=On Clicked:K2:4)
		Case of 
			: (Self:C308->=1)
				vDef:=""
			: (Self:C308->=2)
				vDef:="M"
				If (vDefOp="<")
					vDefOp:="<="
					cboDefOp:=5
					REDRAW:C174(cboDefOp)
				End if 
			: (Self:C308->=3)
				vDef:="S"
			: (Self:C308->=4)
				vDef:="C-S"
			: (Self:C308->=5)
				vDef:="C-H"
				If (vDefOp=">")
					vDefOp:=">="
					cboDefOp:=7
					REDRAW:C174(cboDefOp)
				End if 
				
		End case 
End case 
OBJECT SET ENABLED:C1123(*; "FindButton"; LSS_EditCheckDefQRY)
//End ElementDeficiencyQuery.cboDeficiency1