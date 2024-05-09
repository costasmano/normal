//%attributes = {"invisible":true}
//Method: Mods_2024_LSS_1

// **** copied from v18bugfix to Normal  branch:develop 
//added to table [LSS_Inventory] fields #39 : LSS_Cycle_L , #40 : LSS_NextSchedInsp_d
//added to table [LSS_Inspection] fields #60 : LSS_ContractNo_L, #61 LSS_AssignmentNo_L

// **** copied from v18bugfix to Normal  branch:develop 
//Method: LSS_DuplicateInspection 
//Description
// duplicate the current inspection - meant to be used in 'batch' mode to create inspection assignments.
// Parameters
// $1 : $parameterobject
//   ->  .contractno
//   ->  .assignno
//   ->  .batch (boolean) optional
//   ->  .showmessage  (boolean) optional
//   <-  .newinspid 
//   <-  .newinsptype 

// **** copied from v18bugfix to Normal  branch:develop 
//Form  "LSS_EditContracts"
//Description
// Form to edit system parameter LSS_Contracts

// **** copied from v18bugfix to Normal  branch:develop 
//Method: LSS_ContractsToStorage
//Description
// save the collection in systemparameter LSS_Contracts to Storage

// **** copied from v18bugfix to Normal  branch:develop 
//Method: LSS_ImportAssignements
//Description
// Import LSS Inspection assignments from a text file
// should report back what type inspection was created initial or routine
// input is :
//   col1 : structure number
//   col2 : contract number
//   col3 : assignment number

// **** copied from v18bugfix to Normal  branch:develop 
//Method: LSS_InitSchedInspDate
//Description
// initialize the Next scheduled inspection date and Cycle values
// for all inventory records

// **** copied from v18bugfix to Normal  branch:develop 
//Method: LSS_ManageAncInspContracts
//Description
// open LSS_EditContracts dialog to manage Anc Structure inspection contracts

// **** copied from v18bugfix to Normal  branch:develop 
//Method: LSS_MemberofContract
//Description
// Check if a user is member of one of the companies associated with a contract
// Parameters
// $0 : $Member_b
// $1 : $ContractNum_L
// $2 : $PersonID_L (optional - default to current user PID

// **** copied from v18bugfix to Normal  branch:develop 
// FM_InspectionInput
//  `mods to handle Contract num and assignment num
//  `If there is a contract, disable the delete button except for design user or members of "LSS_AllowDeleteAssignment"

// **** copied from v18bugfix to Normal  branch:develop 
// FM_SaveInspection
//  `update next sched inspection date if the insp date # 0 (date cannot be future date) 
//  `and insp type=@1 or @2(initial or routine)
//  ` also make structure active if it is not

// **** copied from v18bugfix to Normal  branch:develop 
// LSS_DisplayInspection
//  `Allow users in LSS_MassEditAccess to edit so they can modify Contract and assignment number

// **** copied from v18bugfix to Normal  branch:develop 
// LSS_InspectionRecSave
//  `added updating of modified fields

// **** copied from v18bugfix to Normal  branch:develop 
// LSS_InspReviewLB_OM
//  `allow copying of structure numbers when using right-click on the str num column.
//  `enable on Clicked event for listbox object on inspection review form

// **** copied from v18bugfix to Normal  branch:develop 
// LSS_PermissionModInspection
//  `re-arranged last checks for all non design users
//  `Allow editing of blank inspections (date=!00/00/00!) with a contract number if user is member of one associated companies 

// **** copied from v18bugfix to Normal  branch:develop 
// LSS_SetUp
//  `added LSS_defaultcycle Storage object 
//  `call LSS_ContractsToStorage

// **** copied from v18bugfix to Normal  branch:develop 
// LSS_SetUpInventoryListBox
//  `added columns for contract number and assignment number

// **** copied from v18bugfix to Normal  branch:develop 
// [LSS_Inspection];"Inspection_Template"
//  `added objects for Contract info (consultant, cont num, assign num) and HL dropdown

// **** copied from v18bugfix to Normal  branch:develop 
// [LSS_Inventory];"Input"
//  `resized and moved Inspection related buttons and listbox to allow for Contract and Assignment columns
//  `added Cycle (years) and Next Scheduled inspection dates - added Edit button to edit the cycle accessible for members of "LSS_EditCycle"

// **** copied from v18bugfix to Normal  branch:develop 
// [LSS_Inventory];"Input".Inspection_LB
//  `unload and reload LSS_inventory record on exit from the inspection to update any changes to cycle and next sched date
//  `added sorting of inspections by date to update the list and account if inspection has been deleted

// **** copied from v18bugfix to Normal  branch:develop 
// [LSS_Inventory];"Input".LSS_Edit_L
//  `unload and reload LSS_inventory record on exit from the inspection to update any changes to cycle and next sched date
//  `added sorting of inspections by date to update the list and account if inspection has been deleted

// **** copied from v18bugfix to Normal  branch:develop 
// [LSS_Inventory];"Input".LSS_Duplicate_L
//  `initialize the contract and assignment number

// **** copied from v18bugfix to Normal  branch:develop 
// [LSS_Inventory];"ListBoxOutput".Inventory_LB
//  `use contextual click on 1st column to copy the selected structure numbers
//  `enable on Clicked event for listbox object

// **** copied from v18bugfix to Normal  branch:develop 
// [LSS_Inventory];"ListBoxOutput".Tools
//  `on form enabled On load event for button

// **** copied from v18bugfix to Normal  branch:develop 
// [PERS_Groups];"Input"
//  `added missing pushchange on the group name when duplicating a group

//
//End Mods_2024_LSS_1   