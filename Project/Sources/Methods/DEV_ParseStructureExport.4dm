//%attributes = {"invisible":true}
//Method: DEV_ParseStructureExport
//Description
// parse the XML export of a structure to create export .xls files
// same as ut_exportfieldtitles but include the comments found in the XML export
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/18/20, 18:03:21
	// ----------------------------------------------------
	//Created : 
	Mods_2020_05
End if 
//
C_TEXT:C284($Struct_ref)
C_BOOLEAN:C305($ShowTitles_b)
C_TEXT:C284($structXMLexport)
ARRAY TEXT:C222($structXMLexport_atxt; 0)

EXPORT STRUCTURE:C1311($structXMLexport)

$Struct_ref:=DOM Parse XML variable:C720($structXMLexport)

C_TEXT:C284($destfloder_txt)
$destfloder_txt:=Select folder:C670("pick folder for text files")
C_TIME:C306($tbldoc_t)
C_TEXT:C284($Row_txt; $RowOut_txt; $Header_txt; $Footer_txt; $HeaderOut_txt; $TBLHeader_txt; \
$TBLRow_txt; $docAndStyles_txt; $TBLRow2_txt; \
$WorksheetHdr_txt; $WorkSheetFtr_txt; $masterHdr_txt; $masterFooter_txt)

$docandStyles_txt:="<?xml version="+<>sQu+"1.0"+<>sQu+"?>"
$docandStyles_txt:=$docandStyles_txt+Char:C90(13)+"<Workbook xmlns="+<>sQu+"urn:schemas-microsoft-com:office:spreadsheet"+<>sQu
$docandStyles_txt:=$docandStyles_txt+Char:C90(13)+"xmlns:o="+<>sQu+"urn:schemas-microsoft-com:office:office"+<>sQu
$docandStyles_txt:=$docandStyles_txt+Char:C90(13)+"xmlns:x="+<>sQu+"urn:schemas-microsoft-com:office:excel"+<>sQu
$docandStyles_txt:=$docandStyles_txt+Char:C90(13)+"xmlns:ss="+<>sQu+"urn:schemas-microsoft-com:office:spreadsheet"+<>sQu
$docandStyles_txt:=$docandStyles_txt+Char:C90(13)+"xmlns:html="+<>sQu+"http://www.w3.org/TR/REC-html40"+<>sQu+">"
$docandStyles_txt:=$docandStyles_txt+Char:C90(13)+"<DocumentProperties xmlns="+<>sQu+"urn:schemas-microsoft-com:office:office"+<>sQu+">"
$docandStyles_txt:=$docandStyles_txt+Char:C90(13)+"<Author>"+Current system user:C484+"</Author>"
$docandStyles_txt:=$docandStyles_txt+Char:C90(13)+"<LastAuthor>"+Current system user:C484+"</LastAuthor>"
$docandStyles_txt:=$docandStyles_txt+Char:C90(13)+"<Created>"+String:C10(Current date:C33; ISO date GMT:K1:10; Current time:C178)+"</Created>"
$docandStyles_txt:=$docandStyles_txt+Char:C90(13)+"<LastSaved>"+String:C10(Current date:C33; ISO date GMT:K1:10; Current time:C178)+"</LastSaved>"
$docandStyles_txt:=$docandStyles_txt+Char:C90(13)+"<Company>MassDOT</Company>"
$docandStyles_txt:=$docandStyles_txt+Char:C90(13)+"<Version>14</Version>"
$docandStyles_txt:=$docandStyles_txt+Char:C90(13)+"</DocumentProperties>"
$docandStyles_txt:=$docandStyles_txt+Char:C90(13)+"<OfficeDocumentSettings xmlns="+<>sQu+"urn:schemas-microsoft-com:office:office"+<>sQu+">"
$docandStyles_txt:=$docandStyles_txt+Char:C90(13)+"<AllowPNG/>"
$docandStyles_txt:=$docandStyles_txt+Char:C90(13)+"</OfficeDocumentSettings>"
$docandStyles_txt:=$docandStyles_txt+Char:C90(13)+"<ExcelWorkbook xmlns="+<>sQu+"urn:schemas-microsoft-com:office:excel"+<>sQu+">"
$docandStyles_txt:=$docandStyles_txt+Char:C90(13)+"<WindowHeight>13980</WindowHeight>"
$docandStyles_txt:=$docandStyles_txt+Char:C90(13)+"<WindowWidth>25600</WindowWidth>"
$docandStyles_txt:=$docandStyles_txt+Char:C90(13)+"<WindowTopX>0</WindowTopX>"
$docandStyles_txt:=$docandStyles_txt+Char:C90(13)+"<WindowTopY>0</WindowTopY>"
$docandStyles_txt:=$docandStyles_txt+Char:C90(13)+"<ProtectStructure>False</ProtectStructure>"
$docandStyles_txt:=$docandStyles_txt+Char:C90(13)+"<ProtectWindows>False</ProtectWindows>"
$docandStyles_txt:=$docandStyles_txt+Char:C90(13)+"</ExcelWorkbook>"

$docandStyles_txt:=$docandStyles_txt+Char:C90(13)+" <Styles>"
$docandStyles_txt:=$docandStyles_txt+Char:C90(13)+"  <Style ss:ID="+<>sQU+"Default"+<>sQU+" ss:Name="+<>sQU+"Normal"+<>sQU+">"
$docandStyles_txt:=$docandStyles_txt+Char:C90(13)+"   <Alignment ss:Vertical="+<>sQU+"Bottom"+<>sQU+"/>"
$docandStyles_txt:=$docandStyles_txt+Char:C90(13)+"   <Borders/>"
$docandStyles_txt:=$docandStyles_txt+Char:C90(13)+"   <Font ss:FontName="+<>sQU+"Calibri"+<>sQU+" x:Family="+<>sQU+"Swiss"+<>sQU+" ss:Size="+<>sQU+"12"+<>sQU+" ss:Color="+<>sQU+"#000000"+<>sQU+"/>"
$docandStyles_txt:=$docandStyles_txt+Char:C90(13)+"   <Interior/>"
$docandStyles_txt:=$docandStyles_txt+Char:C90(13)+"   <NumberFormat/>"
$docandStyles_txt:=$docandStyles_txt+Char:C90(13)+"   <Protection/>"
$docandStyles_txt:=$docandStyles_txt+Char:C90(13)+"  </Style>"
$docandStyles_txt:=$docandStyles_txt+Char:C90(13)+"  <Style ss:ID="+<>sQU+"s62"+<>sQU+">"
$docandStyles_txt:=$docandStyles_txt+Char:C90(13)+"   <NumberFormat ss:Format="+<>sQU+"@"+<>sQU+"/>"
$docandStyles_txt:=$docandStyles_txt+Char:C90(13)+"   <Alignment ss:Vertical="+<>sQU+"Top"+<>sQU+" ss:WrapText="+<>sQU+"1"+<>sQU+"/>"
$docandStyles_txt:=$docandStyles_txt+Char:C90(13)+"  </Style>"
$docandStyles_txt:=$docandStyles_txt+Char:C90(13)+"  <Style ss:ID="+<>sQU+"s65"+<>sQU+">"
$docandStyles_txt:=$docandStyles_txt+Char:C90(13)+"   <Alignment ss:Vertical="+<>sQU+"Top"+<>sQU+" ss:WrapText="+<>sQU+"1"+<>sQU+"/>"
$docandStyles_txt:=$docandStyles_txt+Char:C90(13)+"  </Style>"
$docandStyles_txt:=$docandStyles_txt+Char:C90(13)+" </Styles>"

$Row_txt:="<Row>"+Char:C90(13)
$Row_txt:=$Row_txt+"<Cell ss:StyleID="+<>sQu+"s62"+<>sQu+"><Data ss:Type="+<>sQu+"String"+<>sQu+"><!--#4DVAR XXX_FieldName--></Data></Cell>"
$Row_txt:=$Row_txt+"<Cell><Data ss:Type="+<>sQu+"String"+<>sQu+"><!--#4DVAR XXX_FieldType--></Data></Cell>"
$Row_txt:=$Row_txt+"<Cell><Data ss:Type="+<>sQu+"String"+<>sQu+"><!--#4DVAR XXX_FieldDesc--></Data></Cell>"
$Row_txt:=$Row_txt+"</Row>"+Char:C90(13)

$TBLRow_txt:="<Row>"+Char:C90(13)
$TBLRow_txt:=$TBLRow_txt+"<Cell ss:StyleID="+<>sQu+"s62"+<>sQu+"><Data ss:Type="+<>sQu+"String"+<>sQu+"><!--#4DVAR XXX_TableName--></Data></Cell>"
$TBLRow_txt:=$TBLRow_txt+"<Cell ss:StyleID="+<>sQu+"s65"+<>sQu+"><Data ss:Type="+<>sQu+"String"+<>sQu+"><!--#4DVAR XXX_TableComments--></Data></Cell>"
$TBLRow_txt:=$TBLRow_txt+"</Row>"+Char:C90(13)

$TBLRow2_txt:="<Row ss:Height="+<>sQu+"<!--#4DVAR XXX_RowHeight-->"+<>sQu+">"+Char:C90(13)
$TBLRow2_txt:=$TBLRow2_txt+"<Cell ss:StyleID="+<>sQu+"s62"+<>sQu+"><Data ss:Type="+<>sQu+"String"+<>sQu+"><!--#4DVAR XXX_TableName--></Data></Cell>"
$TBLRow2_txt:=$TBLRow2_txt+"<Cell ss:StyleID="+<>sQu+"s65"+<>sQu+"><Data ss:Type="+<>sQu+"String"+<>sQu+"><!--#4DVAR XXX_TableComments--></Data></Cell>"
$TBLRow2_txt:=$TBLRow2_txt+"</Row>"+Char:C90(13)

If (False:C215)
	$Header_txt:="<?xml version="+<>sQu+"1.0"+<>sQu+"?>"
	$Header_txt:=$Header_txt+Char:C90(13)+"<Workbook xmlns="+<>sQu+"urn:schemas-microsoft-com:office:spreadsheet"+<>sQu
	$Header_txt:=$Header_txt+Char:C90(13)+"xmlns:o="+<>sQu+"urn:schemas-microsoft-com:office:office"+<>sQu
	$Header_txt:=$Header_txt+Char:C90(13)+"xmlns:x="+<>sQu+"urn:schemas-microsoft-com:office:excel"+<>sQu
	$Header_txt:=$Header_txt+Char:C90(13)+"xmlns:ss="+<>sQu+"urn:schemas-microsoft-com:office:spreadsheet"+<>sQu
	$Header_txt:=$Header_txt+Char:C90(13)+"xmlns:html="+<>sQu+"http://www.w3.org/TR/REC-html40"+<>sQu+">"
	$Header_txt:=$Header_txt+Char:C90(13)+"<DocumentProperties xmlns="+<>sQu+"urn:schemas-microsoft-com:office:office"+<>sQu+">"
	$Header_txt:=$Header_txt+Char:C90(13)+"<Author>"+Current system user:C484+"</Author>"
	$Header_txt:=$Header_txt+Char:C90(13)+"<LastAuthor>"+Current system user:C484+"</LastAuthor>"
	$Header_txt:=$Header_txt+Char:C90(13)+"<Created>"+String:C10(Current date:C33; ISO date GMT:K1:10; Current time:C178)+"</Created>"
	$Header_txt:=$Header_txt+Char:C90(13)+"<LastSaved>"+String:C10(Current date:C33; ISO date GMT:K1:10; Current time:C178)+"</LastSaved>"
	$Header_txt:=$Header_txt+Char:C90(13)+"<Company>MassDOT</Company>"
	$Header_txt:=$Header_txt+Char:C90(13)+"<Version>14</Version>"
	$Header_txt:=$Header_txt+Char:C90(13)+"</DocumentProperties>"
	$Header_txt:=$Header_txt+Char:C90(13)+"<OfficeDocumentSettings xmlns="+<>sQu+"urn:schemas-microsoft-com:office:office"+<>sQu+">"
	$Header_txt:=$Header_txt+Char:C90(13)+"<AllowPNG/>"
	$Header_txt:=$Header_txt+Char:C90(13)+"</OfficeDocumentSettings>"
	$Header_txt:=$Header_txt+Char:C90(13)+"<ExcelWorkbook xmlns="+<>sQu+"urn:schemas-microsoft-com:office:excel"+<>sQu+">"
	$Header_txt:=$Header_txt+Char:C90(13)+"<WindowHeight>13980</WindowHeight>"
	$Header_txt:=$Header_txt+Char:C90(13)+"<WindowWidth>25600</WindowWidth>"
	$Header_txt:=$Header_txt+Char:C90(13)+"<WindowTopX>0</WindowTopX>"
	$Header_txt:=$Header_txt+Char:C90(13)+"<WindowTopY>0</WindowTopY>"
	$Header_txt:=$Header_txt+Char:C90(13)+"<ProtectStructure>False</ProtectStructure>"
	$Header_txt:=$Header_txt+Char:C90(13)+"<ProtectWindows>False</ProtectWindows>"
	$Header_txt:=$Header_txt+Char:C90(13)+"</ExcelWorkbook>"
	
	$Header_txt:=$Header_txt+Char:C90(13)+" <Styles>"
	$Header_txt:=$Header_txt+Char:C90(13)+"  <Style ss:ID="+<>sQU+"Default"+<>sQU+" ss:Name="+<>sQU+"Normal"+<>sQU+">"
	$Header_txt:=$Header_txt+Char:C90(13)+"   <Alignment ss:Vertical="+<>sQU+"Bottom"+<>sQU+"/>"
	$Header_txt:=$Header_txt+Char:C90(13)+"   <Borders/>"
	$Header_txt:=$Header_txt+Char:C90(13)+"   <Font ss:FontName="+<>sQU+"Calibri"+<>sQU+" x:Family="+<>sQU+"Swiss"+<>sQU+" ss:Size="+<>sQU+"12"+<>sQU+" ss:Color="+<>sQU+"#000000"+<>sQU+"/>"
	$Header_txt:=$Header_txt+Char:C90(13)+"   <Interior/>"
	$Header_txt:=$Header_txt+Char:C90(13)+"   <NumberFormat/>"
	$Header_txt:=$Header_txt+Char:C90(13)+"   <Protection/>"
	$Header_txt:=$Header_txt+Char:C90(13)+"  </Style>"
	$Header_txt:=$Header_txt+Char:C90(13)+"  <Style ss:ID="+<>sQU+"s62"+<>sQU+">"
	$Header_txt:=$Header_txt+Char:C90(13)+"   <NumberFormat ss:Format="+<>sQU+"@"+<>sQU+"/>"
	$Header_txt:=$Header_txt+Char:C90(13)+"  </Style>"
	$Header_txt:=$Header_txt+Char:C90(13)+" </Styles>"
	
End if 

$masterHdr_txt:=$docAndStyles_txt

$WorksheetHdr_txt:=""
$WorksheetHdr_txt:=$WorksheetHdr_txt+Char:C90(13)+"<Worksheet ss:Name="+<>sQu+"<!--#4DVAR XXX_TableName-->"+<>sQu+">"
$WorksheetHdr_txt:=$WorksheetHdr_txt+Char:C90(13)+"<Table ss:ExpandedColumnCount="+<>sQu+"3"+<>sQu+" ss:ExpandedRowCount="+<>sQu+"<!--#4DVAR XXX_NumRows-->"+<>sQu+" x:FullColumns="+<>sQu+"1"+<>sQu
$WorksheetHdr_txt:=$WorksheetHdr_txt+Char:C90(13)+"x:FullRows="+<>sQu+"1"+<>sQu+" ss:DefaultColumnWidth="+<>sQu+"65"+<>sQu+" ss:DefaultRowHeight="+<>sQu+"15"+<>sQu+">"
$WorksheetHdr_txt:=$WorksheetHdr_txt+Char:C90(13)+"<Column ss:Width="+<>sQu+"135"+<>sQu+"/>"
$WorksheetHdr_txt:=$WorksheetHdr_txt+Char:C90(13)+"<Column ss:Width="+<>sQu+"100"+<>sQu+"/>"
$WorksheetHdr_txt:=$WorksheetHdr_txt+Char:C90(13)+"<Column ss:Width="+<>sQu+"200"+<>sQu+"/>"

$WorksheetHdr_txt:=$WorksheetHdr_txt+Char:C90(13)+"<Row>"
$WorksheetHdr_txt:=$WorksheetHdr_txt+Char:C90(13)+"<Cell ss:StyleID="+<>sQu+"s62"+<>sQu+"><Data ss:Type="+<>sQu+"String"+<>sQu+">Table : [<!--#4DVAR XXX_TableName-->]</Data></Cell>"
$WorksheetHdr_txt:=$WorksheetHdr_txt+Char:C90(13)+"</Row>"

$WorksheetHdr_txt:=$WorksheetHdr_txt+Char:C90(13)+"<Row>"
$WorksheetHdr_txt:=$WorksheetHdr_txt+Char:C90(13)+"<Cell ss:StyleID="+<>sQu+"s62"+<>sQu+"><Data ss:Type="+<>sQu+"String"+<>sQu+">Comments : <!--#4DVAR XXX_TableComments--></Data></Cell>"
$WorksheetHdr_txt:=$WorksheetHdr_txt+Char:C90(13)+"</Row>"

$WorksheetHdr_txt:=$WorksheetHdr_txt+Char:C90(13)+"<Row>"
$WorksheetHdr_txt:=$WorksheetHdr_txt+Char:C90(13)+"<Cell ss:StyleID="+<>sQu+"s62"+<>sQu+"><Data ss:Type="+<>sQu+"String"+<>sQu+">Field name</Data></Cell>"
$WorksheetHdr_txt:=$WorksheetHdr_txt+Char:C90(13)+"<Cell><Data ss:Type="+<>sQu+"String"+<>sQu+">Field Type</Data></Cell>"
$WorksheetHdr_txt:=$WorksheetHdr_txt+Char:C90(13)+"<Cell><Data ss:Type="+<>sQu+"String"+<>sQu+">Description</Data></Cell>"
$WorksheetHdr_txt:=$WorksheetHdr_txt+Char:C90(13)+"</Row>"+Char:C90(13)

$WorkSheetFtr_txt:="</Table>"
$WorkSheetFtr_txt:=$WorkSheetFtr_txt+Char:C90(13)+"<WorksheetOptions xmlns="+<>sQu+"urn:schemas-microsoft-com:office:excel"+<>sQu+">"
$WorkSheetFtr_txt:=$WorkSheetFtr_txt+Char:C90(13)+"<PageLayoutZoom>0</PageLayoutZoom>"
$WorkSheetFtr_txt:=$WorkSheetFtr_txt+Char:C90(13)+"<Selected/>"
$WorkSheetFtr_txt:=$WorkSheetFtr_txt+Char:C90(13)+"<ProtectObjects>False</ProtectObjects>"
$WorkSheetFtr_txt:=$WorkSheetFtr_txt+Char:C90(13)+"<ProtectScenarios>False</ProtectScenarios>"
$WorkSheetFtr_txt:=$WorkSheetFtr_txt+Char:C90(13)+"</WorksheetOptions>"
$WorkSheetFtr_txt:=$WorkSheetFtr_txt+Char:C90(13)+"</Worksheet>"

$masterFooter_txt:=Char:C90(13)+"</Workbook>"

$Header_txt:=$docAndStyles_txt
$Header_txt:=$Header_txt+Char:C90(13)+"<Worksheet ss:Name="+<>sQu+"<!--#4DVAR XXX_TableName-->"+<>sQu+">"
$Header_txt:=$Header_txt+Char:C90(13)+"<Table ss:ExpandedColumnCount="+<>sQu+"3"+<>sQu+" ss:ExpandedRowCount="+<>sQu+"<!--#4DVAR XXX_NumRows-->"+<>sQu+" x:FullColumns="+<>sQu+"1"+<>sQu
$Header_txt:=$Header_txt+Char:C90(13)+"x:FullRows="+<>sQu+"1"+<>sQu+" ss:DefaultColumnWidth="+<>sQu+"65"+<>sQu+" ss:DefaultRowHeight="+<>sQu+"15"+<>sQu+">"
$Header_txt:=$Header_txt+Char:C90(13)+"<Column ss:Width="+<>sQu+"135"+<>sQu+"/>"
$Header_txt:=$Header_txt+Char:C90(13)+"<Column ss:Width="+<>sQu+"100"+<>sQu+"/>"
$Header_txt:=$Header_txt+Char:C90(13)+"<Column ss:Width="+<>sQu+"200"+<>sQu+"/>"

$Header_txt:=$Header_txt+Char:C90(13)+"<Row>"
$Header_txt:=$Header_txt+Char:C90(13)+"<Cell ss:StyleID="+<>sQu+"s62"+<>sQu+"><Data ss:Type="+<>sQu+"String"+<>sQu+">Table : [<!--#4DVAR XXX_TableName-->]</Data></Cell>"
$Header_txt:=$Header_txt+Char:C90(13)+"</Row>"

$Header_txt:=$Header_txt+Char:C90(13)+"<Row>"
$Header_txt:=$Header_txt+Char:C90(13)+"<Cell ss:StyleID="+<>sQu+"s62"+<>sQu+"><Data ss:Type="+<>sQu+"String"+<>sQu+">Comments : <!--#4DVAR XXX_TableComments--></Data></Cell>"
$Header_txt:=$Header_txt+Char:C90(13)+"</Row>"

$Header_txt:=$Header_txt+Char:C90(13)+"<Row>"
$Header_txt:=$Header_txt+Char:C90(13)+"<Cell ss:StyleID="+<>sQu+"s62"+<>sQu+"><Data ss:Type="+<>sQu+"String"+<>sQu+">Field name</Data></Cell>"
$Header_txt:=$Header_txt+Char:C90(13)+"<Cell><Data ss:Type="+<>sQu+"String"+<>sQu+">Field Type</Data></Cell>"
$Header_txt:=$Header_txt+Char:C90(13)+"<Cell><Data ss:Type="+<>sQu+"String"+<>sQu+">Description</Data></Cell>"
$Header_txt:=$Header_txt+Char:C90(13)+"</Row>"+Char:C90(13)

$TBLHeader_txt:=$docAndStyles_txt
$TBLHeader_txt:=$TBLHeader_txt+Char:C90(13)+"<Worksheet ss:Name="+<>sQu+"ListOfTables"+<>sQu+">"
$TBLHeader_txt:=$TBLHeader_txt+Char:C90(13)+"<Table ss:ExpandedColumnCount="+<>sQu+"3"+<>sQu+" ss:ExpandedRowCount="+<>sQu+"<!--#4DVAR XXX_NumRows-->"+<>sQu+" x:FullColumns="+<>sQu+"1"+<>sQu
$TBLHeader_txt:=$TBLHeader_txt+Char:C90(13)+"x:FullRows="+<>sQu+"1"+<>sQu+" ss:DefaultColumnWidth="+<>sQu+"65"+<>sQu+" ss:DefaultRowHeight="+<>sQu+"15"+<>sQu+">"
$TBLHeader_txt:=$TBLHeader_txt+Char:C90(13)+"<Column ss:Width="+<>sQu+"200"+<>sQu+"/>"
$TBLHeader_txt:=$TBLHeader_txt+Char:C90(13)+"<Column ss:Width="+<>sQu+"500"+<>sQu+"/>"

$TBLHeader_txt:=$TBLHeader_txt+Char:C90(13)+"<Row>"
$TBLHeader_txt:=$TBLHeader_txt+Char:C90(13)+"<Cell ss:StyleID="+<>sQu+"s62"+<>sQu+"><Data ss:Type="+<>sQu+"String"+<>sQu+">Table name</Data></Cell>"
$TBLHeader_txt:=$TBLHeader_txt+Char:C90(13)+"<Cell><Data ss:Type="+<>sQu+"String"+<>sQu+">Comments</Data></Cell>"
$TBLHeader_txt:=$TBLHeader_txt+Char:C90(13)+"</Row>"+Char:C90(13)

$Footer_txt:="</Table>"
$Footer_txt:=$Footer_txt+Char:C90(13)+"<WorksheetOptions xmlns="+<>sQu+"urn:schemas-microsoft-com:office:excel"+<>sQu+">"
$Footer_txt:=$Footer_txt+Char:C90(13)+"<PageLayoutZoom>0</PageLayoutZoom>"
$Footer_txt:=$Footer_txt+Char:C90(13)+"<Selected/>"
$Footer_txt:=$Footer_txt+Char:C90(13)+"<ProtectObjects>False</ProtectObjects>"
$Footer_txt:=$Footer_txt+Char:C90(13)+"<ProtectScenarios>False</ProtectScenarios>"
$Footer_txt:=$Footer_txt+Char:C90(13)+"</WorksheetOptions>"
$Footer_txt:=$Footer_txt+Char:C90(13)+"</Worksheet>"
$Footer_txt:=$Footer_txt+Char:C90(13)+"</Workbook>"


C_BOOLEAN:C305($ShowTitles_b)
CONFIRM:C162("Show field Titles or Field Names?"; "Titles"; "ActualName")
$ShowTitles_b:=(OK=1)

C_LONGINT:C283($count_L; $tableIndx; $fieldIndx; $fieldCount_L; $fldextra; $commentElem)
$count_L:=DOM Count XML elements:C726($Struct_ref; "table")
C_TEXT:C284($table_ref; $elemvalue; $tablename_txt; $elem_ref; $fieldName; \
$fldindx; $fldExtraRef; $CommentRef; $fldComment; $extraRef; $tblComment; $Fieldtype_txt; \
$attrname; $attrvalue; $elemCdata)
C_LONGINT:C283($fldType; $fldLen; $fldNum; $tblNum)
//start the bar
C_OBJECT:C1216($progress_o)
$progress_o:=ProgressNew("Exporting table info to .xls files"; $count_L; True:C214; " table"; 3)

C_TIME:C306($tableList_t; $allTablesList_t)
$tableList_t:=Create document:C266($destfloder_txt+"ListofTables.xls")
$HeaderOut_txt:=Replace string:C233($TBLHeader_txt; "<!--#4DVAR XXX_NumRows-->"; String:C10($count_L+4))
SEND PACKET:C103($tableList_t; $HeaderOut_txt)

$allTablesList_t:=Create document:C266($destfloder_txt+"AllTablesCombined.xls")
SEND PACKET:C103($allTablesList_t; $masterHdr_txt)

For ($tableIndx; 1; $count_L)
	
	//update progress
	UpdateProgressNew($progress_o; $tableIndx)
	
	ARRAY TEXT:C222($Fieldnames_atxt; 0)
	ARRAY TEXT:C222($Fieldtypes_atxt; 0)
	ARRAY LONGINT:C221($fieldnum_aL; 0)
	ARRAY TEXT:C222($FieldCommnent_atxt; 0)
	
	$table_ref:=DOM Get XML element:C725($Struct_ref; "table"; $tableIndx; $elemvalue)
	DOM GET XML ATTRIBUTE BY NAME:C728($table_ref; "name"; $tablename_txt)
	
	DOM GET XML ATTRIBUTE BY NAME:C728($table_ref; "id"; $tblNum)
	GET FIELD TITLES:C804(Table:C252($tblNum)->; $fieldNames_atxt; $fieldNum_aL)
	ARRAY TEXT:C222($Fieldtypes_atxt; Size of array:C274($fieldNames_atxt))
	ARRAY TEXT:C222($FieldCommnent_atxt; Size of array:C274($fieldNames_atxt))
	$tblComment:=""
	If (DOM Count XML elements:C726($table_ref; "table_extra")>0)
		$extraRef:=DOM Get XML element:C725($table_ref; "table_extra"; 1; $elemvalue)
		If (DOM Count XML elements:C726($extraRef; "comment")>0)
			$CommentRef:=DOM Get XML element:C725($extraRef; "comment"; DOM Count XML elements:C726($extraRef; "comment"); $elemvalue)
			DOM GET XML ELEMENT VALUE:C731($CommentRef; $elemvalue; $elemCdata)
			
			If ($elemCdata#"")
				$tblComment:=ST Get plain text:C1092($elemCdata)
			Else 
				$tblComment:=ST Get plain text:C1092($elemvalue)
			End if 
			//start of new lines are marked by ++ sometimes the ST Get plain text strips one of them
			$tblComment:=Replace string:C233($tblComment; "++"; "&#10;")
			$tblComment:=Replace string:C233($tblComment; "+"; "&#10;")
			
		End if 
	End if 
	
	If (Position:C15("&#10;"; $tblComment)>0)
		C_LONGINT:C283($startLen; $endLen; $numRows)
		$startLen:=Length:C16($tblComment)
		$endLen:=Length:C16(Replace string:C233($tblComment; "&#10;"; ""))
		$numRows:=($startLen-$endLen)/Length:C16("&#10;")
		
		$RowOut_txt:=Replace string:C233($TBLRow2_txt; "<!--#4DVAR XXX_TableName-->"; $tablename_txt)
		$RowOut_txt:=Replace string:C233($RowOut_txt; "<!--#4DVAR XXX_RowHeight-->"; String:C10(($numRows+1)*16))
	Else 
		$RowOut_txt:=Replace string:C233($TBLRow_txt; "<!--#4DVAR XXX_TableName-->"; $tablename_txt)
	End if 
	
	$RowOut_txt:=Replace string:C233($RowOut_txt; "<!--#4DVAR XXX_TableComments-->"; $tblComment)
	SEND PACKET:C103($tableList_t; $RowOut_txt)
	
	$fieldCount_L:=DOM Count XML elements:C726($table_ref; "field")
	C_LONGINT:C283($numAttrs; $attrLoop)
	For ($fieldIndx; 1; $fieldCount_L)
		$elem_ref:=DOM Get XML element:C725($table_ref; "field"; $fieldIndx; $elemvalue)
		$numAttrs:=DOM Count XML attributes:C727($elem_ref)
		$fldComment:=""
		DOM GET XML ATTRIBUTE BY NAME:C728($elem_ref; "name"; $fieldName)
		DOM GET XML ATTRIBUTE BY NAME:C728($elem_ref; "id"; $fldNum)
		If (DOM Count XML elements:C726($elem_ref; "field_extra")>0)
			$fldExtraRef:=DOM Get XML element:C725($elem_ref; "field_extra"; 1; $elemvalue)
			If (DOM Count XML elements:C726($fldExtraRef; "comment")>0)
				$CommentRef:=DOM Get XML element:C725($fldExtraRef; "comment"; 1; $elemvalue)
				DOM GET XML ELEMENT VALUE:C731($CommentRef; $elemvalue; $elemCdata)
				If ($elemCdata#"")
					$fldComment:=ST Get plain text:C1092($elemCdata)
				Else 
					$fldComment:=ST Get plain text:C1092($elemvalue)
				End if 
				
			End if 
		End if 
		
		GET FIELD PROPERTIES:C258($tblNum; $fldNum; $fldType; $fldLen)
		$Fieldtype_txt:=fGetDataType($fldType)
		If ($fldLen>0)
			$Fieldtype_txt:=$Fieldtype_txt+"("+String:C10($fldLen)+")"
		End if 
		
		C_LONGINT:C283($fldindx_L)
		$fldindx_L:=Find in array:C230($fieldNum_aL; $fldNum)
		
		If ($fldindx_L>0)
			If (Not:C34($ShowTitles_b))
				$Fieldnames_atxt{$fldindx_L}:=$fieldName
			End if 
			$FieldCommnent_atxt{$fldindx_L}:=$fldComment
			$Fieldtypes_atxt{$fldindx_L}:=$Fieldtype_txt
		Else 
			//field not in the field titles - append
			APPEND TO ARRAY:C911($Fieldnames_atxt; $fieldName)
			APPEND TO ARRAY:C911($fieldnum_aL; $fldNum)
			APPEND TO ARRAY:C911($FieldCommnent_atxt; $fldComment)
			APPEND TO ARRAY:C911($Fieldtypes_atxt; $Fieldtype_txt)
		End if 
		
	End for 
	
	$tbldoc_t:=Create document:C266($destfloder_txt+$tablename_txt+".xls")
	C_LONGINT:C283($loop_L)
	$HeaderOut_txt:=Replace string:C233($Header_txt; "<!--#4DVAR XXX_TableName-->"; $tablename_txt)
	$HeaderOut_txt:=Replace string:C233($HeaderOut_txt; "<!--#4DVAR XXX_NumRows-->"; String:C10(Size of array:C274($Fieldnames_atxt)+4))
	$HeaderOut_txt:=Replace string:C233($HeaderOut_txt; "<!--#4DVAR XXX_TableComments-->"; $tblComment)
	SEND PACKET:C103($tbldoc_t; $HeaderOut_txt)
	
	$RowOut_txt:=Replace string:C233($WorksheetHdr_txt; "<!--#4DVAR XXX_TableName-->"; $tablename_txt)
	$RowOut_txt:=Replace string:C233($RowOut_txt; "<!--#4DVAR XXX_NumRows-->"; String:C10(Size of array:C274($Fieldnames_atxt)+4))
	$RowOut_txt:=Replace string:C233($RowOut_txt; "<!--#4DVAR XXX_TableComments-->"; $tblComment)
	SEND PACKET:C103($allTablesList_t; $RowOut_txt)
	
	For ($loop_L; 1; Size of array:C274($fieldnum_aL))
		$RowOut_txt:=Replace string:C233($Row_txt; "<!--#4DVAR XXX_FieldName-->"; $Fieldnames_atxt{$loop_L})
		$RowOut_txt:=Replace string:C233($RowOut_txt; "<!--#4DVAR XXX_FieldType-->"; $Fieldtypes_atxt{$loop_L})
		$RowOut_txt:=Replace string:C233($RowOut_txt; "<!--#4DVAR XXX_FieldDesc-->"; $FieldCommnent_atxt{$loop_L})
		SEND PACKET:C103($tbldoc_t; $RowOut_txt)
		SEND PACKET:C103($allTablesList_t; $RowOut_txt)
	End for 
	
	SEND PACKET:C103($tbldoc_t; $Footer_txt)
	CLOSE DOCUMENT:C267($tbldoc_t)
	
	SEND PACKET:C103($allTablesList_t; $WorkSheetFtr_txt)
	
	//check if progress stopped
	If (Progress Stopped(OB Get:C1224($progress_o; "progress"; Is longint:K8:6)))
		//abort loop
		$tableIndx:=$count_L+1
	End if 
	
End for 

SEND PACKET:C103($tableList_t; $Footer_txt)
CLOSE DOCUMENT:C267($tableList_t)

SEND PACKET:C103($allTablesList_t; $masterFooter_txt)
CLOSE DOCUMENT:C267($allTablesList_t)

DOM CLOSE XML:C722($Struct_ref)
//quit progress
Progress QUIT(OB Get:C1224($progress_o; "progress"; Is longint:K8:6))

SHOW ON DISK:C922($destfloder_txt)

//End DEV_ParseStructureExport