//%attributes = {"invisible":true}
//G_CountCritPages 
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
	C_LONGINT:C283($recnum)
	SET QUERY DESTINATION:C396(Into variable:K19:4; $recnum)
	QUERY SELECTION:C341([ElementsSafety:29]; [ElementsSafety:29]Rating:2#"N")
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	C_LONGINT:C283(viNumPg1s)  //Command Replaced was o_C_INTEGER
	C_LONGINT:C283(viNumCmtsPgs; viCmtsPgStart; viSkPgStart; viChPgStart; viPhPgStart)  //Command Replaced was o_C_INTEGER
	C_LONGINT:C283(viNumSkPgs; viNumChPgs; viNumPhPgs)  //Command Replaced was o_C_INTEGER
	$recnum:=Records in selection:C76([ElementsSafety:29])
	viNumPg1s:=-(Trunc:C95(-($recnum/5); 0))
	//Comments pages
	viNumCmtsPgs:=INSP_PrintComments_WP(New object:C1471("printFlag"; False:C215))
	viCmtsPgStart:=viNumPg1s+1
	G_CountInspImagePgs
	vTotalPages:=viNumPg1s+viNumCmtsPgs+viNumSkPgs+viNumChPgs+viNumPhPgs
	INSP_PageCountDone_b:=True:C214
End if 