//%attributes = {"invisible":true}
//Method: NTI_OpenHelpWindow
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/22/16, 11:44:11
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
	
	C_LONGINT:C283(NTI_OpenHelpWindow; $1)
	
End if 
//
C_LONGINT:C283($1)
C_LONGINT:C283(PON_HELPWINDOW_PID_L)
C_TEXT:C284($myHelpWin_s)  // Command Replaced was o_C_STRING length was 80
$myHelpWin_s:="$PontisHelp"+String:C10(Current process:C322)
If (PON_HELPWINDOW_PID_L=0)
	PON_HELPWINDOW_PID_L:=New process:C317("NTI_RUNHelpWindow"; 0; $myHelpWin_s; $1; *)
Else 
	C_LONGINT:C283($procState_L; $procTim_L)
	C_TEXT:C284($procName_s)  // Command Replaced was o_C_STRING length was 80
	PROCESS PROPERTIES:C336(PON_HELPWINDOW_PID_L; $procName_s; $procState_L; $procTim_L)
	
	Case of 
		: (Process state:C330(PON_HELPWINDOW_PID_L)=Aborted:K13:1)
			PON_HELPWINDOW_PID_L:=New process:C317("NTI_RUNHelpWindow"; 0; $myHelpWin_s; $1; *)
		: ($procName_s#$myHelpWin_s)
			PON_HELPWINDOW_PID_L:=New process:C317("NTI_RUNHelpWindow"; 0; $myHelpWin_s; $1; *)
		Else 
			SET PROCESS VARIABLE:C370(PON_HELPWINDOW_PID_L; PON_NEWELEMENTNO_L; $1)
			DELAY PROCESS:C323(Current process:C322; 20)
			POST OUTSIDE CALL:C329(PON_HELPWINDOW_PID_L)
	End case 
	
End if 
//End NTI_OpenHelpWindow