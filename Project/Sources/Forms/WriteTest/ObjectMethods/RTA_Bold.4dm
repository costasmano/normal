C_TEXT:C284($ZoneName)
$ZoneName:="RTA_Text"  // change THIS if you change the name of the area


C_LONGINT:C283($StartSel; $EndSel)

C_POINTER:C301($PtrButton)
C_LONGINT:C283($Value)
C_POINTER:C301($PtrRichTextArea)

$PtrRichTextArea:=OBJECT Get pointer:C1124(Object named:K67:5; $ZoneName)
If (Not:C34(Is nil pointer:C315($PtrRichTextArea)))
	
	$PtrButton:=Self:C308
	$Value:=$PtrButton->
	
	If ($Value=2)
		$Value:=0
		$PtrButton->:=$Value
	End if 
	
	GET HIGHLIGHT:C209($PtrRichTextArea->; $StartSel; $EndSel)
	ST SET ATTRIBUTES:C1093($PtrRichTextArea->; $StartSel; $EndSel; Attribute bold style:K65:1; $Value)
	
End if 