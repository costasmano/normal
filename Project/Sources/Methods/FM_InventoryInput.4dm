//%attributes = {"invisible":true}
// Method: FM_InventoryInput
// Description
// Form method for [LSS_inventory];"Input"
//
// Parameters
// $1 : $FormEvent (optional)
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): administrator
	// Date and time: 09/11/14, 16:29:25
	// ----------------------------------------------------
	Mods_2015_07_bug  // 
	//Make sure POPUPMENUC runs as an on load option by setting first array to locatikon to zero
	//Modified by: administrator (8/6/15 14:10:16)
	Mods_2015_08_bug
	//  `Added EditIDNum button to the list of enable/disable buttons
	Mods_2015_11  //Add ability to approve or reject  LSS inspections 
	//Modified by: administrator (11/10/15 16:45:30)
	Mods_2016_01_bug  // Add item that user can change in Structure number
	//Modified by: administrator (1/7/16 14:53:31)
	// Modified by: Costas Manousakis-(Designer)-(10/4/18 17:45:24)
	Mods_2018_10
	//  `added Owner
	// Modified by: Costas Manousakis-(Designer)-(2/12/19 12:13:10)
	Mods_2019_02_bug
	//  `enable import button for Designer
	// Modified by: Costas Manousakis-(Designer)-(12/21/20 17:18:58)
	Mods_2020_12_bug
	//  `don't hide "ArmLength2@" objects for highway signs. They are needed. Call Reference #761
	
	// Modified by: manousakisc (4/28/2023)
	Mods_2023_LSSNew
	// added dropdown for status , entries for PRoj no built, Proj no removed, buttons to open Pinfo. re-arranged fileds.
	// Modified by: manousakisc-(Designer)-(9/7/2023 09:57:49)
	Mods_2023_LSSNew
	//  `Allow all to be able to change status from anything to anything and change the pinfo numbers
End if 
C_LONGINT:C283($FormEvent_L)

If (Count parameters:C259=1)
	C_LONGINT:C283($1)
	$FormEvent_L:=$1
End if 
Case of 
	: (Form event code:C388=On Load:K2:1) | ($FormEvent_L=On Load:K2:1)
		LSS_Edit_MilePoint("LOCK")
		C_LONGINT:C283($l; $t; $r; $b; $Width_L; $Height_L)
		FORM GET PROPERTIES:C674([LSS_Inventory:165]; "Input"; $Width_L; $Height_L)
		GET WINDOW RECT:C443($l; $t; $r; $b)
		SET WINDOW RECT:C444($l; $t; $l+$Width_L+5; $t+$Height_L+5)
		
		LSS_MovingInvRecords_B:=False:C215
		
		START TRANSACTION:C239
		LSS_InitChangeStacks
		LSS_PermissionDELInventory
		OBJECT SET VISIBLE:C603(*; "bDelete"; LSS_AllowInventoryDelete_B)
		
		LSS_SetUpInventoryListBox
		LSS_Built_L:=0
		LSSRehab_L:=0
		LSSReplaced_L:=0
		If ([LSS_Inventory:165]LSS_YearBuilt_s:11="Unknown")
			LSS_Built_L:=1
		End if 
		If ([LSS_Inventory:165]LSS_YearRehabbed_s:13="Unknown")
			LSSRehab_L:=1
		End if 
		If ([LSS_Inventory:165]LSS_YearRemoved_s:12="Unknown")
			LSSReplaced_L:=1
		End if 
		C_LONGINT:C283(<>Color_Not_editable; <>Color_Alert_Field; <>Color_Editable; <>LSS_ListBoxColor_L)  //Command Replaced was o_C_INTEGER
		C_TEXT:C284(LSS_StructureClass_txt)
		<>Color_Editable:=-(Blue:K11:7+(256*Grey:K11:15))
		<>Color_Not_editable:=-(Blue:K11:7+(256*Light grey:K11:13))
		<>Color_Alert_Field:=-(Dark blue:K11:6+(256*Red:K11:4))
		<>LSS_ListBoxColor_L:=-(Black:K11:16+(256*White:K11:1))
		LSS_SetEntryColor(->[LSS_Inventory:165])
		
		LSS_ArmDescriptor1_txt:="Number of Arms : "
		LSS_ArmDescriptor2_txt:="Arm Length 1 : "
		OBJECT SET VISIBLE:C603(*; "Rehabbed@"; False:C215)
		OBJECT SET VISIBLE:C603(*; "LSSRehab_L"; False:C215)
		
		OBJECT SET VISIBLE:C603(*; "ArmLength2@"; True:C214)
		OBJECT SET VISIBLE:C603(*; "HeightFromBaseToArm2@"; False:C215)
		OBJECT SET VISIBLE:C603(*; "HeightFromBaseToArm1@"; True:C214)
		Case of 
			: ([LSS_Inventory:165]LSS_InventoryType_s:28="HS")
				LSS_StructureClass_txt:="Highway Sign"
				LSS_StructTypeDescriptor_txt:="Sign Structure Type: "
				LSS_ArmDescriptor1_txt:="Number of Spans : "
				LSS_ArmDescriptor2_txt:="Span / Arm Length : "
				//OBJECT SET VISIBLE(*;"ArmLength2@";False)
				OBJECT SET VISIBLE:C603(*; "HeightFromBaseToArm@"; False:C215)
				
				OBJECT SET VISIBLE:C603(*; "Rehabbed@"; True:C214)
				OBJECT SET VISIBLE:C603(*; "LSSRehab_L"; True:C214)
				
			: ([LSS_Inventory:165]LSS_InventoryType_s:28="LI")
				LSS_StructureClass_txt:="Lighting"
				LSS_StructTypeDescriptor_txt:="Light Structure Type: "
				LSS_HeightDescriptor1_txt:="Height from Base Plate to Lower Arm : "
				LSS_HeightDescriptor2_txt:="Height from Base Plate to Upper Arm : "
				OBJECT SET VISIBLE:C603(*; "HeightFromBaseToArm2@"; True:C214)
				
			: ([LSS_Inventory:165]LSS_InventoryType_s:28="SI")
				LSS_StructureClass_txt:="Signal"
				LSS_StructTypeDescriptor_txt:="Signal Structure Type: "
				LSS_HeightDescriptor1_txt:="Height from Base Plate to Arm (Left) : "
				LSS_HeightDescriptor2_txt:="Height from Base Plate to Arm (Right) : "
				OBJECT SET VISIBLE:C603(*; "HeightFromBaseToArm2@"; True:C214)
				
			: ([LSS_Inventory:165]LSS_InventoryType_s:28="IT")
				LSS_StructureClass_txt:="Intelligent Structure"
				LSS_StructTypeDescriptor_txt:="ITS Structure Type: "
				LSS_HeightDescriptor1_txt:="Height from Base Plate to Lower Arm : "
				LSS_HeightDescriptor2_txt:="Height from Base Plate to Upper Arm : "
				OBJECT SET VISIBLE:C603(*; "HeightFromBaseToArm2@"; True:C214)
				
		End case 
		
		LSS_LoadArraysForInputForm
		//setup popup menus here
		//Make sure POPUPMENUC runs as an on load option by setting first array to locatikon to zero
		v_170_002_atxt:=0
		v_171_003_atxt:=0
		v_169_002_atxt:=0
		POPUPMENUC(->v_170_002_atxt; ->v_170_001_atxt; ->[LSS_Inventory:165]LSS_StructureMaterialId_s:15)
		POPUPMENUC(->v_171_003_atxt; ->v_171_001_atxt; ->[LSS_Inventory:165]LSS_StructureTypeId_s:25)
		POPUPMENUC(->v_169_002_atxt; ->v_169_001_atxt; ->[LSS_Inventory:165]LSS_StructureCoatingId_s:16)
		POPUPMENUC(->v_165_034_atxt; ->v_165_034_atxt; ->[LSS_Inventory:165]LSS_Owner_s:34)
		
		ARRAY TEXT:C222($status_atxt; 0)
		COLLECTION TO ARRAY:C1562(LSS_StatusColors_c; $status_atxt; "status")
		
		//If (GRP_UserInGroup ("LSS_AllowStatusProposed")=1) | User in group(Current user;"Design Access Group")
		//Else 
		//  //if user not in LSS_AllowStatusProposed remove the Proposed option
		//C_LONGINT($propindx_L)
		//$propindx_L:=Find in array($status_atxt;"proposed")
		
		//If ($propindx_L>0)
		//DELETE FROM ARRAY($status_atxt;$propindx_L;1)
		//End if 
		
		//  //and disable the projectinfo number entry
		//OBJECT SET ENABLED(*;"@pinfo";False)
		
		//End if 
		
		C_POINTER:C301($status_ptr)
		$status_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "status")
		COPY ARRAY:C226($status_atxt; $status_ptr->)
		POPUPMENUC($status_ptr; $status_ptr; ->[LSS_Inventory:165]LSS_Status_s:35)
		
		LSS_SelectInspectionsForInvItem
		CLEAR SET:C117("ListboxSet0")
		
		C_BOOLEAN:C305($Entry_b)
		$Entry_b:=True:C214
		C_LONGINT:C283($Color_L)
		$Color_L:=<>Color_editable
		If (Not:C34(LSS_AllowInventoryEdit_B)) | (Read only state:C362([LSS_Inventory:165]))
			$Entry_b:=False:C215
			$Color_L:=<>Color_Not_Editable
		End if 
		OBJECT SET RGB COLORS:C628(*; "NoEdit@"; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced o OBJECT SET COLOR(*;"NoEdit@";<>Color_Not_Editable)
		OBJECT SET ENTERABLE:C238(*; "Built1"; True:C214)
		OBJECT SET RGB COLORS:C628(*; "Built1"; Col_paletteToRGB(Abs:C99(<>Color_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_editable)\256))  // **Replaced o OBJECT SET COLOR(*;"Built1";<>Color_editable)
		If ([LSS_Inventory:165]LSS_YearBuilt_s:11="Unknown") | Not:C34($Entry_b)
			OBJECT SET ENTERABLE:C238(*; "Built1"; False:C215)
			OBJECT SET RGB COLORS:C628(*; "Built1"; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced o OBJECT SET COLOR(*;"Built1";<>Color_Not_Editable)
		End if 
		
		OBJECT SET ENTERABLE:C238(*; "Replaced1"; True:C214)
		OBJECT SET RGB COLORS:C628(*; "Replaced1"; Col_paletteToRGB(Abs:C99(<>Color_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_editable)\256))  // **Replaced o OBJECT SET COLOR(*;"Replaced1";<>Color_editable)
		If ([LSS_Inventory:165]LSS_YearRemoved_s:12="Unknown") | Not:C34($Entry_b)
			OBJECT SET ENTERABLE:C238(*; "Replaced1"; False:C215)
			OBJECT SET RGB COLORS:C628(*; "Replaced1"; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced o OBJECT SET COLOR(*;"Replaced1";<>Color_Not_Editable)
		End if 
		OBJECT SET ENTERABLE:C238(*; "Rehabbed1"; True:C214)
		OBJECT SET RGB COLORS:C628(*; "Rehabbed1"; Col_paletteToRGB(Abs:C99(<>Color_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_editable)\256))  // **Replaced o OBJECT SET COLOR(*;"Rehabbed1";<>Color_editable)
		If ([LSS_Inventory:165]LSS_YearRehabbed_s:13="Unknown") | Not:C34($Entry_b)
			OBJECT SET ENTERABLE:C238(*; "Rehabbed1"; False:C215)
			OBJECT SET RGB COLORS:C628(*; "Rehabbed1"; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced o OBJECT SET COLOR(*;"Rehabbed1";<>Color_Not_Editable)
		End if 
		OBJECT SET RGB COLORS:C628(*; "Location1"; Col_paletteToRGB(Abs:C99($Color_L)%256); Col_paletteToRGB(Abs:C99($Color_L)\256))  // **Replaced o OBJECT SET COLOR(*;"Location1";$Color_L)
		OBJECT SET ENTERABLE:C238(*; "Location1"; $Entry_b)
		OBJECT SET RGB COLORS:C628(*; "AssetNo1"; Col_paletteToRGB(Abs:C99($Color_L)%256); Col_paletteToRGB(Abs:C99($Color_L)\256))  // **Replaced o OBJECT SET COLOR(*;"AssetNo1";$Color_L)
		OBJECT SET ENTERABLE:C238(*; "AssetNo1"; $Entry_b)
		OBJECT SET RGB COLORS:C628(*; "Latitude1"; Col_paletteToRGB(Abs:C99($Color_L)%256); Col_paletteToRGB(Abs:C99($Color_L)\256))  // **Replaced o OBJECT SET COLOR(*;"Latitude1";$Color_L)
		OBJECT SET ENTERABLE:C238(*; "Latitude1"; $Entry_b)
		OBJECT SET RGB COLORS:C628(*; "Longitude1"; Col_paletteToRGB(Abs:C99($Color_L)%256); Col_paletteToRGB(Abs:C99($Color_L)\256))  // **Replaced o OBJECT SET COLOR(*;"Longitude1";$Color_L)
		OBJECT SET ENTERABLE:C238(*; "Longitude1"; $Entry_b)
		OBJECT SET RGB COLORS:C628(*; "NoofArms1"; Col_paletteToRGB(Abs:C99($Color_L)%256); Col_paletteToRGB(Abs:C99($Color_L)\256))  // **Replaced o OBJECT SET COLOR(*;"NoofArms1";$Color_L)
		OBJECT SET ENTERABLE:C238(*; "NoofArms1"; $Entry_b)
		OBJECT SET RGB COLORS:C628(*; "ArmLength@"; Col_paletteToRGB(Abs:C99($Color_L)%256); Col_paletteToRGB(Abs:C99($Color_L)\256))  // **Replaced o OBJECT SET COLOR(*;"ArmLength@";$Color_L)
		OBJECT SET ENTERABLE:C238(*; "ArmLength@"; $Entry_b)
		OBJECT SET RGB COLORS:C628(*; "HeightFromBaseToArm@"; Col_paletteToRGB(Abs:C99($Color_L)%256); Col_paletteToRGB(Abs:C99($Color_L)\256))  // **Replaced o OBJECT SET COLOR(*;"HeightFromBaseToArm@";$Color_L)
		OBJECT SET ENTERABLE:C238(*; "HeightFromBaseToArm1A"; $Entry_b)
		OBJECT SET ENTERABLE:C238(*; "HeightFromBaseToArm2A"; $Entry_b)
		OBJECT SET RGB COLORS:C628(*; "LSS_IntersectionNo_txt"; Col_paletteToRGB(Abs:C99($Color_L)%256); Col_paletteToRGB(Abs:C99($Color_L)\256))  // **Replaced o OBJECT SET COLOR(*;"LSS_IntersectionNo_txt";$Color_L)
		OBJECT SET ENTERABLE:C238(*; "LSS_IntersectionNo_txt"; $Entry_b)
		OBJECT SET RGB COLORS:C628(*; "Location1"; Col_paletteToRGB(Abs:C99($Color_L)%256); Col_paletteToRGB(Abs:C99($Color_L)\256))  // **Replaced o OBJECT SET COLOR(*;"Location1";$Color_L)
		OBJECT SET ENTERABLE:C238(*; "Location1"; $Entry_b)
		OBJECT SET RGB COLORS:C628(*; "Status@"; Col_paletteToRGB(Abs:C99($Color_L)%256); Col_paletteToRGB(Abs:C99($Color_L)\256))
		OBJECT SET ENTERABLE:C238(*; "Status@"; $Entry_b)
		
		If (Not:C34($Entry_b))
			OBJECT SET ENABLED:C1123(*; "LSS_Built_L"; False:C215)  // **replaced _ o _DISABLE BUTTON(*;"LSS_Built_L")
			OBJECT SET ENABLED:C1123(*; "LSSRehab_L"; False:C215)  // **replaced _ o _DISABLE BUTTON(*;"LSSRehab_L")
			OBJECT SET ENABLED:C1123(*; "LSSReplaced_L"; False:C215)  // **replaced _ o _DISABLE BUTTON(*;"LSSReplaced_L")
			OBJECT SET ENABLED:C1123(*; "bValidate"; False:C215)  // **replaced _ o _DISABLE BUTTON(*;"bValidate")
			OBJECT SET ENABLED:C1123(*; "bDelete"; False:C215)  // **replaced _ o _DISABLE BUTTON(*;"bDelete")
			OBJECT SET ENABLED:C1123(*; "StructureType1"; False:C215)  // **replaced _ o _DISABLE BUTTON(*;"StructureType1")
			OBJECT SET ENABLED:C1123(*; "Material1"; False:C215)  // **replaced _ o _DISABLE BUTTON(*;"Material1")
			OBJECT SET ENABLED:C1123(*; "Coating1"; False:C215)  // **replaced _ o _DISABLE BUTTON(*;"Coating1")
			OBJECT SET ENABLED:C1123(*; "EditIDNum"; False:C215)  // **replaced _ o _DISABLE BUTTON(*;"EditIDNum")
			OBJECT SET ENABLED:C1123(*; "Owner"; False:C215)
			OBJECT SET ENABLED:C1123(*; "Status"; False:C215)
			
		Else 
			OBJECT SET ENABLED:C1123(*; "LSS_Built_L"; True:C214)  // **replaced _ o _ENABLE BUTTON(*;"LSS_Built_L")
			OBJECT SET ENABLED:C1123(*; "LSSRehab_L"; True:C214)  // **replaced _ o _ENABLE BUTTON(*;"LSSRehab_L")
			OBJECT SET ENABLED:C1123(*; "LSSReplaced_L"; True:C214)  // **replaced _ o _ENABLE BUTTON(*;"LSSReplaced_L")
			OBJECT SET ENABLED:C1123(*; "bValidate"; True:C214)  // **replaced _ o _ENABLE BUTTON(*;"bValidate")
			OBJECT SET ENABLED:C1123(*; "bDelete"; True:C214)  // **replaced _ o _ENABLE BUTTON(*;"bDelete")
			OBJECT SET ENABLED:C1123(*; "StructureType1"; True:C214)  // **replaced _ o _ENABLE BUTTON(*;"StructureType1")
			OBJECT SET ENABLED:C1123(*; "Material1"; True:C214)  // **replaced _ o _ENABLE BUTTON(*;"Material1")
			OBJECT SET ENABLED:C1123(*; "Coating1"; True:C214)  // **replaced _ o _ENABLE BUTTON(*;"Coating1")
			OBJECT SET ENABLED:C1123(*; "EditIDNum"; True:C214)  // **replaced _ o _ENABLE BUTTON(*;"EditIDNum")
			OBJECT SET ENABLED:C1123(*; "Owner"; True:C214)
			OBJECT SET ENABLED:C1123(*; "Status"; True:C214)
			
			LSS_StatusControls
		End if 
		
		LSS_PermissionADDInspection
		
		If (Not:C34(LSS_AllowNewInspection_b)) & (Not:C34(User in group:C338(Current user:C182; "Design Access Group")))
			OBJECT SET VISIBLE:C603(*; "LSS_Add_L"; False:C215)
		Else 
			OBJECT SET VISIBLE:C603(*; "LSS_Add_L"; True:C214)
		End if 
		
		OBJECT SET VISIBLE:C603(*; "LSS_Edit_L"; False:C215)
		OBJECT SET VISIBLE:C603(*; "LSS_Print_L"; False:C215)
		OBJECT SET VISIBLE:C603(*; "LSS_Duplicate_L"; False:C215)
		
		LSS_SetPrevNextButtons(LSS_InventoryRow_L; Records in selection:C76([LSS_Inventory:165]))
		OBJECT SET VISIBLE:C603(*; "LSS_Approved_L"; False:C215)
		OBJECT SET VISIBLE:C603(*; "LSS_Complete_L"; False:C215)
		OBJECT SET VISIBLE:C603(*; "LSS_ExportInspection@"; False:C215)
		
		If (User in group:C338(Current user:C182; "Design Access Group"))
			OBJECT SET VISIBLE:C603(*; "LSS_ImportInspection@"; True:C214)
		Else 
			OBJECT SET VISIBLE:C603(*; "LSS_ImportInspection@"; False:C215)
		End if 
		
End case 