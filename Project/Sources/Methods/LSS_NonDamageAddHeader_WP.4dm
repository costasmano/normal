//%attributes = {"invisible":true}
//Method: LSS_NonDamageAddHeader_WP
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/28/21, 19:22:54
	// ----------------------------------------------------
	//Created : 
	Mods_2021_WP
	C_OBJECT:C1216(LSS_NonDamageAddHeader_WP; $1)
	C_TEXT:C284(LSS_NonDamageAddHeader_WP; $2)
	C_BOOLEAN:C305(LSS_NonDamageAddHeader_WP; $3)
	C_LONGINT:C283(LSS_NonDamageAddHeader_WP; $4)
	
	// Modified by: Costas Manousakis-(Designer)-(2022-04-29 12:10:14)
	Mods_2022_04
	//  `When adding element text - first create a WP New, then use WP SET Text - Corrects failed WP import message
	// Modified by: Costas Manousakis-(Designer)-(2022-05-05 12:07:44)
	Mods_2022_05
	//  `after adding the text make sure line height is 100%
End if 
//
//STILLWORKINGONTHIS:=True
C_OBJECT:C1216($1; $CommentsArea)
C_LONGINT:C283($4; $i; $StartPages_L; $vlStartSel; $CommentArea_L; $StartSelection_L; $EndSelection_L; $PagesAfterInsert_L; $vlCol; $vlLine; $vlPos; $Loop_L)
$Loop_L:=$4
$CommentsArea:=$1
C_TEXT:C284($2; $TextToAdd_txt)
$TextToAdd_txt:=$2

C_BOOLEAN:C305($3; $InHeader_B)
$InHeader_B:=$3

C_OBJECT:C1216($new; $range; $TextToAddRange)
C_OBJECT:C1216($endPos; $titlePos; $SectionPos; $RangeStart; $rangeEnd; $bookmarkRange; $newPar)
C_OBJECT:C1216($titleStartPos; $titleRange; $RemarksStartPos; $indxRange; $RangeEndPos; $newRangeEndPos)

C_OBJECT:C1216($new)

$range:=WP Text range:C1341($CommentsArea; wk start text:K81:165; wk end text:K81:164)
$rangeEnd:=WP Text range:C1341($CommentsArea; wk end text:K81:164; wk end text:K81:164)  // the end of text
$RangeEndPos:=WP Get position:C1577($rangeEnd; wk 4D Write Pro layout:K81:176)  //location of end of text

If ($InHeader_B)
	//add the header with two spaces before
	
	WP SET TEXT:C1574($rangeEnd; "\r"; wk append:K81:179; wk include in range:K81:180)
	$newPar:=WP Text range:C1341($CommentsArea; $rangeEnd.end; $rangeEnd.end)  // this is start of new parapgraph
	// we should clear bullets, left right margins and indents
	WP SET ATTRIBUTES:C1342($newPar; wk text indent:K81:52; 0; wk margin left:K81:11; 0; wk margin right:K81:12; 0; wk list style type:K81:55; wk none:K81:91)
	$newRangeEndPos:=WP Get position:C1577(WP Text range:C1341($rangeEnd; wk end text:K81:164; wk end text:K81:164); wk 4D Write Pro layout:K81:176)
	If ($newRangeEndPos.page=$RangeEndPos.page)
		//still on same page - add one more linefeed
		WP SET TEXT:C1574($rangeEnd; "\r"; wk append:K81:179; wk include in range:K81:180)
		$newRangeEndPos:=WP Get position:C1577(WP Text range:C1341($rangeEnd; wk end text:K81:164; wk end text:K81:164); wk 4D Write Pro layout:K81:176)
		If ($newRangeEndPos.page=$RangeEndPos.page)
			WP SET TEXT:C1574($rangeEnd; "\r"; wk append:K81:179; wk include in range:K81:180)
			$newRangeEndPos:=WP Get position:C1577(WP Text range:C1341($rangeEnd; wk end text:K81:164; wk end text:K81:164); wk 4D Write Pro layout:K81:176)
		End if 
	End if 
	$range:=WP Text range:C1341($CommentsArea; wk start text:K81:165; wk end text:K81:164)  //all of previuus text
	
	ST SET ATTRIBUTES:C1093($TextToAdd_txt; ST Start text:K78:15; ST End text:K78:16; Attribute bold style:K65:1; 1; \
		Attribute underline style:K65:4; 1; Attribute font name:K65:5; "Arial"; \
		Attribute text size:K65:6; 11)
	$new:=WP New:C1317($TextToAdd_txt)
	$RangeStart:=WP Text range:C1341($range; wk end text:K81:164; wk end text:K81:164)
	$titleStartPos:=WP Get position:C1577($RangeStart; wk 4D Write Pro layout:K81:176)
	WP INSERT DOCUMENT:C1411($range; $new; wk append:K81:179; wk include in range:K81:180)
	
	$rangeEnd:=WP Text range:C1341($range; wk end text:K81:164; wk end text:K81:164)
	
Else 
	
	WP SET TEXT:C1574($rangeEnd; "\r"; wk append:K81:179; wk include in range:K81:180)
	$newPar:=WP Text range:C1341($CommentsArea; $rangeEnd.end; $rangeEnd.end)  // this is start of new parapgraph
	// we should clear bullets, left right margins and indents
	WP SET ATTRIBUTES:C1342($newPar; wk text indent:K81:52; 0; wk margin left:K81:11; 0; wk margin right:K81:12; 0; wk list style type:K81:55; wk none:K81:91)
	$newRangeEndPos:=WP Get position:C1577(WP Text range:C1341($rangeEnd; wk end text:K81:164; wk end text:K81:164); wk 4D Write Pro layout:K81:176)
	If ($newRangeEndPos.page=$RangeEndPos.page)
		//still on same page - add one more linefeed
		WP SET TEXT:C1574($rangeEnd; "\r"; wk append:K81:179; wk include in range:K81:180)
		$newRangeEndPos:=WP Get position:C1577(WP Text range:C1341($rangeEnd; wk end text:K81:164; wk end text:K81:164); wk 4D Write Pro layout:K81:176)
	End if 
	$range:=WP Text range:C1341($CommentsArea; wk start text:K81:165; wk end text:K81:164)  //all of previuus text
	//$TextToAdd_txt:=$TextToAdd_txt+"\r" ` no need to add a linefeed
	ST SET ATTRIBUTES:C1093($TextToAdd_txt; ST Start text:K78:15; ST End text:K78:16; Attribute bold style:K65:1; 1; \
		Attribute font name:K65:5; "Arial"; \
		Attribute text size:K65:6; 11)
	$new:=WP New:C1317($TextToAdd_txt)
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
	
	$new:=WP New:C1317
	//make sure the text added is arial family and size 11
	$TextToAddRange:=WP Text range:C1341($new; wk start text:K81:165; wk end text:K81:164)
	WP SET TEXT:C1574($TextToAddRange; LSS_ElementRemarks_atxt{$Loop_L}; wk replace:K81:177; wk include in range:K81:180)
	WP SET ATTRIBUTES:C1342($TextToAddRange; wk font family:K81:65; "Arial"; wk font size:K81:66; 11)
	
	WP INSERT DOCUMENT:C1411($range; $new; wk append:K81:179; wk include in range:K81:180)
	WP SET ATTRIBUTES:C1342($range; wk font family:K81:65; "Arial"; wk font size:K81:66; 11; wk line height:K81:51; "100%")
	
	$bookmarkRange:=WP Text range:C1341($range; $RangeStart.start+1; $range.end)
	$rangeEnd:=WP Text range:C1341($range; $bookmarkRange.start; $bookmarkRange.start)
	$RemarksStartPos:=WP Get position:C1577($rangeEnd; wk 4D Write Pro layout:K81:176)
	
	If ($RemarksStartPos.page>$titleStartPos.page)
		//remarks start in a page after the title
		//should insert a page break before the title
		WP INSERT BREAK:C1413($titleRange; wk page break:K81:188; wk prepend:K81:178; wk exclude from range:K81:181)
	End if 
	
End if 

//End LSS_NonDamageAddHeader_WP