//%attributes = {"invisible":true}
//Method: SRC_ResetForm_NBE
//Description
//  `reset the NBE search dialog
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 07/06/15, 16:10:47
	// ----------------------------------------------------
	//Created : 
	Mods_2015_07
	// Modified by: Costas Manousakis-(Designer)-(8/29/17 12:40:14)
	Mods_2017_08
	//  `adjust for material, category, type
End if 
//
//
//need to clear arrays, quantities, listboxes

vrSearchElmttotQty:=0
vrSearchElmtQty:=0
PON_MASTERELEM_Desc_atxt:=0
PON_CATEGORIES_Desc_atxt:=0
PON_TYPES_Desc_atxt:=0
PON_MATERIALS_Desc_atxt:=0

cboElmttotQtyOp:=0
cboElmtQtyOp:=0

cboElmtStateOp:=0
cboElmtState:=0

cboElmtEnv:=0

If (Size of array:C274(NBESearch_LB1)>0)
	C_LONGINT:C283($loop_L)
	For ($loop_L; Size of array:C274(NBESearch_LB1); 1; -1)
		LISTBOX DELETE ROWS:C914(*; "NBESearch_LB1"; $loop_L)
	End for 
	
End if 
If (Size of array:C274(NBESearch_LB2)>0)
	For ($loop_L; Size of array:C274(NBESearch_LB2); 1; -1)
		LISTBOX DELETE ROWS:C914(*; "NBESearch_LB2"; $loop_L)
	End for 
	
End if 

OBJECT SET VISIBLE:C603(*; "NBESearch_Defect_2"; False:C215)
OBJECT SET VISIBLE:C603(*; "NBESearch_LB2"; False:C215)

//End SRC_ResetForm_NBE