//%attributes = {"invisible":true}
// ----------------------------------------------------
// Mods_2004_VN03
// Date: 11/22/04
// Date: 01/12/05
// ----------------------------------------------------
// Description
// This method will outline changes made per Costas by me
//
// Parameters
// None
// ----------------------------------------------------

//Modified Form Object Method:
//[Bridge MHD NBIS]; "Inspections"; "bDuplicate"
//  `Modify the code that allows users to duplicate different types of inspections
//  `  such as regular inspection, special inspection, and combined inspection.
//  `  For the combined inspection, the user now has the option to duplicate 
//  `  either special inspection or combined inspection.
//  `Replace Push Pop Record data structure by using query with the new
//  `  $NewInspID to get the record that just duplicated.
//  `Restructure the codes so that it is easy to maintain and read. Instead of
//  `  putting all the codes for the duplications of regular,  special, or combine
//  `  inspection in on place, the method will make a call either to a new
//  `  project method named Duplicate_Inspection with the boolean flag  
//  `  either true or false depending on the type of the inspection.

//Modified Form Method:
//[Inspections]; "Inc. Inpsections"
//  `Modified the code not to append the string " & Spec.Mem." to the
//  `  description of the special inspection when it is duplicated from the 
//  `  combined inspection 

//Created New Project Method:
//  `Duplicate_Inspection

//Created New Dialog Form
//  `[Dialogs]; "DupicateInsp"