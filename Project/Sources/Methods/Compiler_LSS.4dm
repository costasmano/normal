//%attributes = {"invisible":true}
// Method: Compiler_LSS
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
	// ----------------------------------------------------
	// User name (OS): administrator
	// Date and time: 09/23/14, 14:37:25
	// ----------------------------------------------------
	//DROP DOWNS USE ARRAYS FROM Compiler_FieldVariables 
	Mods_2015_08_bug  // Fix [LSS_Photos]LSS_PhotoSequence_L bug
	//Modified by: administrator (8/18/15 15:55:24)
	// Modified by: Costas Manousakis-(Designer)-(9/17/15 11:45:00)
	Mods_2015_09_bug
	//  `drag and drop mods
	// Modified by: Costas Manousakis-(Designer)-(9/28/15 17:38:59)
	Mods_2015_09_bug
	//  `add LSS_Edit_MilePoint
	Mods_2015_11  //Add ability to approve or reject  LSS inspections 
	//Modified by: administrator (11/10/15 16:45:30)
	// Modified by: Costas Manousakis-(Designer)-(12/23/15 10:41:40)
	Mods_2015_12_bug
	//  `LSS_RouteSuffix_L
	Mods_2015_12_bug  // Fix bug where deletion of picture records not recorded correctly
	//Modified by: administrator (12/24/15 11:13:41)
	Mods_2015_12_bug  //Fix bug where accessibility records, ut records, dmeter recdords not updated all the time
	//Modified by: administrator (12/29/15 16:10:34)
	// Modified by: Costas Manousakis-(Designer)-(1/7/16 14:40:50)
	Mods_2016_01_bug
	//  `added vars for second pages of UT prints ; added LSS_UpdateStructNumPart
	// Modified by: Costas Manousakis-(Designer)-(2/19/16 10:25:51)
	Mods_2016_02_bug
	//  `added LSS_AddAddtlCmnts
	// Modified by: Costas Manousakis-(Designer)-(3/10/16 17:45:07)
	Mods_2016_03_bug
	//  `added LSS_ExportInspection_L
	// Modified by: Costas Manousakis-(Designer)-(5/16/16 10:46:29)
	Mods_2016_05_bug
	//  `added  6 extra variables for a total of 11 sign panels on sign structures; vert clr and tower dist
	// Modified by: Costas Manousakis-(Designer)-(5/16/16 14:21:29)
	Mods_2016_05
	//  `added inspection review declarations
	Mods_2017_06_bug  //Fix error where errors occur and tranaction not cancelled
	//Modified by: Chuck Miller (6/21/17 12:40:16)
	Mods_2018_03_bug  //Re-adjust how and when get next number
	//Modified by: Chuck Miller (3/20/18 15:36:1
	Mods_2018_08  //WORK ON LSS DAMAGE INSPECTION TYPES INCLUDING FORMS
	//Modified by: Chuck Miller (8/28/18 15:23:33)
	Mods_2020_02  //Modify the way photos are sequenced
End if 
Compiler_FieldVariables(Table:C252(->[LSS_Accessibility:159]))
Compiler_FieldVariables(Table:C252(->[LSS_AccessibilityElement:160]))
Compiler_FieldVariables(Table:C252(->[LSS_DMeter:161]))
Compiler_FieldVariables(Table:C252(->[LSS_Element:162]))
Compiler_FieldVariables(Table:C252(->[LSS_ElementInspection:163]))
Compiler_FieldVariables(Table:C252(->[LSS_Inspection:164]))
Compiler_FieldVariables(Table:C252(->[LSS_Inventory:165]))
Compiler_FieldVariables(Table:C252(->[LSS_Photos:166]))
Compiler_FieldVariables(Table:C252(->[LSS_refInspectionType:167]))
Compiler_FieldVariables(Table:C252(->[LSS_refRouteDirection:168]))
Compiler_FieldVariables(Table:C252(->[LSS_refStructureCoating:169]))
Compiler_FieldVariables(Table:C252(->[LSS_refStructureMaterial:170]))
Compiler_FieldVariables(Table:C252(->[LSS_refStructureTypes:171]))
Compiler_FieldVariables(Table:C252(->[LSS_SignPanel:172]))
Compiler_FieldVariables(Table:C252(->[LSS_TeamMembers:173]))
Compiler_FieldVariables(Table:C252(->[LSS_TowerDistance:174]))
Compiler_FieldVariables(Table:C252(->[LSS_UT:175]))
Compiler_FieldVariables(Table:C252(->[LSS_UtResult:176]))

ARRAY TEXT:C222(LSS_RatingChoices_as; 0)  //Command Replaced was o_ARRAY string length was 1
ARRAY TEXT:C222(LSS_Urgency_as; 0)  //Command Replaced was o_ARRAY string length was 1
ARRAY TEXT:C222(LSS_RouteDirection_as; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(LSS_InpectionTabs_as; 0)  //Command Replaced was o_ARRAY string length was 31
ARRAY TEXT:C222(LSS_Deficiency_as; 0)  //Command Replaced was o_ARRAY string length was 5
ARRAY TEXT:C222(LSS_Cities_atxt; 0)
ARRAY TEXT:C222(LSS_RouteDesignation_atxt; 0)
ARRAY TEXT:C222(LSS_StructureClass_atxt; 0)

ARRAY TEXT:C222(LSS_TownBDEPT_atxt; 0)
ARRAY TEXT:C222(LSS_TownDistrict_atxt; 0)
ARRAY TEXT:C222(LSS_TownName_atxt; 0)
ARRAY TEXT:C222(LSS_Categories_as; 0)  //Command Replaced was o_ARRAY string length was 30
ARRAY TEXT:C222(LSS_Districts_as; 0)  //Command Replaced was o_ARRAY string length was 10
ARRAY TEXT:C222(LSS_SignPanel_as; 0)  //Command Replaced was o_ARRAY string length was 50
ARRAY TEXT:C222(v_163_007_atxt; 0)

ARRAY LONGINT:C221(LSS_ELementDictionaryID_al; 0)
ARRAY BOOLEAN:C223(LSS_ELementDisctionaryHeader_ab; 0)
ARRAY TEXT:C222(LSS_ELementDictionaryDescr_atxt; 0)
ARRAY BOOLEAN:C223(LSS_ElementHeader_ab; 0)
ARRAY TEXT:C222(LSS_StructureTypeIDs_atxt; 0)
ARRAY TEXT:C222(LSS_StructureTypeDesc_atxt; 0)
ARRAY TEXT:C222(LSS_STID_atxt; 0)
ARRAY TEXT:C222(LSS_STDescription_atxt; 0)
ARRAY TEXT:C222(LSS_RouteDirectionDesc_atxt; 0)
ARRAY TEXT:C222(LSS_RouteDirectionID_as; 0)  //Command Replaced was o_ARRAY string length was 13
//Array based LBs are boolean arrays
ARRAY BOOLEAN:C223(ElementRating_LB; 0)

//selecion based LBs are longints
C_LONGINT:C283(DMeter_LB)
C_LONGINT:C283(UTResults_LB)
C_LONGINT:C283(UT_LB)
C_LONGINT:C283(Photos_LB)
C_LONGINT:C283(SignPanel_LB)
C_LONGINT:C283(VerticalClearance_LB)
C_LONGINT:C283(TowerorPost_LB)
C_LONGINT:C283(Inspection_LB)
C_LONGINT:C283(Inventory_LB)

ARRAY TEXT:C222(LSS_PhotoTypes_atxt; 0)

ARRAY TEXT:C222(LSS_ElementLabel_atxt; 0)
ARRAY TEXT:C222(LSS_ElementRemarks_atxt; 0)
ARRAY BOOLEAN:C223(LSS_ElementHeader_ab; 0)
ARRAY TEXT:C222(LSS_ElementHeaderNo_atxt; 0)
ARRAY BOOLEAN:C223(LSS_ADDInventory_aB; 0)
ARRAY BOOLEAN:C223(LSS_DELInventory_aB; 0)
ARRAY BOOLEAN:C223(LSS_MODInventory_aB; 0)
ARRAY BOOLEAN:C223(LSS_ADDInspection_aB; 0)
ARRAY BOOLEAN:C223(LSS_DELInspection_aB; 0)
ARRAY BOOLEAN:C223(LSS_MODInspection_aB; 0)

ARRAY LONGINT:C221(LSS_AllTeamLeaders_aL; 0)
ARRAY LONGINT:C221(LSS_AllTeamMembers_aL; 0)
ARRAY LONGINT:C221(LSS_AllProjManagers_aL; 0)

ARRAY TEXT:C222(LSS_StructType_atxt; 0)
ARRAY TEXT:C222(LSS_StructTypeID_atxt; 0)

ARRAY LONGINT:C221(LSS_ElemListBackColor_AL; 0)
ARRAY LONGINT:C221(LSS_NewPhotoSequence_aL; 0)

C_LONGINT:C283(LSS_ExportInspection_L)


ARRAY TEXT:C222(LSS_Crack_atxt; 0)
ARRAY LONGINT:C221(LSS_Page1Postions_aL; 0)
ARRAY BOOLEAN:C223(LSS_AddtoCommentsPAGE_AB; 0)



If (Not:C34(Is compiled mode:C492))
	
	
	C_BLOB:C604(BlobHoldUpdates_blb)
	//buttons
	C_LONGINT:C283(LSS_LoadPictureButton_L; UTButton_L; PlusButton_L; PlusButton1_L; LSS_DeletePictureButton_L; LSS_Approved_L)
	
	C_LONGINT:C283(LSS_Page_l)  //Used to select page on LSS_InspectionApproval form
	
	C_LONGINT:C283(LSS_Print_L; LSS_Edit_L; LSS_Duplicate_L; LSS_Add_L; LSS_SelectedRow_L; LSS_InventoryRow_L; LSS_InspectionRow_L; LSS_UTRow_L)
	C_LONGINT:C283(LSS_MapLocation_L)
	
	C_TEXT:C284(LSS_TownCode_s)  // Command Replaced was o_C_STRING length was 3
	C_TEXT:C284(LSS_RouteDesignation_s)  // Command Replaced was o_C_STRING length was 1
	C_TEXT:C284(LSS_StructureClass_txt)
	C_TEXT:C284(LSS_StructTypeDescriptor_txt; LSS_HeightDescriptor1_txt; LSS_HeightDescriptor2_txt; LSS_StructureType_txt; LSS_StructureCoating_txt; LSS_StructureMaterial_txt)
	C_BOOLEAN:C305(LSS_AllowNewInventoryItem_b; LSS_AllowInventoryEdit_B; LSS_AllowNewInspection_b; LSS_AllowInspectionEdit_B; LSS_AllowInventoryDelete_B; LSS_AllowInspectionDelete_B; LSS_AllowStatusChange_B)
	C_TEXT:C284(<>KeyMask_s)  // Command Replaced was o_C_STRING length was 20
	C_TEXT:C284(DataFileKey_s)  // Command Replaced was o_C_STRING length was 3
	
	C_PICTURE:C286(Photo_pct; LSS_CommentsPrint_pct)
	
	C_TEXT:C284(LSS_IDNumber_txt; LSS_PhotoDescription_txt)
	
	C_LONGINT:C283(TrapEnter_L; bFirst; bPrevious; bNext; bLast; bDelete; bCancel; bValidate; bShowAll; bShowSubset; bQuery; bOrderBy; bReport; bDone)
	
	C_TEXT:C284(LSS_TeamMembers_txt)
	
	C_TEXT:C284(LSS_AccessibilityNeed2_s)  // Command Replaced was o_C_STRING length was 2
	C_TEXT:C284(LSS_AccessibilityUsed2_s)  // Command Replaced was o_C_STRING length was 2
	C_TEXT:C284(LSS_AccessibilityNeed3_s)  // Command Replaced was o_C_STRING length was 2
	C_TEXT:C284(LSS_AccessibilityUsed3_s)  // Command Replaced was o_C_STRING length was 2
	C_TEXT:C284(LSS_AccessibilityNeed4_s)  // Command Replaced was o_C_STRING length was 2
	C_TEXT:C284(LSS_AccessibilityUsed4_s)  // Command Replaced was o_C_STRING length was 2
	C_TEXT:C284(LSS_AccessibilityNeed5_s)  // Command Replaced was o_C_STRING length was 2
	C_TEXT:C284(LSS_AccessibilityUsed5_s)  // Command Replaced was o_C_STRING length was 2
	C_TEXT:C284(LSS_AccessibilityNeed6_s)  // Command Replaced was o_C_STRING length was 2
	C_TEXT:C284(LSS_AccessibilityUsed6_s)  // Command Replaced was o_C_STRING length was 2
	C_TEXT:C284(LSS_AccessibilityNeed7_s)  // Command Replaced was o_C_STRING length was 2
	C_TEXT:C284(LSS_AccessibilityUsed7_s)  // Command Replaced was o_C_STRING length was 2
	C_TEXT:C284(LSS_AccessibilityNeed8_s)  // Command Replaced was o_C_STRING length was 2
	C_TEXT:C284(LSS_AccessibilityUsed8_s)  // Command Replaced was o_C_STRING length was 2
	C_TEXT:C284(LSSOtherDescription_s)  // Command Replaced was o_C_STRING length was 31
	
	C_TEXT:C284(LSS_ProjectManager_s; LSS_MassDOTRep_s; LSS_TeamLeader_s)  // Command Replaced was o_C_STRING length was 80
	C_TEXT:C284(LSS_TeamMembers_txt; LSS_InspectionTypeID_txt)
	C_TEXT:C284(LSS_StructureClass_txt; LSS_ArmDescriptor1_txt; LSS_ArmDescriptor2_txt; LSS_StructTypeDescriptor_txt; LSS_SIN_Label_txt)
	
	C_BOOLEAN:C305(LSS_EditingInspection_B; LSS_EditingInventory_B; LSS_NewPhoto_B)
	
	C_TEXT:C284(LSS_Width1_txt; LSS_Width2_txt; LSS_Width3_txt; LSS_Width4_txt; LSS_Width5_txt)
	C_TEXT:C284(LSS_Width6_txt; LSS_Width7_txt; LSS_Width8_txt; LSS_Width9_txt; LSS_Width10_txt; LSS_Width11_txt)
	C_TEXT:C284(LSS_Height1_txt; LSS_Height2_txt; LSS_Height3_txt; LSS_Height4_txt; LSS_Height5_txt)
	C_TEXT:C284(LSS_Height6_txt; LSS_Height7_txt; LSS_Height8_txt; LSS_Height9_txt; LSS_Height10_txt; LSS_Height11_txt)
	C_TEXT:C284(LSS_Message1_txt; LSS_Message2_txt; LSS_Message3_txt; LSS_Message4_txt; LSS_Message5_txt)
	C_TEXT:C284(LSS_Message6_txt; LSS_Message7_txt; LSS_Message8_txt; LSS_Message9_txt; LSS_Message10_txt; LSS_Message11_txt)
	C_TEXT:C284(LSS_LanesOver1_txt; LSS_LanesOver2_txt; LSS_LanesOver3_txt; LSS_LanesOver4_txt; LSS_LanesOver5_txt)
	C_TEXT:C284(LSS_LanesOver6_txt; LSS_LanesOver7_txt; LSS_LanesOver8_txt; LSS_LanesOver9_txt; LSS_LanesOver10_txt; LSS_LanesOver11_txt)
	C_LONGINT:C283(LSSBuilt_L; LSSRehab_L; LSSReplaced_L; <>LSS_ListBoxColor_L; LSS_Route_L; LSS_Built_L)
	C_PICTURE:C286(LSS_Picture_pct; LSS_UTPicture_pct; LSS_DMeterPicture_pct)
	C_TEXT:C284(LSS_DefaultDescription_txt)
	C_TEXT:C284(LSS_UTPictureDesc_txt)
	
	//Variable used in LSS Inpsection reports
	C_TEXT:C284(LSS_Panel1_txt; LSS_Panel2_txt; LSS_Panel3_txt; LSS_Panel4_txt; LSS_Panel5_txt)
	C_TEXT:C284(LSS_Panel6_txt; LSS_Panel7_txt; LSS_Panel8_txt; LSS_Panel9_txt; LSS_Panel10_txt; LSS_Panel11_txt)
	C_TEXT:C284(LSS_Feet1_txt; LSS_Feet2_txt; LSS_Feet3_txt; LSS_Feet4_txt; LSS_Feet5_txt)
	C_TEXT:C284(LSS_Feet6_txt; LSS_Feet7_txt; LSS_Feet8_txt; LSS_Feet9_txt; LSS_Feet10_txt; LSS_Feet11_txt)
	C_TEXT:C284(LSS_Inch1_txt; LSS_Inch2_txt; LSS_Inch3_txt; LSS_Inch4_txt; LSS_Inch5_txt)
	C_TEXT:C284(LSS_Inch6_txt; LSS_Inch7_txt; LSS_Inch8_txt; LSS_Inch9_txt; LSS_Inch10_txt; LSS_Inch11_txt)
	C_TEXT:C284(LSS_Meter1_txt; LSS_Meter2_txt; LSS_Meter3_txt; LSS_Meter4_txt; LSS_Meter5_txt)
	C_TEXT:C284(LSS_Meter6_txt; LSS_Meter7_txt; LSS_Meter8_txt; LSS_Meter9_txt; LSS_Meter10_txt; LSS_Meter11_txt)
	C_TEXT:C284(LSS_TowerPost1_txt; LSS_TowerPost2_txt; LSS_TowerPost3_txt; LSS_TowerPost4_txt; LSS_TowerPost5_txt)
	C_TEXT:C284(LSS_TowerPost6_txt; LSS_TowerPost7_txt; LSS_TowerPost8_txt; LSS_TowerPost9_txt; LSS_TowerPost10_txt; LSS_TowerPost11_txt)
	C_TEXT:C284(LSS_SignPanel1_txt; LSS_SignPanel2_txt; LSS_SignPanel3_txt; LSS_SignPanel4_txt; LSS_SignPanel5_txt)
	C_TEXT:C284(LSS_SignPanel6_txt; LSS_SignPanel7_txt; LSS_SignPanel8_txt; LSS_SignPanel9_txt; LSS_SignPanel10_txt; LSS_SignPanel11_txt)
	C_TEXT:C284(LSS_Distance1_txt; LSS_Distance2_txt; LSS_Distance3_txt; LSS_Distance4_txt; LSS_Distance5_txt)
	C_TEXT:C284(LSS_Distance6_txt; LSS_Distance7_txt; LSS_Distance8_txt; LSS_Distance9_txt; LSS_Distance10_txt; LSS_Distance11_txt)
	C_TEXT:C284(LSS_PanelType1_txt; LSS_PanelType2_txt; LSS_PanelType3_txt; LSS_PanelType4_txt; LSS_PanelType5_txt)
	C_TEXT:C284(LSS_PanelType6_txt; LSS_PanelType7_txt; LSS_PanelType8_txt; LSS_PanelType9_txt; LSS_PanelType10_txt; LSS_PanelType11_txt)
	
	C_TEXT:C284(VT1_1; VT1_2; VT1_3; VT1_4; VT1_5; VT1_6; VT1_7; VT1_8; VT1_9; VT1_10; VT1_11; VT1_12; VT1_13; VT1_14; VT1_15; VT1_16; VT1_17; VT1_18; VT1_19)
	C_TEXT:C284(VT10_1; VT10_2; VT10_3; VT10_4; VT10_5; VT10_6; VT10_7; VT10_8; VT10_9; VT10_10; VT10_11; VT10_12; VT10_13; VT10_14; VT10_15; VT10_16; VT10_17; VT10_18; VT10_19)
	C_TEXT:C284(VT28_1; VT28_2; VT28_3; VT28_4; VT28_5; VT28_6; VT28_7; VT28_8; VT28_9; VT28_10; VT28_11; VT28_12; VT28_13; VT28_14)
	C_TEXT:C284(VT38_1; VT38_2; VT38_3; VT38_4; VT38_5; VT38_6; VT38_7; VT38_8)
	C_TEXT:C284(VT44_1; VT44_2; VT44_3; VT44_4; VT44_5; VT44_6; VT44_7)
	C_TEXT:C284(VT49_1; VT49_2; VT49_3; VT49_4; VT49_5; VT49_6; VT49_7)
	C_TEXT:C284(vR1_1; vR1_2; vR1_3; vR1_4; vR1_5; vR1_6; vR1_7; vR1_8; vR1_9; vR1_10; vR1_11; vR1_12; vR1_13; vR1_14; vR1_15; vR1_16; vR1_17; vR1_18; vR1_19)
	C_TEXT:C284(vR10_1; vR10_2; vR10_3; vR10_4; vR10_5; vR10_6; vR10_7; vR10_8; vR10_9; vR10_10; vR10_11; vR10_12; vR10_13; vR10_14; vR10_15; vR10_16; vR10_17; vR10_18; vR10_19)
	C_TEXT:C284(vR28_1; vR28_2; vR28_3; vR28_4; vR28_5; vR28_6; vR28_7; vR28_8; vR28_9; vR28_10; vR28_11; vR28_12; vR28_13; vR28_14)
	C_TEXT:C284(vR38_1; vR38_2; vR38_3; vR38_4; vR38_5; vR38_6; vR38_7; vR38_8)
	C_TEXT:C284(vR44_1; vR44_2; vR44_3; vR44_4; vR44_5; vR44_6; vR44_7)
	C_TEXT:C284(vR49_1; vR49_2; vR49_3; vR49_4; vR49_5; vR49_6; vR49_7)
	C_TEXT:C284(vR1_0; vR10_0; vR28_0; vR38_0; vR44_0; vR49_0)
	C_TEXT:C284(VD1_1; VD1_2; VD1_3; VD1_4; VD1_5; VD1_6; VD1_7; VD1_8; VD1_9; VD1_10; VD1_11; VD1_12; VD1_13; VD1_14; VD1_15; VD1_16; VD1_17; VD1_18; VD1_19)
	C_TEXT:C284(VD10_1; VD10_2; VD10_3; VD10_4; VD10_5; VD10_6; VD10_7; VD10_8; VD10_9; VD10_10; VD10_11; VD10_12; VD10_13; VD10_14; VD10_15; VD10_16; VD10_17; VD10_18; VD10_19)
	C_TEXT:C284(VD28_1; VD28_2; VD28_3; VD28_4; VD28_5; VD28_6; VD28_7; VD28_8; VD28_9; VD28_10; VD28_11; VD28_12; VD28_13; VD28_14)
	C_TEXT:C284(VD38_1; VD38_2; VD38_3; VD38_4; VD38_5; VD38_6; VD38_7; VD38_8)
	C_TEXT:C284(VD44_1; VD44_2; VD44_3; VD44_4; VD44_5; VD44_6; VD44_7)
	C_TEXT:C284(VD49_1; VD49_2; VD49_3; VD49_4; VD49_5; VD49_6; VD49_7)
	C_TEXT:C284(VU1_1; VU1_2; VU1_3; VU1_4; VU1_5; VU1_6; VU1_7; VU1_8; VU1_9; VU1_10; VU1_11; VU1_12; VU1_13; VU1_14; VU1_15; VU1_16; VU1_17; VU1_18; VU1_19)
	C_TEXT:C284(VU10_1; VU10_2; VU10_3; VU10_4; VU10_5; VU10_6; VU10_7; VU10_8; VU10_9; VU10_10; VU10_11; VU10_12; VU10_13; VU10_14; VU10_15; VU10_16; VU10_17; VU10_18; VU10_19)
	C_TEXT:C284(VU28_1; VU28_2; VU28_3; VU28_4; VU28_5; VU28_6; VU28_7; VU28_8; VU28_9; VU28_10; VU28_11; VU28_12; VU28_13; VU28_14)
	C_TEXT:C284(VU38_1; VU38_2; VU38_3; VU38_4; VU38_5; VU38_6; VU38_7; VU38_8)
	C_TEXT:C284(VU44_1; VU44_2; VU44_3; VU44_4; VU44_5; VU44_6; VU44_7)
	C_TEXT:C284(VU49_1; VU49_2; VU49_3; VU49_4; VU49_5; VU49_6; VU49_7)
	
	C_TEXT:C284(TemplateMIN_Sin_txt)
	C_BOOLEAN:C305(LSS_PhotoUpdateSeq_b)
	
	C_DATE:C307(LSS_Date_d1; LSS_Date_d2; LSS_Date_d3; LSS_Date_d4; LSS_Date_d5; LSS_Date_d6; LSS_Date_d7; LSS_Date_d8; LSS_Date_d9; LSS_Date_d10; LSS_Date_d11; LSS_Date_d12)
	C_TEXT:C284(LSS_Location_txt1; LSS_Location_txt2; LSS_Location_txt3; LSS_Location_txt4; LSS_Location_txt5; LSS_Location_txt6; LSS_Location_txt7; LSS_Location_txt8)
	C_TEXT:C284(LSS_Location_txt9; LSS_Location_txt10; LSS_Location_txt11; LSS_Location_txt12)
	C_TEXT:C284(LSS_Location_txt13; LSS_Location_txt14; LSS_Location_txt15; LSS_Location_txt16; LSS_Location_txt17; LSS_Location_txt18)
	C_TEXT:C284(LSS_A_txt1; LSS_A_txt2; LSS_A_txt3; LSS_A_txt4; LSS_A_txt5; LSS_A_txt6; LSS_A_txt7; LSS_A_txt8; LSS_A_txt9; LSS_A_txt10; LSS_A_txt11; LSS_A_txt12)
	C_TEXT:C284(LSS_B_txt1; LSS_B_txt2; LSS_B_txt3; LSS_B_txt4; LSS_B_txt5; LSS_B_txt6; LSS_B_txt7; LSS_B_txt8; LSS_B_txt9; LSS_B_txt10; LSS_B_txt11; LSS_B_txt12)
	C_TEXT:C284(LSS_C_txt1; LSS_C_txt2; LSS_C_txt3; LSS_C_txt4; LSS_C_txt5; LSS_C_txt6; LSS_C_txt7; LSS_C_txt8; LSS_C_txt9; LSS_C_txt10; LSS_C_txt11; LSS_C_txt12)
	C_TEXT:C284(LSS_D_txt1; LSS_D_txt2; LSS_D_txt3; LSS_D_txt4; LSS_D_txt5; LSS_D_txt6; LSS_D_txt7; LSS_D_txt8; LSS_D_txt9; LSS_D_txt10; LSS_D_txt11; LSS_D_txt12)
	C_TEXT:C284(LSS_Reference_txt1; LSS_Reference_txt2; LSS_Reference_txt3; LSS_Reference_txt4; LSS_Reference_txt5; LSS_Reference_txt6; LSS_Reference_txt7; LSS_Reference_txt8)
	C_TEXT:C284(LSS_Reference_txt9; LSS_Reference_txt10; LSS_Reference_txt11; LSS_Reference_txt12)
	
	C_LONGINT:C283(LSS_PostBolt_L1; LSS_PostBolt_L2; LSS_PostBolt_L3; LSS_PostBolt_L4; LSS_PostBolt_L5; LSS_PostBolt_L6; LSS_PostBolt_L7; LSS_PostBolt_L8; LSS_PostBolt_L9; LSS_PostBolt_L10; LSS_PostBolt_L11)
	C_LONGINT:C283(LSS_PostBolt_L12; LSS_PostBolt_L13; LSS_PostBolt_L14; LSS_PostBolt_L15; LSS_PostBolt_L16; LSS_PostBolt_L17; LSS_PostBolt_L18)
	C_TEXT:C284(LSS_Indication_txt1; LSS_Indication_txt2; LSS_Indication_txt3; LSS_Indication_txt4; LSS_Indication_txt5; LSS_Indication_txt6; LSS_Indication_txt7; LSS_Indication_txt8; LSS_Indication_txt9; LSS_Indication_txt10; LSS_Indication_txt11)
	C_TEXT:C284(LSS_Indication_txt12; LSS_Indication_txt13; LSS_Indication_txt14; LSS_Indication_txt15; LSS_Indication_txt16; LSS_Indication_txt17; LSS_Indication_txt18)
	C_BOOLEAN:C305(LSS_Accept_b1; LSS_Accept_b2; LSS_Accept_b3; LSS_Accept_b4; LSS_Accept_b5; LSS_Accept_b6; LSS_Accept_b7; LSS_Accept_b8; LSS_Accept_b9; LSS_Accept_b10; LSS_Accept_b11)
	C_BOOLEAN:C305(LSS_Accept_b12; LSS_Accept_b13; LSS_Accept_b14; LSS_Accept_b15; LSS_Accept_b16; LSS_Accept_b17; LSS_Accept_b18)
	C_BOOLEAN:C305(LSS_Reject_b1; LSS_Reject_b2; LSS_Reject_b3; LSS_Reject_b4; LSS_Reject_b5; LSS_Reject_b6; LSS_Reject_b7; LSS_Reject_b8; LSS_Reject_b9; LSS_Reject_b10; LSS_Reject_b11)
	C_BOOLEAN:C305(LSS_Reject_b12; LSS_Reject_b13; LSS_Reject_b14; LSS_Reject_b15; LSS_Reject_b16; LSS_Reject_b17; LSS_Reject_b18)
	C_TEXT:C284(LSS_Remarks_txt1; LSS_Remarks_txt2; LSS_Remarks_txt3; LSS_Remarks_txt4; LSS_Remarks_txt5; LSS_Remarks_txt6; LSS_Remarks_txt7; LSS_Remarks_txt8; LSS_Remarks_txt9; LSS_Remarks_txt10; LSS_Remarks_txt11)
	C_TEXT:C284(LSS_Remarks_txt12; LSS_Remarks_txt13; LSS_Remarks_txt14; LSS_Remarks_txt15; LSS_Remarks_txt16; LSS_Remarks_txt17; LSS_Remarks_txt18)
	
	C_LONGINT:C283(bAncillary)
	C_BOOLEAN:C305(LSS_IsNewESRecord_B)
	
	ARRAY TEXT:C222(LSS_TeamLeaders_atxt; 0)
	ARRAY LONGINT:C221(LSS_TeamLeaderIDs_aL; 0)
	ARRAY TEXT:C222(LSS_TeamMembers_atxt; 0)
	ARRAY LONGINT:C221(LSS_TeamMemberIDs_aL; 0)
	ARRAY TEXT:C222(LSS_ProjManagers_atxt; 0)
	ARRAY LONGINT:C221(LSS_ProjManagerIDs_aL; 0)
	ARRAY TEXT:C222(LSS_MassDOTReps_atxt; 0)
	ARRAY LONGINT:C221(LSS_MassDOTRepIDs_aL; 0)
	ARRAY TEXT:C222(LSS_ConsultanList_atxt; 0)
	C_LONGINT:C283(LSS_SIN_2_L)
	C_BOOLEAN:C305(LSS_MovingInvRecords_B)
	
	ARRAY LONGINT:C221(LSS_SearchDistr_aL; 0)
	C_LONGINT:C283(LSS_SearchRouteNum_L; LSS_SearchSIN_L; LSS_DoneSearch; LSS_SearchNumFound_L)
	C_REAL:C285(LSS_SearchStartMile_r; LSS_SearchEndMile_r)
	C_TEXT:C284(LSS_SearchTwnCode_txt; LSS_SearchStrClass_txt; LSS_SearchRoutType_txt; LSS_SearchRoutDir_txt)
	C_LONGINT:C283(LSS_ClearResults_L; bCustomSearch; LSS_RtgDropDown_L)
	
	C_BOOLEAN:C305(LSS_ThisPictureDrag_b)
	
	C_LONGINT:C283(LSS_RouteSuffix_L)
	C_BOOLEAN:C305(LSS_UpdateMany_B; LSS_UpdateAccessibility_B)
	C_BOOLEAN:C305(LSS_DuplicateRecordError_B; LSS_Error_B)
	C_TEXT:C284(LSS_InventorySemaphore_txt)
	
	
	ARRAY LONGINT:C221(LSS_HeaderPosition_aL; 0)
	ARRAY LONGINT:C221(LSS_ElementRecordNo_aL; 0)
	C_BOOLEAN:C305(LSS_CountingPage_B; LSS_EditDamageOnly_B)
	ARRAY TEXT:C222(LSS_Headers_atxt; 0)
	C_BLOB:C604(<>HSBlob_blb; <>LIBlob_blb; <>SIBlob_blb; <>ITBlob_blb)
	ARRAY LONGINT:C221(InspectionRecs_AL; 0; 0)
End if 

If (False:C215)
	C_BOOLEAN:C305(LSS_EditCheckDefQRY; $0)
	C_LONGINT:C283(LSS_AddNotes; $1)
	C_LONGINT:C283(LSS_PrintDamageInspection; $1)
	C_TEXT:C284(LSS_AddNotes; $2)
	C_TEXT:C284(LSS_AddNotes; $3)
	C_LONGINT:C283(LSS_ClearSpecialMemberVariables; $1)
	C_LONGINT:C283(LSS_FillElementMemberLines; $1)
	C_LONGINT:C283(LSS_FillElementMemberLines; $2)
	
	C_LONGINT:C283(LSS_CountandPrintDamagePages; $1)
	C_TEXT:C284(LSS_FillDamagePage_1; $1)
	
	C_BOOLEAN:C305(LSS_ReceiveRecords; $1)
	C_POINTER:C301(LSS_SendRecords; $1)
	
	C_BOOLEAN:C305(LSS_ControlDeleteOfInspection; $0)
	
	C_TEXT:C284(ut_SetReadWrite; $1)
	
	C_POINTER:C301(ut_SetReadWrite; ${2})
	
	C_LONGINT:C283(FM_InspectionInput; $1)
	
	C_LONGINT:C283(FM_ElementInspection; $1)
	
	C_LONGINT:C283(FM_PhotoInput; $1)
	
	C_LONGINT:C283(FM_InventoryInput; $1)
	
	C_LONGINT:C283(FM_SignPanel; $1)
	
	C_LONGINT:C283(FM_DMeterInput; $1)
	
	C_LONGINT:C283(FM_UTInput; $1)
	
	C_LONGINT:C283(FM_VerticalClearance; $1)
	
	C_LONGINT:C283(FM_TowerDistance; $1)
	
	C_LONGINT:C283(LSS_SetPrevNextButtons; $1; $2)
	
	C_LONGINT:C283(LSS_SortStructureType; $0)
	
	C_POINTER:C301(LSS_ReturnStructureType; $1; $2; $3)
	C_TEXT:C284(LSS_ReturnStructureType; $0)
	
	C_POINTER:C301(WIN_SetWindowTitle; $1)
	
	C_POINTER:C301(LSS_SelectInpsectionInputForm; $1; $2)
	
	C_POINTER:C301(ut_LSSControlPictureMod; $3)
	C_TEXT:C284(ut_LSSControlPictureMod; $1)
	C_TEXT:C284(ut_LSSControlPictureMod; $2)
	
	C_POINTER:C301(LSS_ControlModification; $1)
	C_TEXT:C284(LSS_ControlModification; $2)
	
	
	C_BOOLEAN:C305(ut_UpdateorCreatePhotoRecord; $0)
	C_TEXT:C284(ut_UpdateorCreatePhotoRecord; $1)
	C_TEXT:C284(ut_UpdateorCreatePhotoRecord; $2)
	C_TEXT:C284(ut_UpdateorCreatePhotoRecord; $3)
	C_TEXT:C284(ut_UpdateorCreatePhotoRecord; $4)
	C_POINTER:C301(ut_UpdateorCreatePhotoRecord; $5)
	
	C_POINTER:C301(LSS_SetEntryColor; $1)
	
	C_TEXT:C284(LSS_FillStructureTypes; $1)
	C_TEXT:C284(LSS_FillStructureTypes; $2)
	
	C_TEXT:C284(LSS_CreateElementInputArrays; $1)
	
	C_TEXT:C284(LSS_DisplayInspection; $1)
	
	C_TEXT:C284(LSS_FillPage1_FM; $1)
	
	C_TEXT:C284(LSS_CreateRoles; $1)
	
	C_LONGINT:C283(FM_UTResults; $1)
	
	C_LONGINT:C283(FM_refInspectionTypeInput; $1)
	
	C_LONGINT:C283(FM_RefRouteDirectionInput; $1)
	
	C_LONGINT:C283(FM_RefStructureCoatingInput; $1)
	
	C_LONGINT:C283(FM_refStructureMaterialInput; $1)
	
	C_LONGINT:C283(FM_RefStructureTypesInput; $1)
	
	C_LONGINT:C283(FM_Accessibility; $1)
	
	C_LONGINT:C283(FM_TeamMembersInput; $1)
	
	C_BOOLEAN:C305(LSS_PrintComments; $1)
	
	C_LONGINT:C283(LSS_AddHeader; $1)
	C_TEXT:C284(LSS_AddHeader; $2)
	C_BOOLEAN:C305(LSS_AddHeader; $3)
	C_LONGINT:C283(LSS_AddHeader; $4)
	C_POINTER:C301(LSS_AddHeader; $5)
	
	
	C_POINTER:C301(LSS_ReturnPhotoComments; $1)
	C_POINTER:C301(LSS_ReturnPhotoComments; $2)
	C_POINTER:C301(LSS_ReturnPhotoComments; $3)
	C_TEXT:C284(LSS_ReturnPhotoComments; $4)
	
	C_LONGINT:C283(LSS_AddGeneralComments; $1)
	
	C_BOOLEAN:C305(LSS_PrintPhoto; $1)
	
	C_TEXT:C284(LSS_GetHeader; $1)
	C_TEXT:C284(LSS_GetHeader; $0)
	
	
	C_BOOLEAN:C305(LSS_CompareBlobs; $0)
	C_BLOB:C604(LSS_CompareBlobs; $1)
	C_BLOB:C604(LSS_CompareBlobs; $2)
	
	C_BOOLEAN:C305(LSS_PrintSketchChart; $0; $1; $2)
	
	C_TEXT:C284(m_ListInventory; $1)
	
	C_POINTER:C301(LSS_CheckTeamMembership; $1)
	
	C_TEXT:C284(LSS_SelectPictureFile; $0)
	
	C_TEXT:C284(LSS_SortFunction; $0)
	
	C_BOOLEAN:C305(LSS_FindInvalidStructureNames; $1)
	
	
	C_PICTURE:C286(qr_returnpict; $0)
	
	C_TEXT:C284(LSS_CustomSearch; $1)
	
	C_POINTER:C301(LSS_RatingPopup; $1)
	
	
	
	C_LONGINT:C283(LSS_SaveDMorUTPicture; $0)
	C_POINTER:C301(LSS_SaveDMorUTPicture; $1)
	
	C_BOOLEAN:C305(LSS_CompareText; $0)
	C_POINTER:C301(LSS_CompareText; $1)
	C_POINTER:C301(LSS_CompareText; $2)
	
	C_LONGINT:C283(LSS_YearUnknownChkBox; $1)
	C_POINTER:C301(LSS_YearUnknownChkBox; $2)
	C_TEXT:C284(LSS_YearUnknownChkBox; $3)
	
	C_LONGINT:C283(QR_ReturnNUmberInspections; $0)
	
	C_TEXT:C284(LSS_ResetStructureNumber; $0)
	//LSS_ResequencePictures is Obsolete
	C_TEXT:C284(LSS_ResequencePictures; $1)
	C_TEXT:C284(LSS_ResequencePictures; $2)
	C_TEXT:C284(LSS_ResequencePictures; $3)
	C_LONGINT:C283(LSS_ResequencePictures; $4)
	
	C_TEXT:C284(LSS_Edit_MilePoint; $1)
	
	
	
	C_TEXT:C284(LSS_UpdateStructNumPart; $0)
	C_TEXT:C284(LSS_UpdateStructNumPart; $1)
	C_TEXT:C284(LSS_UpdateStructNumPart; $2)
	C_LONGINT:C283(LSS_UpdateStructNumPart; $3)
	
	C_LONGINT:C283(LSS_AddAddtlCmnts; $1)
	
	C_TEXT:C284(LSS_ReturnCount; $1)
	C_TEXT:C284(LSS_ReturnCount; $2)
	C_TEXT:C284(LSS_ReturnCount; $3)
	C_LONGINT:C283(LSS_ReturnCount; $0)
	
	C_LONGINT:C283(LSS_PrintInspection; $1)
	
	C_TEXT:C284(m_ListInspReview; $1)
	C_LONGINT:C283(LSS_SortInspReviewLB; $0)
	C_LONGINT:C283(LSS_InspReviewLB_OM; $0)
	
	C_LONGINT:C283(LSS_VerifyNewInventoryNumber; $0)
	C_POINTER:C301(LSS_VerifyNewInventoryNumber; $1)
	
	C_BOOLEAN:C305(LSS_SetInventoryNumber; $1)
	
	C_TEXT:C284(LSS_RTRNInspectionData; $1)
	C_POINTER:C301(LSS_RTRNInspectionData; $2)
	C_POINTER:C301(LSS_RTRNInspectionData; $3)
	
	C_BOOLEAN:C305(LSS_PrintDMeter; $1)
	C_BOOLEAN:C305(LSS_PrintUT; $1)
	
	C_LONGINT:C283(LSS_NonDamageAddHeader; $1)
	C_TEXT:C284(LSS_NonDamageAddHeader; $2)
	C_BOOLEAN:C305(LSS_NonDamageAddHeader; $3)
	C_LONGINT:C283(LSS_NonDamageAddHeader; $4)
	
	C_LONGINT:C283(LB_ProcessLSSElementQuery; $0)
	C_TEXT:C284(LSS_CreateElementArraysForQuery; $1)
	C_BOOLEAN:C305(LSS_CreateElementArraysForQuery; $2)
	
	C_TEXT:C284(LSS_SortElements; $0)
	C_TEXT:C284(LSS_OrderByJustStructure; $0)
	
	C_BOOLEAN:C305(LSS_SetUpAndSortForElementRpt; $1)
	
	C_TEXT:C284(LSS_ClearForNewQuery; $1)
	C_TEXT:C284(LSS_SetInspInputFormHeight; $1)
	C_TEXT:C284(LSS_MoveImageRows; $1)
	
	
	C_LONGINT:C283(LSS_PhotoSubForm_FM; $1)
	
	C_COLLECTION:C1488(LSS_StatusColors_c)
	C_LONGINT:C283(LSS_StatusColor; $0)
	
	C_LONGINT:C283(LSS_StatusTextColor; $0)
	
End if 