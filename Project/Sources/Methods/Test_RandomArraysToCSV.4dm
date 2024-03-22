//%attributes = {"invisible":true}
//Method: Test_RandomArraysToCSV
//Description
// test generating random contect of arrays and then export them to a CSV file.
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/17/19, 16:01:41
	// ----------------------------------------------------
	//Created : 
	Mods_2019_06
End if 
//
ARRAY LONGINT:C221($PRJ_PROJECT_NO_al; 0)
ARRAY TEXT:C222($PRJFileAdDate_atxt; 0)
ARRAY REAL:C219($PRJ_AdCost_ar; 0)
ARRAY REAL:C219($PRJ_FedPartCost_ar; 0)
ARRAY TEXT:C222($PRJTipYear_atxt; 0)
ARRAY REAL:C219($PRJ_TipCost_ar; 0)
ARRAY TEXT:C222($PRJ_BidOpenedDate_atxt; 0)
ARRAY REAL:C219($PRJ_OfficeEst_ar; 0)
ARRAY TEXT:C222($PRJ_TypeCode_as; 0)  // old _ O _ARRAY STRING length 2
ARRAY TEXT:C222($PRJ_Description_atxt; 0)

//OB SET($test_ao{1};"arrPointer";->PRJ_PROJECT_NO_al)
//OB SET($test_ao{2};"arrPointer";->PRJFileAdDate_atxt)
//OB SET($test_ao{3};"arrPointer";->PRJ_AdCost_ar)
//OB SET($test_ao{4};"arrPointer";->PRJ_FedPartCost_ar)
//OB SET($test_ao{5};"arrPointer";->PRJTipYear_atxt)
//OB SET($test_ao{6};"arrPointer";->PRJ_TipCost_ar)
//OB SET($test_ao{7};"arrPointer";->PRJ_BidOpenedDate_atxt)
//OB SET($test_ao{8};"arrPointer";->PRJ_OfficeEst_ar)
//OB SET($test_ao{9};"arrPointer";->PRJ_TypeCode_as)
//OB SET($test_ao{10};"arrPointer";->PRJ_Description_atxt)

//C_POINTER($arr_ptr)
//$arr_ptr:=OB Get($test_ao{7};"arrPointer")
//C_OBJECT($arrays_o)

C_TEXT:C284($seed_txt; $sample_txt)
C_LONGINT:C283($textLen_L; $char_L; $pos_L)
$seed_txt:=" abcdefghijklmnopqrstuvwxyz +-1234567890!,.@#$%&*()/;:'[]{}"+"\t"+Char:C90(Double quote:K15:41)+"\n"
C_LONGINT:C283($loop)
For ($loop; 1; 3000)
	APPEND TO ARRAY:C911($PRJ_PROJECT_NO_al; ((Random:C100%(666001-600000+1))+600000))
	APPEND TO ARRAY:C911($PRJFileAdDate_atxt; String:C10(Add to date:C393(Current date:C33(*); 0; 0; ((Random:C100%(2000-100+1))+100)); ISO date GMT:K1:10))
	APPEND TO ARRAY:C911($PRJ_AdCost_ar; ((Random:C100%(4000000-100000+1))+100000))
	APPEND TO ARRAY:C911($PRJ_FedPartCost_ar; ((Random:C100%(4000000-100000+1))+100000))
	APPEND TO ARRAY:C911($PRJTipYear_atxt; String:C10((Random:C100%(2030-2010+1))+2010))
	APPEND TO ARRAY:C911($PRJ_TipCost_ar; ((Random:C100%(4000000-100000+1))+100000))
	APPEND TO ARRAY:C911($PRJ_BidOpenedDate_atxt; String:C10(Add to date:C393(Current date:C33(*); 0; 0; ((Random:C100%(3000-500+1))+500)); ISO date GMT:K1:10))
	APPEND TO ARRAY:C911($PRJ_OfficeEst_ar; ((Random:C100%(5000000-100000+1))+100000))
	$textLen_L:=(Random:C100%(90-10+1))+10
	$sample_txt:=""
	For ($char_L; 1; $textLen_L)
		$pos_L:=(Random:C100%(Length:C16($seed_txt)-1+1))+1
		$sample_txt:=$sample_txt+Substring:C12($seed_txt; $pos_L; 1)
	End for 
	APPEND TO ARRAY:C911($PRJ_Description_atxt; $sample_txt)
	
End for 

//APPEND TO ARRAY($arrays_aptr;->PRJFileAdDate_atxt)
//APPEND TO ARRAY($arrays_aptr;->PRJ_AdCost_ar)
C_TEXT:C284($res_txt)

$res_txt:=ut_ArraysToText(","; \
->$PRJ_PROJECT_NO_al; \
->$PRJFileAdDate_atxt; \
->$PRJ_AdCost_ar; \
->$PRJ_FedPartCost_ar; \
->$PRJTipYear_atxt; \
->$PRJ_TipCost_ar; \
->$PRJ_BidOpenedDate_atxt; \
->$PRJ_OfficeEst_ar; \
->$PRJ_Description_atxt)

C_TEXT:C284($doc_txt)
$doc_txt:=Select document:C905(""; ".csv"; "Pick a CSV file"; File name entry:K24:17; $PRJ_Description_atxt)
$doc_txt:=$PRJ_Description_atxt{1}
TEXT TO DOCUMENT:C1237($doc_txt; $res_txt)
SHOW ON DISK:C922($doc_txt)


//End Test_RandomArraysToCSV