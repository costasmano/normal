//%attributes = {"invisible":true}
// Method: PON_OpenHelpWindow
// Description
// open help window for current element.
// Parameters
// $1 : Current element key
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/20/15, 09:31:22
	// ----------------------------------------------------
	//Created : 
	Mods_2015_02
End if 
//
C_LONGINT:C283($1)
C_LONGINT:C283(PON_HELPWINDOW_PID_L)
C_TEXT:C284($myHelpWin_s)  // Command Replaced was o_C_STRING length was 80
$myHelpWin_s:="$PontisHelp"+String:C10(Current process:C322)
If (PON_HELPWINDOW_PID_L=0)
	PON_HELPWINDOW_PID_L:=New process:C317("PON_RUNHelpWindow"; 0; $myHelpWin_s; $1; *)
Else 
	C_LONGINT:C283($procState_L; $procTim_L)
	C_TEXT:C284($procName_s)  // Command Replaced was o_C_STRING length was 80
	PROCESS PROPERTIES:C336(PON_HELPWINDOW_PID_L; $procName_s; $procState_L; $procTim_L)
	
	Case of 
		: (Process state:C330(PON_HELPWINDOW_PID_L)=Aborted:K13:1)
			PON_HELPWINDOW_PID_L:=New process:C317("PON_RUNHelpWindow"; 0; $myHelpWin_s; $1; *)
		: ($procName_s#$myHelpWin_s)
			PON_HELPWINDOW_PID_L:=New process:C317("PON_RUNHelpWindow"; 0; $myHelpWin_s; $1; *)
		Else 
			SET PROCESS VARIABLE:C370(PON_HELPWINDOW_PID_L; PON_NEWELEMENTNO_L; $1)
			DELAY PROCESS:C323(Current process:C322; 20)
			POST OUTSIDE CALL:C329(PON_HELPWINDOW_PID_L)
	End case 
	
End if 
//End PON_OpenHelpWindow