//%attributes = {"invisible":true}
//G_CountRTNInspPgs
//Count pages for a Routine or Routine Arch inspection

If (False:C215)
	//Check if it is a combo inspection
	Mods_2005_CM01
	// Modified by: Costas Manousakis-(Designer)-(5/2/13 17:02:37)
	Mods_2013_05
	//  `Added Tunnel case and short message 
	// Modified by: Costas Manousakis-(Designer)-(9/9/13 16:20:29)
	Mods_2013_09
	//  `call Print_Tunnel_Cmts for both TAL and TOV inspections
	// Modified by: Costas Manousakis-(Designer)-(10/22/13 11:15:14)
	Mods_2013_10
	//  `added flag that pages were counted -  count if the inspection is open for editing
	//  `or is locked and it has not been counted yet
	// Modified by: Costas Manousakis-(Designer)-(1/28/21 18:34:59)
	Mods_2021_WP
	//  `WRITE PRO
End if 

G_Insp_RelateInsp(->[ElementsSafety:29]InspID:4; ->[Standard Photos:36]InspID:1; ->[Field Trip:43]InspID:1)

If (Not:C34(vbInspectionLocked) | (vbInspectionLocked & Not:C34(INSP_PageCountDone_b)))
	SHORT_MESSAGE("Counting Pages")
	
	C_LONGINT:C283(viNumCmtsPgs; viCmtsPgStart; viSkPgStart; viChPgStart; viPhPgStart)  //Command Replaced was o_C_INTEGER
	C_LONGINT:C283(viNumSkPgs; viNumChPgs; viNumPhPgs; viNumSpMPages)  //Command Replaced was o_C_INTEGER
	
	viNumSpMPages:=G_CountInspSpecMPgs
	
	If ([Inspections:27]Insp Type:6="T@")
		viNumCmtsPgs:=Print_Tunnel_Cmts_WP(New object:C1471("printFlag"; False:C215))  // need to call it to set page numbers straight
	Else 
		viNumCmtsPgs:=Print_RTN_Cmts_WP(New object:C1471("printFlag"; False:C215))  //don't print
	End if 
	viCmtsPgStart:=2+viNumSpMPages+1
	G_CountInspImagePgs
	vTotalPages:=2+viNumSpMPages+viNumCmtsPgs+viNumSkPgs+viNumChPgs+viNumPhPgs
	
	INSP_PageCountDone_b:=True:C214
	
	CLOSE WINDOW:C154
End if 