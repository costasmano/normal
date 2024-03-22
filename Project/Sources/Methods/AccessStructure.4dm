//%attributes = {"invisible":true}


//GP: AccessStructure
//Use this procedure to get information about the structure
If (False:C215)
	Mods_2012_12  //r001 ` check if field number valid
	//Modified by: Charles Miller (12/18/12 12:22:45)
End if 
C_LONGINT:C283($FileNo; $i; $size)
C_TEXT:C284(vFieldNo; vFileNo)  // Command Replaced was o_C_STRING length was 255

$FileNo:=1
$size:=Get last field number:C255($FileNo)
ARRAY TEXT:C222(aFieldName; $size)  //Command Replaced was o_ARRAY string length was 255
ARRAY LONGINT:C221(aFieldNo; $size)
For ($i; $size; 1; -1)
	If (Is field number valid:C1000($FileNo; $i))
		aFieldName{$i}:=Field name:C257($FileNo; $i)
		aFieldNo{$i}:=$i
	Else 
		DELETE FROM ARRAY:C228(aFieldName; $i; 1)
		DELETE FROM ARRAY:C228(aFieldNo; $i; 1)
	End if 
End for 
CENTER_WINDOW(350; 210)
vFileNo:="Field Numbers for file "+String:C10($FileNo)
DIALOG:C40([Dialogs:21]; "Structure View")