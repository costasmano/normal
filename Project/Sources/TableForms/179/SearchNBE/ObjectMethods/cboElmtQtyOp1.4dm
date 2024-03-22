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
				vElmttotQtyOp:=""
			: (Self:C308->=2)
				vElmttotQtyOp:="="
			: (Self:C308->=3)
				vElmttotQtyOp:="#"
			: (Self:C308->=4)
				vElmttotQtyOp:="<"
			: (Self:C308->=5)
				vElmttotQtyOp:="<="
			: (Self:C308->=6)
				vElmttotQtyOp:=">"
			: (Self:C308->=7)
				vElmttotQtyOp:=">="
		End case 
		
End case 
