//%attributes = {"invisible":true}
If (False:C215)
	//G_InspElmtCatPopup 
	//Method for Pop up menu to control the visible elements.
	Mods_2004_CM12
	Mods_2005_CM01
	// Modified by: Costas Manousakis-(Designer)-(12/28/12 17:02:26)
	Mods_2012_12
	//  `Use new method Insp_SortElmtSfty
End if 

If ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Clicked:K2:4))
	POPUPMENUC(->aInspType_; ->aInspCod_; ->CurCat)
	If (Form event code:C388=On Clicked:K2:4)
		COPY NAMED SELECTION:C331([Standard Photos:36]; "StdPhotosSel")
		G_Insp_RelateInsp(->[ElementsSafety:29]InspID:4)
		
		If (CurCat#"ALL")
			QUERY SELECTION:C341([ElementsSafety:29]; [ElementDict:30]Category:3=CurCat)
		End if 
		USE NAMED SELECTION:C332("StdPhotosSel")
		CLEAR NAMED SELECTION:C333("StdPhotosSel")
	End if 
	
	Insp_SortElmtSfty([Inspections:27]Insp Type:6)
	
	G_Insp_ElmtArray_setup
End if 