If (Form event code:C388=On Clicked:K2:4)
	If (Is new record:C668([Templates:86]))
		LogNewRecord(->[Templates:86]TemplateID:1; ->[Templates:86]TemplateID:1; ->[Templates:86]TemplateID:1; 0; "TemplateInc")
	End if 
	//SAVE RECORD([Templates])
End if 