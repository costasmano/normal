//%attributes = {"invisible":true}
//Method: Mods_2024_01

//**********`Modified by: Costas Manousakis-(Designer)-(2024-01-03)
//Method: ARCH_AnnualMasterList - copied from v18Bug 2024-02-20
//Description
// Generate an annual Master List from records in the [BridgeMHDNBISArchive] table
// will use NBI Tape records
// requires templates WRP_MasterListStart and WRP_MasterListNonNBITitlePage

// ARCH_M_MasterList - copied from v18Bug 2024-02-20
//  `added optional object parameter. when it is passed, indicates that a combined master list is being produced
//  ` attributes .title : title for the report (input).
//  ` attributes .pagecount : number of pages printed (output).

//**********`Modified by: Costas Manousakis-(Designer)-(2024-01-08)
// [Cons Inspection];"Cslt Insp In" - copied from v18Bug 2024-02-20
//  `removed accept action from save button
//  `added dropdowns for contract no and assignment. 
//  `made fields [Cons Inspection]ConContractNo [Cons Inspection]AssignConNumber [Cons Inspection]ReqFeeProposal
//  ` [Cons Inspection]NTPdate_verbal [Cons Inspection]ProceedConDate  not enterable and transparent and deleted object methods.
//  `added definition of dropdowns On Load for contract num and assignment num by searching for open inspection contracts.
//  //Move code in On Validate to the Save button

//**********`Modified by: Costas Manousakis-(Designer)-(2024-01-10)
// MAIL_scriptOutlook - copied from v18Bug 2024-02-20
//  `user PROCESS 4D tags to convert body to HTML

// [Cons Inspection];"Cslt Insp In".DE btnSave - copied from v18Bug 2024-02-20
//  `added checks for valid contract number and assignment number
//  `now have to ACCEPT since automatic action was removed from button

//**********`Modified by: Costas Manousakis-(Designer)-(2024-01-11)
//Method: [Cons Inspection];"Cslt Insp In".DE contrno_list - copied from v18Bug 2024-02-20
//Description
// new contract number dropdown list

//Method: [Cons Inspection];"Cslt Insp In".DE assign_list - copied from v18Bug 2024-02-20
//Description
// New assignment number dropdown

//**********`Modified by: Costas Manousakis-(Designer)-(2024-01-12)
//Method: [Conslt Rating];"Cslt Rating In".DE contrno_list - copied from v18Bug 2024-02-20
//Description
// New contract number dropdown

//Method: [Conslt Rating];"Cslt Rating In".DE assign_list - copied from v18Bug 2024-02-20
//Description
// new assignment number dropdown

// [Conslt Rating];"Cslt Rating In" - copied from v18Bug 2024-02-20
//  `added dropdowns for contract no and assignment. 

//**********`Modified by: Costas Manousakis-(Designer)-(2024-01-16)
// [Conslt Rating];"Cslt Rating In".DE btnSave - copied from v18Bug 2024-02-20
//  `make sure all changes are in the change stack

//Method: CIR_UpdateAssgnFields - copied from v18Bug 2024-02-20
//Description
// update records in [Cons Inspection] or [Conslt Rating] with changes to fields
//[Contract Assignments]ReqFeeProposalDate
//[Contract Assignments]NTPdate_verbal
//[Contract Assignments]NTPdate_written
//[Contract Assignments]OverHeadRate
//[Contract Assignments]NetFeeRate

// [Contract Assignments];"Assignments In".DE btnSave - copied from v18Bug 2024-02-20
//  `update any related cons insp or cons rating records

//**********`Modified by: Costas Manousakis-(Designer)-(2024-01-19)
//Method: DB_ReturnLockStatusInfo - copied from v18Bug 2024-02-20
//Description
// Update a status object of a .lock() with an attribute that has all the info combined in one text
// Parameters
// $1 : $lockstatus_o
//    add .dblockstatusinfo

//Method: DB_LockEntityInteractive - copied from v18Bug 2024-02-20
//Description
// lock an entity in interactive mode  will keep trying until user cancels.
// Similar to ut_LoadRecordInteractive but using entity
// Parameters
// $0 : $Locked_b
// $1 : $entity
// $2 : $entityDescr_txt (optional)

//
//End Mods_2024_01   