POPUPMENUC(->aElementCat_; ->aElementCatCode_; ->[ElementDict:30]Category:3)
If (Form event code:C388=On Clicked:K2:4)
	PushChange(1; ->[ElementDict:30]Category:3)
	If (aParentCat_{aParent_}#aElementCatCode_{aElementCat_})
		//This category is not the same as the parent. Reset the parent to none.
		aParent_:=1
		[ElementDict:30]Parent:4:=0
		PushChange(1; ->[ElementDict:30]Parent:4)
	End if 
End if 