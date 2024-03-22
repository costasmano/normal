If (False:C215)
	//LO: [Inspections];"Routine Pr Pg 1"
	//Copyright © 1995-1996,  Albert S. Leung, All Rights Reserved.
	Mods_2005_CM01
	Mods_2005_CM05
	Mods_2005_CM15
	// Modified by: costasmanousakis-(Designer)-(2/17/2006 16:51:09)
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(8/22/2007 15:29:05)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(10/22/2007 11:50:14)
	Mods_2007_CM12_5302
	// Modified by: costasmanousakis-(Designer)-(11/20/07 16:27:03)
	Mods_2007_CM_5401
	// Modified by: costasmanousakis-(Designer)-(3/28/08 12:51:38)
	Mods_2008_CM_5403
	//Adjust Kilo/Mile display
	// Modified by: Costas Manousakis-(Designer)-(12/20/12 10:34:57)
	Mods_2012_12
	//  `Fixed misplaced objects for dbie, tmleader and consqc
	// Modified by: Costas Manousakis-(Designer)-(7/29/13 11:33:18)
	Mods_2013_07
	//  `Modified print forms for MBTA to display the title MBTA Area engineer only.
End if 

//Load variables
C_TEXT:C284(vItem26)  // Command Replaced was o_C_STRING length was 23
C_TEXT:C284(xR1; xR2; xR3; xR4; xS1; xS2; xS3; xS4; xT1; xT2; xT3; xT4; xU1; xU2; xU3; xU4)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(xV1; xV2; xV3; xV4; xW1; xW2; xW3; xW4)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(vFC; vCracks; vUndermine; vOvrHead)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(vsCurbRvlNE; vsCurbRvlSW)  // Command Replaced was o_C_STRING length was 3// added for curb reveal

//Added to simplify coding of Element info variables
C_LONGINT:C283(INSP_NumItems_L)  //Command Replaced was o_C_INTEGER//number of items on this form
INSP_NumItems_L:=5  //items 58,59,60,OVR,APR
ARRAY INTEGER:C220(INSP_Start_ai; INSP_NumItems_L)  //start of item counter
ARRAY INTEGER:C220(INSP_Fin_ai; INSP_NumItems_L)  //end of item counter
//load values in the arrays
INSP_Start_ai{1}:=<>k58s_
INSP_Start_ai{2}:=<>k59s_
INSP_Start_ai{3}:=<>k60s_
INSP_Start_ai{4}:=<>kOVRs_
INSP_Start_ai{5}:=<>kAPRs_
INSP_Fin_ai{1}:=<>k58f_
INSP_Fin_ai{2}:=<>k59f_
INSP_Fin_ai{3}:=<>k60f_
INSP_Fin_ai{4}:=<>kOVRf_
INSP_Fin_ai{5}:=<>kAPRf_

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
		
		INSP_FillElementInfo
		
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
		QUERY SELECTION:C341([ElementsSafety:29]; [ElementDict:30]Category:3="OVR"; *)
		QUERY SELECTION:C341([ElementsSafety:29];  & ; [ElementsSafety:29]Rating:2#"N")
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		vOvrHead:=f_Boolean2String(($vlNumOVRs>0); "YN")
		
		G_Insp_SetDirLbl([Inspections:27]OrientationNS:133)
		
		G_Insp_SetDeptFont
		G_Insp_ApplyRev2_PR
		ut_FitPrintFormObject(->[Bridge MHD NBIS:1]Bridge Name:29; 11; 8)
End case 