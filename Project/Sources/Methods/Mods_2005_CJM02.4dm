//%attributes = {"invisible":true}
// ----------------------------------------------------

// Mods_2005_CJM02

// User name (OS): cjmiller

// Date and time: 03/29/05, 15:42:56

// ----------------------------------------------------

// Description

// Fix print form and record problems

//

// Parameters

// ----------------------------------------------------

If (False:C215)
	Mods_2005_CJM02
End if 
//Note that there are still a few places thhat use page set up Costas will identify and change as needed



//replaced page set up with 

//SET PRINT OPTION(Orientation option ;1)  `set to portrait sometimes set to 2 for landscape

//SET PRINT OPTION(Paper option ;"Letter")


//[Inspections];"routine form"

//  ` Object Method: vbPGPreview

//[Inspections];"critical member"

//  ` Object Method: vbPGPreview

//[Inspections];"culvert form"

//  ` Object Method: vbPGPreview

//[Inspections];"dive template"

//  ` Object Method: vbPG1Preview

//[Inspections];"closed bridge"

//  ` Object Method: vbPGPreview

//[Inspections];"damage form"

//  ` Object Method: vbPGPreview

//[Inspections];"routine combined"

//  ` Object Method: vbPGPreview

//[Inspections];"culvert combined"

//  ` Object Method: vbPGPreview

//[Inspections];"pontis form"

//  ` Object Method: vbPGPreview

// [Standard Photos];"[Standard Photos]"

//  ` Object Method: vbPrintImages


//[Conslt Rating];"Cslt Rating In"

//  ` Object Method: btnPrint

//[Conslt Inspection];"Cslt Insp In"

//  ` Object Method: btnPrint

//[Bridge Design];"Bridge Design In"

//  ` Object Method: btnPrint


// PRINT_Critical

// PRINT_CULVERT_F

// PRINT_Damage

// Print_Dive_F

// PRINT_ROUTINE_F

//PRINT_SIA 

//prt_oofrep 

//prt_substdrep 

//Print_Dive_photos 

//G_PreviewInspImage 

//PRINT_Closed 

//G_PrintReviewCmnts 

//M_ContractRpt_Assignment

//M_ContractRpt_Cost 

//M_ContractRpt_Invoice 

//M_DeficientElementRpt 

//PrintPreviewImages 

//PreviewCurrentPhoto 

//PreviewCurrentAndNextPhotos

//PreviewPreviousAndCurrentPhotos 

//PRINT_PONTIS_F 




//End Mods_2005_CJM02


