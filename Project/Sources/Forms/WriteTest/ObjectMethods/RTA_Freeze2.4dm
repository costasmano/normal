C_TEXT:C284($ZoneName)
$ZoneName:="RTA_Text"  // change THIS if you change the name of the area

C_LONGINT:C283($StartSel; $EndSel)
C_POINTER:C301($PtrRichTextArea)

$PtrRichTextArea:=OBJECT Get pointer:C1124(Object named:K67:5; $ZoneName)

If (Not:C34(Is nil pointer:C315($PtrRichTextArea)))  //& (Not(Nil($PtrColorMenuRef)))
	
	Case of 
			
		: (Form event code:C388=On Load:K2:1)
			
		: (Form event code:C388=On Clicked:K2:4)
			
			ST FREEZE EXPRESSIONS:C1282($PtrRichTextArea->; 1)
			
		: (Form event code:C388=On Unload:K2:2)
			
	End case 
	
End if 