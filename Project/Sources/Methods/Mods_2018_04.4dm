//%attributes = {"invisible":true}
//Method: Mods_2018_04
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 04/02/18, 11:14:21
	// ----------------------------------------------------
	//Created : 
	Mods_2018_04
End if 
//Continue work on 
//NTI_DuplicateInspection
//NTI_DuplicateElements 
//Make sure no error if no match for agency
//TININSP_aAgency_OM


//add groups person is member of to 
//[Personnel];"Inspectors In"
//  // Method: Form Method: Inspectors In
//Method: [Personnel].Inspectors In.ViewGroups //New button
//Compiler_Personnel

//Fix error where $Pos_l might be less than zero when User in group(Current user;"Design Access Group"))
// Method: Object Method: [LSS_Inventory].Input.Inspection_LB

//Change delete from aut action to no action (Delete photo recprd here in code and and accept
//[LSS_Photos];"Input"-changed button from delete to no action
//Method: Object Method: [LSS_Photos].Input.bDelete


//Remove ability to delete a UT or D-Meter sketch once record is created
//LSS_SaveDMorUTPicture 
//Also removed following events form both D-Meter Picture and Ut Picture variable
//on Begin drag over
//On Drag Over
//On Drop
//[LSS_Inspection];"Input_ITS"
//[LSS_Inspection];"Input_Light"
//[LSS_Inspection];"Input_Sign"
//[LSS_Inspection];"Input_Signal"
//LSS_GotToInspectionPage//reset LSS_ThisPictureDrag_b to False


//Make sure [LSS_Photos] record is loaded for D-Meter and UTR pages on form
//Modified by: Chuck Miller (4/19/18 12:08:49
//LSS_GotToInspectionPage
//Made changes to Dmeter and UT pages on _ITS and copied those to the other forms
//[LSS_Inspection];"Input_ITS"
//[LSS_Inspection];"Input_Light"
//[LSS_Inspection];"Input_Sign"
//[LSS_Inspection];"Input_Signal"

//```
//```    **** End of Release 7.1.0 18-Apr-2018
//```

//**********`Modified by: Costas Manousakis-(Designer)-(4/30/18)
// Modified Table(s) : 
//[LSS_Inventory]
//Added many to one links 
//  from [LSS_Inventory]LSS_StructureTypeId_s to [LSS_refStructureTypes]
//   from [LSS_Inventory]LSS_StructureCoatingId_s to [LSS_refStructureCoating]LSS_StructureCoatingId_s
//   from [LSS_Inventory]LSS_StructureMaterialId_s to [LSS_refStructureMaterial]LSS_StructureMaterialId_s

// Modified Object Methods : 
// [LSS_Inventory];"ListBoxOutput".bQuery
//  `set auto relations to true ; true before doing a query table

//Method: SIA_BridgeCondRating
//Description
//
// Parameters
// $0 : $Rating + Critical item(s)
// $1 : $Item58 (optional - assume current [Bridge MHD NBIS] record)
// $2 : $Item59 (optional - assume current [Bridge MHD NBIS] record)
// $3 : $Item60 (optional - assume current [Bridge MHD NBIS] record)
// $4 : $Item62 (optional - assume current [Bridge MHD NBIS] record)

//End Mods_2018_04