//%attributes = {"invisible":true}
//Method: INSP_SaveComments_WP
//Description
// Save the Write PRo comments into a field and record the change
// Parameters
// $1 : $paramObj
// $2 : $fieldPtr
// $3 : $WPArea_ptr
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/19/21, 10:21:59
	// ----------------------------------------------------
	//Created : 
	Mods_2021_WP
	
	C_OBJECT:C1216(INSP_SaveComments_WP; $1)
	
End if 
//

C_LONGINT:C283($ChangeStack_L)
C_POINTER:C301($fieldPtr)
C_TEXT:C284($WPAreaName)

$ChangeStack_L:=$1.changeStack
$fieldPtr:=$1.fieldptr
$WPAreaName:=$1.WPAreaname

C_POINTER:C301($WParea_ptr)
$WParea_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; $WPAreaName)

C_OBJECT:C1216($Range)
$Range:=WP Text range:C1341($WParea_ptr->; wk start text:K81:165; wk end text:K81:164)

C_TEXT:C284($DataTag)
$DataTag:="WPAREA"

C_BLOB:C604($WPAreaExport; $SaveToField)

SET BLOB SIZE:C606($SaveToField; 0)
If ($range.end>1)
	//we have something in comments
	
	WP EXPORT VARIABLE:C1319($WParea_ptr->; $WPAreaExport; wk 4wp:K81:4; wk normal:K81:7)
	
	VARIABLE TO BLOB:C532($DataTag; $SaveToField)
	VARIABLE TO BLOB:C532($WPAreaExport; $SaveToField; *)
	
	COMPRESS BLOB:C534($SaveToField)
	$fieldPtr->:=$SaveToField
Else 
	//area is blank, save blank blob
	$fieldPtr->:=$SaveToField
	
End if 

PushChange($ChangeStack_L; $fieldPtr)

//End INSP_SaveComments_WP