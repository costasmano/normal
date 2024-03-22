//%attributes = {"invisible":true}
//GP OUTPUT_ERRORS
//Copyright © 1997, Thomas D. Nee, All Rights Reserved.

//Append a list of errors to the specified document.

C_LONGINT:C283($2; $ErrCode; $ErrValue)  //Command Replaced was o_C_INTEGER
C_TEXT:C284($3; $ErrGroup)  // Command Replaced was o_C_STRING length was 20
C_TIME:C306($1; $dImportRpt)
$dImportRpt:=$1  //The document reference.
$ErrCode:=$2  //The error code to be parsed.
$ErrGroup:=$3  //The name of the error group.

C_LONGINT:C283($recs; $i; $j)  //Command Replaced was o_C_INTEGER
C_TEXT:C284($text)

QUERY:C277([Error Codes:58]; [Error Codes:58]Err Group Name:1=$ErrGroup)
$recs:=Records in selection:C76([Error Codes:58])
If ($recs>0)
	ARRAY INTEGER:C220($aBit; 0)
	ARRAY TEXT:C222($aLevel; 0)  //Command Replaced was o_ARRAY string length was 20
	ARRAY TEXT:C222($aDescr; 0)
	SELECTION TO ARRAY:C260([Error Codes:58]Err Bit:2; $aBit; [Error Codes:58]Err Level:4; $aLevel; [Error Codes:58]Err Description:3; $aDescr)
	SORT ARRAY:C229($aBit; $aLevel; $aDescr)
	
	$j:=0
	ARRAY TEXT:C222($aText; 0)
	For ($i; $recs; 1; -1)
		//Record the errors from highest to lowest.    
		If ($aBit{$i}#$i)
			$text:="There is an error in the records for error group "+$ErrGroup+".  "
			$text:=$text+"Call DB Administrator.   Rec:"+String:C10($i)+"   Bit:"+String:C10($aBit{$i})+<>sCR
			SEND PACKET:C103($dImportRpt; $text)
		End if 
		$ErrValue:=BinErr($i)
		If ($ErrCode>=$ErrValue)
			//Record the error.
			$j:=$j+1
			INSERT IN ARRAY:C227($aText; $j)
			$aText{$j}:=<>sTAB+$aLevel{$i}+<>sTAB+String:C10($i; "00")+<>sTAB+$aDescr{$i}+<>sCR
			$ErrCode:=$ErrCode-$ErrValue
		End if 
	End for 
	
	For ($i; $j; 1; -1)
		//Reverse; output the errors from lowest to highest. 
		SEND PACKET:C103($dImportRpt; $aText{$i})
	End for 
	
	If ($ErrCode>0)
		$text:="The error code for error group "+$ErrGroup+" did not process completely.  "
		$text:=$text+"Call Tom Nee.   Remainder:"+String:C10($ErrCode)+<>sCR
		SEND PACKET:C103($dImportRpt; $text)
	End if 
	
End if 