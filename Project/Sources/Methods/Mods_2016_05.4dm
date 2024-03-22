//%attributes = {"invisible":true}
//Method: Mods_2016_05
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/04/16, 17:44:25
	// ----------------------------------------------------
	//Created : 
	Mods_2016_05
End if 
//

//**********`Modified by: Costas Manousakis-(Designer)-(5/4/16)

// Modified Object Methods : 
//Object Method: [NTI_TunnelInfo];"ListBoxOutput".NTI_Tunnel_LB 
//  `added contextual click for designer only
// Modified Forms : 
//[NTI_TunnelInfo];"ListBoxOutput"
//  `Enabled On Click event on the List Box

//**********`Modified by: Costas Manousakis-(Designer)-(5/12/16)
// Created Form(s) : 
//[LSS_Inspection];"InspectionReview"

// Modified Forms : 
// Method: Form Method: [LSS_Inventory];"ListBoxOutput"
//  `re-arranged buttons ; added Review button

// Modified Method(s) : 
// Method: LSS_PrintInspection
//  `use ◊ShowPrint to print settings

// Created Method(s) : 
//Method: LSS_SortInspReview
//  `Description
//  ` Sort the insp review screen
//Method: m_ListInspReview
//  `Description
//  ` run the Anc struct insp review screen

//**********`Modified by: Costas Manousakis-(Designer)-(5/16/16)
// Modified Method(s) : 
//Compiler_LSS 
//  `added inspection review declarations

// Created Method(s) : 
//Method: LSS_GetPendingInsp
//  `Description
//  `Get the pending inspecions - not approved
//Method: LSS_SortInspReviewLB
//  `Description
//  ` do sorting on the insp review list box

// Modified by: Charles Miller-(Designer)-(5/19/16 )
// Modified Method(s) : 
//On Server Startup 
//  `Do not Launch StartControlSrvProc unless compiled in boston or external server

//**********`Modified by: Costas Manousakis-(Designer)-(5/20/16)
// Modified Method(s) : 
//G_AddElmtTxt2Area
//  `Added optional 3rd parameter to pass the sytled text blob

//**********`Modified by: Costas Manousakis-(Designer)-(5/23/16)
//Method: MacroUtils
//  `added CompilerDecl to make compiler declarations
//Method: COMPILER_Inspections
//  `moved  declarations from Compiler_methods
//Method: Compiler_Tunnels

//```
//```   **** End of Release 6.5.1 27-May-2016
//```


//End Mods_2016_05