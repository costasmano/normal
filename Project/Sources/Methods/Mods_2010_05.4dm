//%attributes = {"invisible":true}
// **********  ` Modified by: costasmanousakis-(Designer)-(5/3/10 11:51:14)
// Modified Method(s) : 
//HI_CalcBridgeHI
//  `Added CMI - Special member inspections in the list. - use method HI_CalcInspectionHI

// **********  ` Modified by: costasmanousakis-(Designer)-(5/11/10 10:45:00)
// Modified Method(s) : 
//QR_GetProjInfoNo
//  `Added a sort by sched ad date descending and a filter of ad dates > 1950
//  `Also optional 2nd param to specify the min ad date

// **********  ` Modified by: costasmanousakis-(Designer)-(5/12/10 13:30:24)
// Modified Method(s) : 
//SCPOA_Print
//  `Changed so that all pages go under the same print job;
//  `Added a spooier document option
//SCPOA_FieldNoteCtrl
//  `Added option SAVEDISKFIELDNOTE;
//  `Changed method of finding selected field note - search in array for true

// Modified Forms : 
// [ScourPOA];"Input"
//  `Added a Save all to Disk button in the Field Notes / Attachments section

// Modified Forms :
//[ScourPOA];"SummaryPrint"
//[ScourPOA];"PrintTemplate"
//[ScourPOA];"PrintMap"
//[ScourPOA];"Print1"
//[ScourPOA];"Print2"
//[ScourPOA];"Print3"
//[ScourPOA];"Print4"
//  `Moved all objects and resized some to make them fit without scaling on a XEROX workcenter;
//  `Changed the form markers to also fit within the XEROX printable area;
//  `Made sure objects were transparent ; changed height of some text variables so the 'g's show OK;
//  `Also changed sizes of some objects so they print ok on Windos;

// Modified Library Picture 4754 (NewCheckBox) : 
//  `Adjusted the width of borders and location of the checkmark for better printing when small size (10-12 square)

// **********  ` Modified by: costasmanousakis-(Designer)-(5/14/10 )
// Created Method(s) : 
//QR_GetConstrContrInfo
//   ` Retrieve the Constr Contr info related to the current BIN based on bid opening dates
//QR_GetPFILEDesigner
//  ` Retrieve the Designer for the current ProjectFIle


// **********  ` Modified by: costasmanousakis-(Designer)-(5/17/10 09:06:34)
// Modified Form and Methods : 
//[Bridge MHD NBIS];"Cslt Insps"
//  `Added a 2nd page for the new list box and code to load arrays and go to the page 
//  `for Design Access group
// Modified Object Methods : 
//[Bridge MHD NBIS];"Cslt Insps".bAdd
//  `Changed from Relate Many to a query by BIN and Order by
// Created Method(s) : 
//CINSP_LBControl
//  `Control method for the List box in the Consultant Inspections

// **********  ` Modified by: costasmanousakis-(Designer)-(5/18/10 11:44:36)
// Modified Method(s) : 
//INSP_CalcHI_BTN_OM
//  `Added a call to RememberCombined at the On Clicked event. - The BMS Inspection
//  `record might not be loaded.
//G_Insp_LockFormOnOff
//  `Allow DistrictBridge, MaintEngineers, DBIEs access to the calc bridge hi button. will not save anyway.

// **********  ` Modified by: costasmanousakis-(Designer)-(5/19/10 13:35:45)
// Created Method(s) : 
//ut_RenameInspAgency
//  ` Rename an Inspection agency. 
//  ` Involves changing the Agency field in Iinspection reports [inspections] , [bms inspections] logchanges
//  ` changing the [Personnel]Employer field in the [Personnel] table - logchanges
//  `[Cons Inspection]AssignConName - log changes
//  `[Contracts]ConsltName - no log
//  `[Conslt Address]ConsltName - log changes
//  `[Conslt Rating]AssignRatCons ????

//ut_ExportCopyTable
//  ` Export a table definition into a Blob file usable by AP Pack, or Import that file and create a table.

//Temp_CreateArchiveBMSTable
//  ` creates a new table which is the archive of the bridge mhd nbis table
//  ` adds two fields ArchiveReason (Alpha 80), DateArchived (Date), and a DummyBoolean

//ut_UpdateInspModDate
//  ` update the mod date on inspection records loaded from a text file
//  ` Done to force the update of inspection CUs from 4D to the pontis DB.
//  ` The imput text file should contain a list of bridges and date with zero CU counts
//  ` as shown below.

//  `BRKEY           INSPKEY INSPDATE                                               ElemCount   
//  `--------------- ------- ------------------------------------------------------ ----------- 
//  `A0200128RMHDNBI YYST    2008-02-27 00:00:00.000                                0
//  `
//  `the sql script that generates this report is :
//  `SELECT     BRKEY, INSPKEY, INSPDATE,
//  `                          (SELECT     COUNT(*)
//  `                            FROM          dbo.eleminsp
//  `                            WHERE      dbo.eleminsp.inspkey = dbo.inspevnt.inspkey AND dbo.eleminsp.brkey = dbo.inspevnt.brkey) AS ElemCount
//  `FROM         dbo.INSPEVNT
//  `WHERE     ((SELECT     COUNT(*)
//  `                         FROM         dbo.eleminsp
//  `                         WHERE     dbo.eleminsp.inspkey = dbo.inspevnt.inspkey AND dbo.eleminsp.brkey = dbo.inspevnt.brkey) = 0)
//
//  `Stored in [Parameters] table under sp_PontisGet0CUInsp

// **********  ` Modified by: costasmanousakis-(Designer)-(5/20/10 10:13:22)
// Modified Forms : 
//[InventoryPhotoInsp];"PrintForm"
//  `Adjusted Form markers to fit on Xerox printer and moved objects.

// Modified Form(s) : 
//[Contract_Maintenance];"PrintDetail"
//  `Adjusted heights of some text areas for better printing
//[Contract_Assignment_Maintenance];"PrintAssignReport"
//  `Adjusted form dimensions, markers, and form object sizes to better fit the Project description 

// **********  ` Modified by: costasmanousakis-(Designer)-(5/21/10 11:32:02)
// Modified Method(s) : 
//PRJ_BPGM_InitDispArrays
//  `Added array PRJ_BPGMAdDate_aD
//PRJ_BPGM_LoadArrays_2
//  `Added array PRJ_BPGMAdDate_aD
//PRJ_BPGM_ListDetailData 
//  `Added var PRJ_BPGM_AdDate_d
//PRJ_BPGM_LoadSorts
//  `Replaced [PRJ_ProjectFile]PF_Advertised_d with PRJ_BPGMAdDate_aD
// Modified Forms : 
//[PRJ_ProjectDetails];"BridgeProgram"
//  `Replaced [PRJ_ProjectFile]PF_Advertised_d with variable PRJ_BPGM_AdDate_d

// **********  ` Modified by: costasmanousakis-(Designer)-(5/24/10 14:15:07)
// Modified Method(s) : 
//P_LoadSelection
//  `Added the name of the Set file in the MainTitle
//PRJ_LoadBasedUponBIN
//  `PRJ_RatingApprovedDate_s = [Conslt Rating]NBISLetter

// **********  ` Modified by: costasmanousakis-(Designer)-(5/26/10 11:33:59)
// Created Method(s) : 
//QR_Choise_txt
//  ` Return a text value from a list based on the first parameter. Must be Gt 0.
//  ` If it is larger than the number of choises passed in the last choise will be returned
//  ` ex.
//  ` $Res_txt := QR_Choise_txt(2;"Opt A";"Opt AA";"Opt AB"; "Opt B"; "Opt BA" ;" Opt BB") - > "Opt AA"`
//  ` $Res_txt := QR_Choise_txt(20;"Opt A";"Opt AA";"Opt AB"; "Opt B"; "Opt BA" ;" Opt BB") - > "Opt BB"
//  ` $Res_txt := QR_Choise_txt(0;"Opt A";"Opt AA";"Opt AB"; "Opt B"; "Opt BA" ;" Opt BB") - > ""


// **********  ` Modified by: costasmanousakis-(Designer)-(5/28/10 )
//Added tables
//[DCM_Contracts]
//[DCM_Project]
//[DCM_WorkOrders]
//  `Tables used in the District Maintenance Contract Module
//Added forms
//[DCM_Contracts];"Output"
//[DCM_Contracts];"DistrMaintInput"
//[DCM_Contracts];"PrintDetail"
//[DCM_Project];"DistrWorkOrderInput"
//[DCM_Project];"DistrWorkOrderList"
//[DCM_WorkOrders];"DCM_4DWriteDlg"
//DCM_WorkOrders];"DistrMaintIncList"
//[DCM_WorkOrders];"DistrMaintInput"
//Added Methods
//DCM_4DWriteDlg_FM 
//DCM_AssignControl 
//DCM_AttachmentCtlr 
//DCM_BrgProjDataControl 
//DCM_ContractNo_OM 
//DCM_ContrBidItems 
//DCM_ControlCUs 
//DCM_ControlWOBlobs 
//DCM_CreateWorkOrder 
//DCM_LOADBrgInfo 
//DCM_LoadConstrContrList 
//DCM_SetBINInfo 
//DCM_SetupRelated 
//DCM_SortOutputList 
//DCM_WorkOrderDataControl 
//DCM_WorkOrderSums 
//DCM_WO_GetText_blob 
//M_ListDistrMaint
//ut_OpenProjInfo_OM 
//ITMLB_ItemQEnt_ar_OM

// Modified Method(s) : 
//ControlMenuBar 
//  `Modified for the new menu item District Maintenance Contracts

//[BridgeMHDNBISArchive]
//[NBISSecondaryArchive]
//  `Will be used to archive records from the Bridge Mhd nbis and NBIS SEcondary tables
