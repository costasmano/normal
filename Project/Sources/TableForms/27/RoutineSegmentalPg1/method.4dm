// Method: Form Method: [Inspections]RoutineSegmentalPg1
// Description
// Copied from Routine Pr Pg 1
// 
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 05/06/14, 17:39:33
	// ----------------------------------------------------
	// First Release
	Mods_2014_05
	// Modified by: Costas Manousakis-(Designer)-(4/18/17 12:31:53)
	Mods_2017_04
	//  `for OVerhead Y/N (variable vOvrHead) search Elements by InspID instead of Selection. 
	//  //The selection has been modified by INSP_LoadESForReport
End if 


//Load variables
C_TEXT:C284(vItem26)  // Command Replaced was o_C_STRING length was 23
C_TEXT:C284(xR1; xR2; xR3; xR4; xS1; xS2; xS3; xS4; xT1; xT2; xT3; xT4; xU1; xU2; xU3; xU4)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(xV1; xV2; xV3; xV4; xW1; xW2; xW3; xW4)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(vFC; vCracks; vUndermine; vOvrHead)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(vsCurbRvlNE; vsCurbRvlSW)  // Command Replaced was o_C_STRING length was 3// added for curb reveal


Case of 
	: (Form event code:C388=On Printing Detail:K2:18)
		
		
		FORM_FixHairLine
		
		OBJECT SET VISIBLE:C603(*; "txtPCAbutments"; <>WindowsPL_b)
		OBJECT SET VISIBLE:C603(*; "txtMacAbutments"; <>MacPL_b)
		OBJECT SET VISIBLE:C603(*; "txtPCPiersBents"; <>WindowsPL_b)
		OBJECT SET VISIBLE:C603(*; "txtMacPiersBents"; <>MacPL_b)
		OBJECT SET VISIBLE:C603(*; "txtPCPileBents"; <>WindowsPL_b)
		OBJECT SET VISIBLE:C603(*; "txtMacPileBents"; <>MacPL_b)
		
		vInspTitlePr:=Uppercase:C13(G_Insp_SetTitle)
		G_Insp_FormatTitle
		
		vsCurbRvlNE:=G_CurbRvl([Inspections:27]CurbRevealNE:10)
		vsCurbRvlSW:=G_CurbRvl([Inspections:27]CurbRevealSW:11)
		INSP_KiloPtValues
		INSP_Item21Desc
		INSP_Item22Desc
		
		vItem26:=Get_Description(-><>aFC; -><>aFC_Cod; ->[Inspections:27]Item26:200)
		INSP_Item41Desc
		INSP_Item43Desc
		INSP_Item107Desc
		
		//Added variables for Item 58,59,60,60uw ratings
		vItem58:=G_ElmtRatingTxt([Inspections:27]Item 58:79)
		vItem59:=G_ElmtRatingTxt([Inspections:27]Item 59:80)
		vItem60:=G_ElmtRatingTxt([Inspections:27]Item 60:81)
		vItem60UW:=G_ElmtRatingTxt([Inspections:27]Item 60 UW:66)
		vItem60Cur:=G_ElmtRatingTxt([Inspections:27]Item 60 Cur:155)
		
		//Adjust Fonts and fields.
		If (Length:C16(vItem26)>14)
			OBJECT SET FONT SIZE:C165(vItem26; 9)
		End if 
		INSP_Item43Desc("Resize")
		
		G_Insp_FmtSTOWN
		
		INSP_LoadESForReport([Inspections:27]Insp Type:6)  //This will be "RTB" routine Box -segmental
		
		//Check boxes
		f_Var_to_Series([Inspections:27]CollisionDamSup:13; "xR"; "NRMS"; "N")
		f_Var_to_Series([Inspections:27]LoadDeflection:14; "xS"; "NRMS"; "N")
		f_Var_to_Series([Inspections:27]LoadVibration:15; "xT"; "NRMS"; "N")
		f_Var_to_Series([Inspections:27]CollisionDamSub:18; "xU"; "NRMS"; "N")
		f_Var_to_Series([Inspections:27]Scour:20; "xV"; "NRMS"; "N")
		
		//Flags    
		vFC:=f_Boolean2String([Inspections:27]FractureCrit:16; "YN")
		vCracks:=f_Boolean2String([Inspections:27]Cracks:17; "YN")
		vUndermine:=f_Boolean2String([Inspections:27]UnderMining:19; "YN")
		C_LONGINT:C283($vlNumOVRs)
		SET QUERY DESTINATION:C396(Into variable:K19:4; $vlNumOVRs)
		QUERY:C277([ElementsSafety:29]; [ElementsSafety:29]InspID:4=[Inspections:27]InspID:2; *)
		QUERY:C277([ElementsSafety:29]; [ElementDict:30]Category:3="OVR"; *)
		QUERY:C277([ElementsSafety:29];  & ; [ElementsSafety:29]Rating:2#"N")
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		vOvrHead:=f_Boolean2String(($vlNumOVRs>0); "YN")
		
		G_Insp_SetDirLbl([Inspections:27]OrientationNS:133)
		
		G_Insp_SetDeptFont
		G_Insp_ApplyRev2_PR
		ut_FitPrintFormObject(->[Bridge MHD NBIS:1]Bridge Name:29; 11; 8)
End case 