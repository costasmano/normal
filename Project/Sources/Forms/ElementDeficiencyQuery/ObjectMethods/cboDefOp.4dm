//Method: ElementDeficiencyQuery.cboDefOp1
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 12/11/18, 16:44:28
	// ----------------------------------------------------
	//Created : 
	Mods_2018_12
End if 
//
//equal to
//not equal to
//less than
//less or equal
//greater than
//greater and equal
C_LONGINT:C283($l; $t; $r; $b)
C_TEXT:C284($menuref_txt; $selected_txt)
OBJECT GET COORDINATES:C663(*; "cboDefOp"; $l; $t; $r; $b)

ARRAY TEXT:C222($MenuDiscriptor_atxt; 0)
ARRAY TEXT:C222($MenuSelected_atxt; 0)
ARRAY TEXT:C222($MenuDiscriptor_atxt; 5)
ARRAY TEXT:C222($MenuSelected_atxt; 5)
$MenuDiscriptor_atxt{2}:="M=Minor Deficiency"
$MenuDiscriptor_atxt{3}:="S=Severe/Major Deficiency"
$MenuDiscriptor_atxt{4}:="C-S=Critical Structural Deficiency"
$MenuDiscriptor_atxt{5}:="C-H=Critical Hazard Deficiency"
$MenuSelected_atxt{2}:="M"
$MenuSelected_atxt{3}:="S"
$MenuSelected_atxt{4}:="C-S"
$MenuSelected_atxt{5}:="C-H"

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		
		Case of 
			: (Self:C308->=1)
				vDefOp:=""
			: (Self:C308->=2)
				vDefOp:="="
				
			: (Self:C308->=3)
				vDefOp:="#"
			: (Self:C308->=4)
				vDefOp:="<"
				DELETE FROM ARRAY:C228($MenuSelected_atxt; 2; 1)
				DELETE FROM ARRAY:C228($MenuDiscriptor_atxt; 2; 1)
				
			: (Self:C308->=5)
				vDefOp:="<="
			: (Self:C308->=6)
				vDefOp:=">"
				DELETE FROM ARRAY:C228($MenuSelected_atxt; 5; 1)
				DELETE FROM ARRAY:C228($MenuDiscriptor_atxt; 5; 1)
				
			: (Self:C308->=7)
				vDefOp:=">="
		End case 
End case 
REDRAW:C174(cboDefOp)

If (vDefOp#"")
	
	$menuref_txt:=MENU_BuildMenuFromArrays(->$MenuDiscriptor_atxt; ->$MenuSelected_atxt; "\\")
	vDef:=Dynamic pop up menu:C1006($menuref_txt; ""; $r+30; $t)
	RELEASE MENU:C978($menuref_txt)
	C_LONGINT:C283($Loc_L)
	$Loc_L:=Find in array:C230($MenuSelected_atxt; vDef)
	If ($Loc_L>0) & (vDef#"")
		OBJECT SET TITLE:C194(*; "SelectedCategory"; $MenuDiscriptor_atxt{$Loc_L})
		OBJECT SET VISIBLE:C603(*; "DEF_Warning"; False:C215)
	Else 
		OBJECT SET TITLE:C194(*; "SelectedCategory"; "Nothing Selected")
		OBJECT SET VISIBLE:C603(*; "DEF_Warning"; True:C214)
	End if 
Else 
	OBJECT SET TITLE:C194(*; "SelectedCategory"; "Nothing Selected")
	OBJECT SET VISIBLE:C603(*; "DEF_Warning"; True:C214)
End if 
OBJECT SET ENABLED:C1123(*; "FindButton"; LSS_EditCheckDefQRY)
//End ElementDeficiencyQuery.cboDefOp1