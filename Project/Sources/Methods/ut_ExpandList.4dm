//%attributes = {"invisible":true}
If (False:C215)
	//ut_ExpandList proc
	//Expand all levels of an Hierarchical list
	//Usage :
	//ut_ExpandList(listPtr) 
	//Where :
	//listPtr : pointer to a process or global list variable.
	//example :
	//C_longint(hList)
	//ut_ExpandList(->hList)
End if 

C_POINTER:C301($1; $List)
C_LONGINT:C283($ItemCount; $ItemNum; $ItemRef; $SubList)
C_TEXT:C284($ItemText)
C_BOOLEAN:C305($Expanded; $Done)

$List:=$1

If (Is a list:C621($List->))
	Repeat 
		$Done:=True:C214
		$ItemCount:=Count list items:C380($List->)
		For ($ItemNum; 1; $ItemCount)
			GET LIST ITEM:C378($List->; $ItemNum; $itemRef; $ItemText; $SubList; $Expanded)
			If ($SubList#0)
				If (Not:C34($Expanded))
					SET LIST ITEM:C385($List->; $itemRef; $ItemText; $ItemRef; $SubList; True:C214)
					$Done:=False:C215
				End if 
			End if 
		End for 
	Until ($Done)
	REDRAW:C174($List->)  // Command Replaced was o_REDRAW LIST //<--- Added
End if 