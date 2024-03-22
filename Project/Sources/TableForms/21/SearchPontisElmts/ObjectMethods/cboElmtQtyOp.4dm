If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 06/11/05, 06:14:05
	// ----------------------------------------------------
	// Method: Object Method: cboElmtQtyOp
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	
End if 

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		Case of 
			: (Self:C308->=1)
				vElmtQtyOp:=""
			: (Self:C308->=2)
				vElmtQtyOp:="="
			: (Self:C308->=3)
				vElmtQtyOp:="#"
			: (Self:C308->=4)
				vElmtQtyOp:="<"
			: (Self:C308->=5)
				vElmtQtyOp:="<="
			: (Self:C308->=6)
				vElmtQtyOp:=">"
			: (Self:C308->=7)
				vElmtQtyOp:=">="
		End case 
		
End case 
