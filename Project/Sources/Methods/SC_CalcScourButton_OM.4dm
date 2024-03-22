//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 06/10/08, 10:35:23
	// ----------------------------------------------------
	// Method: SC_CalcScourButton_OM
	// Description
	// Object method for button to calculate the Scour priority ranking
	// for the bridge record on the SIA form.
	// Will display the results and then ask if they should be stored.
	
	// Parameters
	// ----------------------------------------------------
	
	Mods_2008_CM_5403("SCOUR")
End if 
SC_LoadParameters
C_LONGINT:C283(SC_P_LifeRemain)
C_REAL:C285(SC_P_AnnualFailProb_r; SC_P_LifeTimeProbFail_r; SC_P_AdjustedFailProb_r; SC_P_TotalFailCost_r; SC_P_LifeTimeRisk_r; SC_P_ContinuityF)
C_TEXT:C284(SC_P_Category_S)  // Command Replaced was o_C_STRING length was 1
C_LONGINT:C283(SC_SAVEASHTML_i)  //Command Replaced was o_C_INTEGER
SC_CalcSingleBridgeData
C_TEXT:C284($msg_txt)
$msg_txt:="Calculated Scour Category="+SC_P_Category_S
$msg_txt:=$msg_txt+<>sCR+"Failure Cost="+String:C10(SC_P_TotalFailCost_r; "$###,###,###,##0")
$msg_txt:=$msg_txt+<>sCR+"Failure Probability="+String:C10(SC_P_AdjustedFailProb_r; "##0.0000")
$msg_txt:=$msg_txt+<>sCR+"Life Time Risk="+String:C10(SC_P_LifeTimeRisk_r; "$###,###,###,##0")

ALERT:C41($msg_txt)