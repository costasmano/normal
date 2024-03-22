//%attributes = {"invisible":true}
//G_ResortImages 

C_LONGINT:C283($1; $2)
C_TEXT:C284($3)  // Command Replaced was o_C_STRING length was 2

C_LONGINT:C283($oldv; $newv; $slide; $nphotos; $currID; $i; $k; $nphotos)
C_TEXT:C284($CurrType)  // Command Replaced was o_C_STRING length was 2

$newv:=$1
$currID:=$2
$CurrType:=$3

$nphotos:=Records in selection:C76([Standard Photos:36])
If ($nphotos>0)
	ARRAY TEXT:C222($asPicType; $nphotos)  //Command Replaced was o_ARRAY string length was 2
	ARRAY LONGINT:C221($alPhIDs; $nphotos)
	ARRAY LONGINT:C221($alAllPhIDs; $nphotos)
	ARRAY INTEGER:C220($alSeqnos; $nphotos)
	ARRAY INTEGER:C220($alOLDSeqnos; $nphotos)
	C_LONGINT:C283($nothers)
	SELECTION TO ARRAY:C260([Standard Photos:36]PictType:5; $asPicType; [Standard Photos:36]StdPhotoID:7; $alPhIDs; [Standard Photos:36]SeqNum:6; $alSeqnos)
	SELECTION TO ARRAY:C260([Standard Photos:36]StdPhotoID:7; $alAllPhIDs)
	SELECTION TO ARRAY:C260([Standard Photos:36]SeqNum:6; $alOLDSeqnos)
	For ($i; $nphotos; 1; -1)
		Case of 
			: ($asPictype{$i}#$currType)
				DELETE FROM ARRAY:C228($asPicType; $i)
				DELETE FROM ARRAY:C228($alPhIDs; $i)
				DELETE FROM ARRAY:C228($alSeqnos; $i)
				DELETE FROM ARRAY:C228($alOLDSeqnos; $i)
			: ($alPhIDs{$i}=$currID)
				DELETE FROM ARRAY:C228($asPicType; $i)
				DELETE FROM ARRAY:C228($alPhIDs; $i)
				DELETE FROM ARRAY:C228($alSeqnos; $i)
				DELETE FROM ARRAY:C228($alOLDSeqnos; $i)
		End case 
	End for 
	If (Size of array:C274($alPhIDs)>0)
		SORT ARRAY:C229($alSeqnos; $alPhIDs; $alOLDSeqnos)
		If ($newv>0)
			INSERT IN ARRAY:C227($alSeqnos; $newv)
			INSERT IN ARRAY:C227($alPhIDs; $newv)
			INSERT IN ARRAY:C227($alOLDSeqnos; $newv)
			If ($newv>Size of array:C274($alSeqnos))
				$newv:=Size of array:C274($alSeqnos)
			End if 
			$alSeqnos{$newv}:=$newv
			$alOLDSeqnos{$newv}:=$newv
			$alPhIDs{$newv}:=$currID
		End if 
		$nothers:=Size of array:C274($alSeqnos)
		For ($i; 1; $nothers)
			$alSeqnos{$i}:=$i
		End for 
		For ($i; $nothers; 1; -1)
			If ($alSeqnos{$i}=$alOLDSeqnos{$i})
				DELETE FROM ARRAY:C228($alPhIDs; $i)
				DELETE FROM ARRAY:C228($alSeqnos; $i)
				DELETE FROM ARRAY:C228($alOLDSeqnos; $i)
			End if 
		End for 
		For ($i; 1; Size of array:C274($alPhIDs))
			$k:=Find in array:C230($alAllPhIDs; $alPhIDs{$i})
			If ($k>0)
				GOTO SELECTED RECORD:C245([Standard Photos:36]; $k)
				[Standard Photos:36]SeqNum:6:=$alSeqnos{$i}
				LogChanges(->[Standard Photos:36]SeqNum:6; ->[Inspections:27]InspID:2; ->[Standard Photos:36]InspID:1; ->[Standard Photos:36]StdPhotoID:7; 2)
				SAVE RECORD:C53([Standard Photos:36])
			End if 
		End for 
	End if   //array size($alPhIDs) >0
End if   //$nphotos>0