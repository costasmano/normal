//%attributes = {"invisible":true}
//G_CountCulvInspPgs
If (False:C215)
	//Count Culvert Inspection Pages
	Mods_2005_CM01
	// Modified by: Costas Manousakis-(Designer)-(10/22/13 11:15:14)
	Mods_2013_10
	//  `added flag that pages were counted -  count if the inspection is open for editing
	//  `or is locked and it has not been counted yet
	// Modified by: Costas Manousakis-(Designer)-(1/28/21 18:27:55)
	Mods_2021_WP
	//  `WRITE PRO
End if 

G_Insp_RelateInsp(->[ElementsSafety:29]InspID:4; ->[Standard Photos:36]InspID:1; ->[Field Trip:43]InspID:1)

If (Not:C34(vbInspectionLocked) | (vbInspectionLocked & Not:C34(INSP_PageCountDone_b)))
	C_LONGINT:C283(viNumCmtsPgs; viCmtsPgStart; viSkPgStart; viChPgStart; viPhPgStart)  //Command Replaced was o_C_INTEGER
	C_LONGINT:C283(viNumSkPgs; viNumChPgs; viNumPhPgs; viNumSpMPages)  //Command Replaced was o_C_INTEGER
	viNumCmtsPgs:=Print_CUL_Cmts_WP(New object:C1471("printFlag"; False:C215))  //dont'print
	If (viNumCmtsPgs=0)
		viNumCmtsPgs:=1  //at least one page
	End if 
	
	//Check if it is a combo inspection
	viNumSpMPages:=G_CountInspSpecMPgs
	
	viCmtsPgStart:=1+viNumSpMPages+1
	G_CountInspImagePgs
	vTotalPages:=1+viNumSpMPages+viNumCmtsPgs+viNumSkPgs+viNumChPgs+viNumPhPgs
	
	INSP_PageCountDone_b:=True:C214
End if 