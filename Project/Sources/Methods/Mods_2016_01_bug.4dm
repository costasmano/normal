//%attributes = {"invisible":true}
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 01/05/16, 14:17:35
//----------------------------------------------------
//Method: Mods_2016_01_bug
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	//   ` 
	//Modified by: administrator (1/5/16 14:17:37)
	
End if 

//**********`Modified by: Costas Manousakis-(Designer)-(1/4/16)
// Modified Method(s) : 
//fUpforInsp
//  `When  checking UW Spec memb (case 9) use the routine date if  it is after the spec memb.


//Modified by: administrator (1/5/16 14:53:31)
//   `FIX BUG WHERE [Activity Log] records were being created where they should not have been
//  `added emailing of duplicate records found in FileIDRes table at the end of download
//  `modified methods  
//ut_ControlDBSycnh
//ut_SQLCreateNewRecord
//ut_SQLDownloadNewRecords 
//ut_SQLUpdateLocalFields 
//ut_SQLDeleteLocalRecord
//ut_SQLDeleteLocalRecords 
//aLookUpDest
// Created Method(s) : 
//ut_ReturnProcessName

// Add items that user can change in Structure number
//Modified by: administrator (1/7/16 14:53:31)
//[LSS_Inventory];"Edit_SIN"
// Object Method: [LSS_Inventory].Edit_SIN.LSS_StructureClass_atxt
// Object Method: [LSS_Inventory].Edit_SIN.LSS_RouteDesignation_atxt
// Object Method: [LSS_Inventory].Edit_SIN.LSS_RouteDirection_as 
// Object Method: [LSS_Inventory].New_InventoryItem.LSS_Cities_atxt
// Object Method: [LSS_Inventory].New_InventoryItem.LSS_Route_L
// Object Method: [LSS_Inventory].New_InventoryItem.LSS_RouteSuffix_L
// Object Method: [LSS_Inventory].Edit_SIN.v_165_007_r
// Object Method: [LSS_Inventory].Edit_SIN.v_165_008_r
//[LSS_Inventory];"Input"
//FM_InventoryInput
//LSS_Edit_Inv_SIN 

//**********`Modified by: Costas Manousakis-(Designer)-(1/7/16)
// Modified Method(s) : 
//LSS_PrintInspection
//  `added code to count UT print pages accounting for more than 11 rods per UT- 2nd pages take up to 18
//LSS_PrintUT
//  `added ability to print multiple pages for ut results
// Created Form(s) : 
//[LSS_UT];"UTPrintPg2"
//  `to Allow printing  of more than 11 rod results per UT inspection 

//**********`Modified by: Costas Manousakis-(Designer)-(1/11/16)
// Created Method(s) : 
//Method: LSS_UpdateStructNumPart
//Description
// Update a part of the  LSS structure number
// Parameters
// $0 : $Result
// $1 : $StartStructNumber_txt
// $2 : $PartValue_txt
// $3 : $PartNum_L


//```
//```   **** End of Release 6.5.0.b 2016-01-12 
//```

//**********`Modified by: Costas Manousakis-(Designer)-(1/14/16)
// Modified Forms/FormMethod : 
//[LSS_Inventory];"Edit_SIN"
//  `Addition of changing  the town/District ; Added city / town /distr ;moved obj down by 30 ;  changed form method
// Modified Method(s) : 
//LSS_Edit_Inv_SIN
//  `Addition of changing  the town/District
//Object Method: [LSS_Inventory].Edit_SIN.LSS_TownName_atxt 
//  `Addition of changing  the town/District


//**********`Modified by: Costas Manousakis-(Designer)-(1/15/16)
// Created Method(s) : 
//Method: LSS_FillPrintCheckBoxes
//Description
// fill the checkboxes in LSS print inspection forms   - needed because boolean fields print with grey background in Windows

// Modified Forms : 
// [LSS_Inspection];"Print_DMeter"
//  `moved title ,pict, desc and notes up by 10, increased NOTES ht by 10 to accommodate some future changes
//[LSS_Inspection];"LSS_FormTemplate"
//  `adjusted size and locaion of SIN and Route number; made style sheets arial9
//[LSS_Inspection];"ITSStructurePg1"
//  ` changed Cracks from the field to a check box with a boolean variable
//  `made form type as detail form for printing ; platform : printing ; unchecked all event except on printing detail`
//  `adjusted size/location of struct material field, struct coating
//  `increased size of AssetNo
//  `check boxes must be done in form method - check boxes are initialized on form load
//[LSS_Inspection];"ITSStructurePg2"
//  `made form type detail form for printing; form platform printing; adjust size location of SIN and Routenumber
//  `replaced Plans and photos  fields with checkboxes with variables; added call to LSS_FillPrintCheckBoxes
//  `increased  size of boxes for num arms, arm lengths, heights
//[LSS_Inspection];"LightStructurePg1"
//  ` changed Cracks from the field to a check box with a boolean variable
//  `made form type as detail form for printing ; platform : printing ; unchecked all event except on printing detail`
//  `adjusted size/location of struct material field, struct coating
//  `increased size of AssetNo
//  `increased vert  size to 12 of all Arial10 fields and vars in the header
//  `check boxes must be done in form method - check boxes are initialized on form load call method LSS_FillPrintCheckBoxes
//[LSS_Inspection];"LightStructurePg2"
//  `made form type detail form for printing; form platform printing; adjust size location of SIN and Routenumber and top of all vars in header
//  `replaced Plans and photos  fields with checkboxes with variables; added call to LSS_FillPrintCheckBoxes
//  `increased  size of boxes for num arms, arm lengths, heights
//[LSS_Inspection];"SignStructurePg1"
//  ` changed Cracks from the field to a check box with a boolean variable
//  `made form type as detail form for printing ; platform : printing ; unchecked all event except on printing detail`
//  `adjusted size/location of struct material field, struct coating
//  `adjusted size/location of labels in SIGN PANELS header
//  `adjusted size/location of labels/variables in the structure location line
//  `adjusted size/location of labels/variables in the structure type line
//  `increased size of AssetNo
//  `check boxes must be done in form method - check boxes are initialized on form event; added call to LSS_FillPrintCheckBoxes
//[LSS_Inspection];"SignStructurePg2"
//  `made form type detail form for printing; form platform printing; adjust size location of SIN and Routenumber; made header vars arial9
//  `replaced Plans and photos  fields with checkboxes with variables; added call to LSS_FillPrintCheckBoxes
//  `increased size of boxes for num spans and span length/arm
//[LSS_Inspection];"TrafficSignalStructurePg1"
//  ` changed Cracks from the field to a check box with a boolean variable
//  `made form type as detail form for printing ; platform : printing ; unchecked all event except on printing detail`
//  `adjusted size/location of struct material field, struct coating
//  `increased size of AssetNo
//  `increased vert size of all single line arial10 in header to 12 ht
//  `check boxes must be done in form method - check boxes are initialized on form load call LSS_FillPrintCheckBoxes
//[LSS_Inspection];"TrafficSignalStructurePg2"
//  `made form type detail form for printing; form platform printing; adjust size location of SIN and Routenumber
//  `replaced Plans and photos  fields with checkboxes with variables; added call to LSS_FillPrintCheckBoxes
//  `increased  size of boxes for num arms, arm lengths, heights

//Deleted Form :
//[LSS_Inspection];"LSS_D_Meter"


//**********`Modified by: Costas Manousakis-(Designer)-(1/20/16)
// Created Method(s) : 
//Method: PON_ExportFHWANBE
//Description
//  `method to export NBE elements in XML format to submit to FHWA
//  `Current version does all records in [PON_ELEM_DEFS]
//  `Needs to be updated to work only with the current selection of Bridges
//  `Also has two versions of the XML template

// Modified Method(s) : 
//Compiler_PON
//  `Export NBE to  FHWA definitions

//**********`Modified by: CJM-(Designer)-(1/21/16)
//ut_LSSControlPictureMod
//  ` Fix where UT and DMeter pictures not being saved properly
// Modified Object Methods : 
//Method: Object Method: [LSS_Inspection].Inspection_Template.bValidate
//`  ` Fix where UT and DMeter pictures not being saved properly

//**********`Modified by: Costas Manousakis-(Designer)-(1/21/16)
// Modified Forms : 
//[LSS_UT];"UTPrint"
//  `replaced text for search unit., smallest def, search beam with static pictures to account for the lambda in the text (showed up as ?)
//  `made search diam & freq wider 

//**********`Modified by: Costas Manousakis-(Designer)-(1/25/16)
// Modified Method(s) : 
//LSS_PrintInspection
//  `added missing call to set query destination into curr sel after the DMeter count

// ut_PRJRetrieveConstructionCont
//  ` in sp_RTRVSpecData reduce to use only planstoprint and toCashier - other fields were deprecated in new Tish

// SQL_FillBuiltStatements
//  `in call for "sp_RTRVSpecData"  reduced to planst to print and toCashier

//**********`Modified by: Costas Manousakis-(Designer)-(1/26/16)
// Created Method(s) : 
//PRJ_TempUpdateSQLID
// Description
// Update the SQLID in the [PRJ_ConstructionProject] table

//**********`Modified by: Designer)-(1/27/16)
// Created Method(s) : 
// Method: ut_FixPRJRetrieve
// Description
// method to fix the duplicate SQLIDs/ Contract numbers found in the [PRJ_ConstructionProject]


//```
//```   **** End of Release v6.5.0.c 01/27/2016
//```

//**********`Modified by: CJM-(Designer)-(1/28/16)
// Created Method(s) : 
//Method: ut_Fix
//  `Description
//  `Fix duplicate [FileIDRes Table] records
//Method: ut_FixPRJRetrieve
//  `Description
//  ` method to fix the duplicate SQLIDs/ Contract numbers found in the [PRJ_ConstructionProject]
//Method: ut_FixPRJRetrievePart2

//**********`Modified by: Costas Manousakis-(Designer)-(1/28/16)

// Modified Forms / form method: 
//Method: Form Method: [LSS_Inventory];'CustomSearch"
//  `replaced LSS_Townname_atxt , etc with global variables ◊aTownName, ◊aBDEPT, ◊aDistrict
// Modified Object Methods : 
//Object Method: [LSS_Inventory].CustomSearch.LSS_SearchTwnCode_txt 
//Object Method: [LSS_Inventory].CustomSearch.aTownName_ 
//Object Method: [LSS_Inventory].CustomSearch.LSS_SearchDistr_aL 
//  `replaced LSS_Townname_atxt , etc with global variables ◊aTownName, ◊aBDEPT, ◊aDistrict`
//  `use the District dropdown to narrow down the list of towns.

// Modified Form : 
//Form  [PON_ELEM_DEFS];"Input" 
//  ` changed style  of everything to Label12 made notes to grow vertically and fields below it to move vertically

//**********`Modified by: Costas Manousakis-(Designer)-(1/29/16)
// Modified Method(s) : 
// Method: PON_LoadElementHelp
//  `changes to read the element notes and split them into notes and Commentary

//**********`Modified by: Costas Manousakis-(Designer)-(1/30/16)
// Modified Method(s) : 
//PON_ExportFHWANBE 
//  `Adjusted to consider [PON_ELEM_DEFS]ELEM_SUBSET_KEY which should indicate the 'roll up' key for elements
// Created Method(s) : 
//Method: PON_util1
//Description
//  ` load notes from a tab delimited file into the notes field for an element
//  ` the columns in the tab delimited file are:
//  ` key Description QuantityCalc CommentaryParag1 CommentaryParag2 CommentaryParag3 CommentaryParag4
//  ` the notes field will be formatted as :
//  ` Description<br><b>Quantity Calculations :<b>QuantityCalc <Commentary>CommentaryParag1<br>CommentaryParag2<br>CommentaryParag3<br>CommentaryParag4

//End Mods_2016_01_bug