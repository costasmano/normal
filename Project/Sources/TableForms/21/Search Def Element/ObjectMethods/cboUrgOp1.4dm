If (False:C215)
	Mods_2004_CM12
	
End if 

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
					cboUrgency:=3
					REDRAW:C174(cboUrgency)
				End if 
			: (Self:C308->=5)
				vUrgOp:="<="
			: (Self:C308->=6)
				vUrgOp:=">"
				If (Substring:C12(cboUrgency{cboUrgency}; 1; 1)="I")
					vUrg:="A"
					cboUrgency:=3
					REDRAW:C174(cboUrgency)
				End if 
			: (Self:C308->=7)
				vUrgOp:=">="
		End case 
End case 


//equal to
//not equal to
//less than
//less or equal
//greater than
//greater and equal