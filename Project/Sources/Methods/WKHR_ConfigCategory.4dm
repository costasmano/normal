//%attributes = {"invisible":true}
// ----------------------------------------------------
// WKHR_ConfigCategory
// User name (OS): costasmanousakis
// User name (4D): Designer
// Date and time: 11/10/05, 17:56:34
// ----------------------------------------------------
// Method: WKHR_ConfigCategory
// Description
// Configure Category restricted items
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2009_03  //CJM  r001   `03/06/09, 14:33:52`Upgrade from open form window to open window
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v1
End if 

C_LONGINT:C283($NumRestrCat_L; $NumRestrSubItm_L; $NumRestrTot_L; $ItemIcon_L; $TempWin)
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
vAllowDefault_B:=False:C215

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
	C_LONGINT:C283($NumAllowedCats_L; $CatRef_L; $PosInMajCat)
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
	End if 
	
	C_BLOB:C604($RestrictedList_Blob)
	VARIABLE TO BLOB:C532(Arr_WKHR_RestrictedItems_I; $RestrictedList_Blob; *)
	VARIABLE TO BLOB:C532(Arr_WKHR_RestrictedSubItms_I; $RestrictedList_Blob; *)
	
	COMPRESS BLOB:C534($RestrictedList_Blob)
	[WorkHour_Config:104]ConfigArrays:1:=$RestrictedList_Blob
	SET BLOB SIZE:C606($RestrictedList_Blob; 0)
End if 
//End WKHR_ConfigCategory