C_TEXT:C284($ZoneName)
$ZoneName:="RTA_Text"  // change THIS if you change the name of the area

C_LONGINT:C283($StartSel; $EndSel)
C_POINTER:C301($PtrRichTextArea)
C_TEXT:C284($URL; $SelectedText)

$PtrRichTextArea:=OBJECT Get pointer:C1124(Object named:K67:5; $ZoneName)

If (Not:C34(Is nil pointer:C315($PtrRichTextArea)))
	
	Case of 
			
		: (Form event code:C388=On Load:K2:1)
			
		: (Form event code:C388=On Clicked:K2:4)
			
			GET HIGHLIGHT:C209($PtrRichTextArea->; $StartSel; $EndSel)
			
			$URL:=Request:C163("URL ?")
			If (ok=1)
				If ($StartSel<$EndSel)
					$SelectedText:=ST Get text:C1116($PtrRichTextArea->; $StartSel; $EndSel)
					$SelectedText:=ST Get plain text:C1092($SelectedText)
				Else 
					$SelectedText:=""
				End if 
				ST INSERT URL:C1280($PtrRichTextArea->; $SelectedText; $URL; $StartSel; $EndSel)
				ST SET ATTRIBUTES:C1093($PtrRichTextArea->; $StartSel; $StartSel+1; Attribute underline style:K65:4; 1)
			End if 
			
		: (Form event code:C388=On Unload:K2:2)
			
	End case 
	
End if 