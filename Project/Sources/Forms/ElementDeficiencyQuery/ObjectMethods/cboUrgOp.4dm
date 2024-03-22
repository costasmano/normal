//Method: ElementDeficiencyQuery.cboUrgOp1
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 12/11/18, 16:51:34
	// ----------------------------------------------------
	//Created : 
	Mods_2018_12
	
	//I=Immediate
	//A=ASAP
	//P=Prioritize
End if 
//
//equal to
//not equal to
//less than
//less or equal
//greater than
//greater and equal

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		Case of 
			: (Self:C308->=1)
				vUrgOp:=""
			: (Self:C308->=2)
				vUrgOp:="="
			: (Self:C308->=3)
				vUrgOp:="#"
			: (Self:C308->=4)
				vUrgOp:="<"
				If (Substring:C12(cboUrgency{cboUrgency}; 1; 1)="P")
					vUrgOp:="<="
					cboUrgency:=5
					REDRAW:C174(cboUrgency)
				End if 
			: (Self:C308->=5)
				vUrgOp:="<="
			: (Self:C308->=6)
				vUrgOp:=">"
				If (Substring:C12(cboUrgency{cboUrgency}; 1; 1)="I")
					vUrgOp:=">="
					REDRAW:C174(cboUrgency)
				End if 
			: (Self:C308->=7)
				vUrgOp:=">="
		End case 
End case 

OBJECT SET ENABLED:C1123(*; "FindButton"; LSS_EditCheckDefQRY)
//End ElementDeficiencyQuery.cboUrgOp1