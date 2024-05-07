//%attributes = {"invisible":true}
//Method: Mods_2024_04

//**********`Modified by: Costas Manousakis-(Designer)-(2024-04-05)

// CIR_SetInspectionType_OM -***- copied from v18Bug to develop branch 2024-05-06
//  `use collection to combine the types
//  `account for the new checkboxes for inspection types
// CIR_SetReceiveLabels -***- copied from v18Bug to develop branch 2024-05-06
//  `use collections to compile the strings
//  `account for the new checkboxes for inspection types
// CIR_InitInspTypeChkboxes -***- copied from v18Bug to develop branch 2024-05-06
//  `account for the new checkboxes for inspection types

//**********`Modified by: Costas Manousakis-(Designer)-(2024-04-11)

// [LSS_Inventory];"ListBoxOutput".bQuery -***- copied from v18Bug to develop branch 2024-05-06
//  `added option to select random number of records from current list
//  `changed button to "with popup menu separated" ; enabled on Alternate click and on long click 
//  `don't use the Shift - modifier when clicking
//  `from popup menu removed option to find structures with no match - only useful when there were two servers

// LSS_SortDupsOnly -***- copied from v18Bug to develop branch 2024-05-06
//  `use structure arrays to find dups ; added progress indicator

// LSS_FindInvalidStructureNames -***- copied from v18Bug to develop branch 2024-05-06
//  `use struct number array instead of looping thru records
//  `add progress indicator

// LSS_SetInventoryNumber -***- copied from v18Bug to develop branch 2024-05-06
//  `when getting next number make sure it is within the district 

// [LSS_Inventory];"Edit_SIN" -***- copied from v18Bug to develop branch 2024-05-06
//  `added button to get a new I.N. number - rearranged the objects in that row; removed variables from buttons
//  `adjusted size and location of objects on first line

// GRP_GetMembersOfGrps -***- copied from v18Bug to develop branch 2024-05-06
//  `use arrays to search instead of looping through [pers_group] records.

// [LSS_Inspection];"InspectionReview".bQuery -***- copied from v18Bug to develop branch 2024-05-06
//  `added on alt click and on long click events to button. added option with pop-up menu separated

//**********`Modified by: manousakisc-(Designer)-(4/12/2024)

// [Contracts];"Contracts_LB" -***- copied from v18Bug to develop branch 2024-05-06
//  `do not block users if they are also members of "Conslt Rating - ReadWrite"

//**********`Modified by: manousakisc-(Designer)-(4/24/2024)

// LSS_SetUpReviewButton -***- copied from v18Bug to develop branch 2024-05-06
//  `use ds. queries to avoid changing current selections

//**********`Modified by: manousakisc-(Designer)-(4/24/2024)

//added Field [Contract Assignments]ReqFeeProposalRcd  date -***- copied from v18Bug to develop branch 2024-05-06

// [Contract Assignments];"Assignments In" -***- copied from v18Bug to develop branch 2024-05-06
//  `added label and field [Contract Assignments]ReqFeeProposalRcd; moved objects to fit.

// CIR_UpdateAssgnFields -***- copied from v18Bug to develop branch 2024-05-06
//  `added code to account for new field [Contract Assignments]ReqFeeProposalRcd

// [Cons Inspection];"Cslt Insp In" -***- copied from v18Bug to develop branch 2024-05-06
//  `made field [Cons Inspection]FeeProposalRecvd not enterable and transparent and deleted object methods.
//  `made all 4 date fields with format System date short 
//  `added checkboxes for Initial, Freeze thaw and damage inspections - re-arranged the insp type checkboxes

//**********`Modified by: Costas Manousakis-(Designer)-(2024-04-29)

// [Contract Assignments];"Assignments In" -***- copied from v18Bug to develop branch 2024-05-07
//  `added label and field [Contract Assignments]ReqFeeProposalRcd; moved objects to fit.
//  `renamed the four date field objects to @_date

// [Contract Assignments];"Assignments In".DE btnSave -***- copied from v18Bug to develop branch 2024-05-07
//  `added checks on dates 

//**********`Modified by: Costas Manousakis-(Designer)-(2024-04-30)

// CONS_Address_O_FM -***- copied from v18Bug to develop branch 2024-05-07
//  `fixed wrong variable for the add button

// [Conslt Address];"View Conslt Address_LB".Variable1 -***- copied from v18Bug to develop branch 2024-05-07
//  `remove on load code - handled in form method

// [Conslt Address];"View Conslt Address".Variable1 -***- copied from v18Bug to develop branch 2024-05-07
//  `remove on load code - handled in form method

// [Conslt Address];"Conslt Address In".ConsNames_HL -***- copied from v18Bug to develop branch 2024-05-07
//  `Update the consultant name field and variable.

// [Conslt Address];"Conslt Address In" -***- copied from v18Bug to develop branch 2024-05-07
//  `run the code for the HL menu for all users. disable HL menu when in RO mode

// [Conslt Address];"Conslt Address In".DATABTN1 -***- copied from v18Bug to develop branch 2024-05-07
//  `Remove BMS admin group ; add members of CSLTAddressManage group access to the Edit name button - set Employers as the choice list

//```
//```    **** End of Release 8.0.5 2024-04-30
//```

//End Mods_2024_04   