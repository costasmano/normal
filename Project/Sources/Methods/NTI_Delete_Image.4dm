//%attributes = {"invisible":true}
//Method: NTI_Delete_Image
//Description
// Delete the current [TIN_Insp_Images] image
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 11/20/17, 16:00:38
	// ----------------------------------------------------
	//Created : 
	Mods_2017_11_bug
End if 
//
Case of 
		
	: (Form event code:C388=On Clicked:K2:4)
		C_TEXT:C284($msg_txt)
		
		Case of 
			: ([TIN_Insp_Images:186]ImageType:5=BMS Sketch)
				$msg_txt:="Sketch"
			: ([TIN_Insp_Images:186]ImageType:5=BMS Chart)
				$msg_txt:="Chart"
			: ([TIN_Insp_Images:186]ImageType:5=BMS Photo)
				$msg_txt:="Photo"
			Else 
				$msg_txt:="Image"
				
		End case 
		
		CONFIRM:C162("Are you sure you want to delete this "+$msg_txt+"?"; "Delete"; "Cancel")
		If (OK=1)
			LogDeletion(->[TIN_Inspections:184]InspectionID:2; ->[TIN_Insp_Images:186]InspectionID:1; ->[TIN_Insp_Images:186]ImageID:2; 2)
			DELETE RECORD:C58([TIN_Insp_Images:186])
			CANCEL:C270
		End if 
End case 

//End NTI_Delete_Image