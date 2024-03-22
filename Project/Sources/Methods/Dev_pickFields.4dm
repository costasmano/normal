//%attributes = {"invisible":true}
//Method: Dev_pickFields
//Description
//fill  array in ptr $2 with selected field numbers
// Parameters
// $1 : $Tbl_ptr
// $2 : $FieldNumArray_ptr
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 10/09/15, 17:47:47
	// ----------------------------------------------------
	//Created : 
	Mods_2015_10
	C_POINTER:C301(Dev_pickFields; $1)
	C_POINTER:C301(Dev_pickFields; $2)
	
	// Modified by: Costas Manousakis-(Designer)-(7/15/21 18:10:43)
	Mods_2021_07
	//  `if $2 array has data populate the omit list
End if 
//
C_POINTER:C301($1)
C_POINTER:C301($2)

C_LONGINT:C283(UseList_HL; OmitList_HL)
C_BOOLEAN:C305(TWOLIST_MOVEONLY_B)
C_TEXT:C284(vCancelBtntxt; vOKBtnTxt; vUseListLbl_txt; vOmitLbl_txt)
vCancelBtntxt:="Cancel"
vOKBtnTxt:="Accept"
vUseListLbl_txt:="Available Fields"
vOmitLbl_txt:="Selected Fields"

C_LONGINT:C283($tbl_L; $fld_L; $numFlds_L; $fld_loop_L)
$tbl_L:=Table:C252($1)
$numFlds_L:=Get last field number:C255($1)
ARRAY LONGINT:C221($FieldList_aL; 0)
ARRAY TEXT:C222($FieldName_atxt; 0)
ARRAY LONGINT:C221($fieldsUsed_aL; 0)
ARRAY TEXT:C222($fieldsUsedNames_atxt; 0)
For ($fld_loop_L; 1; $numFlds_L)
	If (Is field number valid:C1000($1; $fld_loop_L))
		//skip field if it is already in array ptr $2
		If (Find in array:C230($2->; $fld_loop_L)>0)
			APPEND TO ARRAY:C911($fieldsUsed_aL; $fld_loop_L)
			APPEND TO ARRAY:C911($fieldsUsedNames_atxt; Field name:C257($tbl_L; $fld_loop_L))
		Else 
			APPEND TO ARRAY:C911($FieldList_aL; $fld_loop_L)
			APPEND TO ARRAY:C911($FieldName_atxt; Field name:C257($tbl_L; $fld_loop_L))
			
		End if 
	End if 
End for 
SORT ARRAY:C229($FieldName_atxt; $FieldList_aL)
UseList_HL:=ut_ArrayToHL(->$FieldName_atxt; ""; ->$FieldList_aL)

If (Size of array:C274($2->)>0)
	SORT ARRAY:C229($fieldsUsedNames_atxt; $fieldsUsed_aL)
	OmitList_HL:=ut_ArrayToHL(->$fieldsUsedNames_atxt; ""; ->$fieldsUsed_aL)
Else 
	OmitList_HL:=New list:C375
End if 


C_LONGINT:C283($Width_l; $Height_l; $Win_l; $Pages_l)
C_BOOLEAN:C305($FixedWidth_b; $FixedHeight_b)
C_TEXT:C284($Title_txt)

FORM GET PROPERTIES:C674("TwoListMove"; $Width_l; $Height_l; $Pages_l; $FixedWidth_b; $FixedHeight_b; $Title_txt)
$Win_l:=ut_OpenNewWindow($Width_l; $Height_l; 0; Plain form window:K39:10; $Title_txt; "ut_CloseCancel")
//$winID:=Open form window([Dialogs];"TwoListMove")
DIALOG:C40("TwoListMove")
CLOSE WINDOW:C154($Win_l)
C_LONGINT:C283($numFldsSelected_L)
$numFldsSelected_L:=Count list items:C380(OmitList_HL)
ARRAY LONGINT:C221($2->; $numFldsSelected_L)
C_LONGINT:C283($ref)
C_TEXT:C284($Name)
For ($fld_loop_L; 1; $numFldsSelected_L)
	GET LIST ITEM:C378(OmitList_HL; $fld_loop_L; $Ref; $Name)
	$2->{$fld_loop_L}:=$Ref
End for 
If (Is a list:C621(UseList_HL))
	CLEAR LIST:C377(UseList_HL; *)
End if 
If (Is a list:C621(OmitList_HL))
	CLEAR LIST:C377(OmitList_HL; *)
End if 

//End Dev_pickFields