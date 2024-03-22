// ----------------------------------------------------
// Method: Object Method: [ScourPOA].Input-A.SCPOA_ViewoldSumm
// Description
// 
// 
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 03/15/12, 13:59:55
	// First Release
	Mods_2012_03
End if 
SCPOA_EvalTextProcess_L:=ut_ShowText(SCPOA_POAEval_txt; "Old Scour Evaluation Summary"; "ScourPOA BIN "+[ScourPOA:132]BIN:2)
