//%attributes = {"invisible":true}
//Method: INSP_AddTextToArea_WP
//Description
// Add text with label to area
// Parameters
// $1 : $WPArea_o
// $2 : $Title
// $3 : $TextToAdd
// $4 : $ParIndent_text
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/24/21, 19:13:04
	// ----------------------------------------------------
	//Created : 
	Mods_2021_WP
	
	C_OBJECT:C1216(INSP_AddTextToArea_WP; $1)
	C_TEXT:C284(INSP_AddTextToArea_WP; $2)
	C_TEXT:C284(INSP_AddTextToArea_WP; $3)
	C_TEXT:C284(INSP_AddTextToArea_WP; $4)
	
	// Modified by: Costas Manousakis-(Designer)-(2021-12-16T00:00:00 20:01:42)
	Mods_2021_12_bug
	//  `adjust method of inserting the text. First create a blank WP area, then use WP SET TEXT w/ wk replace 
	//  `handles errors when text contains & or other characters
	// Modified by: Costas Manousakis-(Designer)-(2022-05-05 12:04:05)
	Mods_2022_05
	//  `after adding the Texttoadd to the wparea range, make sure the whole range has lineheight=100%
End if 
//

C_OBJECT:C1216($1; $WParea; $WPComments)
C_TEXT:C284($2; $Title)
C_TEXT:C284($3; $TextToAdd)

$WParea:=$1
$Title:=$2
$TextToAdd:=$3

C_TEXT:C284($vTitleTxt; vtHeaderLbl)
If (vtHeaderLbl#"")
	$Title:=vtHeaderLbl+<>sCR+<>sCR+$Title
	vtHeaderLbl:=""
	
End if 

C_OBJECT:C1216($new; $range; $TextToAddRange)
C_OBJECT:C1216($endPos; $titlePos; $SectionPos; $RangeStart; $rangeEnd; $bookmarkRange; $newPar)
C_OBJECT:C1216($titleStartPos; $titleRange; $RemarksStartPos; $indxRange; $RangeEndPos; $newRangeEndPos)

$range:=WP Text range:C1341($WParea; wk start text:K81:165; wk end text:K81:164)

If ($range.end=1)
	//unless it is first thing in document
	
Else 
	If ($Title#"")
		$rangeEnd:=WP Text range:C1341($WParea; wk end text:K81:164; wk end text:K81:164)  // the end of text
		$RangeEndPos:=WP Get position:C1577($rangeEnd; wk 4D Write Pro layout:K81:176)  //location of end of text
		WP SET TEXT:C1574($rangeEnd; "\r"; wk append:K81:179; wk include in range:K81:180)
		$newPar:=WP Text range:C1341($WParea; $rangeEnd.end; $rangeEnd.end)  // this is start of new parapgraph
		// we should clear bullets, left right margins and indents
		WP SET ATTRIBUTES:C1342($newPar; wk text indent:K81:52; 0; wk margin left:K81:11; 0; wk margin right:K81:12; 0; wk list style type:K81:55; wk none:K81:91)
		$newRangeEndPos:=WP Get position:C1577(WP Text range:C1341($rangeEnd; wk end text:K81:164; wk end text:K81:164); wk 4D Write Pro layout:K81:176)
		If ($newRangeEndPos.page=$RangeEndPos.page)
			//still on same page - add one more linefeed
			WP SET TEXT:C1574($rangeEnd; "\r"; wk append:K81:179; wk include in range:K81:180)
			$newRangeEndPos:=WP Get position:C1577(WP Text range:C1341($rangeEnd; wk end text:K81:164; wk end text:K81:164); wk 4D Write Pro layout:K81:176)
		End if 
		$range:=WP Text range:C1341($WParea; wk start text:K81:165; wk end text:K81:164)  //all of previuus text
	End if 
	
End if 

If ($Title#"")
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
	
End if 

$RangeStart:=WP Text range:C1341($range; wk end text:K81:164; wk end text:K81:164)

ST SET ATTRIBUTES:C1093($TextToAdd; ST Start text:K78:15; ST End text:K78:16; Attribute font name:K65:5; "Arial"; Attribute text size:K65:6; 11)
$new:=WP New:C1317($TextToAdd)
//$TextToAddRange:=WP Text range($new;wk start text;wk end text)
//WP SET TEXT($TextToAddRange;$TextToAdd;wk replace)
//make sure the text added is arial family and size 11
$TextToAddRange:=WP Text range:C1341($new; wk start text:K81:165; wk end text:K81:164)
WP SET ATTRIBUTES:C1342($TextToAddRange; wk font family:K81:65; "Arial"; wk font size:K81:66; 11)

WP INSERT DOCUMENT:C1411($range; $new; wk append:K81:179; wk include in range:K81:180)
WP SET ATTRIBUTES:C1342($range; wk font family:K81:65; "Arial"; wk font size:K81:66; 11; wk line height:K81:51; "100%")

$bookmarkRange:=WP Text range:C1341($WParea; $RangeStart.start+1; $range.end)
$rangeEnd:=WP Text range:C1341($WParea; $bookmarkRange.start; $bookmarkRange.start)
$RemarksStartPos:=WP Get position:C1577($rangeEnd; wk 4D Write Pro layout:K81:176)

If ($Title#"")
	
	If ($RemarksStartPos.page>$titleStartPos.page)
		//remarks start in a page after the title
		//should insert a page break before the title
		WP INSERT BREAK:C1413($titleRange; wk page break:K81:188; wk prepend:K81:178; wk exclude from range:K81:181)
	End if 
	
End if 

If (Count parameters:C259>3)
	C_TEXT:C284($indent)
	$indent:=$4
	WP SET ATTRIBUTES:C1342($bookmarkRange; wk text indent:K81:52; $indent)
	C_COLLECTION:C1488($paragraphs)
	C_OBJECT:C1216($par)
	C_TEXT:C284($paragraph_txt)
	$paragraphs:=WP Get elements:C1550($bookmarkRange; wk type paragraph:K81:191)
	For each ($par; $paragraphs)
		$paragraph_txt:=WP Get text:C1575($par; wk expressions as value:K81:255)
		
		Case of 
			: ($paragraph_txt="Sketch @")
			: ($paragraph_txt="Chart @")
			: ($paragraph_txt="Photo @")
			Else 
				WP SET ATTRIBUTES:C1342($par; wk margin left:K81:11; Replace string:C233($indent; "-"; ""))
		End case 
		
	End for each 
End if 

//End INSP_AddTextToArea_WP