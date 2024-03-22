C_TEXT:C284($ZoneName)
$ZoneName:="RTA_Text"  // change THIS if you change the name of the area

C_LONGINT:C283($StartSel; $EndSel)
C_TEXT:C284($FontName)

C_POINTER:C301($PtrPopFontNames)
C_POINTER:C301($PtrRichTextArea)

$PtrRichTextArea:=OBJECT Get pointer:C1124(Object named:K67:5; $ZoneName)
If (Not:C34(Is nil pointer:C315($PtrRichTextArea)))
	
	$PtrPopFontNames:=OBJECT Get pointer:C1124(Object current:K67:2)
	
	Case of 
		: (Form event code:C388=On Load:K2:1)
			
			FONT LIST:C460($PtrPopFontNames->)
			$PtrPopFontNames->{0}:="-"
			
		: (Form event code:C388=On Data Change:K2:15)
			C_LONGINT:C283($indx)
			$indx:=$PtrPopFontNames->
			$FontName:=$PtrPopFontNames->{$indx}
			GET HIGHLIGHT:C209($PtrRichTextArea->; $StartSel; $EndSel)
			ST SET ATTRIBUTES:C1093($PtrRichTextArea->; $StartSel; $EndSel; Attribute font name:K65:5; $FontName)
			
	End case 
	
End if 
