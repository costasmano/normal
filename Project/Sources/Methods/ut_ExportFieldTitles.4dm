//%attributes = {"invisible":true}
//Method: ut_ExportFieldTitles
//Description
//  ` export the tables and field titles as defined by SET FIELD titles to xml excel spreadsheets.
//  ` one file per table
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 08/19/14, 12:11:11
	// ----------------------------------------------------
	//Created : 
	Mods_2014_08
	// Modified by: Costas Manousakis-(Designer)-(1/30/19 14:26:05)
	Mods_2019_01_bug
	//  `added alert at the end and show of the destination folder
	// Modified by: Costas Manousakis-(Designer)-(5/18/20 17:37:11)
	Mods_2020_05
	//  `set author / last author to current machine owner, created and last saved to current date time
End if 
//
C_LONGINT:C283($tbl_count; $tblLoop; $tbl)

$tbl_count:=Get last table number:C254
ARRAY TEXT:C222($tableNames_atxt; 0)
ARRAY LONGINT:C221($tableNums_aL; 0)
GET TABLE TITLES:C803($tableNames_atxt; $tableNums_aL)
C_TEXT:C284($destfloder_txt)
$destfloder_txt:=Select folder:C670("pick folder for text files")
C_TIME:C306($tbldoc_t)
C_TEXT:C284($Row_txt; $RowOut_txt; $Header_txt; $Footer_txt; $HeaderOut_txt)
$Row_txt:="<Row>"+Char:C90(13)
$Row_txt:=$Row_txt+"<Cell ss:StyleID="+<>sQu+"s62"+<>sQu+"><Data ss:Type="+<>sQu+"String"+<>sQu+"><!--#4DVAR XXX_FieldName--></Data></Cell>"
$Row_txt:=$Row_txt+"<Cell><Data ss:Type="+<>sQu+"String"+<>sQu+"><!--#4DVAR XXX_FieldType--></Data></Cell>"
$Row_txt:=$Row_txt+"</Row>"+Char:C90(13)

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


$Header_txt:=$Header_txt+Char:C90(13)+"<Worksheet ss:Name="+<>sQu+"<!--#4DVAR XXX_TableName-->"+<>sQu+">"
$Header_txt:=$Header_txt+Char:C90(13)+"<Table ss:ExpandedColumnCount="+<>sQu+"3"+<>sQu+" ss:ExpandedRowCount="+<>sQu+"<!--#4DVAR XXX_NumRows-->"+<>sQu+" x:FullColumns="+<>sQu+"1"+<>sQu
$Header_txt:=$Header_txt+Char:C90(13)+"x:FullRows="+<>sQu+"1"+<>sQu+" ss:DefaultColumnWidth="+<>sQu+"65"+<>sQu+" ss:DefaultRowHeight="+<>sQu+"15"+<>sQu+">"
$Header_txt:=$Header_txt+Char:C90(13)+"<Column ss:Width="+<>sQu+"135"+<>sQu+"/>"
$Header_txt:=$Header_txt+Char:C90(13)+"<Column ss:Width="+<>sQu+"81"+<>sQu+"/>"
$Header_txt:=$Header_txt+Char:C90(13)+"<Column ss:Width="+<>sQu+"63"+<>sQu+"/>"

$Header_txt:=$Header_txt+Char:C90(13)+"<Row>"
$Header_txt:=$Header_txt+Char:C90(13)+"<Cell ss:StyleID="+<>sQu+"s62"+<>sQu+"><Data ss:Type="+<>sQu+"String"+<>sQu+">Table : [<!--#4DVAR XXX_TableName-->]</Data></Cell>"
$Header_txt:=$Header_txt+Char:C90(13)+"</Row>"

$Header_txt:=$Header_txt+Char:C90(13)+"<Row>"
$Header_txt:=$Header_txt+Char:C90(13)+"<Cell ss:StyleID="+<>sQu+"s62"+<>sQu+"><Data ss:Type="+<>sQu+"String"+<>sQu+">Field name</Data></Cell>"
$Header_txt:=$Header_txt+Char:C90(13)+"<Cell><Data ss:Type="+<>sQu+"String"+<>sQu+">Field Type</Data></Cell>"
$Header_txt:=$Header_txt+Char:C90(13)+"<Cell><Data ss:Type="+<>sQu+"String"+<>sQu+">Description</Data></Cell>"
$Header_txt:=$Header_txt+Char:C90(13)+"</Row>"+Char:C90(13)


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
For ($tblLoop; 1; Size of array:C274($tableNums_aL))
	$tbl:=$tableNums_aL{$tblLoop}
	If (Is table number valid:C999($tbl))
		ARRAY TEXT:C222($Fieldnames_atxt; 0)
		ARRAY TEXT:C222($Fieltypes_atxt; 0)
		ARRAY LONGINT:C221($fieldnum_aL; 0)
		GET FIELD TITLES:C804(Table:C252($tbl)->; $Fieldnames_atxt; $fieldnum_aL)
		ARRAY TEXT:C222($Fieltypes_atxt; Size of array:C274($Fieldnames_atxt))
		C_LONGINT:C283($loop_L; $fldType_L; $fldLen)
		For ($loop_L; 1; Size of array:C274($fieldnum_aL))
			GET FIELD PROPERTIES:C258($tbl; $fieldnum_aL{$loop_L}; $fldType_L; $fldLen)
			$Fieltypes_atxt{$loop_L}:=fGetDataType($fldType_L)
			
			If (Not:C34($ShowTitles_b))
				$Fieldnames_atxt{$loop_L}:=Field name:C257($tbl; $fieldnum_aL{$loop_L})
			End if 
			
			If ($fldLen>0)
				$Fieltypes_atxt{$loop_L}:=$Fieltypes_atxt{$loop_L}+"("+String:C10($fldLen)+")"
			End if 
			
		End for 
		$tbldoc_t:=Create document:C266($destfloder_txt+$tableNames_atxt{$tblLoop}+".xls")
		C_LONGINT:C283($loop_L)
		$HeaderOut_txt:=Replace string:C233($Header_txt; "<!--#4DVAR XXX_TableName-->"; $tableNames_atxt{$tblLoop})
		$HeaderOut_txt:=Replace string:C233($HeaderOut_txt; "<!--#4DVAR XXX_NumRows-->"; String:C10(Size of array:C274($fieldnum_aL)+2))
		SEND PACKET:C103($tbldoc_t; $HeaderOut_txt)
		For ($loop_L; 1; Size of array:C274($fieldnum_aL))
			$RowOut_txt:=Replace string:C233($Row_txt; "<!--#4DVAR XXX_FieldName-->"; $Fieldnames_atxt{$loop_L})
			$RowOut_txt:=Replace string:C233($RowOut_txt; "<!--#4DVAR XXX_FieldType-->"; $Fieltypes_atxt{$loop_L})
			SEND PACKET:C103($tbldoc_t; $RowOut_txt)
		End for 
		SEND PACKET:C103($tbldoc_t; $Footer_txt)
		CLOSE DOCUMENT:C267($tbldoc_t)
	End if 
	
End for 

ALERT:C41("Finished exportting")
SHOW ON DISK:C922($destfloder_txt)
//End ut_ExportFieldTitles