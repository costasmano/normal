//%attributes = {"invisible":true}
//Method: FM_SavePhotoInput
//Description
// Save the image from LSS_Photos ; Input form
// Parameters

If (False:C215)
	//----------------------------------------------------
	//User name (OS): administrator
	//Date and time: 04/02/15, 16:05:35
	//----------------------------------------------------
	// ----------------------------------------------------
	Mods_2014_Lighting  // 
	//Modified by: administrator (4/2/15 16:05:39)
	Mods_2015_08_bug  //Fix [LSS_Photos]LSS_PhotoSequence_L bug
	//Modified by: administrator (8/18/15 16:00:19)
	// Modified by: Costas Manousakis-(Designer)-(9/14/15 14:37:38)
	Mods_2015_09_bug
	//  `added reduction of image size
	Mods_2016_02_bug  // Add code to make sure sequenec update only occurs when seq has changed
	//Modified by: administrator (2/9/16 17:30:28)
	Mods_2017_06_bug  ////Fix error where errors occur and tranaction not cancelled
	//Modified by: Chuck Miller (6/21/17 13:44:29)
	Mods_2018_06_bug  //Make changes to [LSS_Photos] input to try and fix problems with blank [Activity Log] records
	//Modified by: Chuck Miller (6/5/18 15:10:36)
	// Modified by-(7/12/18 17:36:55)
	Mods_2018_07_bug
	//  `add check for new record
	Mods_2020_01_bug  //Modfied way lss pictures are resequenced to follow model on tin images 
	//Modified by: CJ (1/23/20 16:35:21
	
End if 

If (Not:C34(Read only state:C362([LSS_Photos:166])) | Is new record:C668([LSS_Photos:166]))
	
	ARRAY TEXT:C222($FieldsToSkip_atxt; 0)
	
	APPEND TO ARRAY:C911($FieldsToSkip_atxt; "LSS_PhotoId_s")
	APPEND TO ARRAY:C911($FieldsToSkip_atxt; "LSS_Photo_blb")
	SET CURSOR:C469(1)
	C_TEXT:C284($ErrorMethodCalled_txt)
	$ErrorMethodCalled_txt:=Method called on error:C704
	ON ERR CALL:C155("LSS_ErrorMethod")
	If (Is new record:C668([LSS_Photos:166]))
		LSS_PhotoUpdateSeq_b:=True:C214
		LogNewRecord(->[LSS_Photos:166]LSS_PhotoId_s:1; ->[LSS_Photos:166]LSS_PhotoId_s:1; ->[LSS_Photos:166]LSS_PhotoId_s:1; 0; "LSS_PhotoId_s")
	End if 
	
	If (Old:C35([LSS_Photos:166]LSS_PhotoSequence_L:6)#[LSS_Photos:166]LSS_PhotoSequence_L:6)
		LSS_PhotoUpdateSeq_b:=True:C214
		//LSS_ResequencePictures ("Update";[LSS_Photos]LSS_PhotoId_s;[LSS_Photos]LSS_PhotoType_s;[LSS_Photos]LSS_PhotoSequence_L)
	End if 
	If (ACT_PushGroupChanges(Table:C252(->[LSS_Photos:166]); 5; ->$FieldsToSkip_atxt))
	End if 
	//check to see if the blob was changed
	C_LONGINT:C283($BlobInStack_L; $vlThumbNlW; $wi; $he; $vlWidth; $vlHt; $colorDepth_I)
	$BlobInStack_L:=Find in array:C230(ptr_changes{5}; ->[LSS_Photos:166]LSS_Photo_blb:5)
	If ($BlobInStack_L>0)
		If ([LSS_Photos:166]LSS_PhotoType_s:3="Photo")
			//do this only for photos
			$vlThumbNlW:=1350  // effective 225 dpi for  a 4x6 pritned pic
			$colorDepth_I:=32  //colordepth
			C_PICTURE:C286($temp_pic; $temp2_pic)
			BLOB TO PICTURE:C682([LSS_Photos:166]LSS_Photo_blb:5; $temp_pic; "JPEG")
			
			PICTURE PROPERTIES:C457($temp_pic; $vlWidth; $vlHt)
			If ($vlWidth>($vlThumbNlW*1.1))
				CREATE THUMBNAIL:C679($temp_pic; $temp2_pic; $vlThumbNlW; Int:C8($vlHt*($vlThumbNlW/$vlWidth)); Scaled to fit:K6:2; $colorDepth_I)
				PICTURE PROPERTIES:C457($temp2_pic; $vlWidth; $vlHt)
				If ($vlWidth>0)
					PICTURE TO BLOB:C692($temp2_pic; [LSS_Photos:166]LSS_Photo_blb:5; "JPEG")
				End if 
				
			End if 
			
		End if 
	End if 
	[LSS_Inspection:164]LSS_InspectionId_s:1:=[LSS_Inspection:164]LSS_InspectionId_s:1  //reset to force modified record flag for this table
	FlushGrpChgs(5; ->[LSS_Photos:166]LSS_PhotoId_s:1; ->[LSS_Photos:166]LSS_PhotoId_s:1; ->[LSS_Photos:166]LSS_PhotoId_s:1; 0)
	SAVE RECORD:C53([LSS_Photos:166])
	ON ERR CALL:C155($ErrorMethodCalled_txt)
	If (LSS_DuplicateRecordError_B | LSS_Error_B)
		CANCEL:C270
	End if 
	SET CURSOR:C469(0)
End if 
//End FM_SavePhotoInput