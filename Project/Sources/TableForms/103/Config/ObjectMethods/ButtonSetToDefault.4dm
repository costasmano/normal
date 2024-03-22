If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/10/05, 21:42:04
	// ----------------------------------------------------
	// Method: Object Method: SetToDefault
	// Description
	// Set the List to default.
	//
	// Parameters
	// ----------------------------------------------------
	
End if 

CONFIRM:C162("Set the list of Excluded Items to the default list for "+[WorkHour_Config:104]AssignType:2+" Projects?")
If (Ok=1)
	C_LONGINT:C283($NumRestrCat_L; $NumRestrSubItm_L; $NumRestrTot_L; $ItemIcon_L; $TempWin; $offset)
	C_LONGINT:C283($restrictPos_L; $i; CurrCategories_HL; $IsCompressed_L; $offset)
	C_BLOB:C604($TempBlob_BL)
	ARRAY INTEGER:C220($a_RestrictedItm_I; 0)
	ARRAY INTEGER:C220($a_RestrictedSubItm_I; 0)
	
	If (Is a list:C621(CurrCategories_HL))
		CLEAR LIST:C377(CurrCategories_HL; *)
	End if 
	$TempBlob_BL:=[WorkHour_Config:104]ConfigArrays:1
	BLOB PROPERTIES:C536($TempBlob_BL; $IsCompressed_L)
	If ($IsCompressed_L#0)
		EXPAND BLOB:C535($TempBlob_BL)
	End if 
	$offset:=0
	BLOB TO VARIABLE:C533($TempBlob_BL; $a_RestrictedItm_I; $offset)
	BLOB TO VARIABLE:C533($TempBlob_BL; $a_RestrictedSubItm_I; $offset)
	SET BLOB SIZE:C606($TempBlob_BL; 0)
	
	CurrCategories_HL:=New list:C375
	$NumRestrCat_L:=Size of array:C274($a_RestrictedItm_I)
	$NumRestrSubItm_L:=Size of array:C274($a_RestrictedSubItm_I)
	$NumRestrTot_L:=$NumRestrCat_L+$NumRestrSubItm_L
	For ($i; 1; $NumRestrCat_L)
		$restrictPos_L:=Find in array:C230(Arr_AllCategories_L; $a_RestrictedItm_I{$i})
		If ($restrictPos_L>0)
			APPEND TO LIST:C376(CurrCategories_HL; Arr_AllCategories_txt{$restrictPos_L}; $a_RestrictedItm_I{$i})
			SET LIST ITEM PROPERTIES:C386(CurrCategories_HL; $a_RestrictedItm_I{$i}; False:C215; (Bold:K14:2+Italic:K14:3); 0)  //non-enterable, boldItal; no icon
		End if 
		
	End for 
	For ($i; 1; $NumRestrSubItm_L)
		$restrictPos_L:=Find in array:C230(Arr_AllCategories_L; $a_RestrictedSubItm_I{$i})
		If ($restrictPos_L>0)
			APPEND TO LIST:C376(CurrCategories_HL; Arr_AllCategories_txt{$restrictPos_L}; $a_RestrictedSubItm_I{$i})
		End if 
		
	End for 
	
	SORT LIST:C391(CurrCategories_HL)
	REDRAW:C174(CurrCategories_HL)  // Command Replaced was o_REDRAW LIST 
	ARRAY INTEGER:C220($a_RestrictedItm_I; 0)
	ARRAY INTEGER:C220($a_RestrictedSubItm_I; 0)
	
End if 