//%attributes = {"invisible":true}
//Method: SIA_LoadSelectionListInfo
//Description
// Load the FHWA selectList dates - update date variables passed as pointers
// Parameters
// $1 : $FHWADate_ptr
// $2 : $LoadedDate_ptr
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 10/12/17, 14:26:08
	// ----------------------------------------------------
	//Created : 
	Mods_2017_10
	
	C_POINTER:C301(SIA_LoadSelectionListInfo; $1)
	C_POINTER:C301(SIA_LoadSelectionListInfo; $2)
	
End if 
//
C_POINTER:C301($1; $2)

C_TEXT:C284($test_txt; $tree_txt; $PrevErrMethod_txt; $test1_txt)

$test1_txt:=ut_GetSysParameter("FHWASELECT_INFO")
$test_txt:=ut_GetSysParameter("FHWASELECT_INFO"; ""; "VALUE")
//check if the value is still in the old format
C_BOOLEAN:C305($ValueoldFormat_b)
$ValueoldFormat_b:=Match regex:C1019("^\\d{4}_\\d{2}_\\d{2} : \\d{4}_\\d{2}_\\d{2}$"; $test_txt)

If ($ValueoldFormat_b)
	//use the text from the Value field
Else 
	$test_txt:=$test1_txt  // use the description. that is in XML
End if 

$PrevErrMethod_txt:=Method called on error:C704
ON ERR CALL:C155("XMLErrorHandler")
XMLError_b:=False:C215
$tree_txt:=DOM Parse XML variable:C720($test_txt)
ON ERR CALL:C155($PrevErrMethod_txt)
C_DATE:C307($DateValue_d; $DateValue2_d)

If (XMLError_b)
	//bad tree try YYYY_MM_DD : YYYY_MM_DD format
	$DateValue_d:=Date:C102(Substring:C12($test_txt; 6; 2)+"/"+Substring:C12($test_txt; 9; 2)+"/"+Substring:C12($test_txt; 1; 4))
	$DateValue2_d:=Date:C102(Substring:C12($test_txt; 19; 2)+"/"+Substring:C12($test_txt; 22; 2)+"/"+Substring:C12($test_txt; 14; 4))
Else 
	DOM GET XML ATTRIBUTE BY NAME:C728($tree_txt; "UPACSDate"; $DateValue_d)
	DOM GET XML ATTRIBUTE BY NAME:C728($tree_txt; "ImportDate"; $DateValue2_d)
End if 

$1->:=$DateValue_d
$2->:=$DateValue2_d
//End SIA_LoadSelectionListInfo