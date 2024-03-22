//%attributes = {"invisible":true}
//Method: PON_CompareState
//Description
// Compare quantity of states for children and parent
// Parameters
// $0 : $errMsg_txt
// $1 : $StateNo_L
// $2 : $DefectQ_r
// $3 : $ElemQ_r
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/08/15, 11:16:06
	// ----------------------------------------------------
	//Created : 
	Mods_2015_04
End if 
//
C_TEXT:C284($0)
C_LONGINT:C283($1)
C_REAL:C285($2; $3)

C_TEXT:C284($errmsg_txt)
Case of 
	: ($2>$3)
		$ErrMsg_txt:=$ErrMsg_txt+"ERROR : Sum of Quantities in State "+String:C10($1)+" of Defect(s) = "+String:C10($2)+"  EXCEEDS State "+String:C10($1)+" Quantity of Element = "+String:C10($3)+Char:C90(13)
	: ($2<$3)
		$ErrMsg_txt:=$ErrMsg_txt+"WARNING : Sum of Quantities in State "+String:C10($1)+" of Defect(s) = "+String:C10($2)+"  IS LESS THAN State "+String:C10($1)+" Quantity of Element = "+String:C10($3)+Char:C90(13)
End case 

$0:=$errmsg_txt
//End PON_CompareState