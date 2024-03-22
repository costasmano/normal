// Method: Object Method: [Standard Photos].Standard Photos.Button
// Description
//   `For Designer users - to alow recreating of the entries in the activity log table
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name(OS): Costas Manousakis
	// User(4D): Designer
	// Date and time: 10/28/13, 10:52:33
	// ----------------------------------------------------
	// Created :
	Mods_2013_10
	// Modified by: Costas Manousakis-(Designer)-(10/17/16 09:46:02)
	Mods_2016_10
	//  `added display of image type.
	Mods_2017_05  //Add code to allow for re-import of converted pictures. Also seperate options into pop menu
	//Modified by: Chuck Miller (5/9/17 12:38:04)
	// Modified by: Costas Manousakis-(Designer)-(9/15/20 12:07:40)
	Mods_2020_09
	//  `replaced calls to hmfree with call to GetPictureTypes
	// Modified by: Costas Manousakis-(Designer)-(2022-10-21 16:30:41)
	Mods_2022_10
	//  `show all picture types found not only the first one
End if 
// 
Case of 
	: (Form event code:C388=On Load:K2:1)
		
		If (User in group:C338(<>CurrentUser_Name; "Design Access Group"))
			OBJECT SET VISIBLE:C603(Self:C308->; True:C214)
		End if 
		
	: (Form event code:C388=On Clicked:K2:4)
		C_TEXT:C284($PopMenuCmds_txt)
		$PopMenuCmds_txt:="View Picture Types"+Char:C90(Carriage return:K15:38)+"Launch Relog utility in a separate process?"+Char:C90(Carriage return:K15:38)+"Import from Converted Folder"+Char:C90(Carriage return:K15:38)
		C_LONGINT:C283($Choice_L)
		$Choice_L:=Pop up menu:C542($PopMenuCmds_txt)
		
		Case of 
			: ($Choice_L=1)
				ARRAY TEXT:C222($TypesFound_atxt; 0)
				C_BOOLEAN:C305($IsDepracated_B)
				C_LONGINT:C283($InvalidFormat_L; $imgSize_L)
				//If (hmFree_IsLicensed >=0)
				//Else 
				//$imgSize_L:=hmFree_Register ("rLhAA-YcUAGWAAAAJCAMoBksABRAD+AGtAJbF-+")
				//End if 
				//hmFree_GET PICTURE TYPES ([Standard Photos]Std Photo;$TypesFound_atxt)
				
				GetPictureTypes([Standard Photos:36]Std Photo:3; ->$TypesFound_atxt)
				GET PICTURE FORMATS:C1406([Standard Photos:36]Std Photo:3; $TypesFound_atxt)
				
				If (Size of array:C274($TypesFound_atxt)>0)
					ALERT:C41("Current Record ID : "+String:C10([Standard Photos:36]StdPhotoID:7)+" type(s) "+ut_ArrayToText(->$TypesFound_atxt; ","))
				Else 
					ALERT:C41("Current Record ID : "+String:C10([Standard Photos:36]StdPhotoID:7)+" type NULL")
				End if 
				
			: ($Choice_L=2)
				CONFIRM:C162("Launch Relog utility in a separate process?")
				If (OK=1)
					C_LONGINT:C283($Lpid)
					$Lpid:=LSpawnProcess("ut_RelogRecords"; <>LStackSize; "ReLogActivity"; True:C214; False:C215)
				End if 
			: ($Choice_L=3)
				
				C_TEXT:C284(StartFolder_txt)
				StartFolder_txt:=Select folder:C670("Select Folder Containing Converted Pictures"; StartFolder_txt)
				
				ConvertedPicturePath_txt:=CNV_CreateNewPath(String:C10([Standard Photos:36]InspID:1); StartFolder_txt)
				//ConvertedPicturePath_txt:=CNV_CreatePath (Folder separator;StartFolder_txt)
				ARRAY TEXT:C222($Documents_atxt; 0)
				C_LONGINT:C283($Start_L; $Width_L; $Height_L; $vPicW; $vPicH; $vPicHoff; $vPicVoff; $vPicmode)
				DOCUMENT LIST:C474(ConvertedPicturePath_txt; $Documents_atxt)
				ARRAY TEXT:C222(PictureList_atxt; 0)
				If (Size of array:C274($Documents_atxt)>0)
					Repeat 
						$Choice_L:=Find in array:C230($Documents_atxt; String:C10([Standard Photos:36]StdPhotoID:7)+"@"; $Start_L)
						If ($Choice_L>0)
							$Start_L:=$Choice_L+1
							APPEND TO ARRAY:C911(PictureList_atxt; $Documents_atxt{$Choice_L}+" size is - "+String:C10(Get document size:C479(ConvertedPicturePath_txt+$Documents_atxt{$Choice_L})))
							
						End if 
						
					Until ($Choice_L<0)
					If (Size of array:C274(PictureList_atxt)>0)
						
						FORM GET PROPERTIES:C674([Standard Photos:36]; "ImportPicturesFromConversion"; $Width_L; $Height_L)
						ut_OpenNewWindow($Width_L; $Height_L; 0; Plain no zoom box window:K34:1; "Import Converted Pictures"; "ut_CloseCancel")
						DIALOG:C40([Standard Photos:36]; "ImportPicturesFromConversion")
						If (vbPictureChanged)
							REDRAW:C174([Standard Photos:36]Std Photo:3)
							C_TEXT:C284(vPictStats)
							PICTURE PROPERTIES:C457([Standard Photos:36]Std Photo:3; $vPicW; $vPicH; $vPicHoff; $vPicVoff; $vPicmode)
							vPictStats:=String:C10($vPicW)+"x"+String:C10($vPicH)+<>sCR
							vPictStats:=vPictStats+"("+String:C10(Picture size:C356([Standard Photos:36]Std Photo:3); "##,###,### Bytes")+")"
						End if 
					Else 
						ALERT:C41("No pictures found for inspection "+String:C10([Standard Photos:36]InspID:1)+". Path is "+ConvertedPicturePath_txt)
						
					End if 
				Else 
					
					ALERT:C41("No pictures found for inspection "+String:C10([Standard Photos:36]InspID:1)+". Path is "+ConvertedPicturePath_txt)
					
				End if 
				
		End case 
End case 

// End Object Method: [Standard Photos].Standard Photos.Button