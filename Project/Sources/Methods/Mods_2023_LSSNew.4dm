//%attributes = {"invisible":true}
//Method: Mods_2023_LSSNew

//New fields
//[LSS_Inventory]LSS_Status_s   - A40   - copied from V18bug 2023-09-19
//[LSS_Inventory]LSS_StatusDate_s  -A10 - hidden - Copied from v18bug 2023-09-19
//[LSS_Inventory]LSS_ProjInfoBuilt_L - Copied from v18bug 2023-09-19
//[LSS_Inventory]LSS_ProjinfoRemoved_L - Copied from v18bug 2023-09-19

// rename [LSS_Inventory]LSS_YearReplaced_s to LSS_Inventory]LSS_YearRemoved_s - Copied from v18bug 2023-09-19
// rename [LSS_Inventory]LSS_ProjInfoBuilt_L to [LSS_Inventory]LSS_ProjNoBuilt_L - Copied from v18bug 2023-09-19
// rename [LSS_Inventory]LSS_ProjinfoRemoved_L to [LSS_Inventory]LSS_ProjNoRemoved_L - Copied from v18bug 2023-09-19

// Method: FM_InventoryInput - Copied from v18bug 2023-09-20
// added dropdown for status , entries for PRoj no built, Proj no removed, buttons to open Pinfo. re-arranged fields.

//Method: LSS_ApplyFilters - Copied from v18bug 2023-09-20
//Description
// apply filters from the dropdowns in the LSS inventory output form

// Method: LSS_ControlModification - Copied from v18bug 2023-09-20

//Method: LSS_ImportUpdates - Copied from v18bug 2023-09-20
//Description
// Import data to update db 

//Method: LSS_PermissionADDInspection - Copied from v18bug 2023-09-20
// don't allow adding inspections for removed or proposed structures

//Method: LSS_PermissionDelInspection - Copied from v18bug 2023-09-20
// do not allow deletion of inspections for removed structures or proposed

//Method: LSS_PermissionModInspection - Copied from v18bug 2023-09-20
// do not allow edit of inspections for removed or proposed structures

//Method: LSS_PermissionModInventory - Copied from v18bug 2023-09-20
// do not allow changes when structure has been removed

//Method: LSS_ResetListFilters - Copied from v18bug 2023-09-20
//Description
// reset the filter dropdowns in the inventory output form

//Method: LSS_SetUp - Copied from v18bug 2023-09-20
// added status collection

//Method: LSS_SortStructureType - Copied from v18bug 2023-09-20
//added sort by status , year built and proj #built

//Method: LSS_StatusColor - Copied from v18bug 2023-09-20
//Description
// return the background color based on Status

//Method: LSS_StatusControls - Copied from v18bug 2023-09-20
//Description
// method that applies controls to objects on input form depending on status

//Method: LSS_StatusTextColor - Copied from v18bug 2023-09-20
//Description
// set the text color for the status field

//Method: LSS_UpdateProjNumdropdwn - Copied from v18bug 2023-09-20
//Description
// update the project number dropdown on the list box

//  Form : [LSS_Inventory];"ListBoxOutput" - Copied from v18bug 2023-09-20
// add columns for status, year built, proj num built in Listbox 
// status column has methods for background and text color
// add dropdown for status, project num filters
// add code in Show all, query, show subset object methods to reset the filter dropdowns

// Form : [LSS_Inventory];"Input" - Copied from v18bug 2023-09-20
//added status , pinfo fields, relabeled/rearranged year blt,remove,rehab info


//```
//```    **** End of Release 8.0.2 2023-06-29
//```


//```
//```    **** End of Release 9.0.0 beta 2023-09-21-1
//```

//
//End Mods_2023_LSSNew   