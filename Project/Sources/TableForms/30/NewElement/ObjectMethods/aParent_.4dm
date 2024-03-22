C_LONGINT:C283($vlElem)

POPUPMENUC(->aParent_; ->aParentCode_; ->[ElementDict:30]Parent:4)
If (Form event code:C388=On Clicked:K2:4)
	PushChange(1; ->[ElementDict:30]Parent:4)
	If (aParentCode_{aParent_}#0)
		//Adjust the element category code to match the parent    
		For ($vlElem; 1; Size of array:C274(aElementCatCode_))
			If (aElementCatCode_{$vlElem}=aParentCat_{aParent_})
				aElementCat_:=$vlElem
				[ElementDict:30]Category:3:=aElementCatCode_{$vlElem}
				PushChange(1; ->[ElementDict:30]Category:3)
			End if 
		End for 
	End if 
End if 