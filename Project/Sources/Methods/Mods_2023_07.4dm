//%attributes = {"invisible":true}
//Method: Mods_2023_07

//**********`Modified by: Costas Manousakis-(Designer)-(2023-07-03)
// LSS_CheckandUpdateComplete - copied from V18bug 2023-09-19
//  `added a check for inspection date not blank and not in the future

//Method: LSS_ImportUpdates_2 - copied from V18bug 2023-09-19
//Description
// Import data to update Ancillary inventory version 2
// has more options, and requires matching of import data to columns in import file.

// [LSS_Inventory];"ListBoxOutput".bQuery  - will be copied when copying the form
//  `use Get text from Pasteboard when searching from pasteboard.

// Build_SearchFormula - copied from V18bug 2023-09-19
//  `use pick from list to select comparison criteria
//  `if over 500 entries, split the file in multiple .4df files

//**********`Modified by: Costas Manousakis-(Designer)-(2023-07-05)
// ut_MissingBINStoArray - copied from V18bug 2023-09-19
//  `use selection to array to check against existing BINS.

//**********`Modified by: Costas Manousakis-(Designer)-(2023-07-06)
//Method: SIA_GetAvailableBIN - copied from V18bug 2023-09-19
//Description
// Return the first available BINs
// Parameters
// $0 : $BIN_  : return blank if none available

//Method: SIA_ReturnBINtoAvailable - copied from V18bug 2023-09-19
//Description
// Return a BIN to the list of available BINs
// Parameters
// $1 : $BIN_

//
//End Mods_2023_07   