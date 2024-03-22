//%attributes = {"invisible":true}
// Method: FM_PhotoInput
// Description
// Form event method for LSS_Photos; Input form
// Parameters
// $1 : $FormEvent_L (Optional)
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): administrator
	// Date and time: 10/14/14, 15:03:38
	// ----------------------------------------------------
	//
	// ----------------------------------------------------
	// Modified by: Costas Manousakis-(Designer)-(9/14/15 13:42:46)
	Mods_2015_09_bug
	//  `for new record initialize  phototype and sequence based on last used type,  if first time default to photo
	Mods_2018_06_bug  //Make changes to [LSS_Photos] input to try and fix problems with blank [Activity Log] records
	//Modified by: Chuck Miller (6/5/18 15:10:36)
	Mods_2018_11  // Change code from
	//_ o _ENABLE BUTTON and _ o _DISABLE to
	//OBJECT SET ENABLED
	//Modified by: Chuck Miller (11/19/18 12:28:01)
	Mods_2020_09  //Make changes so that UT and d-meter pictures Added and modified using the [LSS_Photos];"Input" form
	//Modified by: CJ (9/3/20 15:39:44)
End if 

C_LONGINT:C283($FormEvent_L; $Choice_L)

If (Count parameters:C259=1)
	C_LONGINT:C283($1)
	$FormEvent_L:=$1
End if 
Case of 
	: (Form event code:C388=On Load:K2:1) | ($FormEvent_L=On Load:K2:1)
		CLEAR VARIABLE:C89(Photo_pct)
		
		//C_LONGINT($l;$t;$r;$b;$Width_L;$Height_L)
		//GET FORM PROPERTIES([LSS_Photos];"Input";$Width_L;$Height_L)
		//GET WINDOW RECT($l;$t;$r;$b)
		//SET WINDOW RECT($l;$t;$l+$Width_L+5;$t+$Height_L+5)
		If (Type:C295(LSS_PhotoTypes_atxt)=Is undefined:K8:13)
			ARRAY TEXT:C222(LSS_PhotoTypes_atxt; 0)
		End if 
		If (Size of array:C274(LSS_PhotoTypes_atxt)=0)
			ARRAY TEXT:C222(LSS_PhotoTypes_atxt; 4)
			LSS_PhotoTypes_atxt{1}:=""
			LSS_PhotoTypes_atxt{2}:="Sketch"
			LSS_PhotoTypes_atxt{3}:="Chart"
			LSS_PhotoTypes_atxt{4}:="Photo"
		End if 
		
		InitChangeStack(5)  //[LSS_Photos]
		If (Is new record:C668([LSS_Photos:166]))
			[LSS_Photos:166]LSS_InspectionId_s:2:=[LSS_Inspection:164]LSS_InspectionId_s:1
			C_LONGINT:C283($ID_L)
			
			Inc_Sequence("LSS_PhotoId_s"; ->$ID_L)
			[LSS_Photos:166]LSS_PhotoId_s:1:=String:C10($ID_L; <>KeyMask_s)
			
			LSS_SetUpButtonsForNewRecords
			C_PICTURE:C286(Photo_pct)
			CLEAR VARIABLE:C89(Photo_pct)
			OBJECT SET RGB COLORS:C628(*; "@"; Col_paletteToRGB(Abs:C99(<>Color_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "@"; <>Color_editable)
			OBJECT SET RGB COLORS:C628(*; "LSS_IDs@"; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "LSS_IDs@"; <>Color_Not_Editable)
			LSS_SetEntryColor(->[LSS_Photos:166])
			OBJECT SET ENTERABLE:C238(*; "LSS_Photos@"; True:C214)
			OBJECT SET VISIBLE:C603(*; "LSS_PhotosInstructions@"; True:C214)
			
			If (v_166_003_txt="")
				OBJECT SET ENABLED:C1123(*; "LSS_PhotoTypes_atxt@"; True:C214)
				
				
				
				If (LSS_PhotoTypes_atxt<2)
					LSS_PhotoTypes_atxt:=Find in array:C230(LSS_PhotoTypes_atxt; "Phot@")  //default to the Photo
				Else 
					// use the last image type selected
				End if 
				[LSS_Photos:166]LSS_PhotoType_s:3:=LSS_PhotoTypes_atxt{LSS_PhotoTypes_atxt}
				C_TEXT:C284($Type_txt; $Key_s)
				C_LONGINT:C283($Sequence_L)
				//C_STRING(13;$Key_s)
				$Key_s:=[LSS_Inspection:164]LSS_InspectionId_s:1
				$Type_txt:=[LSS_Photos:166]LSS_PhotoType_s:3
				Begin SQL
					select max([LSS_Photos].[LSS_PhotoSequence_L])
					from [LSS_Photos]
					where [LSS_Photos].[LSS_InspectionId_s] = :$Key_s
					and
					[LSS_Photos].[LSS_PhotoType_s]=:$Type_txt
					into :$Sequence_L
				End SQL
				[LSS_Photos:166]LSS_PhotoSequence_L:6:=$Sequence_L+1
			Else 
				
				[LSS_Photos:166]LSS_PhotoType_s:3:=v_166_003_txt
				FORM GOTO PAGE:C247(2)
			End if 
		Else 
			If (v_166_003_txt="")
				LSS_PhotoTypes_atxt:=Find in array:C230(LSS_PhotoTypes_atxt; [LSS_Photos:166]LSS_PhotoType_s:3)
				
				LSS_SetPrevNextButtons(LSS_SelectedRow_L; Records in selection:C76([LSS_Photos:166]))
				
			Else 
				
				FORM GOTO PAGE:C247(2)
			End if 
			//SET COLOR(*;"@";◊Color_editable)
			OBJECT SET RGB COLORS:C628(*; "LSS_IDs@"; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "LSS_IDs@"; <>Color_Not_Editable)
			C_PICTURE:C286(Photo_pct)
			LSS_SetEntryColor(->[LSS_Photos:166])
			
			BLOB TO PICTURE:C682([LSS_Photos:166]LSS_Photo_blb:5; Photo_pct)
			C_BOOLEAN:C305($Entry_b)
			$Entry_b:=False:C215
			Case of 
				: (Not:C34(LSS_AllowInspectionEdit_B))
				: (Read only state:C362([LSS_Photos:166]))
				Else 
					$Entry_b:=True:C214
					
			End case 
			OBJECT SET ENABLED:C1123(*; "bValidate@"; $Entry_b)
			OBJECT SET ENABLED:C1123(*; "bDelete@"; $Entry_b)
			OBJECT SET ENABLED:C1123(*; "LSS_PhotoTypes_atxt"; $Entry_b)
			
			
			OBJECT SET ENTERABLE:C238(*; "LSS_Photo@"; $Entry_b)
			OBJECT SET VISIBLE:C603(*; "LSS_PhotosInstructions@"; $Entry_b)
		End if 
		If (v_166_003_txt="")
			
		Else 
			
			Case of 
				: (Position:C15("UT"; v_166_003_txt)>0)
					OBJECT SET TITLE:C194(*; "ImageTypeDesc "; "UT Sketch")
				: (Position:C15("Meter"; v_166_003_txt)>0)
					OBJECT SET TITLE:C194(*; "ImageTypeDesc "; "D Meter Sketch")
			End case 
			OBJECT SET ENTERABLE:C238(*; "LSS_Photo_type"; False:C215)
		End if 
	: (Form event code:C388=On Validate:K2:3) | ($FormEvent_L=On Validate:K2:3)
		
		//FM_PhotoInputSave  `removed 6/15/15
		
End case 