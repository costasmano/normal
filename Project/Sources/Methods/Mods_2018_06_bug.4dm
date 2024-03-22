//%attributes = {"invisible":true}
//Method: Mods_2018_06_bug
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/05/18, 09:43:43
	// ----------------------------------------------------
	//Created : 
	Mods_2018_06_bug
End if 
//

//**********`Modified by: Costas Manousakis-(Designer)-(6/5/18)

// INSP_TunnelRtnPg1_2_FM
//  `Change ChemicalAnchors to use the field from tunnel inspection, not tunnelinfo

//Make changes to [LSS_Photos] input to try and fix problems with blank [Activity Log] records
//[LSS_Photos];"Input"
//LSS_PhotoTraverseRecords 
//FM_SavePhotoInput 
//FM_PhotoInput 

//**********`Modified by: Costas Manousakis-(Designer)-(6/6/18)

//Method: INSP_PrintRTNPage2
//Description
// Print page 2 of the RTN bridge reports

// PRINT_ROUTINE_F
//  `use method INSP_PrintRTNPage2 
// [Inspections];"Routine Combined".Page Preview Btn
//  `use method INSP_PrintRTNPage2 
// [Inspections];"RoutineNewNBE".Page Preview Btn
//  `use method INSP_PrintRTNPage2 


//```
//```    **** End of Release 7.1.1 19-June-2018
//```


//**********`Modified by: Costas Manousakis-(Designer)-(6/21/18)
// Modified Method(s) : 
// ut_GetBackupInfo
//  `added ARRAY TEXT(MAILAttachments_atxt;0)

// INV_OpenInventoryPhoto
//  `make sure photo table is in RW mode before modifying it - it gets set to RO in the form method if INV_InventInspLocked


//```
//```    **** End of Release 7.1.1.a 21-June-2018
//```

//**********`Modified by: Costas Manousakis-(Designer)-(6/25/18)

// Modified Forms : 
// [LSS_Inspection];"TrafficSignalStructurePg1"
// [LSS_Inspection];"SignStructurePg1"
// [LSS_Inspection];"LightStructurePg1"
// [LSS_Inspection];"ITSStructurePg1"
//  `set style sheet of Department Header

// Modified Method(s) : 
// INSP_ImportInspection
//  `fix bug in logging of std photos where Stdphotoid was the only GRP change

//**********`Modified by: Costas Manousakis-(Designer)-(6/28/18)
// [Bridge MHD NBIS];"Other Info".DE Variable15
//  `change in code - fixes problem that left it editable

//**********`Modified by: Costas Manousakis-(Designer)-(6/29/18)
// Created Method(s) : 
//Method: INSP_ReportIncompleteInsp
//Description
// Report on inspections that have not been completed within 60 days of insp date or
// exceeded 90 days. will send emails to team leader/dbie and summary texts to ABIE and BIE.
// code extracted from original version of Server_ReportIncompleteInsp
// Parameters

//Method: Server_ReportIncompleteInsp1
//Description
// copy of Server_ReportIncompleteInsp to run at a different schedule
// Parameters

// Modified Method(s) : 
// Server_ReportIncompleteInsp
//  `use new method INSP_ReportIncompleteInsp - this way can have multiple schedules.

//End Mods_2018_06_bug