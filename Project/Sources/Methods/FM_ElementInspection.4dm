//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 03/31/15, 15:45:16
//----------------------------------------------------
//Method: FM_ElementInspection
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (3/31/15 15:45:19)
	Mods_2015_07_bug  // 
	//Make sure POPUPMENUC runs as an on load option by setting first array to locatikon to zero
	//Modified by: administrator (8/6/15 14:10:16)
	Mods_2018_06
	//Add new fields to LSS [LSS_ElementInspection] table for Damage Inspection type
	//Modified by: Chuck Miller (6/28/18 17:19:42)
	Mods_2018_11  // Change code from
	//_ o _ENABLE BUTTON and _ o _DISABLE to
	//OBJECT SET ENABLED
	//Modified by: Chuck Miller (11/19/18 12:28:01)
End if 
// ----------------------------------------------------
C_LONGINT:C283($FormEvent_L)

If (Count parameters:C259=1)
	C_LONGINT:C283($1)
	$FormEvent_L:=$1
End if 
Case of 
	: (Form event code:C388=On Load:K2:1) | ($FormEvent_L=On Load:K2:1)
		
		//C_LONGINT($l;$t;$r;$b;$Width_L;$Height_L)
		//GET FORM PROPERTIES([LSS_ElementInspection];"Input";$Width_L;$Height_L)
		//GET WINDOW RECT($l;$t;$r;$b)
		//SET WINDOW RECT($l;$t;$l+$Width_L+5;$t+$Height_L+20)
		
		//ARRAY POINTER(ptr_Changes;0;0)
		InitChangeStack(3)  //[LSS_ElementInspection]
		If (LSS_IsNewESRecord_B)
			LSS_RatingChoices_as:=0
			LSS_Deficiency_as:=0
			LSS_Urgency_as:=0
			//[LSS_ElementInspection]LSS_ElementId_L:=v_163_002_aL{LSS_SelectedRow_L}
			[LSS_ElementInspection:163]LSS_InspectionId_s:3:=[LSS_Inspection:164]LSS_InspectionId_s:1
			[LSS_ElementInspection:163]LSS_ElementId_L:2:=v_163_002_aL{LSS_SelectedRow_L}
			//C_LONGINT($ID_L)
			//
			//Inc_Sequence ("LSS_ElementInspectionId_s";->$ID_L)
			//[LSS_ElementInspection]LSS_ElementInspectionId_s:=String($ID_L;◊KeyMask_s)
			//
			//LogNewRecord (->[LSS_ElementInspection]LSS_ElementInspectionId_s;->[LSS_ElementInspection]LSS_ElementInspectionId_s;->[LSS_ElementInspection]LSS_ElementInspectionId_s;0;"LSS_ElementInspection")
			
			
		End if 
		C_BOOLEAN:C305($Header_b)
		C_LONGINT:C283($ID_L)
		$ID_L:=[LSS_ElementInspection:163]LSS_ElementId_L:2
		Begin SQL
			select
			[LSS_Element].[LSS_ElementHeader_b]
			from
			[LSS_Element]
			where
			[LSS_Element].[LSS_ElementId_L] = :$ID_L
			into :$Header_b;
		End SQL
		LSS_SetPrevNextButtons(LSS_SelectedRow_L; Size of array:C274(v_163_007_atxt))
		
		OBJECT SET RGB COLORS:C628(*; "@"; Col_paletteToRGB(Abs:C99(<>Color_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_editable)\256))  // **Replaced o OBJECT SET COLOR(*;"@";<>Color_editable)
		
		OBJECT SET RGB COLORS:C628(*; "LSS_IDs@"; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced o OBJECT SET COLOR(*;"LSS_IDs@";<>Color_Not_Editable)
		OBJECT SET RGB COLORS:C628(*; "DisplayOnly@"; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced o OBJECT SET COLOR(*;"DisplayOnly@";<>Color_Not_Editable)
		C_BOOLEAN:C305($Entry_b)
		$Entry_b:=False:C215
		Case of 
			: (Not:C34(LSS_AllowInspectionEdit_B))
			: (Read only state:C362([LSS_ElementInspection:163]))
			Else 
				$Entry_b:=True:C214
				
		End case 
		
		If ($Entry_b)
			OBJECT SET ENABLED:C1123(*; "bValidate@"; $Entry_b)
			OBJECT SET ENABLED:C1123(*; "bDelete@"; $Entry_b)
			OBJECT SET ENABLED:C1123(*; "LSS_RatingChoices_as@"; $Entry_b)
			OBJECT SET ENABLED:C1123(*; "DamageInfo_@"; $Entry_b)
			If ($Header_b)
				OBJECT SET VISIBLE:C603(*; "LSS_Remarks@"; False:C215)
				OBJECT SET VISIBLE:C603(*; "LSS_Deficiency@"; False:C215)
				OBJECT SET VISIBLE:C603(*; "LSS_Urgency@"; False:C215)
				OBJECT SET VISIBLE:C603(*; "LSS_Description@"; False:C215)
				
			Else 
				OBJECT SET VISIBLE:C603(*; "LSS_Remarks@"; True:C214)
				OBJECT SET VISIBLE:C603(*; "LSS_Deficiency@"; True:C214)
				OBJECT SET VISIBLE:C603(*; "LSS_Urgency@"; True:C214)
				OBJECT SET VISIBLE:C603(*; "LSS_Description@"; True:C214)
				OBJECT SET ENABLED:C1123(*; "LSS_Deficiency_as@"; $Entry_b)
				OBJECT SET ENABLED:C1123(*; "LSS_Urgency_as@"; $Entry_b)
				OBJECT SET ENTERABLE:C238(*; "LSS@"; True:C214)
			End if 
		Else 
			OBJECT SET ENABLED:C1123(*; "bValidate@"; $Entry_b)
			OBJECT SET ENABLED:C1123(*; "bDelete@"; $Entry_b)
			OBJECT SET ENABLED:C1123(*; "LSS_RatingChoices_as@"; $Entry_b)
			OBJECT SET ENABLED:C1123(*; "LSS_Deficiency_as@"; $Entry_b)
			OBJECT SET ENABLED:C1123(*; "LSS_Urgency_as@"; $Entry_b)
			OBJECT SET ENABLED:C1123(*; "DamageInfo_@"; $Entry_b)
			
			
			OBJECT SET ENTERABLE:C238(*; "LSS@"; False:C215)
			OBJECT SET RGB COLORS:C628(*; "LSS_Description_txt"; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced o OBJECT SET COLOR(*;"LSS_Description_txt";<>Color_Not_Editable)
			OBJECT SET RGB COLORS:C628(*; "LSS_Remarks_txt"; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced o OBJECT SET COLOR(*;"LSS_Remarks_txt";<>Color_Not_Editable)
		End if 
		//Make sure POPUPMENUC runs as an on load option by setting first array to locatikon to zero
		LSS_Urgency_as:=0
		LSS_RatingChoices_as:=0
		LSS_Deficiency_as:=0
		POPUPMENUC(->LSS_Urgency_as; ->LSS_Urgency_as; ->[LSS_ElementInspection:163]LSS_Urgency_s:6)
		POPUPMENUC(->LSS_RatingChoices_as; ->LSS_RatingChoices_as; ->[LSS_ElementInspection:163]LSS_Rating_s:4)
		POPUPMENUC(->LSS_Deficiency_as; ->LSS_Deficiency_as; ->[LSS_ElementInspection:163]LSS_Deficiency_s:5)
		C_LONGINT:C283($loop_l)
		If ([LSS_refInspectionType:167]LSS_Description_txt:2="DAMAGE@")
			COPY ARRAY:C226(LSS_RatingChoices_as; v_163_013_atxt)
			v_163_013_atxt:=0
			ARRAY TEXT:C222(v_163_014_atxt; 0)
			ARRAY TEXT:C222(v_163_014_atxt; 10)
			v_163_014_atxt{1}:=""
			For ($loop_l; 2; 10)
				v_163_014_atxt{$loop_l}:=String:C10($loop_l-1)
			End for 
			v_163_014_atxt:=0
			POPUPMENUC(->v_163_013_atxt; ->v_163_013_atxt; ->[LSS_ElementInspection:163]LSS_DamagePreviousCondition_s:13)
			POPUPMENUC(->v_163_014_atxt; ->v_163_014_atxt; ->[LSS_ElementInspection:163]LSS_DamageWeldCondition_s:14)
			
		End if 
		OBJECT SET VISIBLE:C603(*; "DamageInfo@"; ([LSS_refInspectionType:167]LSS_Description_txt:2="DAMAGE@") & (Not:C34($Header_b)))
		If ([LSS_refInspectionType:167]LSS_Description_txt:2="DAMAGE@")
			OBJECT SET TITLE:C194(*; "LSS_Remarks"; "Location and Description of Damage :")
		Else 
			OBJECT SET TITLE:C194(*; "LSS_Remarks"; "Remarks :")
		End if 
		
End case 
//End FM_ElementInspection