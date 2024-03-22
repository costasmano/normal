//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/04/05, 10:15:26
	// ----------------------------------------------------
	// Method: WKHR_ItalisizeLabels
	// Description
	// Italisize Category Labels at the Totals page depending on whether the
	// Category is included or not.
	//
	// Parameters
	// ----------------------------------------------------
	
End if 
C_LONGINT:C283($i; $CatRef; $InExcluded)
C_TEXT:C284($LabelVar_txt)
For ($i; 1; <>WKH_NumPgs)
	$CatRef:=Num:C11(<>a_WKH_Index_Name{$i})
	$InExcluded:=Find in array:C230(Arr_WKHR_RestrictedItems_I; $CatRef)
	$LabelVar_txt:="Item_"+<>a_WKH_Index_Name{$i}+"_T0"
	If ($InExcluded>0)
		OBJECT SET FONT STYLE:C166(*; $LabelVar_txt; Plain:K14:1)
	Else 
		OBJECT SET FONT STYLE:C166(*; $LabelVar_txt; (Bold:K14:2+Underline:K14:4))
	End if 
End for 