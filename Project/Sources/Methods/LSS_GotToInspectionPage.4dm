//%attributes = {"invisible":true}
// Method: LSS_GotToInspectionPage
// Description
// go to a page in an Inspection form
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): administrator
	// Date and time: 10/02/14, 16:25:19
	// ----------------------------------------------------
	// Parameters
	// ----------------------------------------------------
	Mods_2015_08_bug  //Fix [LSS_Photos]LSS_PhotoSequence_L bug
	//Modified by: administrator (8/18/15 16:00:19)
	Mods_2015_12_bug  //Fix bug where accessibility records, ut records, dmeter recdords not updated all the time
	//Modified by: administrator (12/29/15 16:10:34)
	// Modified by: Costas Manousakis-(Designer)-(2/5/16 11:02:44)
	Mods_2016_02_bug
	//  `For Images case - added check if the tab title has been named as Photos
	// Modified by: Costas Manousakis-(Designer)-(5/13/16 16:37:49)
	Mods_2016_05_bug
	//  `Added LSS_PhotoDescription_txt:=[LSS_Photos]LSS_Photo_txt for UT sketch
	Mods_2018_04  //Remove ability to delete a UT or D-Meter sketch once record is created
	//Make sure LSS_ThisPictureDrag_b gets reset to false mpobving form page to page
	
	//Modified by: Chuck Miller (4/17/18 14:59:08)
	// Modified by: Costas Manousakis-(Designer)-(4/18/18 11:59:48)
	Mods_2018_04
	//  `when switching to UT or DMeter make sure [Lss_photos] is Read write mode
	// Modified by: Costas Manousakis-(Designer)-(4/19/18 11:59:48)
	Mods_2018_04_bug
	//Make sure [LSS_Photos] record is loaded for D-Meter and UT pages on form
	Mods_2018_05  //Fix defect where empty [Activity Log] records creatd for [LSS_Photos] records
	//when right click on picture and not phort record existed 
	//Modified by: Chuck Miller (5/24/18 16:34:03)
	Mods_2018_08  //Add code to fix problem with UT page on ibput form where uncompoiled ut and ut results data not didplayed correctly
	//Changed list boxes to use named selections ""UT_LB" and "UTResults_LB"
	//Modified by: Chuck Miller (8/30/18 15:35:58)
	Mods_2019_01  //Create and use Image list subform for LSS inspections
	//[LSS_Inspection];"PhotoSubFormLB"
	//Modified by: Chuck Miller (1/29/19 16:25:30)
	Mods_2019_02  //  //Change lss inspection input forms to use subforms wherever possible
	//Modified by: Chuck Miller (2/4/19 16:49:28)
	// Modified by: Costas Manousakis-(Designer)-(4/30/20 18:35:03)
	Mods_2020_04
	//  `execute the image sorting method in the subform. - only if LSS_PhotoUpdateSeq_b is true
	Mods_2020_09  //Make changes so that UT and d-meter pictures Added and modified using the [LSS_Photos];"Input" form
	//Modified by: CJ (9/3/20 15:39:44)
End if 

OBJECT SET VISIBLE:C603(*; "bDelete"; False:C215)
C_BOOLEAN:C305($Update_B)
C_LONGINT:C283($Option_L)
$Option_L:=0
LSS_ThisPictureDrag_b:=False:C215
If (LSS_EditDamageOnly_B)
	If (Modified record:C314([LSS_Inspection:164]))
		
		$Option_L:=ut_3Option_Confirm("Save LSS Inspection record?"; "Save"; "Stay on page"; "Cancel")
		
		
		Case of 
			: ($Option_L=1)
				LSS_InspectionRecSave
				VALIDATE TRANSACTION:C240
				START TRANSACTION:C239
				LSS_UpdateMany_B:=False:C215
				LSS_PhotoUpdateSeq_b:=False:C215
				LSS_UpdateAccessibility_B:=False:C215
				LSS_EditDamageOnly_B:=False:C215
				OBJECT SET ENABLED:C1123(*; "bValidate@"; False:C215)
				UNLOAD RECORD:C212([LSS_Inspection:164])
				READ ONLY:C145([LSS_Inspection:164])
				LOAD RECORD:C52([LSS_Inspection:164])
				InitChangeStack(1)
				ut_SetReadWrite("Read"; ->[LSS_ElementInspection:163]; ->[LSS_Photos:166]; ->[LSS_Accessibility:159]; ->[LSS_DMeter:161]; ->[LSS_UT:175]; ->[LSS_UtResult:176]; ->[LSS_TeamMembers:173])
				ut_SetReadWrite("Read"; ->[LSS_SignPanel:172]; ->[LSS_TowerDistance:174]; ->[LSS_VerticalClearance:177])
				LSS_AllowInspectionEdit_B:=False:C215
				LSS_AllowInspectionDelete_B:=False:C215
				
			: ($Option_L=3)
				CANCEL TRANSACTION:C241
				START TRANSACTION:C239
				LSS_EditDamageOnly_B:=False:C215
				OBJECT SET ENABLED:C1123(*; "bValidate@"; False:C215)
				OBJECT SET ENABLED:C1123(*; "bValidate@"; False:C215)
				UNLOAD RECORD:C212([LSS_Inspection:164])
				READ ONLY:C145([LSS_Inspection:164])
				LOAD RECORD:C52([LSS_Inspection:164])
				InitChangeStack(1)
				ut_SetReadWrite("Read"; ->[LSS_ElementInspection:163]; ->[LSS_Photos:166]; ->[LSS_Accessibility:159]; ->[LSS_DMeter:161]; ->[LSS_UT:175]; ->[LSS_UtResult:176]; ->[LSS_TeamMembers:173])
				ut_SetReadWrite("Read"; ->[LSS_SignPanel:172]; ->[LSS_TowerDistance:174]; ->[LSS_VerticalClearance:177])
				
				LSS_AllowInspectionEdit_B:=False:C215
				LSS_AllowInspectionDelete_B:=False:C215
				
		End case 
	Else 
		CANCEL TRANSACTION:C241
		
		START TRANSACTION:C239
		UNLOAD RECORD:C212([LSS_Inspection:164])
		READ ONLY:C145([LSS_Inspection:164])
		LOAD RECORD:C52([LSS_Inspection:164])
		InitChangeStack(1)
		ut_SetReadWrite("Read"; ->[LSS_ElementInspection:163]; ->[LSS_Photos:166]; ->[LSS_Accessibility:159]; ->[LSS_DMeter:161]; ->[LSS_UT:175]; ->[LSS_UtResult:176]; ->[LSS_TeamMembers:173])
		ut_SetReadWrite("Read"; ->[LSS_SignPanel:172]; ->[LSS_TowerDistance:174]; ->[LSS_VerticalClearance:177])
		LSS_AllowInspectionEdit_B:=False:C215
		LSS_AllowInspectionDelete_B:=False:C215
		OBJECT SET ENABLED:C1123(*; "bValidate@"; False:C215)
		
	End if 
End if 
If ($Option_L=2)  //Stay on damage page
	LSS_InpectionTabs_as:=Find in array:C230(LSS_InpectionTabs_as; "Damage")
	
Else 
	If (LSS_AllowInspectionEdit_B)
		Case of 
			: (LSS_InpectionTabs_as{FORM Get current page:C276}="Inspection")  //when leaving insopection page always save and restart transaction
				LSS_InspectionRecSave
				VALIDATE TRANSACTION:C240
				START TRANSACTION:C239
				
			: (LSS_InpectionTabs_as{FORM Get current page:C276}="D-METER")
				
				
				
			: (LSS_InpectionTabs_as{FORM Get current page:C276}="Ultrasonic Testing")
				
			: (LSS_InpectionTabs_as{FORM Get current page:C276}="Images") | (LSS_InpectionTabs_as{FORM Get current page:C276}="@Photos@")
				
				If (LSS_PhotoUpdateSeq_b)
					
					If (False:C215)
						LSS_ResequenceInspPhotos
						
					Else 
						EXECUTE METHOD IN SUBFORM:C1085("LSSImagesSubForm"; "NTI_ApplyImageSort")
					End if 
				End if 
				
		End case 
	End if 
	C_TEXT:C284($ERORMETHOD_TXT)
	$ERORMETHOD_TXT:=Method called on error:C704
	ON ERR CALL:C155("MissingSetError")
	CLEAR NAMED SELECTION:C333("UTResults_LB")
	CLEAR NAMED SELECTION:C333("UT_LB")
	ON ERR CALL:C155($ERORMETHOD_TXT)
	Case of 
		: (LSS_InpectionTabs_as{LSS_InpectionTabs_as}="Inspection")
			OBJECT SET VISIBLE:C603(*; "bDelete"; LSS_AllowInspectionDelete_B)
		: (LSS_InpectionTabs_as{LSS_InpectionTabs_as}="Sign Panels")
			
			OBJECT SET VISIBLE:C603(*; "PlusButton@"; True:C214)
			//ENABLE BUTTON(*;"PlusButton@")
		: (LSS_InpectionTabs_as{LSS_InpectionTabs_as}="D-Meter")
			
			//OBJECT SET VISIBLE(*;"PlusButton@";True)
			CLEAR VARIABLE:C89(LSS_DMeterPicture_pct)
			LSS_PhotoDescription_txt:=""
			//ENABLE BUTTON(*;"PlusButton@")
			
			QUERY:C277([LSS_Photos:166]; [LSS_Photos:166]LSS_InspectionId_s:2=[LSS_Inspection:164]LSS_InspectionId_s:1; *)
			QUERY:C277([LSS_Photos:166];  & ; [LSS_Photos:166]LSS_PhotoType_s:3="Sketch D Meter")
			
			If (Records in selection:C76([LSS_Photos:166])=1)
				OBJECT SET VISIBLE:C603(*; "DMeterInput_2"; True:C214)
				OBJECT SET VISIBLE:C603(*; "DMeterInput_3"; True:C214)
				OBJECT SET VISIBLE:C603(*; "Rectangle"; False:C215)
				OBJECT SET VISIBLE:C603(*; "NODMeterPict"; False:C215)
				BLOB TO PICTURE:C682([LSS_Photos:166]LSS_Photo_blb:5; LSS_DMeterPicture_pct)
				LSS_PhotoDescription_txt:=[LSS_Photos:166]LSS_Photo_txt:4
				C_BOOLEAN:C305($SetDMeterButtons_B)
				$SetDMeterButtons_B:=LSS_AllowInspectionEdit_B
				If (LSS_AllowInspectionEdit_B)
					//make sure [LSS_Photos] is read write mode
					If (ut_LoadRecordInteractiveV2(->[LSS_Photos:166])=1)
						$SetDMeterButtons_B:=True:C214
					Else 
						$SetDMeterButtons_B:=False:C215
					End if 
					
					OBJECT SET TITLE:C194(*; "DMeterButton_L"; "Modify D Meter Sketch")
				Else 
					$SetDMeterButtons_B:=False:C215
					
				End if 
			Else 
				OBJECT SET VISIBLE:C603(*; "DMeterInput_2"; False:C215)
				OBJECT SET VISIBLE:C603(*; "DMeterInput_3"; False:C215)
				OBJECT SET VISIBLE:C603(*; "Rectangle"; True:C214)
				OBJECT SET VISIBLE:C603(*; "NODMeterPict"; True:C214)
				
				$SetDMeterButtons_B:=LSS_AllowInspectionEdit_B
				
				CLEAR VARIABLE:C89(LSS_UTPicture_pct)
				LSS_PhotoDescription_txt:=""
				OBJECT SET TITLE:C194(*; "DMeterButton_L"; "Add D Meter Sketch")
			End if 
			OBJECT SET VISIBLE:C603(*; "DMeterButton1"; $SetDMeterButtons_B)
			OBJECT SET VISIBLE:C603(*; "DMeterButton_L"; $SetDMeterButtons_B)
			//OBJECT SET ENTERABLE(*;"DMeterInput_2";$SetDMeterButtons_B)
			OBJECT SET ENTERABLE:C238(*; "DMeterInput_3"; $SetDMeterButtons_B)
			OBJECT SET VISIBLE:C603(*; "D-MeterReadonlyNote"; Not:C34($SetDMeterButtons_B))
			C_LONGINT:C283($Color_L)
			$Color_L:=-(Red:K11:4+(256*White:K11:1))
			OBJECT SET RGB COLORS:C628(*; "D-MeterReadonlyNote"; Col_paletteToRGB(Abs:C99($Color_L)%256); Col_paletteToRGB(Abs:C99($Color_L)\256))  // **Replaced o OBJECT SET COLOR(*; "D-MeterReadonlyNote"; $Color_L)
		: (LSS_InpectionTabs_as{LSS_InpectionTabs_as}="Ultrasonic Testing")
			
			LSS_PhotoDescription_txt:=""
			CLEAR VARIABLE:C89(LSS_UTPicture_pct)
			
			C_BOOLEAN:C305($SetUTButtons_B)
			
			//ENABLE BUTTON(*;"PlusButton@")
			QUERY:C277([LSS_UT:175]; [LSS_UT:175]LSS_InspectionId_s:2=[LSS_Inspection:164]LSS_InspectionId_s:1)
			COPY NAMED SELECTION:C331([LSS_UT:175]; "UT_LB")
			$ERORMETHOD_TXT:=Method called on error:C704
			ON ERR CALL:C155("MissingSetError")
			CLEAR NAMED SELECTION:C333("UTResults_LB")
			ON ERR CALL:C155($ERORMETHOD_TXT)
			QUERY:C277([LSS_Photos:166]; [LSS_Photos:166]LSS_InspectionId_s:2=[LSS_Inspection:164]LSS_InspectionId_s:1; *)
			QUERY:C277([LSS_Photos:166];  & ; [LSS_Photos:166]LSS_PhotoType_s:3="Sketch UT")
			If (Records in selection:C76([LSS_Photos:166])=1)
				OBJECT SET TITLE:C194(*; "UTButton_L"; "Modify UT Sketch")
				OBJECT SET VISIBLE:C603(*; "UTInput_1"; True:C214)
				OBJECT SET VISIBLE:C603(*; "UT_SketchComents"; True:C214)
				OBJECT SET VISIBLE:C603(*; "NOUTPict"; False:C215)
				BLOB TO PICTURE:C682([LSS_Photos:166]LSS_Photo_blb:5; LSS_UTPicture_pct)
				LSS_PhotoDescription_txt:=[LSS_Photos:166]LSS_Photo_txt:4
				
				If (LSS_AllowInspectionEdit_B)
					
					//make sure [LSS_Photos] is read write mode
					If (ut_LoadRecordInteractiveV2(->[LSS_Photos:166])=1)
						$SetUTButtons_B:=True:C214
					Else 
						$SetUTButtons_B:=False:C215
					End if 
					
				End if 
				
			Else 
				OBJECT SET VISIBLE:C603(*; "UTInput_1"; False:C215)
				OBJECT SET VISIBLE:C603(*; "UT_SketchComents"; False:C215)
				OBJECT SET VISIBLE:C603(*; "NOUTPict"; True:C214)
				
				If (LSS_AllowInspectionEdit_B)
					$SetUTButtons_B:=True:C214
				Else 
					$SetUTButtons_B:=False:C215
				End if 
				CLEAR VARIABLE:C89(LSS_UTPicture_pct)
				LSS_PhotoDescription_txt:=""
				OBJECT SET TITLE:C194(*; "UTButton_L"; "Add UT Sketch")
			End if 
			
			OBJECT SET VISIBLE:C603(*; "UTButton_L"; $SetUTButtons_B)
			OBJECT SET ENTERABLE:C238(*; "UTInput_1"; $SetUTButtons_B)
			//OBJECT SET ENTERABLE(*;"UT_SketchComents";$SetUTButtons_B)
			OBJECT SET VISIBLE:C603(*; "UTReadonlyNote"; Not:C34($SetUTButtons_B))
			C_LONGINT:C283($Color_L)
			$Color_L:=-(Red:K11:4+(256*White:K11:1))
			OBJECT SET RGB COLORS:C628(*; "UTReadonlyNote"; Col_paletteToRGB(Abs:C99($Color_L)%256); Col_paletteToRGB(Abs:C99($Color_L)\256))  // **Replaced o OBJECT SET COLOR(*; "UTReadonlyNote"; $Color_L)
			OBJECT SET VISIBLE:C603(*; "UTResults_LB"; False:C215)
			If (Read only state:C362([LSS_Inspection:164]))
				OBJECT SET ENTERABLE:C238(*; "PlusButton@"; False:C215)
			End if 
		: ((LSS_InpectionTabs_as{LSS_InpectionTabs_as}="Images") | (LSS_InpectionTabs_as{LSS_InpectionTabs_as}="@Photos@"))
			
			LSS_GetImages
			
			If (Size of array:C274(v_166_001_atxt)=0)
				LSS_ResequencePictures("Load")
			End if 
			
		: (LSS_InpectionTabs_as{LSS_InpectionTabs_as}="Damage")
			OBJECT SET VISIBLE:C603(*; "BostonOnly@"; True:C214)
			
			C_BOOLEAN:C305($Enterable_B)
			$Enterable_B:=(GRP_UserInGroup("LSS_BostonOffice")=1)
			If (Not:C34($Enterable_B))
				If (User in group:C338(Current user:C182; "Design Access Group"))
					CONFIRM:C162("Do you "+Current user:C182+" want to edit the Damage info"; "Edit"; "Read Only")
					$Enterable_B:=(OK=1)
				End if 
			End if 
			OBJECT SET ENABLED:C1123(*; "DamageByCheckBox"; False:C215)
			OBJECT SET ENTERABLE:C238(*; "Damage@"; False:C215)
			OBJECT SET RGB COLORS:C628(*; "Damage@"; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "Damage@"; <>Color_Not_Editable)
			
			OBJECT SET ENTERABLE:C238(*; "BostonOnly_3"; False:C215)
			OBJECT SET ENTERABLE:C238(*; "BostonOnly_5"; False:C215)
			OBJECT SET ENTERABLE:C238(*; "BostonOnly_7"; False:C215)
			OBJECT SET RGB COLORS:C628(*; "BostonOnly_3"; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "BostonOnly_3"; <>Color_Not_Editable)
			OBJECT SET RGB COLORS:C628(*; "BostonOnly_5"; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "BostonOnly_5"; <>Color_Not_Editable)
			OBJECT SET RGB COLORS:C628(*; "BostonOnly_7"; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "BostonOnly_7"; <>Color_Not_Editable)
			
			If ($Enterable_B)
				OBJECT SET ENABLED:C1123(*; "bValidate@"; True:C214)
				If ([LSS_Inspection:164]LSS_Approved_L:43=BMS Approved)  //If (Read only state([LSS_Inspection]))
					READ WRITE:C146([LSS_Inspection:164])
					LOAD RECORD:C52([LSS_Inspection:164])
					LSS_AllowInspectionEdit_B:=True:C214
					LSS_EditingInspection_B:=True:C214
					LSS_EditDamageOnly_B:=True:C214
					OBJECT SET ENTERABLE:C238(*; "Damage@"; False:C215)
					OBJECT SET ENABLED:C1123(*; "DamageByCheckBox"; False:C215)
					OBJECT SET RGB COLORS:C628(*; "Damage@"; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "Damage@"; <>Color_Not_Editable)
					OBJECT SET ENTERABLE:C238(*; "BostonOnly_@"; True:C214)
					OBJECT SET RGB COLORS:C628(*; "BostonOnly_3"; Col_paletteToRGB(Abs:C99(<>Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "BostonOnly_3"; <>Color_Editable)
					OBJECT SET RGB COLORS:C628(*; "BostonOnly_5"; Col_paletteToRGB(Abs:C99(<>Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "BostonOnly_5"; <>Color_Editable)
					OBJECT SET RGB COLORS:C628(*; "BostonOnly_7"; Col_paletteToRGB(Abs:C99(<>Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "BostonOnly_7"; <>Color_Editable)
					
					
				Else 
					OBJECT SET ENTERABLE:C238(*; "Damage@"; True:C214)
					OBJECT SET ENABLED:C1123(*; "DamageByCheckBox"; True:C214)
					OBJECT SET RGB COLORS:C628(*; "Damage@"; Col_paletteToRGB(Abs:C99(<>Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "Damage@"; <>Color_Editable)
				End if 
				
				
			Else 
				OBJECT SET RGB COLORS:C628(*; "BostonOnly_3"; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "BostonOnly_3"; <>Color_Not_Editable)
				OBJECT SET RGB COLORS:C628(*; "BostonOnly_5"; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "BostonOnly_5"; <>Color_Not_Editable)
				OBJECT SET RGB COLORS:C628(*; "BostonOnly_7"; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "BostonOnly_7"; <>Color_Not_Editable)
				OBJECT SET ENTERABLE:C238(*; "BostonOnly@"; False:C215)
				If (Read only state:C362([LSS_Inspection:164]))
					OBJECT SET ENABLED:C1123(*; "bValidate@"; False:C215)
				End if 
				
				
			End if 
			
			
	End case 
End if 
FORM GOTO PAGE:C247(LSS_InpectionTabs_as)
//End method LSS_GotToInspectionPage