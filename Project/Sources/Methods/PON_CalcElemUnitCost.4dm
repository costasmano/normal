//%attributes = {"invisible":true}
//Method: PON_CalcElemUnitCost
//Description
// Calculate the element Cost for an NBE for H.I. Purposes
// Parameters
// $0 : $UNITCOST_R
// $1 : $elemKey_L
// $2 : $ElemEnv_L
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/14/15, 10:10:59
	// ----------------------------------------------------
	//Created : 
	Mods_2015_04
	
	C_REAL:C285(PON_CalcElemUnitCost; $0)
	C_LONGINT:C283(PON_CalcElemUnitCost; $1)
	C_LONGINT:C283(PON_CalcElemUnitCost; $2)
	
End if 
//
C_REAL:C285($0)

C_LONGINT:C283($1)
C_LONGINT:C283($2)

C_REAL:C285($UnitCost_r)
$UnitCost_r:=0
READ ONLY:C145([PON_ELEM_COSTS:180])
QUERY:C277([PON_ELEM_COSTS:180]; [PON_ELEM_COSTS:180]ELEM_KEY:1=$1; *)
QUERY:C277([PON_ELEM_COSTS:180]; [PON_ELEM_COSTS:180]ENVKEY:2=$2; *)
QUERY:C277([PON_ELEM_COSTS:180]; [PON_ELEM_COSTS:180]ELEM_ACTION:3="HI")

If (Records in selection:C76([PON_ELEM_COSTS:180])=1)
	$UnitCost_r:=[PON_ELEM_COSTS:180]ELEM_COST:4
End if 

$0:=$UnitCost_r
//End PON_CalcElemUnitCost