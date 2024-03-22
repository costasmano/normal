//%attributes = {"invisible":true}
//Method: Mods_2020_08
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 08/07/20, 14:24:40
	// ----------------------------------------------------
	//Created : 
	Mods_2020_08
End if 
//

//**********`Modified by: Costas Manousakis-(Designer)-(8/4/20)
// dev_convertPicLibToJPEG
//  `added Gif - seems v17 complains about those too.

//**********`Modified by: Costas Manousakis-(Designer)-(8/7/20)
// Modified Menu 1
//Disabled Workhours. Preservation addignemnt and Contracts , Distr maint contract menu items in Special menu

// ControlMenuBar
//  `for Work hours added pers_groups WKHR_Consultants, WKHR_Reviewers
//  `and for district maintenance contracts , group DistrictMaintenance.

//Complete work on moving signed PDF inspection reports like we do with ratings
//Modified by: CJ (8/11/20 12:41:29)
//Form modified
//OM_ControlOpenandMoveInspPDF
//RatingReportDisplayandMove
//Method: "RatingReportDisplayandMove"
//[Bridge MHD NBIS];"Bridge Input"
//Method: [Bridge MHD NBIS].Bridge Input.ListAvailInspeReport
//Method: [Bridge MHD NBIS].Bridge Input.MoveInspectionReport
//OM_ControlOpenandMoveRatingPDF


//Modified by: CJ (8/11/20 12:57:11)
//Change new list boxes to make look more uniform and adjust alignment for some columns
//[Bridge Design];"View Bridge Design_LB"
//[Bridge MHD NBIS];"Bridge Input"
//[Cons Inspection];"View Cslt Insp_LB"
//[Conslt Address];"View Conslt Address_LB"
//[Conslt Rating];"View Cslt Rating_LB"
//[Contract_Assignment_Maintenance];"PreservationList"
//[Contract_Maintenance];"Contract Maintenance_LB"
//[Contracts];"Contracts_LB"
//[DCM_Contracts];"DCM_Contracts_LB"
//[Inspections];"InspectionReview_LB"
//[PERS_Groups];"PG_Output_LB"
//[Personnel];"Inspectors Out_LB"
//[RatingRequests];"Output"
//[ScourPOA];"Output_LB"
//[Town Address];"View Town Address_LB"

//Changed method of opening window so we would have close box for all from
//NewWindow to ut_OpenNewWindow   //P_ReviewInspcts 
//P_ListWorkHours

//**********`Modified by: Costas Manousakis-(Designer)-(8/12/20)
// SFA_GetFolderListServer
//  `choose whether to use the "production" base path, or the base path in parameters - added better reporting

//End Mods_2020_08