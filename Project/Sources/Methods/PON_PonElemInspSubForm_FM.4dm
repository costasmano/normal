//%attributes = {"invisible":true}
// Method: PON_PonElemInspSubForm_FM
// Description
// Method for Form [PON_ELEM_INSP];"LB_PON_ELEM_INSP"
// 
// Parameters
// $1 : $formEvent_L
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 02/10/20, 11:48:03
	// ----------------------------------------------------
	// First Release
	Mods_2020_02
	
	C_LONGINT:C283(PON_PonElemInspSubForm_FM; $1)
End if 

C_LONGINT:C283($formEvent_L)

If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$formEvent_L:=$1
Else 
	$formEvent_L:=Form event code:C388
End if 

C_TEXT:C284($LBName_txt)
C_POINTER:C301($LBVar_ptr)
$LBName_txt:="PON_NBE_LB"
$LBVar_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; $LBName_txt)

Case of 
	: ($formEvent_L=On Load:K2:1)
		
		If (Records in selection:C76([Cond Units:45])>0)
			OBJECT SET VISIBLE:C603(*; "PON_ShowCoRE"; True:C214)
		Else 
			OBJECT SET VISIBLE:C603(*; "PON_ShowCoRE"; False:C215)
		End if 
		If (Records in selection:C76([PON_ELEM_INSP:179])>0)
			OBJECT SET VISIBLE:C603(*; "PON_CopyNBE"; False:C215)
		Else 
			OBJECT SET VISIBLE:C603(*; "PON_CopyNBE"; True:C214)
		End if 
		If (Read only state:C362(Current form table:C627->))
			OBJECT SET ENABLED:C1123(*; "DE @"; False:C215)
			OBJECT SET ENABLED:C1123(*; "PON_CopyNBE"; False:C215)
			
		Else 
			OBJECT SET ENABLED:C1123(*; "DE @"; True:C214)
			OBJECT SET ENABLED:C1123(*; "PON_CopyNBE"; True:C214)
			
		End if 
		
		LISTBOX SELECT ROW:C912(*; $LBName_txt; 0; lk remove from selection:K53:3)
		REDRAW:C174($LBVar_ptr->)
		
	: ($formEvent_L=On Resize:K2:27)
		REDRAW:C174($LBVar_ptr->)
		
End case 
