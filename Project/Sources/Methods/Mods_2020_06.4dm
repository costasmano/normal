//%attributes = {"invisible":true}
//Method: Mods_2020_06
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/02/20, 15:44:37
	// ----------------------------------------------------
	//Created : 
	Mods_2020_06
End if 
//

//**********`Modified by: Costas Manousakis-(Designer)-(6/2/20)

//Method: INSP_addTeamLeaders
//Description
// will add to the current selection from [Personnel] table people - for CallReference #714
// Parameters
// $1 : $persGrouptoadd - get members of this personnel group
// $2 : $Agency - belonging to this agancy

// InitPers
//  `use method INSP_addTeamLeaders to add to the list of TL members of BRI or FRZ 
//  // TeamLeader personnel groups for non-NBI inspections and/or FRZ inspection types - for CallReference #714

// [Inspections];"FreezeThawA"
//  `added designated Team leader - CallReference #714

// [Inspections];"FrzThawPg1A".vTeamMbr
//  `include the designated TL in team members - CallReference #714

// Print_initPrintToPDF
//  `remove check of spool format Dest Opt = 3 is PDF on mac CallReference #715

//**********`Modified by: Costas Manousakis-(Designer)-(6/4/20)
//Method: INSPRTG_makeHeaderParam
//Description
// make object for paramaters INSPRTG_LTRHeader
// Parameters
// ----------------------------------------------------

//Method: INSPRTG_GetLetterHDR
//Description
// return the header of a letter based on contract type using parameter INSPRTG_LTRHeader
// Parameters
// $0 : $header_txt
// $1 : $conctractType
// ----------------------------------------------------

//Method: WRT_InspRtgFundTransfer
//Description
// create a Word doc letter for Transfer of funds in Contslt inp Rating contracts
// run from input form of TranferofFunds CallRefernece #699
// Parameters
// ----------------------------------------------------

// [Contract FundTransfer];"TransferFund In"
//  `added button to generate a letter for transfer of funds  CallRefernece #699

//**********`Modified by: Costas Manousakis-(Designer)-(6/4/20)
// [Contracts];"Contracts Out"
//  `adjusted height of detail fields and vars to fit in detail section of form

// M_WRT_CsltInsp_ComplexNTP
//  `use the menu item parameter for the template name - method can be used for multiple contract types - CallReference #698
//  `also check for multiple contracts and assignments on list using CSLTINSP_ProceedWithLetter
// M_WRT_CsltInsp_ComplexReqFee
//  `use the menu item parameter for the template name - method can be used for multiple contract types - CallReference #698
//  `also check for multiple contracts and assignments on list using CSLTINSP_ProceedWithLetter

// Menu Utilities in ConsltInspMenu
//  // added menu item parameters to the Complex ReqFee and NTP items that have the WRT Template name
//  // added a section in the menu for NonNBI inspections using the same commands as the complex 
//  // letters with different menu paramaters - CallReference #698


//**********`Modified by: Costas Manousakis-(Designer)-(6/8/20)
// fGetFormEvent
//  `added the event code when form event is unknown

//Method: DEV_GetKeysPressed
//Description
// return the keys pressed
// Parameters
// $0 : $keys_txt
// ----------------------------------------------------

//Method: CSLTINSP_ProceedWithLetter
//Description
// verify if it is ok to proceed with creating a letter for Consultant inspections
// Parameters
// $0: $Results_o  : object containing results of check
//  // {records : numrecords}
//  // {createLtr : true/false}
//  // {NBIRecs : true/false } : records are all NBI or notNBI
// ----------------------------------------------------

// M_WRT_CsltInsp_ReqFee
//  `use method CSLTINSP_ProceedWithLetter to do the checks for consistancy in the listed records
// M_WRT_CsltInsp_NTP
//  `use method CSLTINSP_ProceedWithLetter to do the checks for consistancy in the listed records

// ut_SQLUpdateServerActLog
//  `do not send the UUID field - CallReference #717

//**********`Modified by: Costas Manousakis-(Designer)-(6/10/20)
// Alert_DateTime
//  `force JSON Parse to return an object
// Test_GetNetworkDateTime
//  `force JSON Parse to return an object
// ut_SelectRandomRecords
//  `force JSON Parse to return an object

// Modified Forms and form method : 
// [Parameters];"Input"
//  `Added button to edit json and code to disable it when RO mode

//**********`Modified by: Costas Manousakis-(Designer)-(6/17/20)
//INSP_ExportInspection
//  `add BDEPT to name of export, made date YYYY_MM_DD


//Modified by: CJ (6/18/20 14:07:25)
//Move code from single user to this to upgrade to use list boxes
//[Conslt Rating];"View Cslt Rating_LB"//New form
//P_ListConsRating 
//LB_CSLT_Rating

//[Cons Inspection];"View Cslt Insp_LB"//New form
//P_ListConsInsp 
//LB_CSLT_Inspection 

//P_ListContractMaintenance

//**********`Modified by: Costas Manousakis-(Designer)-(6/19/20)
// [LSS_Inventory];"ListBoxOutput".bReport
//  `Alert if there are no inventory records selected
//  `Verify printing for multiple records
//  `Keep the order of printing the same as in the list.
// LSS_PrintMultipleInspections
//  `added progress bar with option to stop the printing and added alert at the end

//**********`Modified by: Costas Manousakis-(Designer)-(6/24/20)
// PON_CollectNBEforBrM
//  `Cancel out of method if Number of inspections to be grouped is zero or user cancels out of request
// PERS_GetInfo
//  `initialize the variables passed in to blanks


//**********`Modified by: Costas Manousakis-(Designer)-(6/26/20)
// ut_OpenNewWindow
//  `changed position 1 to "stacked" and 6 to centered
//  `for positions 12,13,14 make sure the window fits on the screens

//Method: WIN_FitWindowInScreens
//Description
// Fit window coordinates in the current screens
// Parameters
// $1 : $x1_ptr pointer to top left x
// $2 : $y1_ptr pointer to top left y
// $3 : $x2_ptr pointer to bot right x
// $4 : $y2_ptr pointer to bot right y



//Modified by: Chuck (6/25/20 15:58:04)
//Move code from single user to this to upgrade to use list boxes also direct change
//P_ListContractMaintenance 
//P_ListConsRating 
//PERS_EditGroups 
//P_ListConsInsp 
//ModSelSort 
//P_ListWorkHours 
//P_Personnel 
//SCPOA_ListPOAs 
//[Cons Inspection];"View Cslt Insp_LB"
//[Conslt Rating];"View Cslt Rating_LB"
//[Contract_Maintenance];"Contract Maintenance_LB"
//[Contracts];"Contract_LB"
//[PERS_Groups];"PG_Output_LB"
//[Personnel];"Inspectors Out_LB"
//[ScourPOA];"Output_LB"
//[Work_Estimate];"List_LB"
//  //Added ut_SetWindowSize to list bpx
//[Bridge MHD NBIS];"NewMBTANBIS_StackInfo"
//[Bridge MHD NBIS];"NewNBIS_StackInfo"
//Added compile directive so it will work uncompiled
//ut_SetWindowSize 


//**********`Modified (6/30/20)
// Center_Window_2
//  `use methods WIN_FindVisibleNode and WIN_FitWindowInScreens to better place window

//Method: WIN_FindVisibleNode
//Description
// find the visible point of a window starting from middle and spiraling out clockwise
// Parameters
// $1 : $WinObj : windowobj
// input
//  // topleft { x , y }
//  // bottomright { x , y}
//  // steps : number of steps in spiral defau;ts to 4
// returns
//  // visnode {x , y, screen}
// ----------------------------------------------------

//Method: WIN_PointVis
//Description
// Find if a screen coordinate point is visible on a screen
// Parameters
// $0 : $Screen  screen number where point is visible
// $1 : $X
// $2 : $Y

//Method: ut_UseListBox
//Description
//This method will allow swich between new list box and original pout for for designer
// Parameters
// $0 : UseListbox_b : true use listbox dialog ; False : use output form
// ----------------------------------------------------

//Method: LB_RtrnRatingBGColor
//Description
//This method will return background colors for consultant rating list box based on [Conslt Rating]PriorityColorFlag
// Parameters
// $0 : Color_L

//End Mods_2020_06