//%attributes = {"invisible":true}
//Method: NTI_VERIFYUNIQELEM_b
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/22/16, 11:06:35
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
	
	C_BOOLEAN:C305(NTI_VERIFYUNIQELEM_b; $0)
	C_LONGINT:C283(NTI_VERIFYUNIQELEM_b; $1; $2)
	C_POINTER:C301(NTI_VERIFYUNIQELEM_b; $3)
	C_LONGINT:C283(NTI_VERIFYUNIQELEM_b; $4)
	
	// Modified by: Costas Manousakis-(Designer)-(3/21/18 13:32:50)
	Mods_2018_03
	//  `addition of prot systems
End if 
//
C_BOOLEAN:C305($0)
C_LONGINT:C283($1; $2)

C_LONGINT:C283($key_L; $env_L; $parent_L; $Grandp_L; $InspID_L; $ElemID_L)
C_POINTER:C301($Tbl_ptr; $InspID_ptr; $ElemID_ptr; $ElemKey_ptr; $ElemParKey_ptr; $ElemGPKey_ptr)
If (Count parameters:C259>2)
	C_POINTER:C301($3)
	$Tbl_ptr:=$3
Else 
	$Tbl_ptr:=Current form table:C627
End if 

$key_L:=$1
$parent_L:=$2

If (Count parameters:C259>3)
	$Grandp_L:=$4
Else 
	$Grandp_L:=0
End if 

Case of 
	: ($Tbl_ptr=(->[NTI_ELEM_BIN_INSP:183]))
		$InspID_ptr:=->[NTI_ELEM_BIN_INSP:183]INSPID:1
		$ElemID_ptr:=->[NTI_ELEM_BIN_INSP:183]ELEMID:2
		$ElemKey_ptr:=->[NTI_ELEM_BIN_INSP:183]ELEM_KEY:3
		$ElemParKey_ptr:=->[NTI_ELEM_BIN_INSP:183]ELEM_PARENT_KEY:7
		$ElemGPKey_ptr:=->[NTI_ELEM_BIN_INSP:183]ELEM_GRANDPARENT_KEY:25
		
	: ($Tbl_ptr=(->[NTI_ELEM_TIN_INSP:185]))
		$InspID_ptr:=->[NTI_ELEM_TIN_INSP:185]InspectionID:1
		$ElemID_ptr:=->[NTI_ELEM_TIN_INSP:185]ELEMID:2
		$ElemKey_ptr:=->[NTI_ELEM_TIN_INSP:185]ELEM_KEY:3
		$ElemParKey_ptr:=->[NTI_ELEM_TIN_INSP:185]ELEM_PARENT_KEY:7
		$ElemGPKey_ptr:=->[NTI_ELEM_TIN_INSP:185]ELEM_GRANDPARENT_KEY:25
End case 

$InspID_L:=$InspID_ptr->
$ElemID_L:=$ElemID_ptr->

C_BOOLEAN:C305($Unique_b)
C_LONGINT:C283($Count_L)

SET QUERY DESTINATION:C396(Into variable:K19:4; $Count_L)
QUERY:C277($Tbl_ptr->;  & ; $InspID_ptr->=$InspID_L; *)
QUERY:C277($Tbl_ptr->;  & ; $ElemID_ptr->#$ElemID_L; *)
QUERY:C277($Tbl_ptr->;  & ; $ElemKey_ptr->=$key_L; *)
QUERY:C277($Tbl_ptr->;  & ; $ElemParKey_ptr->=$parent_L; *)
QUERY:C277($Tbl_ptr->;  & ; $ElemGPKey_ptr->=$Grandp_L; *)
QUERY:C277($Tbl_ptr->)

SET QUERY DESTINATION:C396(Into current selection:K19:1)

$0:=($Count_L=0)
//End NTI_VERIFYUNIQELEM_b