//%attributes = {"shared":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/16/10, 08:46:58
	// ----------------------------------------------------
	// Method: QR_CountRelated
	// Description
	//  ` Get a Count of the related records
	//  `$count;=QR_CountRelated(->MasterTblKeyField;->ChildTableFKGield)
	// 
	// Parameters
	// $0 : $Count_L
	// $1 : $MasterTableKey_ptr
	// $2 : $ChildTableFKey_ptr
	// ----------------------------------------------------
	
	Mods_2010_11
End if 
C_LONGINT:C283($0; $Count_L)
$Count_L:=0
C_POINTER:C301($1; $MasterTableKey_ptr; $2; $ChildTableFKey_ptr)
$MasterTableKey_ptr:=$1
$ChildTableFKey_ptr:=$2
C_POINTER:C301($ChildTbl_ptr)
C_LONGINT:C283($ChildTbl_L)
$ChildTbl_L:=Table:C252($ChildTableFKey_ptr)
$ChildTbl_ptr:=Table:C252($ChildTbl_L)
SET QUERY DESTINATION:C396(Into variable:K19:4; $Count_L)
QUERY:C277($ChildTbl_ptr->; $ChildTableFKey_ptr->=$MasterTableKey_ptr->)
SET QUERY DESTINATION:C396(Into current selection:K19:1)
$0:=$Count_L