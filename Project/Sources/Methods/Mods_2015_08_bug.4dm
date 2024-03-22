//%attributes = {"invisible":true}
//Method: Mods_2015_08_bug
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 08/11/15, 09:48:44
	// ----------------------------------------------------
	//Created : 
	Mods_2015_08_bug
End if 
//
//**********`Modified by: Costas Manousakis-(Designer)-(8/11/15)
// Modified Method(s) : 
//ut_UpdateorCreatePhotoRecord
//  `Length of $key_s changed to 20

// Added code to allow change to mile marker/ kilo point on 
//Modified by: administrator (8/13/15 13:24:39)
//[LSS_Inventory];"Input"
//New button EditIDNum
//LSS_ResetStructureNumber
//Method: Object Method: [LSS_Inventory].Input.LSS_KiloPoint_r
//Method: Object Method: [LSS_Inventory].Input.LSS_MilePoint_r

//Make sure mile point truncates to be part of structure number
//LSS_SetInventoryNumber


//Modified by: designer CM  (8/14/15)
//Indexed fields
//[LSS_Inventory]LSS_IdentificationNumber_L
//[LSS_Inventory]LSS_StructureNumber_s
//[LSS_Inventory]LSS_Route_s
//[LSS_Inventory]LSS_InventoryType_s

//Modified by: designer CM  (8/14/15)
//modified Forms
//[LSS_ElementInspection];"Input"
//[LSS_Inspection];"Input_ITS"
//[LSS_Inspection];"Input_Light"
//[LSS_Inspection];"Input_Sign"
//[LSS_Inspection];"Input_Signal"
//[LSS_UtResult];"Input"
//  `  `Made comments and recommendation fields AutoSpellcheck

// Method: FM_InventoryInput
//  `Added EditIDNum button to the list of enable/disable buttons
//Form Method:[PERS_Groups];"Input"
//  `Fix case where Groupmember id not found in Personnel table

//Form / form Method: [LSS_Inventory]New_InventoryItem
//  `Added button "Confirm" to verify changes in SIN. - moved code from the LSS_SIN_2_L object to the confirm button
//  `make sure pulldowns and fields are enterable on load - to address the logic of the "Confirm" any SIN changes


//Modify to allow for changing structure number
//LSS_ResetStructureNumber
//LSS_SetInventoryNumber 
//[LSS_Inventory];"Input"
//[LSS_Inventory];"New_InventoryItem"


//Fix bug re previous and next record buttons not working correctly
//[LSS_ElementInspection];"Input"
//[LSS_Photos];"Input"
//[LSS_UtResult];"Input"

//Fix [LSS_Photos]LSS_PhotoSequence_L bug
//[LSS_Photos];"Input"
//FM_SaveInspection 
//FM_InspectionInput 
//LSS_GotToInspectionPage
//Compiler_LSS
//FM_SavePhotoInput  
//LSS_ResequencePictures 
//Method: Object Method: [LSS_Inventory].New_InventoryItem.LSS_StructureClass_atxt
//Method: Object Method: [LSS_Photos].Input.bDelete

//**********`Modified by: Costas Manousakis-(Designer)-(8/19/15)
// Modified Method(s) : 
//PON_ELEMINP_FM
//  `Added the total quantity to the display of the parent text 
// Modified Forms : 
//[PON_ELEM_INSP]Input
//  `re-arranged objects in page 0 to allow for display of total quantity


//Completed code and fix bugs as part of photo seq bug
//Modified by: administrator (8/20/15 14:30:47)
//FM_SaveInspection 
//LSS_ResequencePictures
//[LSS_Photos];"Input"
//  `Method: Object Method: [LSS_Photos].Input.bDelete
//Changed description inspection tabs to Images from Photso and Sketches
//Method: Object Method: [LSS_Inspection].Inspection_Template.bValidate`save and exit
//Method: Object Method: [LSS_Inspection].Inspection_Template.bValidate`save and remain on form

//[LSS_Inspection];"Input_ITS"
//[LSS_Inspection];"Input_Light"
//[LSS_Inspection];"Input_Sign"
//[LSS_Inspection];"Input_Signal"
//LSS_GotToInspectionPage

//Modified by: administrator (8/26/15 11:18:47)
//change save message to not say photos
//[LSS_Photos];"Input"
//Method: Object Method: [LSS_Photos].Input.bCancel
//NOTE that all LSS changes have been moved to development

//Change the way display of structure type occurs
//Modified by: administrator (9/1/15 14:37:52)
//LSS_SortStructureType 
// Method: Object Method: [LSS_Inventory].ListBoxOuput.List Box
//m_ListInventory
//NOTE all changes for Change the way display of structure type occurs have been moved to development


//End Mods_2015_08_bug