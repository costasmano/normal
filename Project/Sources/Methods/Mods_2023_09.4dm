//%attributes = {"invisible":true}
//Method: Mods_2023_09

//**********`Modified by: Costas Manousakis-(Designer)-(2023-09-06)
// [LSS_Inventory];"New_InventoryItem".SaveRecord - Copied from v18bug 2023-09-20
//  `added update of created by fields.

//**********`Modified by: Costas Manousakis-(Designer)-(2023-09-07)

// ut_OpenProjInfo_OM - Copied to v19R8 2023-09-20
//  `button is enabled for all is PINFO is available - not just windows and designer group

// Text_toURL - Copied from v18bug 2023-09-20
//  `use code from  https://kb.4d.com/assetid=79062 
//  `Made method available in 4D Tags

// FM_SaveInventoryInput - Copied from v18bug 2023-09-20
//  `added updating of modified_by fields

// LSS_MapPosition - Copied from v18bug 2023-09-20
//  `Use new MAP parameters to display mapping options and open maps.

// GenerateOOF - Copied from v18bug 2023-09-20
//  `removed use of nonmodal windows and on event call to stop - replaced with progress bars.
//  `changed searches to send one request to server - use goto record instead of next record

// [Out of Freq];"I_OutofFreq" - Copied from v18bug 2023-09-20
//  `replaced old MHD logo with DOT logo
//  `added print button over template 

// [Out of Freq];"O_OutofFreq_LB" - Copied from v18bug 2023-09-20
//  `replaced MHD logo with DOT logo ; changed help message on Add and print buttons
//  `removed hidden esc and return buttons; adjusted size of Listbox

// [Out of Freq];"O_OutofFreq_LB".Variable4 - Copied from v18bug 2023-09-20
//  `sort by date created descending

// [Out of Freq];"P_OutofFreq" - Copied from v18bug 2023-09-20
//  `made all text, variables, fields, rectangles, matrices transparent
//  `replaced MHD logo with DOT logo

// [LSS_Inventory];"Input".Status - Copied from v18bug 2023-09-20
//  `Object has only 'On clicked' enabled - Ask user to confirm when changing the status.

//**********`Modified by: Costas Manousakis-(Designer)-(2023-09-19)
// ut_ReturnBackupInfo - Copied from v18bug 2023-09-20
//  `declared $dataFromhistory at the start of declarations

// [TIN_Inspections];"ReviewList".TunnelInspections_LB - Copied from v18bug 2023-09-20
//  `use <>CURRENTUSER_NAME when checking for Design access group


//```
//```    **** End of Release 9.0.0 beta 2023-09-21-1
//```

//
//End Mods_2023_09   