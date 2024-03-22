//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/11/05, 14:17:45
	// ----------------------------------------------------
	// Method: WKHR_AddEstToSum
	// Description
	// Add current estimate values to the sums
	//
	// Parameters
	// ----------------------------------------------------
	
	// Modified by: costasmanousakis-(Designer)-(4/11/11 10:25:10)
	Mods_2011_04
	//  `Added call to ut_CollapseList to make sure list is at state it should be - for v11 transition
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v1
End if 
C_TEXT:C284($IndexPrefix; $ItemTxt; $vsPointername; $ItemText_txt)
C_POINTER:C301($arr_1_ptr; $arr_3_ptr; $arr_4_ptr)
C_POINTER:C301($textVar_ptr; $t)
C_LONGINT:C283($k; $pgno; $i; $Wkhr_list; $ItemSubList; $catRef; $ItemCount; $ic; $ItemRef; $vPointerTnum; $vPointerFnum; $ItemRef_L)
C_BOOLEAN:C305($btOK; $sublistExp)
ut_CollapseList(->AllCategories_HL)
For ($i; 1; <>WKH_NumPgs)
	SELECT LIST ITEMS BY POSITION:C381(AllCategories_HL; $i)
	GET LIST ITEM:C378(AllCategories_HL; $i; $catRef; $ItemTxt; $ItemSubList; $sublistExp)
	$arr_1_ptr:=Get pointer:C304("Arr_"+String:C10($catRef)+"_1")
	$arr_3_ptr:=Get pointer:C304("Arr_"+String:C10($catRef)+"_Values")
	$arr_4_ptr:=Get pointer:C304("Arr_"+String:C10($catRef)+"_Totals")
	$ItemCount:=Size of array:C274($arr_1_ptr->)
	//Sum Items
	If ($arr_4_ptr->{6}>0)  //sum  only there is something for the category
		
		For ($ic; 1; $ItemCount)
			If ($arr_3_ptr->{6}{$ic}>0)  //sum  only there is something for the item
				$k:=Find in array:C230(ArrSum_ItemNos; $arr_1_ptr->{$ic})
				If ($k>0)
					ArrSum_ItemValues{1}{$k}:=ArrSum_ItemValues{1}{$k}+$arr_3_ptr->{1}{$ic}
					ArrSum_ItemValues{2}{$k}:=ArrSum_ItemValues{2}{$k}+$arr_3_ptr->{2}{$ic}
					ArrSum_ItemValues{3}{$k}:=ArrSum_ItemValues{3}{$k}+$arr_3_ptr->{3}{$ic}
					ArrSum_ItemValues{4}{$k}:=ArrSum_ItemValues{4}{$k}+$arr_3_ptr->{4}{$ic}
					ArrSum_ItemValues{5}{$k}:=ArrSum_ItemValues{5}{$k}+$arr_3_ptr->{5}{$ic}
					ArrSum_ItemValues{6}{$k}:=ArrSum_ItemValues{6}{$k}+$arr_3_ptr->{6}{$ic}
					ArrSum_ItemCnt{$k}:=ArrSum_ItemCnt{$k}+1
				End if 
			End if 
		End for 
		$k:=Find in array:C230(ArrSum_ItemNos; String:C10($catRef))
		If ($k>0)
			ArrSum_ItemValues{1}{$k}:=ArrSum_ItemValues{1}{$k}+$arr_4_ptr->{1}
			ArrSum_ItemValues{2}{$k}:=ArrSum_ItemValues{2}{$k}+$arr_4_ptr->{2}
			ArrSum_ItemValues{3}{$k}:=ArrSum_ItemValues{3}{$k}+$arr_4_ptr->{3}
			ArrSum_ItemValues{4}{$k}:=ArrSum_ItemValues{4}{$k}+$arr_4_ptr->{4}
			ArrSum_ItemValues{5}{$k}:=ArrSum_ItemValues{5}{$k}+$arr_4_ptr->{5}
			ArrSum_ItemValues{6}{$k}:=ArrSum_ItemValues{6}{$k}+$arr_4_ptr->{6}
			ArrSum_ItemCnt{$k}:=ArrSum_ItemCnt{$k}+1
		End if 
	End if 
End for 