//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/03/05, 22:52:32
	// ----------------------------------------------------
	// Method: WKHR_SetUpCategPullDwn
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	// Modified by: costasmanousakis-(Designer)-(11/30/2005 10:41:07)
	Mods_2005_CM19
	// Modified by: costasmanousakis-(Designer)-(3/16/09 12:16:47)
	Mods_2009_CM_5404  //Copied to Server on : 03/19/09, 12:01:59  ` ("WKHRMODS")
	// Modified by: costasmanousakis-(Designer)-(4/6/11 08:26:45)
	Mods_2011_04
	//  `Added call to ut_CollapseList to make sure the List is collapsed - Fix for the v11 transition
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v1
End if 
C_LONGINT:C283($Wkhr_list)
$Wkhr_list:=Load list:C383(WKHR_ItmListName_txt)
C_POINTER:C301($textVar_ptr)

ARRAY TEXT:C222(WKHR_PageTitles; 0)
C_LONGINT:C283($NumAllowedCats_L; $restrictPos_L; $ItemRef_L)
C_TEXT:C284($ItemText_txt)

ut_CollapseList(->$Wkhr_list)
C_LONGINT:C283($i; $catRef; $ItemSubList; $ItemCount)
C_BOOLEAN:C305($sublistExp)
C_TEXT:C284($ItemTxt)
$NumAllowedCats_L:=0
For ($i; 1; <>WKH_NumPgs)  //number of categories / pages
	SELECT LIST ITEMS BY POSITION:C381($Wkhr_list; $i)
	GET LIST ITEM:C378($Wkhr_list; $i; $catRef; $ItemTxt; $ItemSubList; $sublistExp)
	$textVar_ptr:=Get pointer:C304("item_"+String:C10($catRef)+"_T0")  //Category label for Totals Page
	$textVar_ptr->:=String:C10($catRef)+" - "+$ItemTxt
	$ItemCount:=Count list items:C380($ItemSubList)
	
	$restrictPos_L:=Find in array:C230(Arr_WKHR_RestrictedItems_I; $catRef)
	If ($restrictPos_L>0)
		
	Else 
		$NumAllowedCats_L:=$NumAllowedCats_L+1
		INSERT IN ARRAY:C227(WKHR_PageTitles; $NumAllowedCats_L)
		WKHR_PageTitles{$NumAllowedCats_L}:=String:C10($catRef)+" - "+$ItemTxt
	End if 
	
End for 
INSERT IN ARRAY:C227(WKHR_PageTitles; 0)
WKHR_PageTitles{1}:="General"
INSERT IN ARRAY:C227(WKHR_PageTitles; (Size of array:C274(WKHR_PageTitles)+1))
WKHR_PageTitles{(Size of array:C274(WKHR_PageTitles))}:="Totals"
INSERT IN ARRAY:C227(WKHR_PageTitles; (Size of array:C274(WKHR_PageTitles)+1))
WKHR_PageTitles{(Size of array:C274(WKHR_PageTitles))}:="Review/Approval Comments"

CLEAR LIST:C377($Wkhr_list; *)