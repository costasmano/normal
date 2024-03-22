//%attributes = {"invisible":true}
//Method: wrpGetParagraphsStartEnd
//Description
// get the paragraph start and end positions
// Parameters
// $1 : $wpDoc
// $0 : $colParaStartEnd
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/05/21, 17:26:26
	// ----------------------------------------------------
	
	C_OBJECT:C1216(wrpGetParagraphsStartEnd; $1)
	C_COLLECTION:C1488(wrpGetParagraphsStartEnd; $0)
	
End if 
//
C_OBJECT:C1216($wpDoc; $1)
C_COLLECTION:C1488($colParaStartEnd; $0)

$wpDoc:=OB Copy:C1225($1)
C_OBJECT:C1216($bodySource)
C_COLLECTION:C1488($paragraphs)
$bodySource:=WP Get body:C1516($wpDoc)
$paragraphs:=WP Get elements:C1550($bodySource; wk type paragraph:K81:191)
C_OBJECT:C1216($parRange; $startEnd; $par)
$colParaStartEnd:=New collection:C1472
For each ($par; $paragraphs)
	$parRange:=WP Text range:C1341($par; wk start text:K81:165; wk end text:K81:164)
	OB SET:C1220($startEnd; "start"; $parRange.start; "end"; $parRange.end)
	$colParaStartEnd.push(OB Copy:C1225($startEnd))
End for each 

$0:=$colParaStartEnd
//End wrpGetParagraphsStartEnd