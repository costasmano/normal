//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/22/08, 11:36:46
	// ----------------------------------------------------
	// Method: INSP_ElmSft_Inc_FM
	// Description
	// Form method for Include forms for [ElementsSafety]
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2007_CM_5401
	// Modified by: costasmanousakis-(Designer)-(7/8/08 18:17:38)
	Mods_2008_CM_5404  // ("DEFELMTEXPORT")
	//  `use method INSP_ElmtSfty_ItemNo
	// Modified by: Costas Manousakis-(Designer)-(10/24/13 11:19:39)
	Mods_2013_10
	//  `use  method  INSP_IsInspRoutine_b to check if inspection is a routine one
End if 
Case of 
	: (Form event code:C388=On Display Detail:K2:22)
		vItemNo:=INSP_ElmtSfty_ItemNo([ElementsSafety:29]ElementNo:1)
		
		//Display description
		vElmDescr:=GetElmtNumber+" "+[ElementsSafety:29]Description:22
		If (INSP_IsInspRoutine_b)
			If ([ElementsSafety:29]SpecMemb Flag:8)
				vElmDescr:=vElmDescr+" - (Spec.Mb.)"
			End if 
			If (([ElementsSafety:29]ElementNo:1=300) | ([ElementsSafety:29]ElementNo:1=313) | ([ElementsSafety:29]ElementNo:1=325))
				OBJECT SET FONT STYLE:C166(vElmDescr; Bold:K14:2)
				// SET RGB COLORS(vElmDescr;Blue ;Grey )
				OBJECT SET RGB COLORS:C628(vElmDescr; Col_paletteToRGB(Abs:C99(<>color_editable)%256); Col_paletteToRGB(Abs:C99(<>color_editable)\256))  // **Replaced o OBJECT SET COLOR(vElmDescr; <>color_editable)
			Else 
				OBJECT SET FONT STYLE:C166(vElmDescr; Plain:K14:1)
				// SET RGB COLORS(vElmDescr;Blue ;Light Grey )
				OBJECT SET RGB COLORS:C628(vElmDescr; Col_paletteToRGB(Abs:C99(<>color_Not_editable)%256); Col_paletteToRGB(Abs:C99(<>color_Not_editable)\256))  // **Replaced o OBJECT SET COLOR(vElmDescr; <>color_Not_editable)
			End if 
		End if 
End case 