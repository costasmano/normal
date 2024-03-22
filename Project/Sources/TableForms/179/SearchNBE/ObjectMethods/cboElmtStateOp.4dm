If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 06/11/05, 06:14:05
	// ----------------------------------------------------
	// Method: Object Method: cboElmtStateOp
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	
End if 

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		C_TEXT:C284(vElmtStateOp)  // Command Replaced was o_C_STRING length was 8
		Case of 
			: (Self:C308->=1)
				vElmtStateOp:=""
			: (Self:C308->=2)
				vElmtStateOp:="INST"  //in State
			: (Self:C308->=3)
				vElmtStateOp:="ATST"  //at most state
			: (Self:C308->=4)
				vElmtStateOp:="ATAFTST"  //at and Past After State
			: (Self:C308->=5)
				vElmtStateOp:="AFTST"  //Past state
			: (Self:C308->=6)
				vElmtStateOp:="BEFST"  //Before state
		End case 
		
End case 
