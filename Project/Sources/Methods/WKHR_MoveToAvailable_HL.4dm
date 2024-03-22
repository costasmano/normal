//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/08/05, 19:25:32
	// ----------------------------------------------------
	// Method: WKHR_MoveToAvailable_HL
	// Description
	// Move Work hours Items out of restricted for Hierarchical List
	//
	// Parameters
	// ----------------------------------------------------
	
End if 
C_LONGINT:C283($selectListItm_L; $ItemRef_L)
C_TEXT:C284($ItemTxt_txt)
$selectListItm_L:=Selected list items:C379(CurrCategories_HL)
GET LIST ITEM:C378(CurrCategories_HL; $selectListItm_L; $ItemRef_L; $ItemTxt_txt)
If ($ItemRef_L>0)
	DELETE FROM LIST:C624(CurrCategories_HL; $ItemRef_L)
	If ($selectListItm_L>Count list items:C380(CurrCategories_HL))
		SELECT LIST ITEMS BY POSITION:C381(CurrCategories_HL; Count list items:C380(CurrCategories_HL))
	End if 
	REDRAW:C174(CurrCategories_HL)  // Command Replaced was o_REDRAW LIST 
End if 
