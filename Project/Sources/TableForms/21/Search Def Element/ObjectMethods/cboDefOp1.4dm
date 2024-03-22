If (False:C215)
	Mods_2004_CM12
End if 

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		Case of 
			: (Self:C308->=1)
				vDefOp:=""
			: (Self:C308->=2)
				vDefOp:="="
			: (Self:C308->=3)
				vDefOp:="#"
			: (Self:C308->=4)
				vDefOp:="<"
			: (Self:C308->=5)
				vDefOp:="<="
			: (Self:C308->=6)
				vDefOp:=">"
				If (vDef="C-H")
					cboDeficiency:=4
					vDef:="C-S"
					REDRAW:C174(cboDeficiency)
				End if 
				
			: (Self:C308->=7)
				vDefOp:=">="
		End case 
End case 


//equal to
//not equal to
//less than
//less or equal
//greater than
//greater and equal