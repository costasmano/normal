//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/07/05, 08:41:12
	// ----------------------------------------------------
	// Method: WKHR_InitConfigArrays
	// Description
	// Initialize arrays used in configuring Workhour Estimates.
	//
	// Parameters
	// ----------------------------------------------------
	
	// Modified by: costasmanousakis-(Designer)-(3/2/09 01:09:00)
	Mods_2009_CM_5404  //Copied to Server on : 03/19/09, 12:05:30  ` ("WKHRMODS")
	// Modified by: costasmanousakis-(Designer)-(4/6/11 08:26:45)
	Mods_2011_04
	//  `Added calls to ut_CollapseList  and ut_ExpandList  to make sure the Lists are at the state they should be
	//  `Also check if a sublist is actually a sublist - Fix for the v11 transition
	// Modified by: costasmanousakis-(Designer)-(5/26/11 16:54:24)
	Mods_2011_05
	//  `fixed the SET LIST ITEM command for AllCategories_HL to keep any existing sublists.
	//  `Also will not loop over sublist, since the list is expanded to start with.
	//  `In case of a sublist make the parent bold and italic
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v1
End if 

C_TEXT:C284(WKHR_ItmListName_txt; WKHR_ItmListXrefName_txt)
If ([Work_Estimate:103]Version_L:47=1)
	WKHR_ItmListName_txt:="WKHR_items_V1"
	WKHR_ItmListXrefName_txt:="WKHR_ItemsNos_V1"
Else 
	WKHR_ItmListName_txt:="WKHR_items"
	WKHR_ItmListXrefName_txt:="WKHR_ItemsNos"
End if 

ARRAY TEXT:C222($ListArray; 0)
LIST TO ARRAY:C288(WKHR_ItmListName_txt; $ListArray)
C_LONGINT:C283(<>WKH_NumPgs)  //Command Replaced was o_C_INTEGER
<>WKH_NumPgs:=Size of array:C274($ListArray)
ARRAY TEXT:C222($ListArray; 0)

C_LONGINT:C283(AllCategoriesNos_HL)
If (Is a list:C621(AllCategoriesNos_HL))
	CLEAR LIST:C377(AllCategoriesNos_HL; *)
End if 
AllCategoriesNos_HL:=Load list:C383(WKHR_ItmListXrefName_txt)

ARRAY TEXT:C222(<>a_WKH_Index_Name; <>WKH_NumPgs)  //Command Replaced was o_ARRAY string length was 3
ARRAY INTEGER:C220(<>a_WKH_NumRows; <>WKH_NumPgs)
ARRAY INTEGER:C220(<>a_WKH_LastDefID; <>WKH_NumPgs)

ARRAY TEXT:C222(Arr_CurrCategories_txt; 0)
ARRAY TEXT:C222(Arr_AllMajCategories_txt; <>WKH_NumPgs)
ARRAY TEXT:C222(Arr_AllSubCategories_txt; 0)
ARRAY TEXT:C222(Arr_AllCategories_txt; <>WKH_NumPgs)
ARRAY LONGINT:C221(Arr_AllCategories_L; <>WKH_NumPgs)
ARRAY LONGINT:C221(Arr_AllCategoriesPar_L; <>WKH_NumPgs)
C_LONGINT:C283($Wkhr_list; $ItemSubList; $TempWin)
C_LONGINT:C283($ArraySize_1; $NumAllowedCats_L; $restrictPos_L; $catRef; $i; $PageFnd; $NumSubItems_L; $ic; $ArraySize_0; $catRef_sub)
C_TEXT:C284($tempCategPrefix)  // Command Replaced was o_C_STRING length was 3
C_BOOLEAN:C305($sublistExp)
C_TEXT:C284($ItemTxt; $CurrPageLbl; $ItemTxt_Sub)

$Wkhr_list:=Load list:C383(WKHR_ItmListName_txt)
ut_CollapseList(->$Wkhr_list)
For ($i; 1; <>WKH_NumPgs)  //number of standard categories / pages
	SELECT LIST ITEMS BY POSITION:C381($Wkhr_list; $i)
	GET LIST ITEM:C378($Wkhr_list; $i; $catRef; $ItemTxt; $ItemSubList; $sublistExp)
	Arr_AllMajCategories_txt{$i}:=WKHR_GetItemNo($catRef)+" - "+$ItemTxt
	Arr_AllCategories_txt{$i}:=WKHR_GetItemNo($catRef)+" - "+$ItemTxt
	Arr_AllCategories_L{$i}:=$catRef
	<>a_WKH_Index_Name{$i}:=WKHR_GetItemNo($catRef)
	C_TEXT:C284($ItemText_txt)
	$NumSubItems_L:=Count list items:C380($ItemSubList)
	GET LIST ITEM:C378($ItemSubList; $NumSubItems_L; $ItemRef_L; $ItemText_txt)
	<>a_WKH_NumRows{$i}:=$NumSubItems_L  //number of standard items per category
	<>a_WKH_LastDefID{$i}:=$ItemRef_L  //Last ID of standard sub-Items
	
	$ArraySize_0:=Size of array:C274(Arr_AllSubCategories_txt)
	$ArraySize_1:=Size of array:C274(Arr_AllCategories_txt)
	INSERT IN ARRAY:C227(Arr_AllSubCategories_txt; ($ArraySize_0+1); $NumSubItems_L)
	INSERT IN ARRAY:C227(Arr_AllCategories_txt; ($ArraySize_1+1); $NumSubItems_L)
	INSERT IN ARRAY:C227(Arr_AllCategories_L; ($ArraySize_1+1); $NumSubItems_L)
	INSERT IN ARRAY:C227(Arr_AllCategoriesPar_L; ($ArraySize_1+1); $NumSubItems_L)
	
	For ($ic; 1; $NumSubItems_L)
		GET LIST ITEM:C378($ItemSubList; $ic; $catRef_sub; $ItemTxt_Sub)
		Arr_AllSubCategories_txt{$ArraySize_0+$ic}:=WKHR_GetItemNo($catRef_sub)+" - "+$ItemTxt_Sub
		Arr_AllCategories_txt{$ArraySize_1+$ic}:=WKHR_GetItemNo($catRef_sub)+" - "+$ItemTxt_Sub
		Arr_AllCategories_L{$ArraySize_1+$ic}:=$catRef_sub
		Arr_AllCategoriesPar_L{$ArraySize_1+$ic}:=$catRef
	End for 
	
End for 
CLEAR LIST:C377($Wkhr_list; *)
SORT ARRAY:C229(Arr_AllCategories_L; Arr_AllCategories_txt; Arr_AllCategoriesPar_L)

C_LONGINT:C283($NumRestrCat_L; $NumRestrSubItm_L; $NumRestrTot_L; $ItemStyle; $ItemIcon_L; $ItemRef_L)
C_LONGINT:C283(AllCategories_HL; CurrCategories_HL; $SubList_HL)
C_TEXT:C284($ItemTxt_txt; $itemNo_txt)
If (Is a list:C621(AllCategories_HL))
	CLEAR LIST:C377(AllCategories_HL; *)
End if 

AllCategories_HL:=Load list:C383(WKHR_ItmListName_txt)
ut_ExpandList(->AllCategories_HL)
GET LIST PROPERTIES:C632(AllCategories_HL; $ListApp_L; $ListIcon_L; $ListHt_L; $DblClick_L)
SET LIST PROPERTIES:C387(AllCategories_HL; $ListApp_L; $ListIcon_L; $ListHt_L; 1)  //Disable double click
For ($i; 1; Count list items:C380(AllCategories_HL))
	GET LIST ITEM:C378(AllCategories_HL; $i; $ItemRef_L; $ItemTxt_txt; $SubList_HL)
	SET LIST ITEM:C385(AllCategories_HL; $ItemRef_L; (WKHR_GetItemNo($ItemRef_L)+" - "+$ItemTxt_txt); $ItemRef_L; -1; True:C214)
	If (Is a list:C621($SubList_HL))
		SET LIST ITEM PROPERTIES:C386(AllCategories_HL; $ItemRef_L; False:C215; (Bold:K14:2+Italic:K14:3); 0)  //non-enterable, boldItal; no icon
		//For ($ic;1;Count list items($SubList_HL))
		//GET LIST ITEM($SubList_HL;$ic;$ItemRef_L;$ItemTxt_txt)
		//SET LIST ITEM($SubList_HL;$ItemRef_L;(WKHR_GetItemNo ($ItemRef_L)+" - "+$ItemTxt_txt);$ItemRef_L)
		//End for 
	End if 
	
End for 