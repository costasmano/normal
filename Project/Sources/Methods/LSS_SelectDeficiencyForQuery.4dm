//%attributes = {"invisible":true}
//Method: LSS_SelectDeficiencyForQuery
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 04/02/19, 16:52:25
	// ----------------------------------------------------
	//Created : 
	Mods_2019_04
End if 
//
C_LONGINT:C283($l; $t; $r; $b)
C_TEXT:C284($menuref_txt; $selected_txt)
OBJECT GET COORDINATES:C663(*; "SelectedCategoryOperator"; $l; $t; $r; $b)

ARRAY TEXT:C222($MenuDiscriptor_atxt; 0)
ARRAY TEXT:C222($MenuSelected_atxt; 0)
ARRAY TEXT:C222($MenuDiscriptor_atxt; 7)
ARRAY TEXT:C222($MenuSelected_atxt; 7)

$MenuDiscriptor_atxt{2}:="equal to (=)"
$MenuDiscriptor_atxt{3}:="not equal to (#)"
$MenuDiscriptor_atxt{4}:="less than (<)"
$MenuDiscriptor_atxt{5}:="equal to or less than (<=)"
$MenuDiscriptor_atxt{6}:="greater than (>)"
$MenuDiscriptor_atxt{7}:="equal to or greater than (>=)"
$MenuSelected_atxt{1}:=""
$MenuSelected_atxt{2}:="="
$MenuSelected_atxt{3}:="#"
$MenuSelected_atxt{4}:="<"
$MenuSelected_atxt{5}:="<="
$MenuSelected_atxt{6}:=">"
$MenuSelected_atxt{7}:=">="
$menuref_txt:=MENU_BuildMenuFromArrays(->$MenuDiscriptor_atxt; ->$MenuSelected_atxt; "\\")
vDefOp:=Dynamic pop up menu:C1006($menuref_txt; ""; $l; $t)
RELEASE MENU:C978($menuref_txt)
C_BOOLEAN:C305($NextMenu_B)
$NextMenu_B:=True:C214

ARRAY TEXT:C222($Menu2Discriptor_atxt; 0)
ARRAY TEXT:C222($Menu2Selected_atxt; 0)
ARRAY TEXT:C222($Menu2Discriptor_atxt; 5)
ARRAY TEXT:C222($Menu2Selected_atxt; 5)
$Menu2Discriptor_atxt{2}:="M=Minor Deficiency"
$Menu2Discriptor_atxt{3}:="S=Severe/Major Deficiency"
$Menu2Discriptor_atxt{4}:="C-S=Critical Structural Deficiency"
$Menu2Discriptor_atxt{5}:="C-H=Critical Hazard Deficiency"
$Menu2Selected_atxt{2}:="M"
$Menu2Selected_atxt{3}:="S"
$Menu2Selected_atxt{4}:="C-S"
$Menu2Selected_atxt{5}:="C-H"
C_LONGINT:C283($loc_L)
$loc_L:=Find in array:C230($MenuSelected_atxt; vDefOp)
If ($loc_L>1)
	OBJECT SET TITLE:C194(*; "SelectedCategoryOperator"; $MenuDiscriptor_atxt{$loc_L})
End if 
Case of 
	: (vDefOp="")
		$NextMenu_B:=False:C215
		OBJECT SET TITLE:C194(*; "SelectedCategoryOperator"; "No Operator Selected")
	: (vDefOp=">")
		DELETE FROM ARRAY:C228($Menu2Selected_atxt; 5; 1)
		DELETE FROM ARRAY:C228($Menu2Discriptor_atxt; 5; 1)
	: (vDefOp="<")
		DELETE FROM ARRAY:C228($Menu2Selected_atxt; 2; 1)
		DELETE FROM ARRAY:C228($Menu2Discriptor_atxt; 2; 1)
		
	Else 
End case 
If ($NextMenu_B)
	
	OBJECT GET COORDINATES:C663(*; "SelectedCategory"; $l; $t; $r; $b)
	
	$menuref_txt:=MENU_BuildMenuFromArrays(->$Menu2Discriptor_atxt; ->$Menu2Selected_atxt; "\\")
	vDef:=Dynamic pop up menu:C1006($menuref_txt; ""; $l; $t)
	RELEASE MENU:C978($menuref_txt)
	$Loc_L:=Find in array:C230($Menu2Selected_atxt; vDef)
	If ($Loc_L>0) & (vDef#"")
		OBJECT SET TITLE:C194(*; "SelectedCategory"; $Menu2Discriptor_atxt{$Loc_L})
		OBJECT SET VISIBLE:C603(*; "DEF_Warning"; False:C215)
	Else 
		OBJECT SET TITLE:C194(*; "SelectedCategory"; "Nothing Selected")
		OBJECT SET VISIBLE:C603(*; "DEF_Warning"; True:C214)
	End if 
Else 
	OBJECT SET TITLE:C194(*; "SelectedCategory"; "Nothing Selected")
	OBJECT SET VISIBLE:C603(*; "DEF_Warning"; True:C214)
End if 

//End LSS_SelectDeficiencyForQuery