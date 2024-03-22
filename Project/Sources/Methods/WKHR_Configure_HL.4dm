//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/08/05, 19:10:04
	// ----------------------------------------------------
	// Method: WKHR_Configure_HL
	// Description
	// Configure a Work Hour Estimate using Hierarchical Lists
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v1
End if 
C_LONGINT:C283($NumRestrCat_L; $NumRestrSubItm_L; $NumRestrTot_L; $ItemIcon_L; $PosInMajCat; $ic; $PageFnd)
C_LONGINT:C283($restrictPos_L; $i; CurrCategories_HL)

CurrCategories_HL:=New list:C375
$NumRestrCat_L:=Size of array:C274(Arr_WKHR_RestrictedItems_I)
$NumRestrSubItm_L:=Size of array:C274(Arr_WKHR_RestrictedSubItms_I)
$NumRestrTot_L:=$NumRestrCat_L+$NumRestrSubItm_L
For ($i; 1; $NumRestrCat_L)
	$restrictPos_L:=Find in array:C230(Arr_AllCategories_L; Arr_WKHR_RestrictedItems_I{$i})
	If ($restrictPos_L>0)
		APPEND TO LIST:C376(CurrCategories_HL; Arr_AllCategories_txt{$restrictPos_L}; Arr_WKHR_RestrictedItems_I{$i})
		SET LIST ITEM PROPERTIES:C386(CurrCategories_HL; Arr_WKHR_RestrictedItems_I{$i}; False:C215; (Bold:K14:2+Italic:K14:3); 0)  //non-enterable, boldItal; no icon
	End if 
	
End for 
For ($i; 1; $NumRestrSubItm_L)
	$restrictPos_L:=Find in array:C230(Arr_AllCategories_L; Arr_WKHR_RestrictedSubItms_I{$i})
	If ($restrictPos_L>0)
		APPEND TO LIST:C376(CurrCategories_HL; Arr_AllCategories_txt{$restrictPos_L}; Arr_WKHR_RestrictedSubItms_I{$i})
	End if 
	
End for 

SORT LIST:C391(CurrCategories_HL)

C_BOOLEAN:C305(vUseHLists_B; vAllowDefault_B)
vUseHLists_B:=True:C214
vAllowDefault_B:=True:C214
QUERY:C277([WorkHour_Config:104]; [WorkHour_Config:104]AssignType:2=[Contract_Assignment_Maintenance:101]ProjectType:36)
If (Records in selection:C76([WorkHour_Config:104])=0)
	vAllowDefault_B:=False:C215
End if 

C_LONGINT:C283($Width_l; $Height_l; $Win_l; $Pages_l)
C_BOOLEAN:C305($FixedWidth_b; $FixedHeight_b)
C_TEXT:C284($Title_txt)
FORM GET PROPERTIES:C674([Work_Estimate:103]; "Config"; $Width_l; $Height_l; $Pages_l; $FixedWidth_b; $FixedHeight_b; $Title_txt)
$Win_l:=ut_OpenNewWindow($Width_l; $Height_l; 0; 0; $Title_txt; "ut_CloseCancel")
//$TempWin:=Open form window([Work_Estimate];"Config";0)
DIALOG:C40([Work_Estimate:103]; "Config")
CLOSE WINDOW:C154($Win_l)

If (OK=1)
	C_TEXT:C284($CatRef_S)  // Command Replaced was o_C_STRING length was 3
	C_LONGINT:C283($NumAllowedCats_L; $CatRef_L)
	C_TEXT:C284($ItemTxt_txt)
	$NumAllowedCats_L:=Count list items:C380(CurrCategories_HL)
	ARRAY INTEGER:C220(Arr_WKHR_RestrictedItems_I; 0)
	ARRAY INTEGER:C220(Arr_WKHR_RestrictedSubItms_I; 0)
	If ($NumAllowedCats_L>0)
		For ($i; 1; $NumAllowedCats_L)
			GET LIST ITEM:C378(CurrCategories_HL; $i; $CatRef_L; $ItemTxt_txt)
			$CatRef_S:=String:C10($CatRef_L)
			$PosInMajCat:=Find in array:C230(<>a_WKH_Index_Name; $CatRef_S)
			
			Case of 
				: ($PosInMajCat>0)
					INSERT IN ARRAY:C227(Arr_WKHR_RestrictedItems_I; 0)
					Arr_WKHR_RestrictedItems_I{1}:=Num:C11($CatRef_S)
				Else 
					INSERT IN ARRAY:C227(Arr_WKHR_RestrictedSubItms_I; 0)
					Arr_WKHR_RestrictedSubItms_I{1}:=Num:C11($CatRef_S)
			End case 
			
		End for 
		//clear out restricted major categories
		For ($i; 1; Size of array:C274(Arr_WKHR_RestrictedItems_I))
			CategoryPrefix:=String:C10(Arr_WKHR_RestrictedItems_I{$i})
			WKHR_ClearOutCategory  //clear extra non-std items and comments.
			WKHR_ResetPageValues  //set values to 0
		End for 
		//Clear out restricted sub items
		If (Size of array:C274(Arr_WKHR_RestrictedSubItms_I)>0)
			ARRAY INTEGER:C220($arr_CategoriesRecalc_L; 0)
			C_LONGINT:C283($PosinAllItems_L; $ParentCat_L; $CmtIdx_L; $LocItmIdx_L)
			C_POINTER:C301($arrPtr_1; $arrPtr_3)
			C_TEXT:C284($ElemPrefix_S)  // Command Replaced was o_C_STRING length was 10
			For ($i; 1; Size of array:C274(Arr_WKHR_RestrictedSubItms_I))
				$ElemPrefix_S:=String:C10(Arr_WKHR_RestrictedSubItms_I{$i})
				$PosinAllItems_L:=Find in array:C230(Arr_AllCategories_L; Arr_WKHR_RestrictedSubItms_I{$i})
				If ($PosinAllItems_L>0)
					$ParentCat_L:=Arr_AllCategoriesPar_L{$PosinAllItems_L}  //Find Parent category
					If (Find in array:C230($arr_CategoriesRecalc_L; $ParentCat_L)<=0)
						INSERT IN ARRAY:C227($arr_CategoriesRecalc_L; 0)
						$arr_CategoriesRecalc_L{1}:=$ParentCat_L
					End if 
					$arrPtr_1:=Get pointer:C304("Arr_"+String:C10($ParentCat_L)+"_1")
					$arrPtr_3:=Get pointer:C304("Arr_"+String:C10($ParentCat_L)+"_Values")
					$LocItmIdx_L:=Find in array:C230($arrPtr_1->; $ElemPrefix_S)
					If ($LocItmIdx_L>0)
						For ($ic; 1; 6)
							$arrPtr_3->{$ic}{$LocItmIdx_L}:=0
						End for 
					End if 
					
					$CmtIdx_L:=Find in array:C230(Arr_WKHR_CommentsRef; Arr_WKHR_RestrictedSubItms_I{$i})
					If ($CmtIdx_L>0)
						DELETE FROM ARRAY:C228(Arr_WKHR_CommentsRef; $CmtIdx_L; 1)
						DELETE FROM ARRAY:C228(Arr_WKHR_Comments; $CmtIdx_L; 1)
						DELETE FROM ARRAY:C228(Arr_WKHR_CommentCat; $CmtIdx_L; 1)
					End if 
					
				End if 
			End for 
			For ($i; 1; Size of array:C274($arr_CategoriesRecalc_L))
				CategoryPrefix:=String:C10($arr_CategoriesRecalc_L{$i})
				WKHR_RecalcPage2(False:C215)
			End for 
		End if 
		//Recalc all
		WKHR_CalcTotals
	End if 
	
	C_BLOB:C604($RestrictedList_Blob)
	VARIABLE TO BLOB:C532(Arr_WKHR_RestrictedItems_I; $RestrictedList_Blob; *)
	VARIABLE TO BLOB:C532(Arr_WKHR_RestrictedSubItms_I; $RestrictedList_Blob; *)
	
	COMPRESS BLOB:C534($RestrictedList_Blob)
	[Work_Estimate:103]RestrictedItemList:32:=$RestrictedList_Blob
	PushChange(1; ->[Work_Estimate:103]RestrictedItemList:32)
	SET BLOB SIZE:C606($RestrictedList_Blob; 0)
	C_TEXT:C284($CurrPageLbl)
	$CurrPageLbl:=WKHR_PageTitles{WKHR_PageTitles}
	WKHR_SetUpCategPullDwn
	
	$PageFnd:=Find in array:C230(WKHR_PageTitles; $CurrPageLbl)
	Case of 
		: ($PageFnd>0)
			WKHR_PageTitles:=$PageFnd
			If (Num:C11(Substring:C12($CurrPageLbl; 1; 3))>0)
				CategoryPrefix:=Substring:C12($CurrPageLbl; 1; 3)
				WKHR_LoadItemHRs
			End if 
			
		Else 
			CategoryPrefix:=""
			WKHR_PageTitles:=1
			FORM GOTO PAGE:C247(1)
	End case 
	If ($CurrPageLbl="Totals")
		WKHR_ItalisizeLabels
	End if 
	
End if 
CLEAR LIST:C377(CurrCategories_HL; *)