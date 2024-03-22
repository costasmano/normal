// Method: Form Method: [Inspections];"FrzThawPg1A"
// Description
// 
// 
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 02/07/14, 12:25:29
	// ----------------------------------------------------
	// First Release
	Mods_2014_02
	// Modified by: Costas Manousakis-(Designer)-(6/17/14 16:20:47)
	Mods_2014_06_bug
	//  `Added code to print the Orientation text if it does not fit on page 1
	//  `Use var FRZ_OrientationPg1_txt
	// Modified by: Costas Manousakis-(Designer)-(11/25/14 13:35:11)
	Mods_2014_11_bug
	//  `set the bridge table fields  back to visible.
	// Modified by: Costas Manousakis-(Designer)-(2022-06-23 12:41:11)
	Mods_2022_06
	//  `made all text objects for the comments on form multi-style
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
		C_BOOLEAN:C305($DoesNotFit_b)
		$DoesNotFit_b:=ut_FitPrintFormObject(->vItem22; 10; 8)
		$DoesNotFit_b:=ut_FitPrintFormObject(->vItem21; 10; 8)
		$DoesNotFit_b:=ut_FitPrintFormObject(->[Bridge MHD NBIS:1]Item6A:63; 10; 8)
		$DoesNotFit_b:=ut_FitPrintFormObject(->[Bridge MHD NBIS:1]Item7:65; 10; 8)
		FRZ_OrientationPg1_txt:=[Inspections:27]UnderminingTxt:102
		FRZ_OrientationOnPg1_b:=Not:C34(ut_FitPrintFormObject(->FRZ_OrientationPg1_txt; 10; 8))
		
		If (Not:C34(FRZ_OrientationOnPg1_b))
			FRZ_OrientationPg1_txt:="See Description in Remarks Section."
			OBJECT SET FONT SIZE:C165(FRZ_OrientationPg1_txt; 10)
		End if 
		
		ORDER BY:C49([ElementsSafety:29]; [ElementsSafety:29]ElementNo:1; >)
		FRZ_PrintPageUtil_A(1)
		FRZ_PrintPageUtil_A(2)
		FRZ_PrintPageUtil_A(3)
		FRZ_PrintPageUtil_A(4)
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