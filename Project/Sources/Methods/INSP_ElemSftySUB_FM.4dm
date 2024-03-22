//%attributes = {"invisible":true}
//Method: INSP_ElemSftySUB_FM
//Description
// form method for the Listbox subforms in ElementsSafety
// Parameters
// $1 : $FormEvent_L
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/03/19, 13:59:25
	// ----------------------------------------------------
	//Created : 
	Mods_2019_05
	// Modified by: Costas Manousakis-(Designer)-(2/10/20 09:58:51)
	Mods_2020_02
	//  `deselect rows on load - added optional param to catch resize event
	
	
	C_LONGINT:C283(INSP_ElemSftySUB_FM; $1)
End if 
//
C_LONGINT:C283($FormEvent_L)

If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$FormEvent_L:=$1
Else 
	$FormEvent_L:=Form event code:C388
End if 

C_TEXT:C284($LBName_txt)
C_POINTER:C301($LBVar_otr)
$LBName_txt:="ElementSafety_LB"
$LBVar_otr:=OBJECT Get pointer:C1124(Object named:K67:5; $LBName_txt)

Case of 
	: ($FormEvent_L=On Load:K2:1)
		
		If (Read only state:C362(Current form table:C627->))
			OBJECT SET ENABLED:C1123(*; "DE@"; False:C215)
		Else 
			OBJECT SET ENABLED:C1123(*; "DE@"; True:C214)
		End if 
		LISTBOX SELECT ROW:C912(*; $LBName_txt; 0; lk remove from selection:K53:3)
		REDRAW:C174($LBVar_otr->)
		
	: ($FormEvent_L=On Resize:K2:27)
		REDRAW:C174($LBVar_otr->)
		
End case 

//End INSP_ElemSftySUB_FM