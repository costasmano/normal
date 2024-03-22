
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 12/06/12, 15:18:47
//----------------------------------------------------
//Method: Form Method: [Inspections];"PedBridge_p2"
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2012_12  //r001 ` 
	//Modified by: Charles Miller (12/6/12 15:18:49)
	
	// Modified by: Costas Manousakis-(Designer)-(10/25/19 14:14:59)
	Mods_2019_10_bug
	//  `fixed line work on page 0 
	// Modified by: Costas Manousakis-(Designer)-(2021-11-19T00:00:00 13:03:12)
	Mods_2021_11_bug
	//  `added vNeedAccOther var on form - adjusted width of field [Inspections]AccessOther
	//  `added call to INSP_LoadESForReport ("PED") to account for adding item 61 data.
	//  `added item 61 elements and data ; re arranged item 61 and accessibility blocks
	
End if 
If (Form event code:C388=On Printing Detail:K2:18)
	
	FORM_FixHairLine
	
	vInspTitlePr:=Uppercase:C13(G_Insp_SetTitle)
	vInspTitlePr:=Replace string:C233(vInspTitlePr; "Pedestrian"; "")
	vInspTitlePr:=f_TrimStr(vInspTitlePr; True:C214; True:C214)
	INSP_FormatTitle_new
	
	vPageNo:=vPageNo+1
	
	INSP_LoadESForReport("PED")
	vItem61:=G_ElmtRatingTxt([Inspections:27]Item 61:82)
	vItem61UW:=G_ElmtRatingTxt([Inspections:27]Item 61 UW:72)
	vItem61Cur:=G_ElmtRatingTxt([Inspections:27]Item 61 Cur:159)
	//Check boxes
	f_Var_to_Series([Inspections:27]StreamFlowV:21; "xR"; "THMLN")
	
	vLiftBucket:=Substring:C12([Inspections:27]LiftBucket:86; 2; 1)
	vLadder:=Substring:C12([Inspections:27]Ladder:87; 2; 1)
	vBoat:=Substring:C12([Inspections:27]Boat:88; 2; 1)
	vWader:=Substring:C12([Inspections:27]Wader:89; 2; 1)
	vInspect50:=Substring:C12([Inspections:27]Inspector50:90; 2; 1)
	vRigging:=Substring:C12([Inspections:27]Rigging:91; 2; 1)
	vStaging:=Substring:C12([Inspections:27]Staging:92; 2; 1)
	vTraffic:=Substring:C12([Inspections:27]Traffic Control:93; 2; 1)
	vFlagman:=Substring:C12([Inspections:27]RR Flagman:94; 2; 1)
	vPolice:=Substring:C12([Inspections:27]Police:95; 2; 1)
	vAccOther:=Substring:C12([Inspections:27]OtherAccBool:97; 2; 1)
	
	vNeedLiftBucket:=Substring:C12([Inspections:27]LiftBucket:86; 1; 1)
	vNeedLadder:=Substring:C12([Inspections:27]Ladder:87; 1; 1)
	vNeedBoat:=Substring:C12([Inspections:27]Boat:88; 1; 1)
	vNeedWader:=Substring:C12([Inspections:27]Wader:89; 1; 1)
	vNeedInspect50:=Substring:C12([Inspections:27]Inspector50:90; 1; 1)
	vNeedRigging:=Substring:C12([Inspections:27]Rigging:91; 1; 1)
	vNeedStaging:=Substring:C12([Inspections:27]Staging:92; 1; 1)
	vNeedTraffic:=Substring:C12([Inspections:27]Traffic Control:93; 1; 1)
	vNeedFlagman:=Substring:C12([Inspections:27]RR Flagman:94; 1; 1)
	vNeedPolice:=Substring:C12([Inspections:27]Police:95; 1; 1)
	vNeedAccOther:=Substring:C12([Inspections:27]OtherAccBool:97; 1; 1)
	
End if 
//End Form Method: [Inspections]PedBridge_p2