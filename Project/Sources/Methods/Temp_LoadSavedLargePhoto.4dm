//%attributes = {"invisible":true}
//Method: Temp_LoadSavedLargePhoto
//Description
// Load a saved Picture variable in the currently loaded Standard photo record.
// Does not save the record!
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/19/17, 10:26:27
	// ----------------------------------------------------
	//Created : 
	Mods_2017_04
End if 
//
C_TEXT:C284($baseFolder_txt; $TemplateFile_txt; $FilePath_txt)
$baseFolder_txt:=Select folder:C670("Select base Folder where pictures were saved")
If (OK=1)
	$FilePath_txt:=$baseFolder_txt+String:C10([Standard Photos:36]StdPhotoID:7; $TemplateFile_txt)+".4pct"
	If (Test path name:C476($FilePath_txt)=Is a document:K24:1)
		C_PICTURE:C286($saved_pic)
		C_BLOB:C604($docBlob_x)
		DOCUMENT TO BLOB:C525($FilePath_txt; $docBlob_x)
		BLOB TO VARIABLE:C533($docBlob_x; $saved_pic)
		C_LONGINT:C283($W_L; $H_L)
		PICTURE PROPERTIES:C457($saved_pic; $W_L; $H_L)
		Case of 
			: (Picture size:C356($saved_pic)=0)
				ALERT:C41("Picture stored in blob of document "+$FilePath_txt+" has zero size!")
			: (($W_L+$H_L)=0)
				ALERT:C41("Picture stored in blob of document "+$FilePath_txt+" has zero Width and Height!")
			Else 
				[Standard Photos:36]Std Photo:3:=$saved_pic
				ALERT:C41("Loaded Picture size :"+String:C10(Picture size:C356($saved_pic); "###,###,###,###,### b")+"  dim : "+String:C10($W_L)+"W x "+String:C10($H_L)+"H")
		End case 
	Else 
		ALERT:C41("Did not find file "+$FilePath_txt+" !!")
	End if 
	
End if 

//End Temp_LoadSavedLargePhoto