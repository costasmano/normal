If (Form event code:C388=On Display Detail:K2:22)
	C_TEXT:C284(vImgType; vImageDescr)
	vImgType:=Get_Description(->aPictType; ->aPictCode; ->[Standard Photos:36]PictType:5)
	vImageDescr:=[Standard Photos:36]Description:2
	vImageDescr:=Replace string:C233(vImageDescr; <>sCR; "_")
	If (vbInspectionLocked)
		//disable entry if inspection is locked
		OBJECT SET ENTERABLE:C238(*; "DE@"; False:C215)
	Else 
		//otherwise make sure they are enterable    
		OBJECT SET ENTERABLE:C238(*; "DE@"; True:C214)
	End if 
	
End if 