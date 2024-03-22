//%attributes = {"invisible":true}
//Method: NTI_AddTIN_Inspection
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/04/16, 17:39:45
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
	// Modified by: Costas Manousakis-(Designer)-(8/21/17 17:02:24)
	Mods_2017_08_bug
	//  `Added determination of vsForward process var
	Mods_2018_01  //Changed description from routine to all items
	//Modified by: Chuck Miller (1/11/18 13:33:18)
	// Modified by: Costas Manousakis-(Designer)-(4/6/18 17:57:23)
	Mods_2018_04
	//  `use menus derived from DOM tree NTI_INSPREQUIREMENTSTREE_txt
	Mods_NewDownloadCode  //Make changes to address new upload and download code
	//Add call to Synch_ReturnForward to reset new style vsForward
	//Modified by: Chuck Miller (1/11/22 14:41:42)
End if 
//
//pick a type Routine, in Depth, Damage, Special
C_TEXT:C284($popup_txt)
$popup_txt:="  ;ALL Items;Overhead Items;Special Member;Damage;Boat Section"
C_LONGINT:C283($Choice_L)
//$Choice_L:=Pop up menu($popup_txt)

ARRAY TEXT:C222($Insptype_atxt; 0)
ARRAY TEXT:C222($Inspnames_atxt; 0)
ARRAY TEXT:C222($AttrNames_atxt; 0)
ARRAY POINTER:C280($AttrValueArrays_aptr; 0)
APPEND TO ARRAY:C911($AttrNames_atxt; "Name")
APPEND TO ARRAY:C911($AttrValueArrays_aptr; ->$Inspnames_atxt)

ut_DOM_To_Arrays(NTI_INSPREQUIREMENTSTREE_txt; "INSPTYPE"; ->$Insptype_atxt; ->$AttrNames_atxt; ->$AttrValueArrays_aptr)
INSERT IN ARRAY:C227($Insptype_atxt; 1; 1)
//$Insptype_atxt{1}:=" "`needs a space to be used in MENU_BuildMenuFromArrays
INSERT IN ARRAY:C227($Inspnames_atxt; 1; 1)
$Inspnames_atxt{1}:=" "  //needs a space to be used in MENU_BuildMenuFromArrays

C_TEXT:C284($menuref_txt; $selected_txt)
$menuref_txt:=MENU_BuildMenuFromArrays(->$Inspnames_atxt; ->$Insptype_atxt; "\\")

$selected_txt:=Dynamic pop up menu:C1006($menuref_txt)
RELEASE MENU:C978($menuref_txt)

//If ($Choice_L>1)
If ($selected_txt#"")
	C_TEXT:C284(NTI_NewTINInspType_txt)
	//Case of 
	//: ($Choice_L=2)
	//NTI_NewTINInspType_txt:="ZRN"
	//: ($Choice_L=3)
	//NTI_NewTINInspType_txt:="ZOI"
	//: ($Choice_L=4)
	//NTI_NewTINInspType_txt:="ZSM"
	//: ($Choice_L=5)
	//NTI_NewTINInspType_txt:="ZDA"
	//: ($Choice_L=6)
	//NTI_NewTINInspType_txt:="ZBT"
	
	//End case 
	NTI_NewTINInspType_txt:=$selected_txt
	FORM SET INPUT:C55([TIN_Inspections:184]; "Input")
	C_LONGINT:C283($Width_L; $Height_L; $Choice_L)
	
	FORM SET INPUT:C55([TIN_Inspections:184]; "Input")
	FORM GET PROPERTIES:C674([TIN_Inspections:184]; "Input"; $Width_L; $Height_l)
	//ut_OpenNewWindow ($Width_L;$Height_l;0;Plain window )
	READ WRITE:C146([TIN_Inspections:184])
	C_BOOLEAN:C305(vbInspectionLocked)
	vbInspectionLocked:=False:C215
	
	//If (Structure file="MHD BMS External@")
	//If (Num([NTI_TunnelInfo]NTI_i6_s)#0)
	//vsForward:="District "+String(Num([NTI_TunnelInfo]NTI_i6_s))+" BMS"
	//End if 
	//End if 
	//add the record
	vsForward:=Synch_ReturnForward([NTI_TunnelInfo:181]NTI_i6_s:11; [NTI_TunnelInfo:181]NTI_InspResp:73; ""; 0)
	
	ADD RECORD:C56([TIN_Inspections:184])
	
	NTI_ListTIN_Inspections
	
End if 

//End NTI_AddTIN_Inspection