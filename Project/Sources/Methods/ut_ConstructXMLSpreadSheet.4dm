//%attributes = {"invisible":true}
// Method: ut_ConstructXMLSpreadSheet
// Description
// This method creates a template that builds an XML Spreadsheet output  `. The template is returned as a text variable. 

// 
// Parameters
// $1 : $TempLate_Text
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/19/11, 08:28:23
	// ----------------------------------------------------
	
	Mods_2011_09
	// Modified by: costasmanousakis-(Designer)-(10/17/11 09:54:23)
	Mods_2011_10  //Copied to Server on : 10/17/11, 09:57:06
	//  `Started Work on adding Footers
End if 

C_TEXT:C284($0; $TempLate_Text)
C_LONGINT:C283($1; $QRarea; curPos; $numRecords; $vlField; $Case_L; $fieldType)
C_LONGINT:C283($numCols; $numRows; $tableNum; $i; $hide; $rep; $size; $numFields; $fieldNum; $HdrHt)
C_TEXT:C284($ColName; $obj; $format; $title; $newLine; $fieldobj; mytype; $metadataTemplate)
C_POINTER:C301($tablePtr; $StyleArray_ptr)
C_TEXT:C284($HeaderL_txt; $HeaderM_Txt; $HeaderR_txt)
$QRarea:=$1
$numCols:=QR Count columns:C764($QRarea)  // Count columns in QR
$tableNum:=QR Get report table:C758($QRarea)  //Get table number of current table in QR
$numFields:=Get last field number:C255($tableNum)  //Count number of fields in table
$tablePtr:=Table:C252($tableNum)
$numRecords:=Records in selection:C76($tablePtr->)  //Get number of records in selection
QR GET HEADER AND FOOTER:C775($QRarea; 1; $HeaderL_txt; $HeaderM_Txt; $HeaderR_txt; $HdrHt)
C_TEXT:C284($FooterL_txt; $FooterM_Txt; $FooterR_txt)
C_LONGINT:C283($FooterHt)
QR GET HEADER AND FOOTER:C775($QRarea; 2; $FooterL_txt; $FooterM_Txt; $FooterR_txt; $FooterHt)
ARRAY TEXT:C222(QR_Fields_atxt; Get last field number:C255($tableNum))
For ($vlField; 1; Size of array:C274(QR_Fields_atxt))  // get all fieldnames of the fields in the table and save in array
	QR_Fields_atxt{$vlField}:=Field name:C257($tableNum; $vlField)
End for 
C_LONGINT:C283($loop_L)
ARRAY TEXT:C222($HeadrStyles_atxt; $numCols)
ARRAY TEXT:C222($FooterStyles_atxt; $numCols)
ARRAY TEXT:C222($BodyStyles_atxt; $numCols)
$TempLate_Text:=""
C_LONGINT:C283($StyleCounter_L; $HdrFontS_L; $HdrBold_L; $Under_L; $ItaL_L; $CbkgCol_L; $CTCol_L; $HAlign_L; $Row_L)
C_LONGINT:C283($LBT_L; $LBC_L; $TBT_L; $TBC_L; $RBT_L; $RBC_L; $BBT_L; $BBC_L; $IVBT_L; $IVBC_L; $IHBT_L; $IHBC_L)  //Border values
C_TEXT:C284($CBold; $CUnder; $CItaL; $HdrFontS; $HdrStyleID; $Halign; $CbkgCol; $CTCol; $Border)
$StyleCounter_L:=60
$HdrStyleID:=String:C10($StyleCounter_L)
$Row_L:=-4  //Header
$HdrFontS:=String:C10(QR Get text property:C760($QRarea; 1; $Row_L; qr font size:K14904:2))
$CBold:=String:C10(QR Get text property:C760($QRarea; 1; $Row_L; qr bold:K14904:3))
$Under_L:=QR Get text property:C760($QRarea; 1; $Row_L; qr underline:K14904:5)
If ($Under_L=0)
	$CUnder:=""
Else 
	$CUnder:=" ss:Underline=\"Single\""
End if 
$CItaL:=String:C10(QR Get text property:C760($QRarea; 1; $Row_L; qr italic:K14904:4))
$CbkgCol_L:=QR Get text property:C760($QRarea; 1; $Row_L; qr background color:K14904:8)
$CTCol_L:=QR Get text property:C760($QRarea; 1; $Row_L; qr text color:K14904:6)
$CbkgCol:=String:C10($CbkgCol_L; "&x")
$CTCol:=String:C10($CTCol_L; "&x")
$HAlign_L:=QR Get text property:C760($QRarea; 1; $Row_L; qr justification:K14904:7)
$Halign:=""
Case of 
	: ($HAlign_L=1)
		$Halign:="ss:Horizontal=\"Left\" "
	: ($HAlign_L=2)
		$Halign:="ss:Horizontal=\"Center\" "
	: ($HAlign_L=3)
		$Halign:="ss:Horizontal=\"Right\" "
End case 
ARRAY TEXT:C222($Linethick_atxt; 4)
$Linethick_atxt{1}:="1"
$Linethick_atxt{2}:="2"
$Linethick_atxt{3}:="1"
$Linethick_atxt{4}:="2"

$TempLate_Text:=$TempLate_Text+"<Style ss:ID=\"s"+String:C10($StyleCounter_L)+"\"><Font ss:Size=\""+$HdrFontS+"\" ss:Bold=\""+$CBold+"\" ss:Italic=\""+$CItaL+"\""+$CUnder+"/>"
$TempLate_Text:=$TempLate_Text+"<Alignment "+$Halign+"ss:Vertical=\"Top\"/>"
$TempLate_Text:=$TempLate_Text+"</Style>"+Char:C90(13)
For ($Case_L; 1; 3)
	Case of 
		: ($Case_L=1)
			$Row_L:=qr title:K14906:1  //Column labels
			$StyleArray_ptr:=->$HeadrStyles_atxt
		: ($Case_L=2)
			$Row_L:=qr detail:K14906:2  //Detail data
			$StyleArray_ptr:=->$BodyStyles_atxt
		: ($Case_L=3)
			$Row_L:=qr grand total:K14906:3  //Footer data
			$StyleArray_ptr:=->$FooterStyles_atxt
			
	End case 
	For ($loop_L; 1; $numCols)
		$StyleCounter_L:=$StyleCounter_L+1
		$StyleArray_ptr->{$loop_L}:=String:C10($StyleCounter_L)
		$HdrFontS:=String:C10(QR Get text property:C760($QRarea; $loop_L; $Row_L; qr font size:K14904:2))
		$CBold:=String:C10(QR Get text property:C760($QRarea; $loop_L; $Row_L; qr bold:K14904:3))
		$Under_L:=QR Get text property:C760($QRarea; $loop_L; $Row_L; qr underline:K14904:5)
		$CItaL:=String:C10(QR Get text property:C760($QRarea; $loop_L; $Row_L; qr italic:K14904:4))
		$HAlign_L:=QR Get text property:C760($QRarea; $loop_L; $Row_L; qr justification:K14904:7)
		$CbkgCol_L:=QR Get text property:C760($QRarea; $loop_L; $Row_L; qr background color:K14904:8)
		$CTCol_L:=QR Get text property:C760($QRarea; $loop_L; $Row_L; qr text color:K14904:6)
		QR GET BORDERS:C798($QRarea; $loop_L; $Row_L; qr left border:K14908:1; $LBT_L; $LBC_L)
		QR GET BORDERS:C798($QRarea; $loop_L; $Row_L; qr top border:K14908:2; $TBT_L; $TBC_L)
		QR GET BORDERS:C798($QRarea; $loop_L; $Row_L; qr right border:K14908:3; $RBT_L; $RBC_L)
		QR GET BORDERS:C798($QRarea; $loop_L; $Row_L; qr bottom border:K14908:4; $BBT_L; $BBC_L)
		QR GET BORDERS:C798($QRarea; $loop_L; $Row_L; qr inside vertical border:K14908:5; $IVBT_L; $IVBC_L)
		QR GET BORDERS:C798($QRarea; $loop_L; $Row_L; qr inside horizontal border:K14908:6; $IHBT_L; $IHBC_L)
		
		If ($Under_L=0)
			$CUnder:=""
		Else 
			$CUnder:=" ss:Underline=\"Single\""
		End if 
		$Halign:=""
		Case of 
			: ($HAlign_L=1)
				$Halign:="ss:Horizontal=\"Left\" "
			: ($HAlign_L=2)
				$Halign:="ss:Horizontal=\"Center\" "
			: ($HAlign_L=3)
				$Halign:="ss:Horizontal=\"Right\" "
		End case 
		$CbkgCol:=Substring:C12(String:C10($CbkgCol_L; "&x"); (Length:C16(String:C10($CbkgCol_L; "&x"))-5))
		If ($CbkgCol#"FFFFFF")
			$CbkgCol:="<Interior ss:Color=\"#"+$CbkgCol+"\" ss:Pattern=\"Solid\"/>"
		Else 
			$CbkgCol:=""
		End if 
		
		//$CbkgCol:=" ss:Color=\"#"+Substring(String($CbkgCol_L;"&x");(Length(String($CbkgCol_L;"&x"))-5))+"\""
		If ($CTCol_L=0)
			$CTCol:=""
		Else 
			$CTCol:=" ss:Color=\"#"+Substring:C12(String:C10($CTCol_L; "&x"); (Length:C16(String:C10($CTCol_L; "&x"))-5))+"\""
		End if 
		If ($LBT_L+$RBT_L+$TBT_L+$BBT_L+$IVBT_L+$IHBT_L=0)
			$Border:=""
		Else 
			$Border:="<Borders>"
			If ($LBT_L>0)
				$Border:=$Border+"<Border ss:Position=\"Left\" ss:LineStyle=\"Continuous\" ss:Weight=\""+$Linethick_atxt{$LBT_L}+"\"/>"
			End if 
			If ($TBT_L>0)
				$Border:=$Border+"<Border ss:Position=\"Top\" ss:LineStyle=\"Continuous\" ss:Weight=\""+$Linethick_atxt{$TBT_L}+"\"/>"
			End if 
			If ($RBT_L>0)
				$Border:=$Border+"<Border ss:Position=\"Right\" ss:LineStyle=\"Continuous\" ss:Weight=\""+$Linethick_atxt{$RBT_L}+"\"/>"
			End if 
			If ($BBT_L>0)
				$Border:=$Border+"<Border ss:Position=\"Bottom\" ss:LineStyle=\"Continuous\" ss:Weight=\""+$Linethick_atxt{$BBT_L}+"\"/>"
			End if 
			
			$Border:=$Border+"</Borders>"
		End if 
		
		$TempLate_Text:=$TempLate_Text+"<Style ss:ID=\"s"+String:C10($StyleCounter_L)+"\"><Font ss:Size=\""+$HdrFontS+"\" ss:Bold=\""+$CBold+"\" ss:Italic=\""+$CItaL+"\""+$CUnder+$CTCol+"/>"
		$TempLate_Text:=$TempLate_Text+"<Alignment "+$Halign+"ss:Vertical=\"Top\"/>"
		$TempLate_Text:=$TempLate_Text+$CbkgCol+$Border
		$TempLate_Text:=$TempLate_Text+"</Style>"+Char:C90(13)
		
	End for 
	
End for 

If (False:C215)
	$Row_L:=-1
	For ($loop_L; 1; $numCols)
		$StyleCounter_L:=$StyleCounter_L+1
		$HeadrStyles_atxt{$loop_L}:=String:C10($StyleCounter_L)
		$HdrFontS:=String:C10(QR Get text property:C760($QRarea; $loop_L; $Row_L; qr font size:K14904:2))
		$CBold:=String:C10(QR Get text property:C760($QRarea; $loop_L; $Row_L; qr bold:K14904:3))
		$Under_L:=QR Get text property:C760($QRarea; $loop_L; $Row_L; qr underline:K14904:5)
		$CItaL:=String:C10(QR Get text property:C760($QRarea; $loop_L; $Row_L; qr italic:K14904:4))
		$HAlign_L:=QR Get text property:C760($QRarea; $loop_L; $Row_L; qr justification:K14904:7)
		$CbkgCol_L:=QR Get text property:C760($QRarea; $loop_L; $Row_L; qr background color:K14904:8)
		$CTCol_L:=QR Get text property:C760($QRarea; $loop_L; $Row_L; qr text color:K14904:6)
		If ($Under_L=0)
			$CUnder:=""
		Else 
			$CUnder:=" ss:Underline=\"Single\""
		End if 
		$Halign:=""
		Case of 
			: ($HAlign_L=1)
				$Halign:="ss:Horizontal=\"Left\" "
			: ($HAlign_L=2)
				$Halign:="ss:Horizontal=\"Center\" "
			: ($HAlign_L=3)
				$Halign:="ss:Horizontal=\"Right\" "
		End case 
		$CbkgCol:=Substring:C12(String:C10($CbkgCol_L; "&x"); (Length:C16(String:C10($CbkgCol_L; "&x"))-5))
		If ($CbkgCol#"FFFFFF")
			$CbkgCol:="<Interior ss:Color=\"#"+$CbkgCol+"\" ss:Pattern=\"Solid\"/>"
		Else 
			$CbkgCol:=""
		End if 
		
		//$CbkgCol:=" ss:Color=\"#"+Substring(String($CbkgCol_L;"&x");(Length(String($CbkgCol_L;"&x"))-5))+"\""
		If ($CTCol_L=0)
			$CTCol:=""
		Else 
			$CTCol:=" ss:Color=\"#"+Substring:C12(String:C10($CTCol_L; "&x"); (Length:C16(String:C10($CTCol_L; "&x"))-5))+"\""
		End if 
		$TempLate_Text:=$TempLate_Text+"<Style ss:ID=\"s"+String:C10($StyleCounter_L)+"\"><Font ss:Size=\""+$HdrFontS+"\" ss:Bold=\""+$CBold+"\" ss:Italic=\""+$CItaL+"\""+$CUnder+$CTCol+"/>"
		$TempLate_Text:=$TempLate_Text+"<Alignment "+$Halign+"ss:Vertical=\"Top\"/>"
		$TempLate_Text:=$TempLate_Text+$CbkgCol
		$TempLate_Text:=$TempLate_Text+"</Style>"+Char:C90(13)
		
	End for 
	$Row_L:=-2
	For ($loop_L; 1; $numCols)
		$StyleCounter_L:=$StyleCounter_L+1
		$BodyStyles_atxt{$loop_L}:=String:C10($StyleCounter_L)
		$HdrFontS:=String:C10(QR Get text property:C760($QRarea; $loop_L; $Row_L; qr font size:K14904:2))
		$CBold:=String:C10(QR Get text property:C760($QRarea; $loop_L; $Row_L; qr bold:K14904:3))
		$Under_L:=QR Get text property:C760($QRarea; $loop_L; $Row_L; qr underline:K14904:5)
		$CItaL:=String:C10(QR Get text property:C760($QRarea; $loop_L; $Row_L; qr italic:K14904:4))
		$HAlign_L:=QR Get text property:C760($QRarea; $loop_L; $Row_L; qr justification:K14904:7)
		$CbkgCol_L:=QR Get text property:C760($QRarea; $loop_L; $Row_L; qr background color:K14904:8)
		$CTCol_L:=QR Get text property:C760($QRarea; $loop_L; $Row_L; qr text color:K14904:6)
		If ($Under_L=0)
			$CUnder:=""
		Else 
			$CUnder:=" ss:Underline=\"Single\""
		End if 
		$Halign:=""
		Case of 
			: ($HAlign_L=1)
				$Halign:="ss:Horizontal=\"Left\" "
			: ($HAlign_L=2)
				$Halign:="ss:Horizontal=\"Center\" "
			: ($HAlign_L=3)
				$Halign:="ss:Horizontal=\"Right\" "
		End case 
		$CbkgCol:=Substring:C12(String:C10($CbkgCol_L; "&x"); (Length:C16(String:C10($CbkgCol_L; "&x"))-5))
		If ($CbkgCol#"FFFFFF")
			$CbkgCol:="<Interior ss:Color=\"#"+$CbkgCol+"\" ss:Pattern=\"Solid\"/>"
		Else 
			$CbkgCol:=""
		End if 
		If ($CTCol_L=0)
			$CTCol:=""
		Else 
			$CTCol:=" ss:Color=\"#"+Substring:C12(String:C10($CTCol_L; "&x"); (Length:C16(String:C10($CTCol_L; "&x"))-5))+"\""
		End if 
		
		$TempLate_Text:=$TempLate_Text+"<Style ss:ID=\"s"+String:C10($StyleCounter_L)+"\"><Font ss:Size=\""+$HdrFontS+"\" ss:Bold=\""+$CBold+"\" ss:Italic=\""+$CItaL+"\""+$CUnder+$CTCol+"/>"
		$TempLate_Text:=$TempLate_Text+"<Alignment "+$Halign+"ss:Vertical=\"Top\"/>"
		$TempLate_Text:=$TempLate_Text+$CbkgCol
		$TempLate_Text:=$TempLate_Text+"</Style>"+Char:C90(13)
		
	End for 
	
End if 

//insert text in template text variable starting with Worksheet element tag
$TempLate_Text:=$TempLate_Text+"</Styles><Worksheet ss:Name=\""+Replace string:C233(Table name:C256($tableNum); " "; "_")+"\">"
//declare number of columns for the worksheet
//$TempLate_Text:=$TempLate_Text+Char(13)+" <Table ss:ExpandedColumnCount=\""+String($numCols)+"\" ss:ExpandedRowCount=\""+String($numRecords+1)+"\" x:FullColumns=\ "1\" x:FullRows=\"1\">"
$TempLate_Text:=$TempLate_Text+Char:C90(13)+" <Table x:FullColumns=\"1\" x:FullRows=\"1\">"
$TempLate_Text:=$TempLate_Text+Char:C90(13)+"<Row ss:Height=\""+String:C10($HdrHt)+"\">"
$HeaderL_txt:=Replace string:C233($HeaderL_txt; "#H"; String:C10(Current time:C178(*)))
$HeaderL_txt:=Replace string:C233($HeaderL_txt; "#D"; String:C10(Current date:C33(*)))
$HeaderL_txt:=Replace string:C233($HeaderL_txt; "#P"; "")  //no pages

$HeaderM_Txt:=Replace string:C233($HeaderM_Txt; "#H"; String:C10(Current time:C178(*)))
$HeaderM_Txt:=Replace string:C233($HeaderM_Txt; "#D"; String:C10(Current date:C33(*)))
$HeaderM_Txt:=Replace string:C233($HeaderM_Txt; "#P"; "")  //no pages

$HeaderR_txt:=Replace string:C233($HeaderR_txt; "#H"; String:C10(Current time:C178(*)))
$HeaderR_txt:=Replace string:C233($HeaderR_txt; "#D"; String:C10(Current date:C33(*)))
$HeaderR_txt:=Replace string:C233($HeaderR_txt; "#P"; "")  //no pages

Case of 
	: ($numCols=1)
		$TempLate_Text:=$TempLate_Text+"<Cell ss:StyleID=\"s"+$HdrStyleID+"\"><Data ss:Type=\"String\">"+"<!--#4DQRlHeader--><!--#4DQRdata--><!--/#4DQRlHeader-->"+"</Data></Cell>"
	: ($numCols=2)
		$TempLate_Text:=$TempLate_Text+"<Cell ss:StyleID=\"s"+$HdrStyleID+"\"><Data ss:Type=\"String\">"+($HeaderL_txt+" "+$HeaderM_Txt)+"</Data></Cell>"
		$TempLate_Text:=$TempLate_Text+"<Cell ss:StyleID=\"s"+$HdrStyleID+"\"><Data ss:Type=\"String\">"+($HeaderR_txt)+"</Data></Cell>"
	: ($numCols=3)
		$TempLate_Text:=$TempLate_Text+"<Cell ss:StyleID=\"s"+$HdrStyleID+"\"><Data ss:Type=\"String\">"+"<!--#4DQRlHeader--><!--#4DQRdata--><!--/#4DQRlHeader-->"+"</Data></Cell>"
		$TempLate_Text:=$TempLate_Text+"<Cell ss:StyleID=\"s"+$HdrStyleID+"\"><Data ss:Type=\"String\">"+"<!--#4DQRcHeader--><!--#4DQRdata--><!--/#4DQRcHeader-->"+"</Data></Cell>"
		$TempLate_Text:=$TempLate_Text+"<Cell ss:StyleID=\"s"+$HdrStyleID+"\"><Data ss:Type=\"String\">"+"<!--#4DQRrHeader--><!--#4DQRdata--><!--/#4DQRrHeader-->"+"</Data></Cell>"
	: ($numCols>3)
		$TempLate_Text:=$TempLate_Text+"<Cell ss:StyleID=\"s"+$HdrStyleID+"\"><Data ss:Type=\"String\">"+"<!--#4DQRlHeader--><!--#4DQRdata--><!--/#4DQRlHeader-->"+"</Data></Cell>"
		$TempLate_Text:=$TempLate_Text+"<Cell ss:StyleID=\"s"+$HdrStyleID+"\" ss:Index=\""+String:C10(Round:C94($numcols/2; 0))+"\"><Data ss:Type=\"String\">"+"<!--#4DQRcHeader--><!--#4DQRdata--><!--/#4DQRcHeader-->"+"</Data></Cell>"
		$TempLate_Text:=$TempLate_Text+"<Cell ss:StyleID=\"s"+$HdrStyleID+"\" ss:Index=\""+String:C10($numcols)+"\"><Data ss:Type=\"String\">"+"<!--#4DQRrHeader--><!--#4DQRdata--><!--/#4DQRrHeader-->"+"</Data></Cell>"
End case 
$TempLate_Text:=$TempLate_Text+"</Row>"
//Insert the column titles
//$TempLate_Text:=$TempLate_Text+Char(13)+"<!--#4DQRHeader--><Row><!--#4DQRCol--><Cell><Data ss:Type=\"String\"><!--#4DQRData-"+"-></Data></Cell><!--/#4DQRCol--></Row><!--/#4DQRHeader-->"
If (False:C215)
	$TempLate_Text:=$TempLate_Text+Char:C90(13)+"<!--#4DQRHeader--><Row>"
	For ($i; 1; $numCols)
		$TempLate_Text:=$TempLate_Text+"<!--#4DQRCol;"+String:C10($i)+"-->"  // content of column at certain column number will be retrieved
		$TempLate_Text:=$TempLate_Text+"<Cell ss:StyleID=\"s"+$HeadrStyles_atxt{$i}+"\" ><Data ss:Type=\"String\">"  // declare data type 
		$TempLate_Text:=$TempLate_Text+"<!--#4DQRData-->"  // insert data in column
		$TempLate_Text:=$TempLate_Text+"</Data></Cell> <!--/#4DQRCol;"+String:C10($i)+"-->"  //insert matching closing tags
	End for 
	$TempLate_Text:=$TempLate_Text+"</Row><!--/#4DQRHeader-->"
Else 
	$TempLate_Text:=$TempLate_Text+Char:C90(13)+"<Row>"
	For ($i; 1; $numCols)
		QR GET INFO COLUMN:C766($QRarea; $i; $title; $obj; $hide; $size; $rep; $format)  // get column information
		$TempLate_Text:=$TempLate_Text+"<Cell ss:StyleID=\"s"+$HeadrStyles_atxt{$i}+"\" ><Data ss:Type=\"String\">"  // declare data type 
		$TempLate_Text:=$TempLate_Text+$title  // insert data in column
		$TempLate_Text:=$TempLate_Text+"</Data></Cell>"  //insert matching closing tags
	End for 
	$TempLate_Text:=$TempLate_Text+"</Row>"
	
End if 

$TempLate_Text:=$TempLate_Text+Char:C90(13)+"<!--#4DQRRow--><Row>"
//Insert column data for each row. 
For ($i; 1; $numCols)
	QR GET INFO COLUMN:C766($QRarea; $i; $title; $obj; $hide; $size; $rep; $format)  // get column information
	curPos:=Position:C15("]"; $obj)
	$fieldobj:=Substring:C12($obj; curPos+1)  //$fieldobj contains field name
	$fieldNum:=Find in array:C230(QR_Fields_atxt; $fieldobj)  //find field number
	GET FIELD PROPERTIES:C258($tableNum; $fieldNum; $fieldType)  //determine the type of field
	mytype:=GetType($fieldType)  //GetType function returns the type of data of the field type. 
	$ColName:=$title  // title of the column
	$TempLate_Text:=$TempLate_Text+Char:C90(13)+"<!--#4DQRCol;"+String:C10($i)+"-->"  // content of column at certain column number will be retrieved
	$TempLate_Text:=$TempLate_Text+Char:C90(13)+"<Cell ss:StyleID=\"s"+$BodyStyles_atxt{$i}+"\"><Data ss:Type=\""+mytype+"\">"  // declare data type 
	$TempLate_Text:=$TempLate_Text+Char:C90(13)+"<!--#4DQRData-->"  // insert data in column
	$TempLate_Text:=$TempLate_Text+Char:C90(13)+"</Data></Cell> <!--/#4DQRCol;"+String:C10($i)+"-->"  //insert matching closing tags
End for 
//insert the closing tags of the lower part of the XMLSpreadsheet
$TempLate_Text:=$TempLate_Text+Char:C90(13)+"</Row><!--/#4DQRRow-->"

$TempLate_Text:=$TempLate_Text+Char:C90(13)+"<Row ss:Height=\""+String:C10($HdrHt)+"\">"

Case of 
	: ($numCols=1)
		$TempLate_Text:=$TempLate_Text+"<Cell ss:StyleID=\"s"+$HdrStyleID+"\"><Data ss:Type=\"String\">"+"<!--#4DQRlFooter--><!--#4DQRdata--><!--/#4DQRlFooter-->"+"</Data></Cell>"
	: ($numCols=2)
		$TempLate_Text:=$TempLate_Text+"<Cell ss:StyleID=\"s"+$HdrStyleID+"\"><Data ss:Type=\"String\">"+($FooterL_txt+" "+$FooterM_Txt)+"</Data></Cell>"
		$TempLate_Text:=$TempLate_Text+"<Cell ss:StyleID=\"s"+$HdrStyleID+"\"><Data ss:Type=\"String\">"+($FooterR_txt)+"</Data></Cell>"
	: ($numCols=3)
		$TempLate_Text:=$TempLate_Text+"<Cell ss:StyleID=\"s"+$HdrStyleID+"\"><Data ss:Type=\"String\">"+"<!--#4DQRlFooter--><!--#4DQRdata--><!--/#4DQRlFooter-->"+"</Data></Cell>"
		$TempLate_Text:=$TempLate_Text+"<Cell ss:StyleID=\"s"+$HdrStyleID+"\"><Data ss:Type=\"String\">"+"<!--#4DQRcFooter--><!--#4DQRdata--><!--/#4DQRcFooter-->"+"</Data></Cell>"
		$TempLate_Text:=$TempLate_Text+"<Cell ss:StyleID=\"s"+$HdrStyleID+"\"><Data ss:Type=\"String\">"+"<!--#4DQRrFooter--><!--#4DQRdata--><!--/#4DQRrFooter-->"+"</Data></Cell>"
	: ($numCols>3)
		$TempLate_Text:=$TempLate_Text+"<Cell ss:StyleID=\"s"+$HdrStyleID+"\"><Data ss:Type=\"String\">"+"<!--#4DQRlFooter--><!--#4DQRdata--><!--/#4DQRlFooter-->"+"</Data></Cell>"
		$TempLate_Text:=$TempLate_Text+"<Cell ss:StyleID=\"s"+$HdrStyleID+"\" ss:Index=\""+String:C10(Round:C94($numcols/2; 0))+"\"><Data ss:Type=\"String\">"+"<!--#4DQRcFooter--><!--#4DQRdata--><!--/#4DQRcFooter-->"+"</Data></Cell>"
		$TempLate_Text:=$TempLate_Text+"<Cell ss:StyleID=\"s"+$HdrStyleID+"\" ss:Index=\""+String:C10($numcols)+"\"><Data ss:Type=\"String\">"+"<!--#4DQRrFooter--><!--#4DQRdata--><!--/#4DQRrFooter-->"+"</Data></Cell>"
End case 
$TempLate_Text:=$TempLate_Text+"</Row>"

$TempLate_Text:=$TempLate_Text+Char:C90(13)+"</Table>"
$TempLate_Text:=$TempLate_Text+Char:C90(13)+"<WorksheetOptions xmlns=\"urn:schemas-microsoft-com:office:excel\">"
$TempLate_Text:=$TempLate_Text+Char:C90(13)+"<Selected/>"
$TempLate_Text:=$TempLate_Text+Char:C90(13)+"<ProtectObjects>False</ProtectObjects>"
$TempLate_Text:=$TempLate_Text+Char:C90(13)+"<ProtectScenarios>False</ProtectScenarios>"
$TempLate_Text:=$TempLate_Text+Char:C90(13)+"</WorksheetOptions>"
$TempLate_Text:=$TempLate_Text+Char:C90(13)+"</Worksheet>"
$TempLate_Text:=$TempLate_Text+Char:C90(13)+"</Workbook>"

$metadataTemplate:=ut_GetSysParameter("XML_QRHeader")  //Retrieve a template for the upper part of the XML Spreadsheet. 
If ($metadataTemplate="")
	$0:=""
	ALERT:C41("Could not Load required XML Template [XML_QRHeader] from Parameters Table!")
Else 
	$0:=$metadataTemplate+$TempLate_Text  // Concatenate the upper part and the lower part of the XML Spreadsheet to be returned as template. 
End if 

ARRAY TEXT:C222(QR_Fields_atxt; 0)