//%attributes = {"invisible":true}
// ----------------------------------------------------
// Mods_2004_VN04
// Date: 12/28/04
// ----------------------------------------------------
// Description
// This method will outline changes made per Costas by me
//
// Parameters
// None
// ----------------------------------------------------

//Created Form Object Method:
//[Standard Photos]; "Standard Photos"; "vbPrintImages"
//  `Print or Print Preview the current page images depending on
//  ` the type of the inspection

//  `In case of new photo has created, the method will prompt the
//  `  user to save the new photo and display the image with the
//  `  formats that set by the user.

//  `In case of the format of the current image is modified, the
//  `  method will prompt the user to save the changes before the
//  `  image is printed preview

//  `In other cases, the method will print preview images depending
//  `  on the type and the formats of the images.

//Created New Project Methods:
//  `PreviewInspectionImages
//  `  Method used to do a print preview of Image for an Inspection.
//  `  Called from vbPrintImages button on Standard Photos form.

//  `PrintPreviewImages
//  `  Print preview the current image associated with the inspection.

//  `PreviewCurrentPhoto  
//  `  Print the curent photo associated with inspection.

//  `PreviewCurrentAndNextPhotos  
//  `  Print the curent and next photos on the same page
//  `  associated with inspection.

//  `PreviewPreviousAndCurrentPhotos  
//  `  Print the previous and current photos on the same page
//  `  associated with inspection.

//Created New Dialog Form
//  `[Dialogs]; "PrintPreviewImages"