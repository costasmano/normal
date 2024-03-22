If (False:C215)
	
	Mods_2004_CM12
	
End if 

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		Case of 
			: (Self:C308->=1)
				vUrg:=""
				
			: (Self:C308->=2)
				vUrg:="I"
				If (vUrgOp=">")
					cboUrgOp:=7
					vUrgOp:=">="
					REDRAW:C174(cboUrgOp)
				End if 
				
			: (Self:C308->=3)
				vUrg:="A"
				
			: (Self:C308->=4)
				vUrg:="P"
				If (vUrgOp="<")
					cboUrgOp:=5
					vUrgOp:="<="
					REDRAW:C174(cboUrgOp)
				End if 
		End case 
End case 


//I=Immediate
//A=ASAP
//P=Prioritize