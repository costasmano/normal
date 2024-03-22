//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/20/07, 12:35:06
	// ----------------------------------------------------
	// Method: ut_FindInHList
	// Description
	// Find a string in an HList
	// 
	// Parameters
	// $0 : $ListPos
	// $1 : $ListRef
	// $2 : $SearchStr
	// ----------------------------------------------------
	
	Mods_2007_CM_5401
End if 
C_LONGINT:C283($0; $ListPos)
C_LONGINT:C283($1; $ListRef)
C_TEXT:C284($2; $SearchStr)
$ListRef:=$1
$SearchStr:=$2
$ListPos:=0
C_LONGINT:C283($listItems; $hSublist; $vlItemRef; $i)
C_TEXT:C284($vsItemText)
C_BOOLEAN:C305($vbExpanded)
If (Is a list:C621($ListRef))
	If (Count list items:C380($ListRef)>0)
		For ($i; 1; Count list items:C380($ListRef))
			GET LIST ITEM:C378($ListRef; $i; $vlItemRef; $vsItemText; $hSublist; $vbExpanded)
			If (Position:C15($SearchStr; $vsItemText)>0)
				$ListPos:=$i
				$i:=Count list items:C380($ListRef)+1
			End if 
		End for 
	End if 
End if 

$0:=$ListPos