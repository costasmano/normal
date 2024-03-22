//%attributes = {"invisible":true}
// Method: ut_LSSControlPictureMod
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): Administrator
	// Date and time: 09/30/14, 13:27:14
	// ----------------------------------------------------
	Mods_2015_12_bug  //Fix bug where accessibility records, ut records, dmeter recdords not updated all the time
	//Modified by: administrator (12/30/15 16:10:34)
	Mods_2016_01_bug  // Fix where UT and DMeter pictures not being saved properly
	//Modified by: administrator (1/21/16 12:42:23)
	// Modified by: Costas Manousakis-(Designer)-(9/12/16 14:36:30)
	Mods_2016_09
	//  `make sure the other buttons  on the DMeter tab become visible after loading a sketch.
	Mods_2017_06_bug  ////Fix error where errors occur and tranaction not cancelled
	//Modified by: Chuck Miller (6/21/17 13:44:29)
	Mods_2018_10_bug  //Make sure image is set to invisble after new picture imports
	//Modified by: Chuck Miller (10/9/18 14:06:38)
	
End if 
C_POINTER:C301($3; $picture_ptr)
$picture_ptr:=$3
C_TEXT:C284($1; $2; $Type_txt; $Path_txt; $imageOrFile_txt)
$Type_txt:=$1
$imageOrFile_txt:=$2
C_BOOLEAN:C305($Proceed_b)
$Proceed_b:=False:C215
If (Picture size:C356($picture_ptr->)=0)
	$Path_txt:=LSS_SelectPictureFile
	$Proceed_b:=(Length:C16($Path_txt)>0)
	
Else 
	CONFIRM:C162("Are you sure you wish to replace the picture?"; "Replace"; "Cancel")
	$Proceed_b:=False:C215
	If (OK=1)
		$Path_txt:=LSS_SelectPictureFile
		$Proceed_b:=(Length:C16($Path_txt)>0)
	End if 
End if 

If ($Proceed_b)
	LSS_UpdateMany_B:=True:C214
	C_BLOB:C604($NewPicture_blb)
	C_PICTURE:C286($MyPicture)
	$MyPicture:=$picture_ptr->
	
	C_BOOLEAN:C305($Update_b)
	//
	
	READ PICTURE FILE:C678($Path_txt; $picture_ptr->; *)
	If (Picture size:C356($picture_ptr->)>0)
		
		If (ut_UpdateorCreatePhotoRecord($imageOrFile_txt; $Path_txt; $Type_txt; LSS_PhotoDescription_txt; $picture_ptr))
			//Case of 
			//: ($Type_txt="Sketch D Meter")
			//PICTURE TO BLOB($picture_ptr->;[LSS_Photos]LSS_Photo_blb;"JPEG")
			//
			//: ($Type_txt="Sketch UT")
			//PICTURE TO BLOB($picture_ptr->;[LSS_Photos]LSS_Photo_blb;"JPEG")
			//
			//
			//End case 
			C_TEXT:C284($ErrorMethodCalled_txt)
			$ErrorMethodCalled_txt:=Method called on error:C704
			ON ERR CALL:C155("LSS_ErrorMethod")
			ARRAY TEXT:C222($FieldsToSkip_atxt; 0)
			APPEND TO ARRAY:C911($FieldsToSkip_atxt; "LSS_PhotoId_s")
			APPEND TO ARRAY:C911($FieldsToSkip_atxt; "LSS_Photo_blb")
			//APPEND TO ARRAY($FieldsToSkip_atxt;"LSS_InspectionId_s")
			PushChange(5; ->[LSS_Photos:166]LSS_Photo_blb:5)
			
			If (ACT_PushGroupChanges(Table:C252(->[LSS_Photos:166]); 5; ->$FieldsToSkip_atxt))
				
			End if 
			[LSS_Inspection:164]LSS_InspectionId_s:1:=[LSS_Inspection:164]LSS_InspectionId_s:1  //reset to force modified record flag for this table
			FlushGrpChgs(5; ->[LSS_Photos:166]LSS_PhotoId_s:1; ->[LSS_Photos:166]LSS_PhotoId_s:1; ->[LSS_Photos:166]LSS_PhotoId_s:1; 0)
			
			OBJECT SET VISIBLE:C603(*; "DMeterInput_@"; True:C214)  //shows the pict var
			OBJECT SET VISIBLE:C603(*; "DMeterButton@"; True:C214)  //show all other buttons
			OBJECT SET VISIBLE:C603(*; "DMeterInput_1@"; True:C214)
			OBJECT SET VISIBLE:C603(*; "UTButton1_L@"; True:C214)
			OBJECT SET VISIBLE:C603(*; "UTInput_1@"; True:C214)
			If ($Type_txt="Sketch UT")
				OBJECT SET VISIBLE:C603(*; "NOUTPict"; False:C215)
				OBJECT SET VISIBLE:C603(*; "UT_SketchComents"; True:C214)
				//OBJECT SET ENTERABLE(*;"UT_SketchComents";True)
			Else 
				OBJECT SET VISIBLE:C603(*; "NODMeterPict"; False:C215)
				OBJECT SET VISIBLE:C603(*; "DMeterInput_2"; True:C214)
				//OBJECT SET ENTERABLE(*;"DMeterInput_2";True)
			End if 
			
			SAVE RECORD:C53([LSS_Photos:166])
			ON ERR CALL:C155($ErrorMethodCalled_txt)
			//UNLOAD RECORD([LSS_Photos])
			
		Else 
			ALERT:C41("No changes to picture were made")
		End if 
	Else 
		ALERT:C41("Selected Picture has no size")
	End if 
	
	
End if 

LSS_SetSaveandDelete