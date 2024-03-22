//%attributes = {"invisible":true}
// **********  ` Modified by: costasmanousakis-(Designer)-(3/6/08 15:19:48)
// Modified Form Methods : 
//[Bridge MHD NBIS];"SI & A Input"
//  `Allow Area and Bridge inps engineer access to the Freeze thaw

// Modified Object Methods : 
//[Dialogs];"Search Bridge".bFind
//  `Allow coma as a separator also.

// **********  ` Modified by: costasmanousakis-(Designer)-(3/28/08 09:19:45)
// Created Method(s) : 
//CM_CalcAssgnValues
//CM_AssgnValues_OM
//CM_AssgnRate_OM

// /START **** Changes to get the MILE Point for MTA Inspections
//INSP_KiloPtValues

// Modified Method(s) : 
//G_InitInspVars 

// Modified Forms  and form methods: 
//[Bridge MHD NBIS];"CombinedInspections"
//[Inspections];"Routine Combined"
//[Inspections];"Routine Pr Pg 1"
//[Inspections];"Routine Arch Pr Pg 1"
//[Inspections];"Critical Member"
//[Inspections];"Culvert Combined"
//[Inspections];"Culvert Pr Pg 1"
//[Inspections];"CulvertPrPg1_v2"
//INSP_CulvertPrPg1_FM
//[Inspections];"FC Pr (Pg 1)"
//[Inspections];"FCPrPg1_v2"
//INSP_FCPrPg1_FM
//[Inspections];"Closed Bridge"
//[Inspections];"Closed Insp Pg1"
//[Inspections];"Damage Form"
//[Inspections];"Damage Pg1"
//[Inspections];"DamagePg1_v2"
//INSP_DamagePg1_FM
// /END **** Changes to get the MILE Point for MTA Inspections

// **********  ` Modified by: costasmanousakis-(Designer)-(3/31/08 10:50:50)
// Created Method(s) : 
//ut_CompareNBITapes
//  ` Compare the Item 8s from two NBI tapes to come up
//  ` with any changes to Item 8 of records.

// Modified Form Methods : 
//[Addendum_Maintenance];"Addendum In"
//  `Copy Ovrhead , netfee rates from Assignment not Contract
// Modified Object Methods : 
//[Addendum_Maintenance];"Addendum In".(all Cost objects)
//  `Use method CM_AssgnValues_OM

// Modified Form Methods : 
//[Contract_Assignment_Maintenance];"Assignment Maintenance In"
//  `Copy the OveHead and NetFee rates from the contract

// Modified Forms : 
//[Contract_Assignment_Maintenance];"Assignment Maintenance In"
//  `Use the [Contract_Assignment_Maintenance] fields for Overheade and netfee;
//  `Add button that locks/unlocks the fields for editing.
//  `Changed entry order on page 1

// Modified Object Methods : 
//[Contract_Assignment_Maintenance];"Assignment Maintenance In".(all cost objects)
//  `Use method CM_AssgnValues_OM

// Modified Forms : 
//[Dialogs];"MyConfirm"
//  `Made Question button to switch back after click (cosmetic)

// **********  ` Modified by: costasmanousakis-(Designer)-(4/1/08 08:13:56)
// Created Method(s) : 
//BRGDESList_SortControl
//BRGList_SortControl

// **********  ` Modified by: costasmanousakis-(Designer)-(4/2/08 12:03:35)
// Created Method(s) : 
//Fn_GetTextBlob
//  ` Retrieve the text from a 4D Write blob.

// Modified Method(s) : 
//M_EZSearch
//M_SearchBridge
//M_GetRegion
//M_OmitSubset
//M_ShowSubset
//M_SearchSel
//  `Added sorting...

// **********  ` Modified by: costasmanousakis-(Designer)-(4/4/08 11:58:23)
// Created Method(s) : 
//BRG_RWAccess
//  ` Determine RW access to any of the current bridge record information.

// Modified Forms : 
//[Bridge MHD NBIS];"SI & A Input"
//  `Changed names of display only objects (fields and vars) to "DisplayOnly"
//  `Made sure all buttons are properly named for locking and unlocking

// Modified Method(s) : 
//M_GetNBIS 
//M_GetNonNBIS 
//M_GetMHD_NBI 
//M_GetMHDnonNBI 
//M_GetOnSystem 
//M_GetOffSystem 
//M_GetSD 
//M_GetFO 
//M_GetNBISBridge 
//M_GetNonNBISBr 
//M_GetHwy 
//M_GetBridges 
//M_GetStateML 
//M_LoadBINfile 
//M_InspSchedule 
//M_SearchDefElement 
//M_SearchPontisElmts
//  `Apply sort...

// **********  ` Modified by: costasmanousakis-(Designer)-(4/14/08 11:52:04)
// Created Method(s) : 
//SIA_SecureInputForm
//  ` Handle security settings in the SIA Input form.
//SIA_Feature_OM
//  ` Handle the Feature On /Off object methods. Called from the SIA input forms.

// **********  ` Modified by: costasmanousakis-(Designer)-(4/16/08 08:26:40)
// Modified Method(s) : 
//INV_InvInspRWAccess 
//  `modified to use the BRG_RWAccess also
// Modified Object Methods : 
//[Bridge MHD NBIS];"CombinedInspections".bAddInsp
//[Bridge MHD NBIS];"CombinedInspections".bDuplicate
//[Bridge MHD NBIS];"CombinedInspections".ChgInspTypeBtn
//  `modified to use the BRG_RWAccess also

// Modified Form Methods : 
//[Bridge MHD NBIS];"SI & A Input"
//  `use SIA_SecureInputForm with a check for BRG_RWAccess
//[Bridge MHD NBIS];"Bridge Input"
//  `Special for MDC users- if not a MDC bridge lock buttons except sia,insp, inv
//[Bridge MHD NBIS];"Other Info"
//  `Also check BRG_RWAccess; Make sure on load we start with all enabled.

// Modified Method(s) : 
//SIA_MountModule
//  `Special for MDC users- if not a MDC bridge lock buttons except sia,insp, inv
//ModSelSort
//  `Added additional search params (13,14) cleaned up var declarations.
//P_MDC 
//  `Use the new params to search also for DEM bridges

// **********  ` Modified by: costasmanousakis-(Designer)-(4/22/08 15:06:01)
// Modified Method(s) : 
//Duplicate_Inspection
//  `Adjust create/modify timestamps ; clear review dates

// **********  ` Modified by: costasmanousakis-(Designer)-(4/23/08 09:10:16)
// Modified Forms : 
//[NBIS Secondary];"2nd In"
//  `Named all Enterable/clickable object to "DE@" and all non-enterable fields to DisplayOnly@
//  `Assigned style sheets to all objects.

// Modified Form Methods : 
//[NBIS Secondary];"2nd In"
//  `Use the form event ; Cancel creating a new record since loging of new record is not working 
//  `at all currently.

// Modified Form Methods : 
//[Dialogs];"MyConfirm"
//  `Added timer possibility, so that after a delay the message will go away.

// Modified Method(s) : 
//G_MyConfirm
//  `Added optional parameters to specify a delay in minutes after which a beep will sound, and
//  `how many times that beeping will occur until the dialog cancels.

// **********  ` Modified by: costasmanousakis-(Designer)-(4/24/08 16:55:59)
// Modified Forms : 
//[Inspections];"Dive Template"
//  `Added the Export button (copy from form [Inspections];"AboveWater Template")

// **********  ` Modified by: costasmanousakis-(Designer)-(4/29/08 10:42:43)
// Modified Method(s) : 
//INIT_FIELDS_DES
//  `Again the arrays ◊aInspType,◊aInspCod,◊aCulvertI,◊aCulInspCod; removed the pre-sizing to
//  `the table size - the get resized with the Selection to array command.

// **********  ` Modified by: costasmanousakis-(Designer)-(4/30/08 08:43:31)
// Modified Form Methods : 
//[Bridge MHD NBIS];"Cslt Insps"
//  `Set table to RO for others.

// Created Method(s) : 
//SIA_Description_OM 
//  ` Object method for the Description object in the various SIA and secondary record input forms
//SIA_RteNum_OM 
//  ` object method for the vRteNum object in the SIA input forms
//SIA_Suffix_OM 
// ` object method for the Suffix object in the SIA input forms

// Modified Forms : 
//[Bridge MHD NBIS];"BDEPT Input"
//  `Added Tab control ; removed record navigation btns; re-arranged location of objects on page 1;
//  `for the Facility carried and Feature intersected use the new SIA_@_OM project methods.
// Modified Object Methods : 
//[Bridge MHD NBIS];"BDEPT Input".aItem7
//  `call the SIA_Feature_OM to calculate the Item 7 , 6A variables and pulldowns

// Modified Forms : 
//[Bridge MHD NBIS];"ID Input"
//  `Adjsut some object arrangement; for all the objects in Item7 and item6A use the new methods
//  `SIA_@@_OM.
//  `Call the SIA_Feature_OM on Load of form event
//[Bridge MHD NBIS];"SI & A Input" and [Bridge MHD NBIS];"SI & A Input". objecte
//  `Adjust entry order on page 1; change objects for item7,6a to use the new
//  `SIA_@_OM project methods.

// **********  ` Modified by: costasmanousakis-(Designer)-(5/1/08 09:25:21)
// Modified Method(s) : 
//SIA_MountModule
//  `After the next input form loaded by the Modify record, unload and reload the 
//  `bridge record because any changes made and then canceled from the next input form
//  `still appear. Saved changes will still hold true.
// Modified Forms : 
//[NBIS Secondary];"2nd In"
//  `Added code for future use to initialize the new record
//  `Adjusted location arrangement and styles of all objects on the form
//  `Modified input of items6a,7 to be the same as for the [Bridge MHD NBIS] fields.
//  `Changed print button to  a picture button

// Modified Form Methods : 
//[Inspections];"BlankCombinedStarter"
//  `Allow access to users belonging to MHDInspectionROAccess group when
//  `the inspection has been completed.

// **********  ` Modified by: costasmanousakis-(Designer)-(5/2/08 11:51:31)
// Modified Method(s) : 
//G_InspInfo
//  `Get the storage only if the shift key is pressed while running this method.'

// **********  ` Modified by: costasmanousakis-(Designer)-(5/7/08 08:30:48)
// Created Method(s) : 
//F_MDistance
//  ` Method to calculate the distance in miles between two LatLon points
//  ` F_MDistance(LatitudeA;LongitudeA;LatitudeB;LongitudeB) `Lats  and Longs in degrees

// **********  ` Modified by: costasmanousakis-(Designer)-(5/8/08 10:10:40)

// Created Form(s) : 
//[Dialogs];"LatLongControl"
//  `Form used to control the input to the ut_DAM_BIN_Distance method

// Created Method(s) : 
//F_FindMaxIndx 
//F_FindMinIndx
//  ` Find the index in an array of a value.
//ut_DAM_BIN_Distance
//  `Method to produce a report of the distance between Bridges over water to a list of
//  `Locations in lat long format,

// **********  ` Modified by: costasmanousakis-(Designer)-(5/9/08 15:00:41)
// Created Method(s) : 
//INSP_UpdateInspection 
//INSP_UpdateLocalInspFromRemote 
//INSP_UPDATE_Combined 
//INSP_UPDATE_getRemoteIDs 
//INSP_UPDATE_InspChildren 
//INSP_UPDATE_InspChildren 
//INSP_UPDATE_InspRec 
//INSP_UPDATE_PontisRec 
//INSP_UPDATE_Record 
//INSP_UPDATE_TmMembers
//  `Group of methods that allow designer to refresh/update the current inspection
//  `from information on the server to which the current db transfers to.
//  `All data in the records will be replaced with the corresponding records on the server
//  `Any missing ones will be downloaded, any extra local records (records with no ID match)
//  `will be deleted.

// Modified Forms : 
//[Inspections];"AboveWater Template"
//  `Added button vUpdateBtn visible only to the Designer to perform INSP_UpdateInspection.

// **********  ` Modified by: costasmanousakis-(Designer)-(5/12/08 16:49:38)
// Created Method(s) : 
//ut_LoadBridgeRank
//  ` Load Bridge Rank from a text file- input from a spreadsheet maintained by F. Rastegari

// **********  ` Modified by: costasmanousakis-(Designer)-(5/13/08 16:55:19)
// Modified Forms : 
//[Bridge MHD NBIS];"BDEPT Input"
//  `Removed the next/prev page buttons.

// **********  ` Modified by: costasmanousakis-(Designer)-(5/14/08 11:12:51)
// Created Method(s) : 
//SIA_BridgeRankOM
//  `Object method for Rank and HI objects on SIA forms

// Modified Forms : 
// Modified Form Methods : 
//[Bridge MHD NBIS];"MHD Specific Items"
//[Bridge MHD NBIS];"SI & A (Insp)"
//[Bridge MHD NBIS];"SI & A (Normal)"
//[Bridge MHD NBIS];"SI & A Input"
//  `Added rank HI object in the form and SIA_BridgeRankOM in the form method

// **********  ` Modified by: costasmanousakis-(Designer)-(5/20/08 15:46:17)
// Modified Method(s) : 
//SC_AnnualFailProb
//  `include 113=6,D with 113=3
//SC_SetScourCategory
//  `include 113=6,D with 113=U

// **********  ` Modified by: costasmanousakis-(Designer)-(5/22/08 15:36:52)
// Created Method(s) : 
//ut_compareLatLong
//  ` Compare Lat/Longs stored in the DB with Lat/Longs in a text file by BIN.
//  ` The Lat/Longs are expected to be in decimal degrees.
//  ` The first line of the file should contain the headers, BIN, Latit(ude), Longit(ude)

// **********  ` Modified by: costasmanousakis-(Designer)-(5/27/08 16:56:58)
// Modified Method(s) : 
//PRJ_DetailOutsideCall`
//  `Copy from CJM of update to handle better "OverrideConsultant" when 
//  `there is no ProjectFile associated with the projdetail record

// **********  ` Modified by: costasmanousakis-(Designer)-(6/2/08 10:47:38)
// Modified Method(s) : 
//INSP_VerifySIAChanges
//  `Fix translation of boolean fields

// **********  ` Modified by: costasmanousakis-(Designer)-(6/3/08 11:45:56)
// Created Method(s) : 
//ut_PRJUpdateConsName
//  ` update cons ids from two text files : 
//  `   one must have the matches of names in LRA xls with names in Conslt_name table
//  `   second is the extract of projects with consnames from the LRA xls

// Modified Method(s) : 
//M_ContractRpt_Assignment 
//M_ContractRpt_Assignment2
//  `Added calculation for rating cons score

// Modified Form:
//[Conslt Rating];"Cslt Rating In"
//  `Added field CostSqFT in 2nd page as Consultant score.

// Modified table : 
//[Conslt Rating]
//  `Renamed field CostSqFt to ConsltScore and made it visible.

// **********  ` Modified by: costasmanousakis-(Designer)-(6/10/08 11:10:46)
// Created Method(s) : 
//SC_ParseTBLLine
//  ` Parse a line representing a table line in table 71_26
//SC_Table71_26_value
//  ` Get the value from table 71_26
//SC_Table60_61_value
//  ` get the value from table 60_61
//  ` Scour vulnerable bridges based on 60 and 61
//SC_FailProb_6061_7126
//  ` Get the failure probability based on item61,60,71,26
//ut_ParseTextToArrayDelim 
//  `Parse a text string to an array using a given single character delimiter
//SC_CalcScourButton_OM
//  ` Object method for button to calculate the Scour priority ranking
//  ` for the bridge record on the SIA form.
//  ` Will display the results without storing them.

// Modified Table(s) : 
//[ScourPriorityRank]
//  `Added Field Rank : Long

//SC_SetRanking
//  ` Set the ranking in the various scour priority categories

// Modified Method(s) : 
//SC_LoadParameters
//  `Load the values for tables 70_26, 60_61, FailProb.
//SC_AnnualFailProb
//  `Use new method SC_FailProb_6061_7126 for 113 # 0,1,2,3
//SC_CalcScourCategories
//  `Modify some of the prompts, use progress bar for reporting the status

// Modified Form Methods : 
//[PERS_Groups];"Input"
//  `Goto the available pers list on load if the Grp name is not blank!

// **********  ` Modified by: costasmanousakis-(Designer)-(6/13/08 08:26:52)
// Modified Method(s) : 
//PRJ_BPGM_LoadArrays_2
//  `Use new methodology where arrays are loaded only when needed for sorting
//PRJ_BPGM_DoSort
//  `Load the sort arrays as needed; Added a message about Sorting...

// Created Method(s) : 
//PRJ_BPGM_OmitSubset
//  `Omit the selected records from the list

// Modified Forms : 
//[PRJ_ProjectDetails];BridgeProgram
//  `Replaced var PRJ_RatingDone_b with PRJ_RatingDone_s
//  `Added button Omit subset.
//[PRJ_ProjectDetails];BridgeProgram.rpt
//  `Replaced var PRJ_RatingDone_b with PRJ_RatingDone_s
// Modified Method(s) : 
//PRJ_BPGM_ListDetailData
//PRJ_BPGM_ListFromBINs
//PRJ_DisplayBridgePgm
//PRJ_ShowAdPrjStatus
//  `Added var PRJ_RatingDone_s

// Modified Menu bar
//BridgeProgram #9
//  `Added menu option in Search-Report to Omit Subset

// **********  ` Modified by: costasmanousakis-(Designer)-(6/16/08 13:35:02)
// Modified Method(s) : 
//PRJ_DetailOutsideCall
//  `Another update for  "OverrideConsultant" when there is a projectfile with no des contract.

// Modified Object Methods : 
//[PRJ_ProjectDetails];"ProjectDetails.o".bDelete
//  `Re-sort after delete.

// **********  ` Modified by: costasmanousakis-(Designer)-(6/18/08 15:40:39)
// Modified Method(s) : 
//ut_PRJUpdateConsName
//  `Added code for more messages and check if existing ID is in the matching ID array

// **********  ` Modified by: costasmanousakis-(Designer)-(6/19/08 11:25:55)

//``***** UPDATES to implement entering Office Estimate in the Work hours module *******
// Created Method(s) : 
//WKHR_OffEstEditChk_OM 
//WKHR_HandleOfficeEstItm 
//WKHR_CalcOffEstTotals

// Modified Method(s) : 
//WKHR_InitVars 
//WKHR_LoadVariables_2 
//WKHR_LoadItemHRs 
//WKHR_Print 
//WKHR_StoreVariables_2 
//WKHR_ZeroAll 
//WK_ScrollArea 
//WKHR_InitLineItemVars 
//WKHR_SetCmmtTxtTop 
//WKHR_HandleSubItm
//WKHR_SubItemMinus 
//WKHR_SubItemPlus
//WKHR_RecalcPage2

// Modified Forms  and  Form Methods
//[Work_Estimate];"Input"
//[Work_Estimate];"LineEntry"

//``*****END OF  UPDATES to implement entering Office Estimate in the Work hours module *******