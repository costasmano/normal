//%attributes = {"invisible":true}
//Method: Mods_2023_11

//**********`Modified by: Costas Manousakis-(Designer)-(2023-11-01)
//Method: MAP_BuildGeoJSON - copied from v18Bug 2023-12-20
//Description
// Build a GeoJSON file from the current list of bridges.
// Parameters

//Method: MAP_BuildAncGeoJSON - copied from v18Bug 2023-12-20
//Description
// build a GeoJson file from the current list of anc structures

//menubar BridgeList   -- synced with v19R8 Dec 21, 2023
// `menu Tools - inserted item "Generate GeoJSON file to use in Mass GeoDOT" - MAP_BuildGeoJSON

//**********`Modified by: Costas Manousakis-(Designer)-(2023-11-06)
//Method: MAP_OpenSite    - copied from v18Bug 2023-12-20
//Description
// open a mapping site from sites in parameter "MAP_Mappingsites"

// [LSS_Inventory];"ListBoxOutput".bReport - merged from v18Bug 2023-12-20
//  `added option to build GeoJSON file from current list

//Method: NTI_MapPosition - copied from v18Bug 2023-12-20
//Description
// Map the current TIN tunnel record
// uses parameter "MAP_GoogleNTI" and "MAP_NTISiteOptions"

// Modified Forms :  - copied from v18Bug 2023-12-20
//Added button [NTI_TunnelInfo];"Input".NTI_MapLocation

// MAP_BuildContent - merged from v18Bug 2023-12-20
//  `use method RES_Load_to_Blob to load the kml template, call MAP_OpenSite at the end

//menubar BridgeList - copied from v18Bug 2023-12-20
// `menu Tools - appended item "Open Mass GeoDOT apps" - MAP_OpenSite
//menubar #1 - copied from v18Bug 2023-12-20
// `menu Tools - inserted item "Open Mass GeoDOT apps" - MAP_OpenSite

// named relation [Cons Inspection] -> [Bridge MHD NBIS] ConsInspToBIN - copied from v18Bug 2023-12-20
// named relation [Cons Inspection] <- [Bridge MHD NBIS] BINToConsInsp - copied from v18Bug 2023-12-20
// named relation [Conslt Rating] -> [Bridge MHD NBIS] ConsRtgToBIN - copied from v18Bug 2023-12-20
// named relation [Conslt Rating] <- [Bridge MHD NBIS] BINToConsRtg - copied from v18Bug 2023-12-20

//Method: MAP_ConsAssignmentsGeoJSON - copied from v18Bug 2023-12-20
//Description
// create a GeoJSON file for the current list of consultant assignments
// Can be run either from Cons inspections or Cons Ratings
// retrieve list of data items from parameters MAP_ConsInspFields or MAP_ConsRtgFields

//Method: Temp_buildMapParams - copied from v18Bug 2023-12-20
//Description
// build and save some map parameters used in creating GeoJSON files

//menubar ConsltRtgMenu , menu Utilities - copied from v18Bug 2023-12-20
// append separator line , item "Create GeoJSON file to use in Mass GeoDOT" method MAP_ConsAssignmentsGeoJSON
//menubar ConsltInspMenu , menu Utilities - copied from v18Bug 2023-12-20
// append separator line , item "Create GeoJSON file to use in Mass GeoDOT" method MAP_ConsAssignmentsGeoJSON

//**********`Modified by: Costas Manousakis-(Designer)-(2023-11-08)
//Method: MAP_FormatDate - copied from v18Bug 2023-12-20
//Description
// format a date for inclusion in GeoJSON files
// Parameters
// $0 : $formatedDate_txt
// $1 : $date_d
// $2 : $FormatOption_L : from popup menu of this
// "MM/DD/YYYY;YYYY-MM-DD;YYYY MM DD;YYYY_MM_DD;Month Day Year;YYYY-MM-DDTHH:MM:SSZ;YYYY-MM-DDTHH:MM:SSZ GMT"

//Method: MAP_SetDateFormat - copied from v18Bug 2023-12-20
//Description
// return a Date format to be used with MAP_FormatDate
// options accessible from design access group or personnel group MAP_ChooseDateFormat
// default is 7 : ISO DATE GMT, or in parameter MAP_DateFormat
// Parameters
// $0 : $dateformat_L

// LSS_PrintInspection_WP - merged from v18Bug 2023-12-20
//  `added spooler name document option in print options to insert structure-type and date
//  `also placed in paste buffer for use with Microsoft Print to PDF

// LSS_PrintMultipleInspections - merged from v18Bug 2023-12-20
//  `Initialize the spooler document name using the 1st inspection
//  `Stop if user cancels out of print settings
//  `Handle case of using Microsoft or Adobe

//**********`Modified by: Costas Manousakis-(Designer)-(2023-11-13)
// Temp_buildMapParams - merged from v18Bug 2023-12-20
//  `update for tunnels

//Method: MAP_BuildTunnelGeoJSON - merged from v18Bug 2023-12-20
//Description
// build a GeoJson file from the current list of tunnel structures
// uses parameter MAP_TunnelStructFlds

// NTI_ExportXML - merged from v18Bug 2023-12-20
//  `added option to menu to export GeoJSON file from current list of structures


//Method: MAP_BuildGeoJSONProperties - copied from v18Bug 2023-12-20
//Description
// build the properties object for GeoJSON
// Parameters
// $0: $properties_o
// $1 : $info_o : info object 
//     .prop : dataobject
//     .mapfields : object with a fields collection with the columns, labels and any formating
//     .dateformat : default date format

//```
//```    **** End of Release 8.0.4 2023-11-14
//```

//**********`Modified by: Costas Manousakis-(Designer)-(2023-11-30)
// LSS_PermissionModInventory - merged from v18Bug 2023-12-20
//  `added proc variable LSS_AllowStatusChange_B - to control access to the Status pulldown

// BrgRank_DoRankCalc - merged from v18Bug 2023-12-20
//  removed column in export line after 4dRank ; removed ending tab 

// ACTFIX202206 - merged from v18Bug 2023-12-20
//  `when clearing OwnerRefIDs , group the $clearOwnRefIds_aL array into groups of 100 to avoid crashing the SQL buffer

//
//End Mods_2023_11   


