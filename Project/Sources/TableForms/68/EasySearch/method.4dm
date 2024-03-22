If (False:C215)
	Mods_2005_CM05
	// Modified by: Costas Manousakis-(Designer)-(6/22/17 12:48:15)
	Mods_2017_06_bug
	//  `combined the two previous scrollable arrays asFields and asFldTypes into one listbox.
	//  `they were converted into separate listboxes in conversion.
	//  `changed font to Label12Plain
End if 

If (Form event code:C388=On Load:K2:1)
	//_O_PLATFORM PROPERTIES($vPlatform)// MassDOT_PS - conversion v19R7
	If (Is Windows:C1573)
		//adjust Explanation text displays for Windows platform    
		OBJECT SET TITLE:C194(*; "Variable18"; "Starts With(Ctrl-B)")
		OBJECT SET TITLE:C194(*; "Variable19"; "Contains (Ctrl-C)")
		OBJECT SET TITLE:C194(*; "Variable20"; "Does Not Contain (Ctrl-N)")
		OBJECT SET TITLE:C194(*; "Variable21"; "Search Within Selection (Ctrl-S)")
		OBJECT SET TITLE:C194(*; "Variable24"; "Add to Selection (Ctrl-A)")
		OBJECT SET TITLE:C194(*; "Variable13"; "Less or Equal (Alt-<)")
		OBJECT SET TITLE:C194(*; "Variable16"; "Greater or Equal (Alt->)")
		OBJECT SET VISIBLE:C603(*; "Text3"; False:C215)
	End if 
End if 