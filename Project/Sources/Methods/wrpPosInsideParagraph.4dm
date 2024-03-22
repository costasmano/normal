//%attributes = {"invisible":true}
//Method: wrpPosInsideParagraph
//Description
// return if a position is inside a paragraph
// Parameters
// $1 : $pos
// $2 : $ColParagraphStartEnd
// $0 : $InParagraph_b

// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/05/21, 17:46:55
	// ----------------------------------------------------
	
	C_LONGINT:C283(wrpPosInsideParagraph; $1)
	C_COLLECTION:C1488(wrpPosInsideParagraph; $2)
	C_BOOLEAN:C305(wrpPosInsideParagraph; $0)
End if 
//
C_LONGINT:C283($pos; $1)
C_COLLECTION:C1488($parStartEnd; $2)
C_BOOLEAN:C305($InParagraph_b; $0)
$InParagraph_b:=False:C215
C_OBJECT:C1216($parlimit)
$pos:=$1
C_LONGINT:C283($parStart; $parEnd)
For each ($parlimit; $2)
	
	If ($pos>$parlimit.start) & ($pos<$parlimit.end)
		$InParagraph_b:=True:C214
	End if 
	
End for each 

$0:=$InParagraph_b

//End wrpPosInsideParagraph