//%attributes = {"invisible":true}
//Method: Mods_2016_05_bug
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/02/16, 11:11:38
	// ----------------------------------------------------
	//Created : 
	Mods_2016_05_bug
End if 
//
//**********`Modified by: Costas Manousakis-(Designer)-(5/2/16)
// Modified Method(s) : 
//ut_ControlDBSycnh
//  `Add var to keep track of the current Refid of local act log. the RefID at VALIDATE TRANSACTION was not the correct current one.

//**********`Modified by: Costas Manousakis-(Designer)-(5/3/16)
// Modified Forms : 
//[InventoryPhotoInsp];"Input"
//  `changed tab orientation to Top (left not available in v13+) - re-arranged objects to fit

//**********`Modified by: Costas Manousakis-(Designer)-(5/4/16)
// Modified Method(s) : 
//PON_VerifyQuantity
//  `exclude quantity of current defect if it is a Damage element 7000

//PON_RecordAllChanges
//  `check if changes were made then set moddate and moduser IF not a new record
//PON_ELEMINP_FM
//  `log the CreateDate and createUser

//**********`Modified by: Costas Manousakis-(Designer)-(5/6/16)
// Modified Method(s) : 
//INV_SavePhoto 
//  `changed picture to blob to use Mime  format instead of Quicktime  4 letter code

//```
//```   **** End of Release 6.5.0.k 06-May-2016
//```

//**********`Modified by: Costas Manousakis-(Designer)-(5/9/16)
// Modified Object Methods : 
//Object Method: [Standard Photos].Standard Photos.CopyOptiondropDwn 
//  `instead  of picture to blob - blob to picture, use convert picture to change the picture to .jpg

//**********`Modified by: Costas Manousakis-(Designer)-(5/10/16)
// Modified Method(s) : 
//ARCH_M_MasterList
//  `use only form [BridgeMHDNBISArchive];"Rpt Mstr" for all parts of the report
//M_MasterList`
//  `use only form [Bridge MHD NBIS];"Rpt Mstr" for printing all parts of the report

// Modified Form  : 
//[Bridge MHD NBIS];"Rpt Mstr"
//[BridgeMHDNBISArchive];"Rpt Mstr"
//  `added Item 104 in the list 

//**********`Modified by: Costas Manousakis-(Designer)-(5/11/16)
// Modified Object Methods : 
//Object Method: [Contracts].Contracts In.cboType 
//  `use TOL_ListToArray ("RtgInspContrType to load  the list
//Object Method: [Contracts].Contracts In.cboStatus 
//  `use TOL_ListToArray ("RtgInspContrStatus to load the list
// Modified Forms : 
// [Contracts];"Contracts In"
//  `removed  Default Values from cboStatus and cboType - using Table of lists 

// Modified Forms : 
//Form : [TableOfLists];"TableOFLists.o"
//  `changed print button to a Tool button, added code for a popup menu to export and import table of lists; removed help tip from button

//utl_ImportTOLRecords
//  `Added check for OK =- 1 after select folder

//**********`Modified by: Costas Manousakis-(Designer)-(5/13/16)
// Modified Forms : 
//[LSS_UT];"UTPrint"
//  `replaced static picture for Search beam due to typo.

// Modified Method(s) : 
//LSS_PrintUT
//LSS_SelectUTResults
//LSS_AddUTResultRecord
//  `Sort order for ut results should be location then Rod num.

//LSS_PrintDMeter
//FM_InspectionInput
//LSS_AddDMeterRecord
//LSS_ControlDmeterModification
//  `sort order for Dmeter should be by location

// Modified Forms : 
//[LSS_Inventory];"CustomSearch"
//  `added check box for route suffix
// Modified Method(s) : 
//LSS_CustomSearch
//  `account for Route Suffix 

// Modified Method(s) : 
//LSS_GotToInspectionPage 
//  `Added LSS_PhotoDescription_txt:=[LSS_Photos]LSS_Photo_txt for UT sketch
// Modified Forms : 
//[LSS_Inspection];"Input_ITS"
//[LSS_Inspection];"Input_Light"
//[LSS_Inspection];"Input_Sign"
//[LSS_Inspection];"Input_Signal"
//  `added UT Sketch Comments

// Created Form(s) : 
//[LSS_Inspection];"SignStructurePg1copy"
// ``backup for [LSS_Inspection];"SignStructurePg1"
// Modified Forms : 
//[LSS_Inspection];"SignStructurePg1'
//  `allow up to 9 sign panels
// Modified Form Methods : 
//[LSS_Inspection];"SignStructurePg1"
//  `use Order by in the SQL select ; increast sign count to 9

//**********`Modified by: Costas Manousakis-(Designer)-(5/16/16)
// Modified Form / Methods : 
//Form Method: [LSS_Inspection];"SignStructurePg1"
//  `use Order by in the SQL select ; increast sign count to 11; resized bottom list of elements to accomodate 11 panels;Code to fit the panel message text
// Form Method: [LSS_Inspection]SignStructurePg2
//  `increased number of panels in vert clr and tower dist to 11

// Modified Method(s) : 
//LSS_FillVerticalClearance
//LSS_FillGeometricData
//  `Increased num of panels to 11
//Compiler_LSS 
//  `added  6 extra variables for a total of 11 sign panels on sign structures; vert clr and tower dist

// Modified Object Methods : 
// Method: Object Method: [LSS_SignPanel];"Input".LSS_SignPanel_as
//  `do not show panel type if it is blank ; when choosing Other go to Panel type field

// Modified Method(s) : 
// Method: LSS_ModifySignPanels
//  `order by Panel_S
//LSS_AddSignPanelRecord
//  `order by Panel_s

//**********`Modified by: Costas Manousakis-(Designer)-(5/17/16)
// Created Method(s) : 
//Method: ut_CountFormVars
//Description
// Count form variables on a form
// Parameters
// $0 : $Count_L
// $1 : $Varpattern_txt (optional)

// Modified Method(s) : 
//COMPILER_Utilities
//  `add ut_CountFormVars
//LSS_FillVerticalClearance 
//LSS_FillGeometricData
//  `use method ut_CountFormVars to count the vars
// Modified Form Methods : 
//Form Method: [LSS_Inspection];"SignStructurePg1"
//  `use method ut_CountFormVars

//**********`Modified by: Costas Manousakis-(Designer)-(5/19/16)
// Modified Method(s) : 
//LSS_ControlDmeterModification
//LSS_AddDMeterRecord
//LSS_PrintDMeter 
//  `ORDER BY([LSS_DMeter];[LSS_DMeter]LSS_DMeterDate_d;>;[LSS_DMeter]LSS_Location_s;>)

//LSS_AddTowerDistanceRecord
//LSS_FillGeometricData
//LSS_ModifyTowerorPost
//  `ORDER BY([LSS_TowerDistance];[LSS_TowerDistance]LSS_TowerOrPost_txt;>;[LSS_TowerDistance]LSS_SignPanel_s;>)


//LSS_AddVerticalClearanceRecord
//LSS_FillVerticalClearance
//LSS_ModifyVerticalClearance
//  `order by [LSS_VerticalClearance]LSS_Panel_txt

//FM_InspectionInput
//  `sort Sign panels, Vert Clr by Panel_s , and Towerdist by TowerPost and Panel
//  `ORDER BY([LSS_DMeter];[LSS_DMeter]LSS_DMeterDate_d;>;[LSS_DMeter]LSS_Location_s;>)

// Modified Forms : 
//[LSS_UT];"UTPrint"
//  `Re-arranged/re-sized lists to allow more space for location and remarks

//**********`Modified by: Costas Manousakis-(Designer)-(5/23/16)
// Modified Forms : 
//[Bridge MHD NBIS];"RailTransitSIA"
//  `fixed Other Accessibility fields, and adjusted print formats on numbers to show 0  values (ex. 0 FT, or 0 IN)

//**********`Modified by: Costas Manousakis-(Designer)-(5/27/16)
// Modified Object Methods : 
//Method: Object Method: [LSS_Inspection];"Inspection_Template".bDelete

// Modified Forms : 
// Form  [Bridge MHD NBIS];"RailTransitSIA"
//  `Fixed item 28 under to point to RailInfo Tracks Under

//```
//```   **** End of Release 6.5.1 27-May-2016
//```

//**********`Modified by: Costas Manousakis-(Designer)-(5/31/16)
// Modified Method(s) : 
//ut_CNV_CheckPictures
//  `adjusted scaling for sketches and charts

//End Mods_2016_05_bug