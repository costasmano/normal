//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/08/05, 19:26:18
	// ----------------------------------------------------
	// Method: WKHR_MoveToExcluded_HL
	// Description
	// Move Work hours Items to restricted for Hierarchical List
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v1
End if 
C_LONGINT:C283($i; $selectListItm_L; $ItemRef_L; $PosInCurr_L; $ItemStyle_L; $ItemParRef_L; $NumSubL_L)
C_LONGINT:C283($SubList_HL; $SubListCopy_HL)
C_BOOLEAN:C305($ItemEnter_B; $ItemInExcl_B; $SubListExp_B)
C_TEXT:C284($ItemTxt_txt)
$selectListItm_L:=Selected list items:C379(AllCategories_HL)
GET LIST ITEM:C378(AllCategories_HL; $selectListItm_L; $ItemRef_L; $ItemTxt_txt; $SubList_HL)
If (Is a list:C621($SubList_HL))
	$SubListCopy_HL:=Copy list:C626($SubList_HL)
	$NumSubL_L:=Count list items:C380($SubListCopy_HL)
End if 
GET LIST ITEM PROPERTIES:C631(AllCategories_HL; $ItemRef_L; $ItemEnter_B; $ItemStyle_L)
$ItemParRef_L:=List item parent:C633(AllCategories_HL; $ItemRef_L)
$PosInCurr_L:=List item position:C629(CurrCategories_HL; $ItemRef_L)
$ItemInExcl_B:=($PosInCurr_L>0)
If ($ItemParRef_L>0)
	$PosInCurr_L:=List item position:C629(CurrCategories_HL; $ItemParRef_L)
	$ItemInExcl_B:=$ItemInExcl_B | ($PosInCurr_L>0)
End if 
If (Not:C34($ItemInExcl_B))
	APPEND TO LIST:C376(CurrCategories_HL; $ItemTxt_txt; $ItemRef_L)
	SET LIST ITEM PROPERTIES:C386(CurrCategories_HL; $ItemRef_L; $ItemEnter_B; $ItemStyle_L; 0)
	If (Is a list:C621($SubListCopy_HL))
		For ($i; 1; $NumSubL_L)
			GET LIST ITEM:C378($SubListCopy_HL; $i; $ItemRef_L; $ItemTxt_txt)
			$PosInCurr_L:=List item position:C629(CurrCategories_HL; $ItemRef_L)
			If ($PosInCurr_L>0)
				DELETE FROM LIST:C624(CurrCategories_HL; $ItemRef_L)
			End if 
			
		End for 
		
	End if 
	
	SORT LIST:C391(CurrCategories_HL)
	REDRAW:C174(CurrCategories_HL)  // Command Replaced was o_REDRAW LIST 
End if 
If (Is a list:C621($SubListCopy_HL))
	CLEAR LIST:C377($SubListCopy_HL; *)
End if 
