//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/14/06, 16:28:15
	// ----------------------------------------------------
	// Method: INSP_LogTableChanges
	// Description
	// 
	// 
	// Parameters
	// $1 : Stack number
	// $2 : ParentFld_Ptr
	// $3 : ChildFld_Ptr
	// $4 : KeyFld_Ptr
	// $5 : RelType_i
	
	// ----------------------------------------------------
	Mods_2007_CM03
End if 
C_LONGINT:C283($1; $StackNum_i)  //Command Replaced was o_C_INTEGER
C_POINTER:C301($2; $ParentFld_Ptr)
C_POINTER:C301($3; $ChildFld_Ptr)
C_POINTER:C301($4; $KeyFld_Ptr)
C_LONGINT:C283($5; $RelType_i)  //Command Replaced was o_C_INTEGER

$StackNum_i:=$1
$ParentFld_Ptr:=$2
$ChildFld_Ptr:=$3
$KeyFld_Ptr:=$4
$RelType_i:=$5

InitChangeStack($StackNum_i)
C_LONGINT:C283($NumTblFlds_L; $i)
$NumTblFlds_L:=Size of array:C274(INSP_Ptr_TableFields)

For ($i; 1; $NumTblFlds_L)
	PushChange($StackNum_i; INSP_Ptr_TableFields{$i})
End for 

FlushGrpChgs($StackNum_i; $ParentFld_Ptr; $ChildFld_Ptr; $KeyFld_Ptr; $RelType_i)
