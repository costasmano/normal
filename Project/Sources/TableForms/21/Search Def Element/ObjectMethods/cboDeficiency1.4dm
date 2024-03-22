If (False:C215)
	Mods_2004_CM12
End if 

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		Case of 
			: (Self:C308->=1)
				vDef:=""
			: (Self:C308->=2)
				vDef:="M"
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


//M=Minor Deficiency
//S=Severe/Major Deficiency
//C-S=Critical Structural Deficiency
//C-H=Critical Hazard Deficiency