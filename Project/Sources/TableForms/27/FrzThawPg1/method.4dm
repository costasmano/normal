If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/16/09, 20:07:11
	// ----------------------------------------------------
	// Method: Form Method: FrzThawPg1
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2009_CM_5404  // --- "FREEZETHAW"
	// Modified by: costasmanousakis-(Designer)-(4/14/10 11:29:50)
	Mods_2010_04
	//  `Added calls to INSP_KiloPtValues INSP_Item21Desc INSP_Item22Desc INSP_Item107Desc INSP_Item43Desc
	Mods_2011_06  // CJ Miller`06/20/11, 11:07:01      ` Type all local variables for v11
	// Modified by: Costas Manousakis-(Designer)-(2/12/12 08:49:13)
	Mods_2012_02
	//  `Fixed format of sTown variable
End if 
Case of 
	: (Form event code:C388=On Printing Detail:K2:18)
		C_TEXT:C284(FRZProb_1_txt; FRZProb_2_txt; FRZProb_3_txt; FRZProb_4_txt)
		C_TEXT:C284(FRZAction_1_txt; FRZAction_2_txt; FRZAction_3_txt; FRZAction_4_txt)
		C_LONGINT:C283(FRZNoProb_1_L; FRZNoProb_2_L; FRZNoProb_3_L; FRZNoProb_4_L)
		C_LONGINT:C283(FRZNA_1_L; FRZNA_3_L; FRZNA_2_L; FRZNA_4_L)
		C_LONGINT:C283(FRZNoAction_1_L; FRZNoAction_2_L; FRZNoAction_3_L; FRZNoAction_4_L)
		C_LONGINT:C283(FRZAction_1_L; FRZAction_2_L; FRZAction_3_L; FRZAction_4_L)
		C_LONGINT:C283(FRZProb_1_L; FRZProb_2_L; FRZProb_3_L; FRZProb_4_L; $Loop)
		C_TEXT:C284(FRZDesc_1_txt; FRZDesc_2_txt; FRZDesc_3_txt; FRZDesc_4_txt)
		
		
		FORM_FixHairLine
		
		For ($Loop; 1; 8)
			FRZ_CommentsFit_b{$Loop}:=False:C215
		End for 
		INSP_KiloPtValues
		INSP_Item21Desc
		INSP_Item22Desc
		INSP_Item107Desc
		INSP_Item43Desc
		C_BOOLEAN:C305($DoesNotFit_b)
		$DoesNotFit_b:=ut_FitPrintFormObject(->vItem22; 10; 8)
		$DoesNotFit_b:=ut_FitPrintFormObject(->vItem21; 10; 8)
		$DoesNotFit_b:=ut_FitPrintFormObject(->vItem43; 10; 8)
		$DoesNotFit_b:=ut_FitPrintFormObject(->vItem107; 10; 8)
		$DoesNotFit_b:=ut_FitPrintFormObject(->[Bridge MHD NBIS:1]Item6A:63; 10; 8)
		$DoesNotFit_b:=ut_FitPrintFormObject(->[Bridge MHD NBIS:1]Item7:65; 10; 8)
		
		ORDER BY:C49([ElementsSafety:29]; [ElementsSafety:29]ElementNo:1; >)
		FRZ_PrintPageUtil(1)
		FRZ_PrintPageUtil(2)
		FRZ_PrintPageUtil(3)
		FRZ_PrintPageUtil(4)
		C_TEXT:C284(FRZ_List_1_s; FRZ_List_2_s; FRZ_List_3_s; $Activeobject_txt)
		FRZ_List_1_s:="1"
		FRZ_List_2_s:="2"
		FRZ_List_3_s:="3"
		//[Inspections]Cld_Schedule:="1"
		$Activeobject_txt:="FRZ_List_"+[Inspections:27]Cld_Schedule:194+"_s"
		OBJECT SET RGB COLORS:C628(*; "FRZ_List_@"; Col_paletteToRGB(Abs:C99((-(Black:K11:16+(256*White:K11:1))))%256); Col_paletteToRGB(Abs:C99((-(Black:K11:16+(256*White:K11:1))))\256))  // **Replaced o OBJECT SET COLOR(*; "FRZ_List_@"; (-(Black+(256*White))))
		OBJECT SET RGB COLORS:C628(*; $Activeobject_txt; Col_paletteToRGB(Abs:C99((-(White:K11:1+(256*Black:K11:16))))%256); Col_paletteToRGB(Abs:C99((-(White:K11:1+(256*Black:K11:16))))\256))  // **Replaced o OBJECT SET COLOR(*; $Activeobject_txt; (-(White+(256*Black))))
		
		If (Not:C34(PrintFlag))
			CANCEL:C270
		End if 
		
End case 