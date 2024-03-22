//%attributes = {"invisible":true}
//Method: Test_ScanXMLWorkbook
//Description
// scan an XML workbook by loading it in a memory and use DOM instead of SAX
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 12/20/17, 10:34:21
	// ----------------------------------------------------
	//Created : 
	Mods_2017_12
End if 
//
C_TIME:C306($doc_t)
$doc_t:=Open document:C264(""; ""; Read mode:K24:5)
CLOSE DOCUMENT:C267($doc_t)
C_TEXT:C284($loadWorkbook_txt; $Rows_txt; $SheetName_txt)
$loadWorkbook_txt:=DOM Parse XML source:C719(document)
ARRAY TEXT:C222($worksheets_atxt; 0)
$Rows_txt:=DOM Find XML element:C864($loadWorkbook_txt; "/Workbook/Worksheet"; $worksheets_atxt)
C_LONGINT:C283($loop_L)
For ($loop_L; 1; Size of array:C274($worksheets_atxt))
	//search for workSheet by name
	
	DOM GET XML ATTRIBUTE BY NAME:C728($worksheets_atxt{$loop_L}; "ss:Name"; $SheetName_txt)
	If ($SheetName_txt="Element Database")
		ARRAY TEXT:C222($SheetRows_atxt; 0)
		C_TEXT:C284($ChildName_txt; $ChildRef_txt)
		
		$Rows_txt:=DOM Find XML element:C864($worksheets_atxt{$loop_L}; "Worksheet/Table/Row"; $SheetRows_atxt)
		
	End if 
End for 


DOM CLOSE XML:C722($loadWorkbook_txt)


//End Test_ScanXMLWorkbook