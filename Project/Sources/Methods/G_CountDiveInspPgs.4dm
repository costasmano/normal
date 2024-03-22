//%attributes = {"invisible":true}
//G_CountDiveInspPgs 

If (False:C215)
	
	// Modified by: Costas Manousakis-(Designer)-(10/22/13 11:15:14)
	Mods_2013_10
	//  `added flag that pages were counted -  count if the inspection is open for editing
	//  `or is locked and it has not been counted yet
	// Modified by: Costas Manousakis-(Designer)-(1/28/21 18:34:59)
	Mods_2021_WP
	//  `WRITE PRO
End if 
If (Not:C34(vbInspectionLocked) | (vbInspectionLocked & Not:C34(INSP_PageCountDone_b)))
	C_LONGINT:C283(viNumCmtsPgs; viCmtsPgStart; viSkPgStart; viChPgStart; viPhPgStart)  //Command Replaced was o_C_INTEGER
	C_LONGINT:C283(viNumSkPgs; viNumChPgs; viNumPhPgs)  //Command Replaced was o_C_INTEGER
	viCmtsPgStart:=2
	
	//Comments pages
	viNumCmtsPgs:=INSP_PrintComments_WP(New object:C1471("printFlag"; False:C215))
	
	G_CountInspImagePgs
	vTotalPages:=1+viNumCmtsPgs+viNumSkPgs+viNumChPgs+viNumPhPgs
	INSP_PageCountDone_b:=True:C214
End if 