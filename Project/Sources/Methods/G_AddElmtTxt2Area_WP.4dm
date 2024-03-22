//%attributes = {"invisible":true}
//Method: G_AddElmtTxt2Area_WP
//Description
// add a wp doc embedded in a blob to a write pro area, include a title
// Parameters
// $1 : $WPArea
// $2 : $Title_txt
// $3 : $Blob
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/20/21, 19:27:19
	// ----------------------------------------------------
	//Created : 
	Mods_2021_WP
	
	C_OBJECT:C1216(G_AddElmtTxt2Area_WP; $1)
	C_TEXT:C284(G_AddElmtTxt2Area_WP; $2)
	C_BLOB:C604(G_AddElmtTxt2Area_WP; $3)
	
	// Modified by: Costas Manousakis-(Designer)-(2022-05-05 11:54:55)
	Mods_2022_05
	//  `added setting the line height of all text to 100%
End if 
//

C_OBJECT:C1216($1; $WParea; $WPComments)
C_TEXT:C284($2; $Title)
C_BLOB:C604($3; $FieldBlob; $wpBlob)

$WParea:=$1
$Title:=$2
$FieldBlob:=$3

C_TEXT:C284($vTitleTxt; vtHeaderLbl)
If (vtHeaderLbl#"")
	//if there is a header , prepend to the element title
	$Title:=vtHeaderLbl+<>sCR+<>sCR+$Title
	vtHeaderLbl:=""  // and then clear it
End if 

C_TEXT:C284($dataTag)
C_LONGINT:C283($offset)
$offset:=0
C_LONGINT:C283($compressed)
BLOB PROPERTIES:C536($FieldBlob; $compressed)
If ($compressed#0)
	EXPAND BLOB:C535($FieldBlob)
End if 
BLOB TO VARIABLE:C533($FieldBlob; $dataTag; $offset)


If ($dataTag="WPAREA")
	BLOB TO VARIABLE:C533($FieldBlob; $wpBlob; $offset)
	$WPComments:=WP New:C1317($wpBlob)
	
	C_OBJECT:C1216($new; $range; $RangePos)
	C_OBJECT:C1216($endPos; $titlePos; $SectionPos; $RangeStart; $rangeEnd; $bookmarkRange; $newRangeEndPos)
	C_OBJECT:C1216($titleStartPos; $titleRange; $RemarksStartPos; $indxRange; $RangeEndPos; $newPar)
	
	$range:=WP Text range:C1341($WParea; wk start text:K81:165; wk end text:K81:164)  //all of previous text
	
	If ($range.end=1)
		//unless it is first thing in document
		
	Else 
		$rangeEnd:=WP Text range:C1341($WParea; wk end text:K81:164; wk end text:K81:164)  // the end of text
		$RangeEndPos:=WP Get position:C1577($rangeEnd; wk 4D Write Pro layout:K81:176)  //location of end of text
		WP SET TEXT:C1574($rangeEnd; "\r"; wk append:K81:179; wk include in range:K81:180)
		$newPar:=WP Text range:C1341($WParea; $rangeEnd.end; $rangeEnd.end)  // this is start of new parapgraph
		// we should clear bullets, left right margins and indents
		WP SET ATTRIBUTES:C1342($newPar; wk text indent:K81:52; 0; wk margin:K81:10; 0; wk list style type:K81:55; wk none:K81:91)
		$newRangeEndPos:=WP Get position:C1577(WP Text range:C1341($rangeEnd; wk end text:K81:164; wk end text:K81:164); wk 4D Write Pro layout:K81:176)
		If ($newRangeEndPos.page=$RangeEndPos.page)
			//still on same page - add one more linefeed
			WP SET TEXT:C1574($rangeEnd; "\r"; wk append:K81:179; wk include in range:K81:180)
			$newRangeEndPos:=WP Get position:C1577(WP Text range:C1341($rangeEnd; wk end text:K81:164; wk end text:K81:164); wk 4D Write Pro layout:K81:176)
		End if 
		$range:=WP Text range:C1341($WParea; wk start text:K81:165; wk end text:K81:164)  //all of previuus text
	End if 
	
	ST SET ATTRIBUTES:C1093($Title; ST Start text:K78:15; ST End text:K78:16; Attribute bold style:K65:1; 1; Attribute underline style:K65:4; 1; Attribute font name:K65:5; "Arial"; Attribute text size:K65:6; 11)
	$new:=WP New:C1317($Title)
	$RangeStart:=WP Text range:C1341($range; wk end text:K81:164; wk end text:K81:164)
	$titleStartPos:=WP Get position:C1577($RangeStart; wk 4D Write Pro layout:K81:176)
	WP INSERT DOCUMENT:C1411($range; $new; wk append:K81:179; wk include in range:K81:180)
	$rangeEnd:=WP Text range:C1341($range; wk end text:K81:164; wk end text:K81:164)
	
	If ($titleStartPos.page=1) & ($titleStartPos.line=1)  //if at first page first line
		$titleRange:=WP Text range:C1341($range; $RangeStart.start; $rangeEnd.end)
	Else 
		$titleRange:=WP Text range:C1341($range; $RangeStart.start; $rangeEnd.end)
	End if 
	$titleStartPos:=WP Get position:C1577($titleRange; wk 4D Write Pro layout:K81:176)
	
	$RangeStart:=WP Text range:C1341($range; wk end text:K81:164; wk end text:K81:164)
	WP INSERT DOCUMENT:C1411($range; $WPComments; wk append:K81:179; wk include in range:K81:180)
	WP SET ATTRIBUTES:C1342($range; wk font family:K81:65; "Arial"; wk font size:K81:66; 11; wk line height:K81:51; "100%")
	
	$rangeEnd:=WP Text range:C1341($range; wk end text:K81:164; wk end text:K81:164)
	$bookmarkRange:=WP Text range:C1341($range; $RangeStart.start+1; $rangeEnd.end)
	$RemarksStartPos:=WP Get position:C1577($bookmarkRange; wk 4D Write Pro layout:K81:176)
	If ($RemarksStartPos.page>$titleStartPos.page)
		//remarks start in a page after the title
		//should insert a page break before the title
		WP INSERT BREAK:C1413($titleRange; wk page break:K81:188; wk prepend:K81:178; wk exclude from range:K81:181)
	End if 
	
End if 

//End G_AddElmtTxt2Area_WP