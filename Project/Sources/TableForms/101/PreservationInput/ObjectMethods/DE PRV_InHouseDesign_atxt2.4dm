//Method: Object Method: [Contract_Assignment_Maintenance].PreservationInput.PRV_ProjectStatus_atxt
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/01/13, 11:46:02
	// ----------------------------------------------------
	//Created : 
	Mods_2013_02
End if 
//
PRV_PopupMenuC(->PRV_InHouseDesign_atxt; ->PRV_InHouseDesign_atxt; ->[Contract_Assignment_Maintenance:101]DesignerDesignation_s:76; "Enter Status")

If ([Contract_Assignment_Maintenance:101]DesignerDesignation_s:76="District@")
	OBJECT SET ENTERABLE:C238([Contract_Assignment_Maintenance:101]DistrictPM_s:77; True:C214)
	OBJECT SET RGB COLORS:C628([Contract_Assignment_Maintenance:101]DistrictPM_s:77; Col_paletteToRGB(Abs:C99(<>Color_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_editable)\256))  // **Replaced o OBJECT SET COLOR([Contract_Assignment_Maintenance]DistrictPM_s; <>Color_editable)
Else 
	[Contract_Assignment_Maintenance:101]DistrictPM_s:77:=""
	OBJECT SET ENTERABLE:C238([Contract_Assignment_Maintenance:101]DistrictPM_s:77; False:C215)
	OBJECT SET RGB COLORS:C628([Contract_Assignment_Maintenance:101]DistrictPM_s:77; Col_paletteToRGB(Abs:C99(<>Color_Not_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_editable)\256))  // **Replaced o OBJECT SET COLOR([Contract_Assignment_Maintenance]DistrictPM_s; <>Color_Not_editable)
End if 

//End Object Method: [Contract_Assignment_Maintenance].PreservationInput.PRV_ProjectStatus_atxt