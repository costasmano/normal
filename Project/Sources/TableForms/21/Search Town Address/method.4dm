// FORM Method: [Dialogs];"Search Town Address"
If (False:C215)
	// Modified by: Costas Manousakis-(Designer)-(3/28/19 13:40:06)
	Mods_2019_03
	//  `added results object ; made all objects except the search var not focusable
	//  `enabled BlankMenu to allow copy/paste
	//  `changed text var for input to a combobox with town name array
End if 

If (Form event code:C388=On Load:K2:1)
	C_BOOLEAN:C305(vAddTo)
	vAddTo:=False:C215
	CBAddTo:=0
	OBJECT SET TITLE:C194(*; "SearchResults"; "")
End if 