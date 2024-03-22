//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/03/05, 21:28:42
	// ----------------------------------------------------
	// Method: WKHR_Configure
	// Description
	// Configure a Work Hour Estimate using Scrollable areas.
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2009_03  //CJM  r001   `03/06/09, 14:34:50`Upgrade from open form window to open window
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v1
End if 
C_LONGINT:C283($NumRestrCat_L; $NumRestrSubItm_L; $NumRestrTot_L; $i; $PosInMajCat; $ic)
$NumRestrCat_L:=Size of array:C274(Arr_WKHR_RestrictedItems_I)
$NumRestrSubItm_L:=Size of array:C274(Arr_WKHR_RestrictedSubItms_I)
$NumRestrTot_L:=$NumRestrCat_L+$NumRestrSubItm_L
ARRAY TEXT:C222(Arr_CurrCategories_txt; $NumRestrTot_L)
C_LONGINT:C283($restrictPos_L)
For ($i; 1; $NumRestrCat_L)
	$restrictPos_L:=Find in array:C230(Arr_AllCategories_L; Arr_WKHR_RestrictedItems_I{$i})
	If ($restrictPos_L>0)
		Arr_CurrCategories_txt{$i}:=Arr_AllCategories_txt{$restrictPos_L}
	End if 
	
End for 
For ($i; 1; $NumRestrSubItm_L)
	$restrictPos_L:=Find in array:C230(Arr_AllCategories_L; Arr_WKHR_RestrictedSubItms_I{$i})
	If ($restrictPos_L>0)
		Arr_CurrCategories_txt{$NumRestrCat_L+$i}:=Arr_AllCategories_txt{$restrictPos_L}
	End if 
	
End for 
SORT ARRAY:C229(Arr_CurrCategories_txt)
C_BOOLEAN:C305(vUseHLists_B)
vUseHLists_B:=False:C215

C_LONGINT:C283($Width_l; $Height_l; $Win_l; $Pages_l)
C_BOOLEAN:C305($FixedWidth_b; $FixedHeight_b)
C_TEXT:C284($Title_txt)
FORM GET PROPERTIES:C674([Work_Estimate:103]; "Config"; $Width_l; $Height_l; $Pages_l; $FixedWidth_b; $FixedHeight_b; $Title_txt)
$Win_l:=ut_OpenNewWindow($Width_l; $Height_l; 0; Plain form window:K39:10; $Title_txt; "ut_CloseCancel")
//$TempWin:=Open form window([Work_Estimate];"Config";0)
DIALOG:C40([Work_Estimate:103]; "Config")
CLOSE WINDOW:C154($Win_l)

If (OK=1)
	C_TEXT:C284($CatRef_S)  // Command Replaced was o_C_STRING length was 3
	C_LONGINT:C283($NumAllowedCats_L)
	$NumAllowedCats_L:=Size of array:C274(Arr_CurrCategories_txt)
	ARRAY INTEGER:C220(Arr_WKHR_RestrictedItems_I; 0)
	ARRAY INTEGER:C220(Arr_WKHR_RestrictedSubItms_I; 0)
	If ($NumAllowedCats_L>0)
		For ($i; 1; $NumAllowedCats_L)
			$CatRef_S:=Substring:C12(Arr_CurrCategories_txt{$i}; 1; 3)
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
			WKHR_ResetPageValues
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
	C_LONGINT:C283($PageFnd)
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
ARRAY TEXT:C222(Arr_CurrCategories_txt; 0)