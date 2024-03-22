//%attributes = {"invisible":true}
If (False:C215)
	//General Method G_AddHeader
	//Set a Header for a group of elements in inspection forms according
	//to the category.
	//Defines process variable   vtHeaderLbl  to be used in methods
	//  G_AddElmtTxt2Area 
	//  and
	//  G_addItemtoWr 
	
	
	//$1 : Element Category 
	
	Mods_2004_CM11
	Mods_2005_CM03
	// Modified by: Costas Manousakis-(Designer)-(2/13/12 16:45:57)
	Mods_2012_02
	//  `Added the GENeral case for RRR inspections
	// Modified by: Costas Manousakis-(Designer)-(5/2/13 14:32:45)
	Mods_2013_05
	//  `Added Tunnel Sections
End if 

C_TEXT:C284($1; $LabelCode)  // Command Replaced was o_C_STRING length was 3
$LabelCode:=$1

C_TEXT:C284(vtHeaderLbl)
vtHeaderLbl:=""
Case of 
	: (Not:C34(f_Insp_Revision1([Inspections:27]Insp Date:78)))
		//do nothing for inspections before DATE_1
	: ($LabelCode="N58")
		vtHeaderLbl:="ITEM 58 - DECK"
	: ($LabelCode="N59")
		vtHeaderLbl:="ITEM 59 - SUPERSTRUCTURE"
	: ($LabelCode="N60")
		vtHeaderLbl:="ITEM 60 - SUBSTRUCTURE"
	: ($LabelCode="N61")
		vtHeaderLbl:="ITEM 61 - CHANNEL AND CHANNEL PROTECTION"
	: ($LabelCode="N62")
		vtHeaderLbl:="ITEM 62 - CULVERT"
	: ($LabelCode="TRA")
		vtHeaderLbl:="TRAFFIC SAFETY"
	: ($LabelCode="OVR")
		vtHeaderLbl:="OVERHEAD SIGNS"
	: ($LabelCode="APP")
		vtHeaderLbl:="APPROACHES"
	: ($LabelCode="GEN")
		vtHeaderLbl:="GENERAL"
	: ($LabelCode="STR")
		vtHeaderLbl:="62a - STRUCTURAL"
	: ($LabelCode="ROA")
		vtHeaderLbl:="62b - ROADWAY"
	: ($LabelCode="CEI")
		vtHeaderLbl:="62c - CEILING / OVERHEAD"
	: ($LabelCode="SUP")
		vtHeaderLbl:="62d - AIR DUCT"
	: ($LabelCode="CRO")
		vtHeaderLbl:="62e - CROSS PASSAGE"
	: ($LabelCode="EGR")
		vtHeaderLbl:="62f - EGRESS"
	: ($LabelCode="UTI")
		vtHeaderLbl:="62g - UTILITY ROOM"
	: ($LabelCode="WET")
		vtHeaderLbl:="WETNESS"
		
End case 