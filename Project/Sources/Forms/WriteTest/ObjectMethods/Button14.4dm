ARRAY TEXT:C222($names; 0)
ARRAY LONGINT:C221($Widths; 0)
ARRAY LONGINT:C221($heights; 0)

PRINT OPTION VALUES:C785(Paper option:K47:1; $names; $Widths; $heights)
C_LONGINT:C283($letterPaper)
$letterPaper:=Find in array:C230($names; "@Letter")

C_OBJECT:C1216($wpnew)
C_POINTER:C301($area_; $area2_; $area3_)

$area_:=OBJECT Get pointer:C1124(Object named:K67:5; "writeproarea")
$area2_:=OBJECT Get pointer:C1124(Object named:K67:5; "writeproarea2")
$area3_:=OBJECT Get pointer:C1124(Object named:K67:5; "WPArea")

C_TEXT:C284($template)
ARRAY TEXT:C222($files_a; 0)
$template:=Select document:C905(""; ""; "Choose template"; 0; $files_a)

$area3_->:=WP Import document:C1318($files_a{1})
C_OBJECT:C1216($range)
$range:=WP Text range:C1341($area3_->; wk start text:K81:165; wk end text:K81:164)
WP SET TEXT:C1574($range; ""; wk replace:K81:177; wk include in range:K81:180)

READ ONLY:C145(*)
C_LONGINT:C283($InspID)
$InspID:=Num:C11(Request:C163("specify inspection ID"; "103530"))
QUERY:C277([Inspections:27]; [Inspections:27]InspID:2=$InspID)

C_LONGINT:C283($WKarea; $charcount; $blobOffset)
Set Doc Margins($WKarea)
C_BLOB:C604($WRBlob; $TempSave; $WRcomments)
C_TEXT:C284($tag)

$TempSave:=Convert_WKStyleTxtToWP([Inspections:27]OrientationText:204; $WKarea)
If (BLOB size:C605($TempSave)=0)
	$TempSave:=INSP_GetWPDocFromBlob([Inspections:27]OrientationText:204)
End if 
$area_->:=WP New:C1317($TempSave)

If (False:C215)
	C_OBJECT:C1216($new; $range)
	$range:=WP Text range:C1341($area3_->; wk start text:K81:165; wk end text:K81:164)
	//clear any text
	WP SET TEXT:C1574($range; ""; wk replace:K81:177; wk include in range:K81:180)
	C_TEXT:C284($title)
	C_LONGINT:C283($BookmarkCount)
	C_OBJECT:C1216($endPos; $titlePos; $SectionPos; $RangeStart; $rangeEnd; $bookmarkRange)
	$BookmarkCount:=0
	C_OBJECT:C1216($titleStartPos; $titleRange; $RemarksStartPos; $indxRange)
	$title:=Uppercase:C13("Orientation")
	ST SET ATTRIBUTES:C1093($title; ST Start text:K78:15; ST End text:K78:16; Attribute bold style:K65:1; 1; Attribute underline style:K65:4; 1; Attribute font name:K65:5; "Arial"; Attribute text size:K65:6; 11)
	$new:=WP New:C1317($title)
	$RangeStart:=WP Text range:C1341($range; wk end text:K81:164; wk end text:K81:164)
	$titleStartPos:=WP Get position:C1577($RangeStart; wk 4D Write Pro layout:K81:176)
	WP INSERT DOCUMENT:C1411($range; $new; wk append:K81:179; wk include in range:K81:180)
	$rangeEnd:=WP Text range:C1341($range; wk end text:K81:164; wk end text:K81:164)
	$BookmarkCount:=$BookmarkCount+1
	
	If ($titleStartPos.page=1) & ($titleStartPos.line=1)  //if at first page first line
		$titleRange:=WP Text range:C1341($range; $RangeStart.start; $rangeEnd.end)
	Else 
		$titleRange:=WP Text range:C1341($range; $RangeStart.start+1; $rangeEnd.end)
	End if 
	$titleStartPos:=WP Get position:C1577($titleRange; wk 4D Write Pro layout:K81:176)
	WP NEW BOOKMARK:C1415($titleRange; String:C10($BookmarkCount; "000000")+"Title")
	
	$RangeStart:=WP Text range:C1341($range; wk end text:K81:164; wk end text:K81:164)
	WP INSERT DOCUMENT:C1411($range; $area_->; wk append:K81:179; wk include in range:K81:180)
	$rangeEnd:=WP Text range:C1341($range; wk end text:K81:164; wk end text:K81:164)
	$bookmarkRange:=WP Text range:C1341($range; $RangeStart.start+1; $rangeEnd.end)
	WP NEW BOOKMARK:C1415($bookmarkRange; String:C10($BookmarkCount; "000000")+"Remarks")
	$RemarksStartPos:=WP Get position:C1577($bookmarkRange; wk 4D Write Pro layout:K81:176)
	If ($RemarksStartPos.page>$titleStartPos.page)
		//remarks start in a page after the title
		//should insert a page break before the title
		WP INSERT BREAK:C1413($titleRange; wk page break:K81:188; wk prepend:K81:178; wk exclude from range:K81:181)
	End if 
	
Else 
	G_Insp_AddOrientation_WP($area3_->)
End if 

$TempSave:=Convert_WKStyleTxtToWP([Inspections:27]InspComments:171; $WKarea)
If (BLOB size:C605($TempSave)=0)
	$TempSave:=INSP_GetWPDocFromBlob([Inspections:27]InspComments:171)
End if 
$area2_->:=WP New:C1317($TempSave)

If (False:C215)
	$title:=Uppercase:C13("General Remarks")
	ST SET ATTRIBUTES:C1093($title; ST Start text:K78:15; ST End text:K78:16; Attribute bold style:K65:1; 1; Attribute underline style:K65:4; 1; Attribute font name:K65:5; "Arial"; Attribute text size:K65:6; 11)
	$new:=WP New:C1317($title)
	WP INSERT BREAK:C1413($range; wk line break:K81:186; wk append:K81:179; wk include in range:K81:180)
	
	$RangeStart:=WP Text range:C1341($range; wk end text:K81:164; wk end text:K81:164)
	$titleStartPos:=WP Get position:C1577($RangeStart; wk 4D Write Pro layout:K81:176)
	WP INSERT DOCUMENT:C1411($range; $new; wk append:K81:179; wk include in range:K81:180)
	$rangeEnd:=WP Text range:C1341($range; wk end text:K81:164; wk end text:K81:164)
	$BookmarkCount:=$BookmarkCount+1
	
	If ($titleStartPos.page=1) & ($titleStartPos.line=1)
		$titleRange:=WP Text range:C1341($range; $RangeStart.start; $rangeEnd.end)  //orientation is always at start
	Else 
		$titleRange:=WP Text range:C1341($range; $RangeStart.start+1; $rangeEnd.end)  //orientation is always at start
	End if 
	WP NEW BOOKMARK:C1415($titleRange; String:C10($BookmarkCount; "000000")+"Title")
	$titleStartPos:=WP Get position:C1577($titleRange; wk 4D Write Pro layout:K81:176)
	
	$RangeStart:=WP Text range:C1341($range; wk end text:K81:164; wk end text:K81:164)
	WP INSERT DOCUMENT:C1411($range; $area2_->; wk append:K81:179; wk include in range:K81:180)
	$rangeEnd:=WP Text range:C1341($range; wk end text:K81:164; wk end text:K81:164)
	$bookmarkRange:=WP Text range:C1341($range; $RangeStart.start+1; $rangeEnd.end)
	WP NEW BOOKMARK:C1415($bookmarkRange; String:C10($BookmarkCount; "000000")+"Remarks")
	$RemarksStartPos:=WP Get position:C1577($bookmarkRange; wk 4D Write Pro layout:K81:176)
	If ($RemarksStartPos.page>$titleStartPos.page)
		//remarks start in a page after the title
		//should insert a page break before the title
		WP INSERT BREAK:C1413($titleRange; wk page break:K81:188; wk prepend:K81:178; wk exclude from range:K81:181)
	End if 
Else 
	G_Insp_AddGenCmts_WP($area3_->)
End if 


QUERY:C277([ElementsSafety:29]; [ElementsSafety:29]InspID:4=[Inspections:27]InspID:2)
QUERY SELECTION:C341([ElementsSafety:29]; [ElementsSafety:29]Comment Flag:6=True:C214)

C_LONGINT:C283($elm)
C_TEXT:C284($cat)
C_OBJECT:C1216($rangeEnd; $rangeEndPos)
$cat:=""
C_OBJECT:C1216($TitleRange; $rangeEnd; $TitleRangepos; $PrevRangeEnd; $prevEndPos; $Commentsbody; $CommentsEnd; $NewEndRange; $newEndPos)

For ($elm; 1; Records in selection:C76([ElementsSafety:29]))
	GOTO SELECTED RECORD:C245([ElementsSafety:29]; $elm)
	$TempSave:=Convert_WKStyleTxtToWP([ElementsSafety:29]ElmComments:23; $WKarea)
	If (BLOB size:C605($TempSave)=0)
		$TempSave:=INSP_GetWPDocFromBlob([ElementsSafety:29]ElmComments:23)
	End if 
	
	QUERY:C277([ElementDict:30]; [ElementDict:30]ElementNo:1=[ElementsSafety:29]ElementNo:1)
	If ($cat#[ElementDict:30]Category:3)
		G_AddHeader([ElementDict:30]Category:3)
		$cat:=[ElementDict:30]Category:3
		$title:=vtHeaderLbl+Char:C90(13)+G_GetElmtLabel(True:C214)
	Else 
		$title:=G_GetElmtLabel(True:C214)
	End if 
	If (False:C215)
		ST SET ATTRIBUTES:C1093($title; ST Start text:K78:15; ST End text:K78:16; Attribute bold style:K65:1; 1; Attribute underline style:K65:4; 1; Attribute font name:K65:5; "Arial"; Attribute text size:K65:6; 11)
		$new:=WP New:C1317($title)
		
		WP INSERT BREAK:C1413($range; wk line break:K81:186; wk append:K81:179; wk include in range:K81:180)
		
		$RangeStart:=WP Text range:C1341($range; wk end text:K81:164; wk end text:K81:164)
		$titleStartPos:=WP Get position:C1577($RangeStart; wk 4D Write Pro layout:K81:176)
		WP INSERT DOCUMENT:C1411($range; $new; wk append:K81:179; wk include in range:K81:180)
		$rangeEnd:=WP Text range:C1341($range; wk end text:K81:164; wk end text:K81:164)
		$BookmarkCount:=$BookmarkCount+1
		If ($titleStartPos.page=1) & ($titleStartPos.line=1)
			$titleRange:=WP Text range:C1341($range; $RangeStart.start; $rangeEnd.end)  //orientation is always at start
		Else 
			$titleRange:=WP Text range:C1341($range; $RangeStart.start+1; $rangeEnd.end)  //orientation is always at start
		End if 
		WP NEW BOOKMARK:C1415($titleRange; String:C10($BookmarkCount; "000000")+"Title")
		$titleStartPos:=WP Get position:C1577($titleRange; wk 4D Write Pro layout:K81:176)  // get new start of title
		
		$RangeStart:=WP Text range:C1341($range; wk end text:K81:164; wk end text:K81:164)
		$Commentsbody:=WP New:C1317($TempSave)  // new doc with the comments
		WP INSERT DOCUMENT:C1411($range; $Commentsbody; wk append:K81:179; wk include in range:K81:180)
		$rangeEnd:=WP Text range:C1341($range; wk end text:K81:164; wk end text:K81:164)
		$bookmarkRange:=WP Text range:C1341($range; $RangeStart.start+1; $rangeEnd.end)
		WP NEW BOOKMARK:C1415($bookmarkRange; String:C10($BookmarkCount; "000000")+"Remarks")
		$RemarksStartPos:=WP Get position:C1577($bookmarkRange; wk 4D Write Pro layout:K81:176)  // get start of remarks
		If ($RemarksStartPos.page>$titleStartPos.page)
			//remarks start in a page after the title
			//should insert a page break before the title
			WP INSERT BREAK:C1413($titleRange; wk page break:K81:188; wk prepend:K81:178; wk exclude from range:K81:181)
		End if 
	Else 
		G_AddElmtTxt2Area_WP($area3_->; $title; [ElementsSafety:29]ElmComments:23)
	End if 
	
	
End for 


QUERY:C277([Standard Photos:36]; [Standard Photos:36]InspID:1=[Inspections:27]InspID:2)
C_LONGINT:C283($numphotos)
$numphotos:=Records in selection:C76([Standard Photos:36])

ARRAY TEXT:C222($aPhotoDesc; 0)  //Command Replaced was o_ARRAY string length was 255
ARRAY TEXT:C222($aPhotoType; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY INTEGER:C220($aImgNo; 0)
G_SortInspImages
SELECTION TO ARRAY:C260([Standard Photos:36]Description:2; $aPhotoDesc; [Standard Photos:36]PictType:5; $aPhotoType; [Standard Photos:36]SeqNum:6; $aImgNo)
C_TEXT:C284($vtIndex)
C_TEXT:C284($vsLabel)  // Command Replaced was o_C_STRING length was 80
C_BOOLEAN:C305($vbPhotos; $vbSketches; $vbCharts)

$vbPhotos:=False:C215
$vbSketches:=False:C215
$vbCharts:=False:C215
$vtIndex:=""
//build the index first
C_LONGINT:C283($i)
For ($i; 1; $numphotos)
	
	Case of 
		: ($aPhotoType{$i}=BMS Photo)  // Photo
			$vtIndex:=$vtIndex+"Photo "
			$vbPhotos:=True:C214
		: ($aPhotoType{$i}=BMS Sketch)  // Sketch       
			$vtIndex:=$vtIndex+"Sketch "
			$vbSketches:=True:C214
		: ($aPhotoType{$i}=BMS Chart)  // Chart        
			$vtIndex:=$vtIndex+"Chart "
			$vbCharts:=True:C214
	End case 
	$vtIndex:=$vtIndex+String:C10($aImgNo{$i})+" : "+<>sTAB+$aPhotoDesc{$i}
	If ($i#$numphotos)
		$vtIndex:=$vtIndex+<>sCR  //add linefeed except the last one.
	End if 
End for 
//build the label
$vsLabel:=""
If ($vbSketches)
	$vsLabel:="Sketch"
End if 
If ($vbCharts)
	If ($vsLabel="")
		$vsLabel:="Chart"
	Else 
		$vsLabel:=$vsLabel+" / Chart"
	End if 
End if 
If ($vbPhotos)
	If ($vsLabel="")
		$vsLabel:="Photo"
	Else 
		$vsLabel:=$vsLabel+" / Photo"
	End if 
End if 
$vsLabel:=$vsLabel+" Log"
If (False:C215)
	ST SET ATTRIBUTES:C1093($vsLabel; ST Start text:K78:15; ST End text:K78:16; Attribute bold style:K65:1; 1; Attribute underline style:K65:4; 1; Attribute font name:K65:5; "Arial"; Attribute text size:K65:6; 11)
	$new:=WP New:C1317($vsLabel)
	WP INSERT BREAK:C1413($range; wk line break:K81:186; wk append:K81:179; wk include in range:K81:180)
	
	$RangeStart:=WP Text range:C1341($range; wk end text:K81:164; wk end text:K81:164)
	$titleStartPos:=WP Get position:C1577($RangeStart; wk 4D Write Pro layout:K81:176)
	WP INSERT DOCUMENT:C1411($range; $new; wk append:K81:179; wk include in range:K81:180)
	$BookmarkCount:=$BookmarkCount+1
	If ($titleStartPos.page=1) & ($titleStartPos.line=1)
		$titleRange:=WP Text range:C1341($range; $RangeStart.start; $rangeEnd.end)  //orientation is always at start
	Else 
		$titleRange:=WP Text range:C1341($range; $RangeStart.start+1; $rangeEnd.end)  //orientation is always at start
	End if 
	WP NEW BOOKMARK:C1415($titleRange; String:C10($BookmarkCount; "000000")+"Title")
	$titleStartPos:=WP Get position:C1577($titleRange; wk 4D Write Pro layout:K81:176)
	
	ST SET ATTRIBUTES:C1093($vtIndex; ST Start text:K78:15; ST End text:K78:16; Attribute font name:K65:5; "Arial"; Attribute text size:K65:6; 11)
	$new:=WP New:C1317($vtIndex)
	$RangeStart:=WP Text range:C1341($range; wk end text:K81:164; wk end text:K81:164)
	WP INSERT DOCUMENT:C1411($range; $new; wk append:K81:179; wk include in range:K81:180)
	$rangeEnd:=WP Text range:C1341($range; wk end text:K81:164; wk end text:K81:164)
	$bookmarkRange:=WP Text range:C1341($range; $RangeStart.start+1; $rangeEnd.end)
	WP NEW BOOKMARK:C1415($bookmarkRange; String:C10($BookmarkCount; "000000")+"Remarks")
	$indxRange:=WP Text range:C1341($range; $RangeStart.start; $rangeEnd.end)
	WP SET ATTRIBUTES:C1342($indxRange; wk text indent:K81:52; "-2.5cm")
	$RemarksStartPos:=WP Get position:C1577($bookmarkRange; wk 4D Write Pro layout:K81:176)  // get start of remarks
	If ($RemarksStartPos.page>$titleStartPos.page)
		//remarks start in a page after the title
		//should insert a page break before the title
		WP INSERT BREAK:C1413($titleRange; wk page break:K81:188; wk prepend:K81:178; wk exclude from range:K81:181)
	End if 
Else 
	
	If ($vtIndex#"")
		INSP_AddTextToArea_WP($area3_->; $vsLabel; $vtIndex; "-2.5cm")
	End if 
	
End if 

ALERT:C41("Done")

C_TEXT:C284($doc)
ARRAY TEXT:C222($files_a; 0)
$doc:=Select document:C905(""; ""; "File to save to"; File name entry:K24:17; $files_a)
If (Size of array:C274($files_a)>0)
	WP EXPORT DOCUMENT:C1337($area3_->; $files_a{1}; wk 4wp:K81:4; wk normal:K81:7)
End if 


C_OBJECT:C1216(INSP_Comments_WP)
//_O_PAGE SETUP([Inspections]; "WPCmtsPrint")
FORM SET OUTPUT:C54([Inspections:27]; "WPCmtsPrint")
INSP_Comments_WP:=WP New:C1317("")
ARRAY LONGINT:C221($pages; 0)
C_LONGINT:C283($pw; $ph)
GET PRINT OPTION:C734(Paper option:K47:1; $pw; $ph)
SET PRINT OPTION:C733(Paper option:K47:1; 400; 600)
pageBreakFind($area3_; ->$pages)

C_TEXT:C284(sBDEPT)
C_LONGINT:C283(vPageNo; vTotal)
vTotal:=23

SET PRINT OPTION:C733(Destination option:K47:7; 5)
SET PRINT OPTION:C733(Paper option:K47:1; "Letter")
SET PRINT PREVIEW:C364(True:C214)

WP PRINT:C1343($area3_->; wk 4D Write Pro layout:K81:176)

SET PRINT OPTION:C733(Paper option:K47:1; $pw; $ph)
SET PRINT OPTION:C733(Destination option:K47:7; 1)


OPEN PRINTING JOB:C995
C_LONGINT:C283($loop_L)
C_OBJECT:C1216($pageRange)
$range:=WP Text range:C1341(INSP_Comments_WP; wk start text:K81:165; wk end text:K81:164)
For ($loop_L; 1; (Size of array:C274($pages)-1))
	$pageRange:=WP Text range:C1341($area3_->; $pages{$loop_L}; $pages{$loop_L+1})
	INSP_Comments_WP:=WP New:C1317($pageRange)
	Print form:C5([Inspections:27]; "WPCmtsPrint")
End for 
$pageRange:=WP Text range:C1341($area3_->; $pages{Size of array:C274($pages)}; wk end text:K81:164)
INSP_Comments_WP:=WP New:C1317($pageRange)
Print form:C5([Inspections:27]; "WPCmtsPrint")

CLOSE PRINTING JOB:C996
SET PRINT PREVIEW:C364(False:C215)
INSP_Comments_WP:=$area3_->
C_LONGINT:C283($dispWP)
$dispWP:=Open form window:C675("WPDisplay"; Palette form window:K39:9; On the left:K39:2; At the top:K39:5)
DIALOG:C40("WPDisplay")

