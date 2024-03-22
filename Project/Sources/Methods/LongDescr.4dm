//%attributes = {"invisible":true}
//GP LongDescr
//Copyright © 1996, Thomas D. Nee, All Rights Reserved.
//Returns a string joining the full element name and  the following three fields:
//     Element description
//     Category note
//     Common note

C_TEXT:C284($Descr; $0)

$Descr:=LongName

If ([BMS Elements:47]Elem Descript:5#"")
	$Descr:=$Descr+Char:C90(13)+Char:C90(13)+[BMS Elements:47]Elem Descript:5  //not blank
End if 

If ([BMS Categories:49]Cat Note:4#"")
	$Descr:=$Descr+Char:C90(13)+Char:C90(13)+[BMS Categories:49]Cat Note:4
End if 

If ([Common Notes:54]Common Note:2#"")
	$Descr:=$Descr+Char:C90(13)+Char:C90(13)+[Common Notes:54]Common Note:2
End if 

$0:=$Descr