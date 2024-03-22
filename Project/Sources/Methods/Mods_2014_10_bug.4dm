//%attributes = {"invisible":true}
//Method: Mods_2014_10_bug
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 10/06/14, 14:49:34
	// ----------------------------------------------------
	//Created : 
	Mods_2014_10_bug
End if 
//
//**********`Modified by: Costas Manousakis-(Designer)-(10/8/14)
// Modified Forms : 
//[ScourPOA];"Print3-A"
//[ScourPOA];"Print6-A"
//[ScourPOA];"Summary-A"
//[ScourPOA];"Input-A"
//  `General POA modifications Oct 2014

// Modified Method(s) : 
//SCPOA_Variables 
//SCPOA_MonitorChecks 
//SCPOA_InstCountMsrChkBoxes 
//Compiler_SCPOA 
//  `General POA modifications Oct 2014
// Modified Method(s) : 
//SET_Item67 
//  `fixes for load factor values in item66  ; also allow passing of parameters for all required items
//Compiler_SIA
//  `added new params for SET_Item67


//**********`Modified by: Costas Manousakis-(Designer)-(10/15/14)
// Modified Method(s) : 
//INSP_PrintInspBtn_OM
//  `Load [TunnelInspection] record before calling the Print method

//**********`Modified by: CJMIller-(Designer)-(10/21/14)
// Modified Method(s) : 
//Inc_Sequence
//  `Changed stack size of call ti ut_assign   to 256 from 64. maybe  avoid memory allocation errors during runtime


//End Mods_2014_10_bug