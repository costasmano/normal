//%attributes = {"invisible":true}
// **********  ` Modified by: costasmanousakis-(Designer)-(6/2/10 09:51:51)
// Created Method(s) : 
//INSP_SortReviewList
//  ` Sort the Pending Inspections List form. New method to be called instead of getting called on the 
//  `On Header event of the review form

// Modified Form Methods : 
//[Inspections];"InspectionReview"
//  `Use new method INSP_SortReviewList at the on load event; don't do anything at the On Header.
//  `Sorting will be done at the buttons.
//  `Also added grey bar picture on the header and footer of the form

// Modified Object Methods : 
//[Inspections];"InspectionReview". aDistrictSelect
//[Inspections] ;"InspectionReview".bzSearchLay
//[Inspections];"InspectionReview".bzSearch
//[Inspections];"InspectionReview".bzAll
//[Inspections];"InspectionReview".bzSub
//[Inspections];"InspectionReview".bzOmit
//  `Do not rely on the On Header event to sort - call INSP_SortReviewList
//[Inspections];"InspectionReview".bzPrint
//  `Do not use set, use named selection, so no need to sort again
//  `Also keep the records selected highlited at the end

// **********  ` Modified by: costasmanousakis-(Designer)-(6/3/10 17:22:03)
// Modified Form Methods : 
//[Bridge MHD NBIS];"BDEPT Input"
//  `Added additional fields from the existing records
//  `Added a new Blue bar at the header. Made form adjustable in ht and fixed moving and growing of objects on page 1

// Modified Object Methods : 
//[Bridge MHD NBIS];"BDEPT Input".bGetRef
//[Bridge MHD NBIS];"BDEPT Input".aItem7
//  `Added additional fields from the existing records

// **********  ` Modified by: costasmanousakis-(Designer)-(6/4/10 15:25:28)
// Modified Method(s) : 
//SCPOA_Variables
//  `Changed "Clough, Harbour & Associates LLP" to "Clough, Harbour & Associates" to match the limit
//  `in the Personnel table of Employer

// **********  ` Modified by: costasmanousakis-(Designer)-(6/9/10 09:38:52)
// Modified Table(s) : 
//[Conslt Rating]
//Made the following name changes to fields
//FirstRepSubmit->RepSubmit1
//SecondRepSubmit->RepSubmit2
//ThirdRepSubmit->RepSubmit3
//AssignRatDate->AssignRtgDate1
//CompletRat->AssignRtgDate2
//ReviewRatDate->AssignRtgDate3
//HoldingRatAppr->AssignRtgDate4
//ReviewRatWho->ReviewRtgWho1
//ApprovedByRat->Disposition1 a80
//Added the following fileds
//RepSubmit4 d
//SentInHouseRev4 d
//ReviewRtgWho2 a80
//ReviewRtgWho3 a80
//ReviewRtgWho4 a80
//Disposition2 a80
//CmtnsRecvd3 d
//CmtnsRecvd4 d
//Disposition2 a80
//Disposition3 a80
//Disposition4 a80
//SentBackToConslt4 d
//BridgeType txt
//ReportDate d

// Modified Forms and form methods : 
//[Conslt Rating];"View Cslt Rating"
//  `added code to adjust window size when closing detail
//  `Also added color bars at the header and footer
//[Conslt Rating];"Cslt Rating In"
//  `Added code to adjust form window size when loading the form
//  `Also changed the form resize properties,  and added a new header bar
//  `Added the option for a White rating : Gusset plate rating

// **********  ` Modified by: costasmanousakis-(Designer)-(6/11/10 08:43:09)
// Modified Form Methods : 
//[Inspections];"BlankCombinedStarter"
//  `Allow Access to Freeze Thaw inspections if they are approved by the DBIE
// Modified Forms : 
//[Bridge MHD NBIS];"CombinedInspections"
//  `Moved all buttons and header stuff to page 0
//Changed some of the object methods to use the Form event instead of Before

// Modified Method(s) : 
//SIA_Item41Desc
//  `Changed use of Before to Form Events
// Modified Forms : 
//[InventoryPhotoInsp];"Input"
//  `Replaced the Green rectangle header with the GreenBar  faded picture.
//  `Adjusted form margins
// Modified Method(s) : 
//INV_InvInspListObjM 
//  `Modified code to go to the record that was exited from and scroll the listbox to that row.
// Modified Forms : 
//[InventoryPhotoInsp];"ReviewDialog"
//  `Inserted a listbox; Moved the group arrays to page 2
//  `Added a green bar at the Footer, adjusted the gery header bar, adjusted form margins

// Modified Form Methods : 
//[DCM_Contracts];"Output"
//  `Allow DistrictMaintenance group to add contracts
//  `Also reload the CM_SelByStatus array on close detail
// Modified Method(s) : 
//DCM_SortOutputList
//  `Make default Task to "SORT"

// Created Method(s) : 
//ut_Temp_Prj_convertAEBlob
//  `Method to convert the [PRJ_ConstructionProject]CP_AEData_blb data in the new format that includes
//  `the data from the sql database and what is modified in 4D
// Modified Method(s) : 
//ut_PRJGetAEData
//  `Modified storing of sp_RTRVAEContData arrays to account for the new method of storing the data in 
//  `field [PRJ_ConstructionProject]CP_AEData_blb.

// Modified Forms : 
//[DCM_Contracts];"DistrMaintInput"
//[DCM_WorkOrders];"DistrMaintInput"
//  `Made adjustments to object sizes and form margins and limiting widths for better appearance.

// **********  ` Modified by: costasmanousakis-(Designer)-(6/14/10 12:38:18)
// Modified Method(s) : 
//M_WRT_IOMcover_cslt
//M_WRT_IOMcover_inhouse
//  `Added var vFourthCheck for the 4th submittal;
//  ` and vWhiteCheck for a white rating report - gusset plate rating
//  `AND, made code similar in both ; streamline the case statements

// Modified Form Methods : 
//[DCM_Contracts];"DistrMaintInput"
//  `On a new record - Clear out related variables used in listboxes and related records;
//  `Modifed the determination of DCM_ViewOnly_b variable ; only DistrictMaintenance users can edit

// Created Method(s) : 
//CRTG_ImportRtgStatus
//  ` import data from the Rating Status spreadsheet

// Modified Table(s) : 
//[Conslt Rating]
//Add Fields 
//[Conslt Rating]SentBackToBIE1 D
//[Conslt Rating]SentBackToBIE2 D
//[Conslt Rating]SentBackToBIE3 D
//[Conslt Rating]SentBackToBIE4 D
//[Conslt Rating]ReportPreparedBy a80

// Modified Object Methods : 
//[DCM_Project];"DistrWorkOrderInput".vBridgeNo
//  `Fixes in the calls to refresh Bridge info.
// Modified Method(s) : 
//DCM_ControlCUs
//  `Fixed error in the name of the InspArray dropdown

// **********  ` Modified by: costasmanousakis-(Designer)-(6/16/10 11:18:22)
// Modified Forms : 
//[Status Report];"P_StatusReport_MDOT"
//  `Fixed wrong fields showing for District 6 -
//  `Added 6 Districts to the title.
// Modified Method(s) : 
//STATREP_DistrNo
//  `Use the array ◊D6Towns_atxt to check if it is Distr 6.
//Server_GenCondRep
//  `Added generation of a report using the new district distribution STATREP_DistrictMethod_b:=true
//STATREP_ReportType
//  `Added the D6 report type

// **********  ` Modified by: costasmanousakis-(Designer)-(6/21/10 11:57:11)
// Modified Forms : 
//[Inspections];"CulvertPrPg1_v2"
//  `Added 414 element (61.9 Blank element - was missing on the form)
//  `Adjusted size and location of some objects for better visibility on both platforms
//[Inspections];"Culvert Combined" and form method
//  `Added field [Inspections]FieldTests on page 2, to be visible only for Spec memb cases

// **********  ` Modified by: costasmanousakis-(Designer)-(6/22/10 08:39:15)
//P_ReviewInspcts
//  `Added handling for inspection responsibility for Dist 6.
// Modified Forms : 
//[Templates];"Output"
//  `Added the description field and made form resizable

// **********  ` Modified by: costasmanousakis-(Designer)-(6/23/10 08:11:43)
//P_ListTownAddress
//  `Added members of the BMS Admin to read write.
// Modified Object Methods : 
//[Inspections];"InspectionReview". aDistrictSelect 
//  `use [Bridge MHD NBIS]InspResp instead of [Bridge MHD NBIS]Item2
