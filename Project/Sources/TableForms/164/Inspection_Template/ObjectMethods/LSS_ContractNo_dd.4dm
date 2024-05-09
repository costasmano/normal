//Method: [LSS_Inspection].Inspection_Template.LSS_ContractNo_dd
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): manousakisc
	//User (4D) : Designer
	//Date and time: 03/27/24, 14:57:26
	// ----------------------------------------------------
	//Created : 
	Mods_2024_LSS_1
End if 
//
C_POINTER:C301($me_ptr; $assign_ptr)
$me_ptr:=OBJECT Get pointer:C1124(Object current:K67:2)
C_LONGINT:C283($pick_L)  //reference of selected item
ARRAY LONGINT:C221($itemrefs_aL; 0)
$pick_L:=Selected list items:C379($me_ptr->; $itemrefs_aL; *)
ARRAY TEXT:C222($paramnames_atxt; 0)
ARRAY TEXT:C222($paramvalues_atxt; 0)

GET LIST ITEM PARAMETER ARRAYS:C1195($me_ptr->; $pick_L; $paramnames_atxt; $paramvalues_atxt)
//param1 = contractnum ; param2 = assign num ; param3 = consultant
C_TEXT:C284($msg_txt)
If (Old:C35([LSS_Inspection:164]LSS_ContractNo_L:60)=0)
	// original contract blank
	$msg_txt:="Assign contract: "+$paramvalues_atxt{1}+\
		" ("+$paramvalues_atxt{3}+\
		"), assignment: "+$paramvalues_atxt{2}+" to this inspection?"
Else 
	//change
	// get the old prime from the contract object
	C_TEXT:C284($oldPrime_txt)
	$oldPrime_txt:=Storage:C1525.LSS_Contracts.query("ContractNo = :1"; Old:C35([LSS_Inspection:164]LSS_ContractNo_L:60))[0].ConsultantName
	$msg_txt:="Change from saved values\ncontract: "+String:C10(Old:C35([LSS_Inspection:164]LSS_ContractNo_L:60))+\
		" ("+$oldPrime_txt+\
		"), assignment: "+String:C10(Old:C35([LSS_Inspection:164]LSS_AssignmentNo_L:61))+"\nto\n"+\
		" contract: "+$paramvalues_atxt{1}+" ("+$paramvalues_atxt{3}+\
		"), assignment: "+$paramvalues_atxt{2}+"\nfor this inspection?"
	
End if 

CONFIRM:C162($msg_txt)

If (Ok=1)
	[LSS_Inspection:164]LSS_ContractNo_L:60:=Num:C11($paramvalues_atxt{1})
	[LSS_Inspection:164]LSS_AssignmentNo_L:61:=Num:C11($paramvalues_atxt{2})
	OBJECT SET TITLE:C194(*; "AssigneCons"; "Assigned Consultant: "+$paramvalues_atxt{3})
	
End if 

//End [LSS_Inspection].Inspection_Template.LSS_ContractNo_dd