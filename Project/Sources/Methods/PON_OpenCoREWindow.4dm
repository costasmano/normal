//%attributes = {"invisible":true}
//Method: PON_OpenCoREWindow
//Description
// open the window to sow the CoRe elements
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/10/15, 17:37:42
	// ----------------------------------------------------
	//Created : 
	Mods_2015_03
End if 
//

C_LONGINT:C283(PON_ShowCoRe_PID_L; $NumCUs_L)
C_TEXT:C284($myHelpWin_s)  // Command Replaced was o_C_STRING length was 80
$myHelpWin_s:="$ShowCoRE"+String:C10(Current process:C322)

Case of 
	: (Form event code:C388=On Mouse Enter:K2:33)
		ut_GenericHelp_OM("Display CoRE Elements")
	: (Form event code:C388=On Mouse Leave:K2:34)
		ut_GenericHelp_OM("Display CoRE Elements")
	: (Form event code:C388=On Clicked:K2:4)
		RememberCombined
		$NumCUs_L:=Records in selection:C76([Cond Units:45])
		
		If ($NumCUs_L=0)
			ALERT:C41("There are no CoRe Elements for this inspection!")
		Else 
			If (PON_ShowCoRe_PID_L=0)
				PON_ShowCoRe_PID_L:=New process:C317("PON_ShowCoReElements"; 0; $myHelpWin_s; [BMS Inspections:44]Inspection ID:1; *)
			Else 
				C_LONGINT:C283($procState_L; $procTim_L)
				C_TEXT:C284($procName_s)  // Command Replaced was o_C_STRING length was 80
				PROCESS PROPERTIES:C336(PON_ShowCoRe_PID_L; $procName_s; $procState_L; $procTim_L)
				Case of 
					: (Process state:C330(PON_ShowCoRe_PID_L)=Aborted:K13:1)
						PON_ShowCoRe_PID_L:=New process:C317("PON_ShowCoReElements"; 0; $myHelpWin_s; [BMS Inspections:44]Inspection ID:1; *)
					: ($procName_s#$myHelpWin_s)
						PON_ShowCoRe_PID_L:=New process:C317("PON_ShowCoReElements"; 0; $myHelpWin_s; [BMS Inspections:44]Inspection ID:1; *)
					Else 
						BRING TO FRONT:C326(PON_ShowCoRe_PID_L)
				End case 
			End if 
			
		End if 
		
	: (Form event code:C388=On Unload:K2:2)
		If (PON_ShowCoRe_PID_L>0)
			POST OUTSIDE CALL:C329(PON_ShowCoRe_PID_L)
		End if 
End case 


//End PON_OpenCoREWindow