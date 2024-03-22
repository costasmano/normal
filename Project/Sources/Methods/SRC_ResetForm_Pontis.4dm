//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/10/05, 20:05:44
	// ----------------------------------------------------
	// Method: SRC_ResetForm_Pontis
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	
	Mods_2005_CM17
End if 

cboPontisElemCat:=0
cboPontisElem:=0

cboElmtEnv:=0

vElmtStateOp:=""
cboElmtStateOp:=0
cboElmtState:=0

cboElmtQtyOp:=0
vrSearchElmtQty:=-1
//    0) All the check boxes are un-checked as default
cbPonElementCat:=0
cbElmtEnv:=0
cbElmtState:=0
cbElmtQty:=0
//Disable all check boxes except the element selection
OBJECT SET ENABLED:C1123(cbElmtEnv; False:C215)  // Command Replaced was o_DISABLE BUTTON 
OBJECT SET ENABLED:C1123(cbElmtState; False:C215)  // Command Replaced was o_DISABLE BUTTON 
OBJECT SET ENABLED:C1123(cbElmtQty; False:C215)  // Command Replaced was o_DISABLE BUTTON 

OBJECT SET ENABLED:C1123(cboPontisElemCat; False:C215)  // Command Replaced was o_DISABLE BUTTON 
OBJECT SET ENABLED:C1123(cboPontisElem; False:C215)  // Command Replaced was o_DISABLE BUTTON 
OBJECT SET ENABLED:C1123(cboElmtEnv; False:C215)  // Command Replaced was o_DISABLE BUTTON 
OBJECT SET ENABLED:C1123(cboElmtStateOp; False:C215)  // Command Replaced was o_DISABLE BUTTON 
OBJECT SET ENABLED:C1123(cboElmtState; False:C215)  // Command Replaced was o_DISABLE BUTTON 
OBJECT SET ENABLED:C1123(cboElmtQtyOp; False:C215)  // Command Replaced was o_DISABLE BUTTON 

OBJECT SET ENTERABLE:C238(vrSearchElmtQty; False:C215)