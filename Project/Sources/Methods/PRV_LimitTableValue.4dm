//%attributes = {"invisible":true}
//Method: PRV_LimitTableValue
//Description
//
// Parameters
// $0 : $Value_L
// $1 : $DomTreeRef_txt
// $2 : $SearchVal_L
// $3 : $ElemName_txt (Optional) -default = "ROW"
// $4 : $HiLimAttrName_txt (optiona) - default = "HighLimit"
// $5 : $HiLimAttrValName_txt (optiona) - default = "ValueLimit"
// $6 : $NoValFound_L (optional) -default = 0
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 08/22/12, 11:37:47
	// ----------------------------------------------------
	//Created : 
	Mods_2012_08
	// Modified by: Costas Manousakis-(Designer)-(9/25/13 15:02:54)
	Mods_2013_09
	//  `Copied to DEV
End if 
//
C_LONGINT:C283($0; $Value_L; $NoValFound_L)
$NoValFound_L:=0
C_TEXT:C284($1; $DomTreeRef_txt)
$DomTreeRef_txt:=$1
C_LONGINT:C283($2; $SearchVal_L)
$SearchVal_L:=$2
C_TEXT:C284($ElemName_txt; $HiLimAttrName_txt; $HiLimAttrValName_txt)
$ElemName_txt:="ROW"
$HiLimAttrName_txt:="HighLimit"
$HiLimAttrValName_txt:="ValueLimit"
If (Count parameters:C259>2)
	C_TEXT:C284($3)
	If ($3#"")
		$ElemName_txt:=$3
	End if 
End if 
If (Count parameters:C259>3)
	C_TEXT:C284($4)
	If ($4#"")
		$HiLimAttrName_txt:=$4
	End if 
End if 
If (Count parameters:C259>4)
	C_TEXT:C284($5)
	If ($5#"")
		$HiLimAttrValName_txt:=$5
	End if 
End if 
If (Count parameters:C259>5)
	C_LONGINT:C283($6)
	$NoValFound_L:=$6
End if 

$Value_L:=$NoValFound_L

C_LONGINT:C283($NumRows_L; $loop_L; $elvalue_L; $highValue_L; $Points_L; $value_L)
C_TEXT:C284($elemRef_txt)
$NumRows_L:=DOM Count XML elements:C726($DomTreeRef_txt; $ElemName_txt)

For ($loop_L; 1; $NumRows_L)
	$elemRef_txt:=DOM Get XML element:C725($DomTreeRef_txt; $ElemName_txt; $loop_L; $elvalue_L)
	DOM GET XML ATTRIBUTE BY NAME:C728($elemRef_txt; $HiLimAttrName_txt; $highValue_L)
	If ($SearchVal_L<=$highValue_L)
		DOM GET XML ATTRIBUTE BY NAME:C728($elemRef_txt; $HiLimAttrValName_txt; $Value_L)
		$loop_L:=$NumRows_L+1
	End if 
	
End for 

$0:=$Value_L
//End PRV_LimitTableValue