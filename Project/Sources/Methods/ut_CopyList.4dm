//%attributes = {"invisible":true}
//CopyList method
//
If (False:C215)
	Mods_2011_06  // CJ Miller`06/14/11, 10:34:03      ` Type all local variables for v11
End if 
C_LONGINT:C283($0; $1)
C_LONGINT:C283($source)
C_LONGINT:C283($copy)
$source:=$1
$copy:=0
If (Is a list:C621($source))
	$copy:=Copy list:C626($source)
	C_LONGINT:C283($ItemCount; $ItemNum; $ItemRef; $SubList)
	C_TEXT:C284($ItemText)
	C_BOOLEAN:C305($Expanded)
	$ItemCount:=Count list items:C380($copy)
	For ($ItemNum; 1; $ItemCount)
		GET LIST ITEM:C378($copy; $ItemNum; $itemRef; $ItemText; $SubList; $Expanded)
		If ($SubList#0)
			C_LONGINT:C283($SubListCopy)
			$SubListCopy:=ut_CopyList($SubList)
			SET LIST ITEM:C385($copy; $itemRef; $ItemText; $ItemRef; $SubListCopy; $Expanded)
		End if 
	End for 
	
End if 
$0:=$copy