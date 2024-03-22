//%attributes = {"invisible":true}
//Method: Mods_2013_01
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/02/13, 09:44:04
	// ----------------------------------------------------
	//Created : 
	Mods_2013_01
End if 
//
//**********`Modified by: Costas Manousakis-(Designer)-(1/2/13)

// Modified Table(s) : 
//[Inspections]
//  `Added new Field [Inspections]BaseType_s A3 to be used for Rail Special, FC, OTHER, Damage inspections. 
//  `Field indicates what inspection type the elements used in the inspection are based on. This controls the labeling
//  `of the elements.

// Modified Method(s) : 
//MakeInspection
//  `Use the new field [Inspections]BaseType_s for RRS, RRF inspecitons. If it is not defined ask user to select it.
//  `Also allow user to change base type if there are no elements already selected.
//  `And if a blank hList is generated, show Alert and don't go to the Configure dialog

// Modified Method(s) : 
//INSP_UpdateInspList
//  `Added call to ut_Read_Write_Tables ("READ";.. to set tables to RO before getting the selection

//SIA_ControlDoubleClick
//  `Added call to ut_Read_Write_Tables ("WRITE";.. to set tables to RW before opening

//ADD_COMBINED_INSPECT
//  `Added call to ut_Read_Write_Tables ("WRITE";.. to set tables to RW before creating new inspection

// Modified Object Methods : 
//[Bridge MHD NBIS].Bridge Input.bDuplicate
//  `Added call to ut_Read_Write_Tables ("WRITE";.. to set tables to RW before copying
//[Bridge MHD NBIS].Bridge Input.bOpenInsp
//  `Added call to ut_Read_Write_Tables ("WRITE";.. to set tables to RW before opening
//[Bridge MHD NBIS].Bridge Input.ChgInspTypeBtn
//  `Added call to ut_Read_Write_Tables ("WRITE";.. to set tables to RW before changing  type

// Modified Form Methods : 
//[Inspections];"Critical Member"
//  `Use new method Insp_SortElmtSfty and  INSP_LoadElmLabelsforReport for RR@ inspection types
//  `Add the cases for RRF, RRS, RRO  types 

//[Inspections];"Damage Form"
//  `Use new method Insp_SortElmtSfty and  INSP_LoadElmLabelsforReport for RR@ inspection types

//G_Insp_SetTitle
//  `Added the Rail Inspection types

//**********`Modified by: Costas Manousakis-(Designer)-(1/3/13)
// Modified Method(s) : 
//PRINT_Critical
//  `Added case for RRS, RRF, RRO, RRD inspection types
//INSP_PreviewBtn_OM
//  `Added case for RRD inspection type

//Print_Dive_Cmt_a_new
//  `Use new method Insp_SortElmtSfty

//
//Modified for new fields/tables
//Compiler_FieldVariables 
//Clear_FieldVariables 


//**********`Modified by: Costas Manousakis-(Designer)-(1/4/13)
// Modified Method(s) : 
//ut_UpdateArrayLoaders
//  `Added  ON ERR  CALL to catch erros in individual loaders

// Modified Form Methods : 
//[Inspections];"Culvert Combined"
//  `Added If (Form event=On Close Detail ) when calling  INSP_PontisCTRL ("CLOSEDETAIL")
//[Inspections];"Routine Combined"
//  `Fixed case statement = ": (vTabRoutingPages{Current form page}="Element@")"  - added @

//**********`Modified by: Costas Manousakis-(Designer)-(1/7/13)
// Created Method(s) : 
//INSP_aAgency_OM
// Object method for Agency pulldown in Inspection forms

// Modified Object Methods : 
//[Inspections].Routine Combined.aAgency 
//[Inspections].Damage Form.aAgency 
//[Inspections].Closed Bridge.aAgency 
//[Inspections].Critical Member.aAgency 
//[Inspections].Culvert Combined.aAgency 
//[Inspections].Pontis Form.aAgency 
//[Inspections].FreezeThaw.aAgency 
//[Inspections].RailRoutineInput.aAgency
//[Inspections].PedestrianInspection-PED.aAgency 
//[Inspections].RailCulvertCombined-RRC.aAgency
//  `Use INSP_aAgency_OM

// Modified Method(s) : 
//INSP_aBIE_OM
//  `Present better display of vDBIE variable

// Modified Forms : 
//[Inspections];"Critical Member"
//[Inspections];"Closed Bridge"
//[Inspections];"Damage Form"
//[Inspections];"Culvert Combined"
//[Inspections];"Routine Combined"
//[Inspections];"FreezeThaw"
//[Inspections];"RailRoutineInput"
//[Inspections];"PedestrianInspection-PED"
//[Inspections];"RailCulvertCombined-RRC"
//  `Minor changes in the UI Look 

// Modified Form Methods : 
//[Inspections];"Closed Bridge"
//  `Use new method Insp_SortElmtSfty and  INSP_LoadElmLabelsforReport for RR@ inspection types

//**********`Modified by: Costas Manousakis-(Designer)-(1/8/13)

// Modified Table(s) : 
//[Inspections]
//  `Added field [Inspections]ADA_Accessible_b for Pedestrian MBTA bridges.

// Modified Forms/Method : 
//[Dialogs];"InspectConfig"
//  `Changed behavior so that default page is page 2 : Changed WindowSize property of dialog to "NoConstraints"; Automatic size based on obj TitleLabel;
//  `Added code in form method to adjust window and buttons when using Page 1 of the form.

// Created Method(s) : 
//INSP_Item44Desc
//  ` Define the description and size of Item 44 for Inspection reports
//  ` Copied from INSP_Item43Desc

//INSP_FormatTitle_new

//**********`Modified by: Costas Manousakis-(Designer)-(1/14/13)
// Modified Method(s) : 
//ut_CreateSQLVariables
//  `Added the complete 'wrapper' code as part of generated method text.

// Modified Object Methods : 
//[Inspections] ;"InspectionReview".bzSearchLay
//  `Use new Variables ◊INSP_AreaEng_b | ◊INSP_UOEng_b to access the full Query

//*********
//********* End of release 6.0.9.a
//*********

//**********`Modified by: Costas Manousakis-(Designer)-(1/16/13)
// Modified Method(s) : 
//SIA_BridgeInpNavCTRL
//P_ReviewInspcts 
//  `Added call to ut_Read_Write_Tables ("READ";.. to set  unneeded tables to RO for [Combined Inspections]

//G_SecureInspection
//  `Added the field trip tables to the RO list

// Modified Form Methods : 
//[Inspections];"BlankCombinedStarter"
//  `added code to unload [RAILBridgeInfo] if loaded

//Make changes to printed inspection forms for differences in MBTA and non MBTA
//[Inspections];"Closed Insp Pg1"
//[Inspections]";Culvert Pr Pg 1"
//[Inspections];"CulvertPrPg1_v2"
//[Inspections];"Damage Pg1"
//[Inspections];"DamagePg1_v2"
//[Inspections];"Dive Pr  LowCl Pg1" `?????
//[Inspections];"Dive Pr Pg 1"`??????
//[Inspections];"Dive Special Pr Pg 1"`?????
//[Inspections];"DivePg1 Blank" `?????
//[Inspections];"FC Pr (Pg 1)"
//[Inspections];"FCPrPg1_v2"
//[Inspections];"FrzThawPg1"
//[Inspections];"MHD_Special_Member98" ??!@?@?!!##$#@#$@??????
//[Inspections];"PedBridge_p1" `?????
//[Inspections];"Railfc_rr_p1"
//[Inspections];"RailRoutine Arch Pr Pg 1"
//[Inspections];"RailRoutine Culvert"
//[Inspections];"RailRoutinePrPg1"
//[Inspections];"Routine Arch Pr Pg 1"
//[Inspections];"Routine Pr Pg 1"


//**********`Modified by: Costas Manousakis-(Designer)-(1/24/13)
// Created Method(s) : 
//ut_AddSCPOA_Vars_to_QR
//  ` Append columns containing ScourPOA variables to a quick report
//QRUTIL_AddFldOrVar
//  ` Add to the end of a quick report the passed pointer to a variable and set the header as the name of the variable or field

//r004 `  Modify to set record limts and add progress bar
//Modified by: Charles Miller (1/24/13 16:04:38)
//ut_DwnldMissingINSPForBridges


//**********`Modified by: Costas Manousakis-(Designer)-(1/28/13)
// Modified Method(s) : 
//fUpforInsp
//  `For UW Special member, if the UW spec memb date = !00/00/00! (ie has not had a UW Spec memb insp yet), 
//  `use UW Routine Item93B


//**********`Modified by: Costas Manousakis-(Designer)-(1/31/13)
// Modified Method(s) : 
//GRP_SaveUserGrp
//  `Added code to enforce uniqueness of Groupname
//  `Made sure the LogNewrecord command for the group is given before the Log commands for the groupmembers

//[PERS_Groups];"Input"

//Object Method: [PERS_Groups].Input.PERS_GroupName_s 
//  `Added code to enforce uniqueness of Groupname

//End Mods_2013_01