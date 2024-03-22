//%attributes = {"invisible":true}
// ----------------------------------------------------
// Mods_2010_01
// User name (OS): charlesmiller
// Date and time: 01/05/10, 12:19:21
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2010_01  // r001 CJ Miller`01/05/10, 12:19:23      `
End if 


// **********  ` Modified by: costasmanousakis-(Designer)-(1/6/10 12:28:00)
// Modified Forms : 
//[Inspections];"Dive Pr  LowCl Pg1"
//[Inspections];"Dive Pr Pg 1"
//[Inspections];"Dive Special Pr Pg 1"
//  `use var vsInspDepartment and method G_Insp_SetDeptFont in the form method

// **********  ` Modified by: costasmanousakis-(Designer)-(1/8/10 11:37:33)
// Modified Method(s) : 
//WRUTIL_Function
//  `added a 'busy' cursor while cleaning. ; `approx sign are OK
//SIA_Item8Owner_OM
//  `Added code to adjust Legacy Owner field also

// Modified Forms : 
//[SD_History];"UserList.o"
//  `Added some of the new columns


// **********  ` Modified by: costasmanousakis-(Designer)-(1/11/10 16:14:58)
// Modified Method(s) : 
//TEMP_UpdSelList_31_01_01 
//TEMP_UpdSelList_old 
//  `Inactivated  : enclosed whole method in if(False) 

//TEMP_UpdSelList 
//  `Added use of BIN in case Item 8 does not match. First check is BIN , then try for BRKEY; This is controlled
//  `by  a prompt at the start of the run.  Addeda more detailed Confirm statement at the end using method
//  `G_MyConfirm

//ControlMenuBar
//  `Replaced Current User calls with text variable $CurrentUser_txt

// **********  ` Modified by: costasmanousakis-(Designer)-(1/29/10 10:18:08)
// Modified Form Methods : 
//[Contract_Maintenance];"Contract Maintenance In"
//  `Change the view only code to make sure only people in BridgeMaintCtrl have ReadWrite access

// Modified Method(s) : 
//INIT_UI_GV 
//  `Added global var ◊InspFormRevDate_6:= Date("02/14/2010")

// Created Method(s) : 
//f_Insp_Revision6 
//  ` Verify revision 6 of inspection forms
//  ` It is the addition of the shielding Element 114  under the Deck category.

// Modified Method(s) : 
//INSP_FillElementInfo
//  ` It is the addition of the shielding Element 114  under the Deck category.

// Modified Form Methods : 
//[Inspections];"Dive Pr  LowCl Pg1"
//  ` It is the addition of the shielding Element 114  under the Deck category.

//End Mods_2010_01