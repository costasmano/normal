// ----------------------------------------------------
// Method: Form Method: [ScourPOA];"Summary-A"
// Description
// 
// 
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 02/29/12, 17:05:14
	
	// First Release
	Mods_2012_02
	// Modified by: Costas Manousakis-(Designer)-(3/13/12 09:54:59)
	Mods_2012_03
	//  `Changed checkboxes to resource file "checkbox.png"
	// Modified by: Costas Manousakis-(Designer)-(3/25/12 21:08:45)
	Mods_2012_03
	//  `use same method in SCPOA_Variables("PRINTPG1") to get the 1st picture
	// Modified by: Costas Manousakis-(Designer)-(8/21/14 10:11:54)
	Mods_2014_08
	//  `General POA modifications Aug 2014
	// Modified by: Costas Manousakis-(Designer)-(10/6/14 17:28:45)
	Mods_2014_10_bug
	//  `General POA modifications Oct 2014
	// Modified by: Costas Manousakis-(Designer)-(11/3/14 12:09:29)
	Mods_2014_11
	//  `minor adjustments in labels
	// Modified by: Costas Manousakis-(Designer)-(1/12/15 17:41:06)
	Mods_2015_01
	//  `adjustments in labels and order of channel scour / uw insp
	// Modified by: Costas Manousakis-(Designer)-(3/6/15 15:26:00)
	Mods_2015_03_bug
	//  `adjusted size and location  of checkboxes above Narrative  to show the full text of "recommended chg in insp freq"
End if 

// Declare local variables
C_LONGINT:C283($LFormEvent)

$LFormEvent:=Form event code:C388

Case of 
	: ($LFormEvent=On Printing Detail:K2:18)
		FORM_FixHairLine
		
		SCPOA_FillFormPicButtons
		If ([ScourPOA:132]DateCompleted:8#!00-00-00!)
			SCPOA_DateComp_txt:=String:C10([ScourPOA:132]DateCompleted:8)
		Else 
			SCPOA_DateComp_txt:=""
		End if 
		SCPOA_ComplDate_txt:=F_dateToString([ScourPOA:132]DateCompleted:8; Internal date short:K1:7)
		READ ONLY:C145([ScourPOA_Images:134])
		ARRAY LONGINT:C221($SeqCopy_aL; 0)
		ARRAY LONGINT:C221($RecNumCopy_aL; 0)
		COPY ARRAY:C226(SCPOA_PhotoSeq_aL; $SeqCopy_aL)
		COPY ARRAY:C226(SCPOA_PhotoRecs_aL; $RecNumCopy_aL)
		
		SORT ARRAY:C229($SeqCopy_aL; $RecNumCopy_aL)
		CREATE SELECTION FROM ARRAY:C640([ScourPOA_Images:134]; $RecNumCopy_aL)
		If (Records in selection:C76([ScourPOA_Images:134])>0)
			FIRST RECORD:C50([ScourPOA_Images:134])
			BLOB TO PICTURE:C682([ScourPOA_Images:134]Image_x:3; SCPOA_SummPgPic_pic)
		Else 
			SCPOA_SummPgPic_pic:=SCPOA_SummPgPic_pic*0
		End if 
		CREATE SELECTION FROM ARRAY:C640([ScourPOA_Images:134]; SCPOA_PhotoRecs_aL)
		READ WRITE:C146([ScourPOA_Images:134])
		C_BOOLEAN:C305($Fit_b)
		$Fit_b:=ut_FitPrintFormObject(->SCPOA_FinalRec_txt; 10; 5)
		$Fit_b:=ut_FitPrintFormObject(->SCPOA_OtherAttach_txt; 10; 5)
		$Fit_b:=ut_FitPrintFormObject(->SCPOA_Town_txt; 12; 5)
		$Fit_b:=ut_FitPrintFormObject(->SCPOA_BDEPT_txt; 10; 5)
		
End case 
//
//End Form Method: [ScourPOA]