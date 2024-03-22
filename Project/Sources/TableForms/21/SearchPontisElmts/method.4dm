If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/10/05, 21:13:35
	// ----------------------------------------------------
	// Method: Form Method: SearchPontisElmts
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	ARRAY TEXT:C222(cboElmtStateOp; 0)
	ARRAY TEXT:C222(cboElmtState; 0)
	ARRAY TEXT:C222(cboElmtStateCode; 0)
	ARRAY TEXT:C222(cboElmtQtyOp; 0)
	ARRAY TEXT:C222(cboElmtEnv; 0)
	
	Mods_2005_CM17
	// Modified by: Costas Manousakis-(Designer)-(11/1/13 13:24:23)
	Mods_2013_11
	//  `added option to open a new window with the CUs
	// Modified by: Costas Manousakis-(Designer)-(10/13/15 13:19:53)
	Mods_2015_10
	//  `Removed object method in cbOpenList - was setting print option
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		
		C_BOOLEAN:C305(vAddTo; vIncludeComments; vPrintNow)
		C_BOOLEAN:C305(vbAnyCompleted; vbAnyApprvDBIE; vInspApproved)
		C_TEXT:C284(vtSearchResultCnt)
		vtSearchResultCnt:=""
		
		cbElmtState:=elmtSrchStateStat
		cbPonElementCat:=elmtSrchPCatStat
		cbElmtQty:=elmtSrchQtyStat
		cbElmtEnv:=elmtSrchEnvStat
		
		If ((cbElmtState=0) & (cbPonElementCat=0) & (cbElmtQty=0) & (cbElmtEnv=0))
			SRC_ResetForm_Pontis
		Else 
			If (cbPonElementCat=0)
				OBJECT SET ENABLED:C1123(cboPontisElem; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			Else 
				OBJECT SET ENABLED:C1123(cboPontisElem; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			End if 
			If (cbElmtEnv=0)
				OBJECT SET ENABLED:C1123(cboElmtEnv; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			Else 
				OBJECT SET ENABLED:C1123(cboElmtEnv; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			End if 
			If (cbElmtState=0)
				OBJECT SET ENABLED:C1123(cboElmtStateOp; False:C215)  // Command Replaced was o_DISABLE BUTTON 
				OBJECT SET ENABLED:C1123(cboElmtState; False:C215)  // Command Replaced was o_DISABLE BUTTON 
				vElmtStateOp:=""
				cboElmtStateOp:=0
				cboElmtState:=0
			Else 
				OBJECT SET ENABLED:C1123(cboElmtStateOp; True:C214)  // Command Replaced was o_ENABLE BUTTON 
				OBJECT SET ENABLED:C1123(cboElmtState; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			End if 
			If (cbElmtQty=0)
				OBJECT SET ENABLED:C1123(cboElmtQtyOp; False:C215)  // Command Replaced was o_DISABLE BUTTON 
				OBJECT SET ENTERABLE:C238(vrSearchElmtQty; False:C215)
				cboElmtQtyOp:=0
				vrSearchElmtQty:=-1
				vElmtQtyOp:=""
			Else 
				OBJECT SET ENABLED:C1123(cboElmtQtyOp; True:C214)  // Command Replaced was o_ENABLE BUTTON 
				OBJECT SET ENTERABLE:C238(vrSearchElmtQty; True:C214)
				If (vrSearchElmtQty<0)
					vrSearchElmtQty:=0
				End if 
			End if 
		End if 
End case 