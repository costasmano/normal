//%attributes = {"invisible":true}
//Method: Mods_2018_04_bug
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/27/18, 16:57:30
	// ----------------------------------------------------
	//Created : 
	Mods_2018_04_bug
End if 
//

//**********`Modified by: Costas Manousakis-(Designer)-(4/19/18)
// LSS_GotToInspectionPage
//Make sure [LSS_Photos] record is loaded for D-Meter and UT pages on form

//**********`Modified by: Costas Manousakis-(Designer)-(4/20/18)
// Created Method(s) : 
//Method: NTI_CalcClearances
//Description
// Calculate and update the Clearance fields in feet from feet and inches in input form

// Modified Forms : 
// [TIN_Inspections];"Input"
//  `added call to NTI_CalcClearances in vert clearance entry variables

//**********`Modified by: Costas Manousakis-(Designer)-(4/26/18)

// Modified Form : 
// [NTI_ELEM_TIN_INSP];"All_Item_Tunnel_Inspection_1"
//  `replaced vTmLeader variable with "team_leader" text object

// Modified Method(s) : 
// FM_All_Items_Tunnel_Inspection
//  `added missing seting of team_leader title and checks for missing person IDs

//**********`Modified by: Costas Manousakis-(Designer)-(4/27/18)
// Modified Forms : 
// [NTI_TunnelInfo];"Input"
//  `fix label of item N.3

//**********`Modified by: Costas Manousakis-(Designer)-(4/30/18)
// NTI_PrintNTEList
//  `Fix logic determining form names for page1 and pages2 and on. 
//  `parameter 2 is the base form name. 
//  ` if "$2_1" is an actual form name it will be used as the 1st page, if not, the use $2 if it is a valid form name 
//  ` if "$2_2" is an actual form name it will be used as the 2nd page, if not, the use $2 if it is a valid form name 

// [Bridge MHD NBIS];"Bridge Input"
//  `added back adding and duplicating inspections in tunnel inspections - enable only for BTS up until a date in parameters
// [Bridge MHD NBIS];"Bridge Input".Add New Insp Button3
//  `allow adding inspections only for Boat sections (BTS) up to NTI_DROPBINBTSINSPDA
// [Bridge MHD NBIS];"Bridge Input".Dupl Insp Button1
//  `allow adding inspections only for Boat sections (BTS) up to NTI_DROPBINBTSINSPDA

//End Mods_2018_04_bug