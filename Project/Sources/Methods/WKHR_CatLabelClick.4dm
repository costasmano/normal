//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 06/27/05, 11:41:19
	// ----------------------------------------------------
	// Method: WKHR_CatLabelClick
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	
End if 
C_TEXT:C284($1; $Label_txt)
$Label_txt:=$1
C_LONGINT:C283($pageno)  //Command Replaced was o_C_INTEGER
$pageno:=Find in array:C230(WKHR_PageTitles; $Label_txt)
If ($pageno>0)
	C_TEXT:C284(CategoryPrefix)  // Command Replaced was o_C_STRING length was 3
	C_LONGINT:C283(WKHR_CategoryNo; WKHR_MaxItemNo)  //Command Replaced was o_C_INTEGER
	FORM GOTO PAGE:C247(2)
	WKHR_CategoryNo:=$pageno
	WKHR_PageTitles:=WKHR_CategoryNo
	CategoryPrefix:=Substring:C12($Label_txt; 1; 3)
	WKHR_MaxItemNo:=Arr_WKHR_MinItemN{(WKHR_CategoryNo-1)}
	WKHR_LoadItemHRs
End if 
