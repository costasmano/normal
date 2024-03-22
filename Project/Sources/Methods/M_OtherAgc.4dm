//%attributes = {"invisible":true}
//GP M_OtherAgc
//Copyright © 1997,  Thomas D. Nee, All Rights Reserved.
//Load data for OtherAgency Bridge inspection
If (False:C215)
	Mods_2005_CM12
End if 

C_LONGINT:C283($Lpid)
C_TEXT:C284(<>vOtherAgc)  // Command Replaced was o_C_STRING length was 5
C_TEXT:C284($sProcName)  // Command Replaced was o_C_STRING length was 15

If (<>vOtherAgc="")
	//Set the default.  
	<>vOtherAgc:="COE"
End if 

CENTER_WINDOW(450; 150; 2)
DIALOG:C40([Dialogs:21]; "GetOtherAgc")
CLOSE WINDOW:C154

If (OK=1)
	Case of 
		: (Substring:C12(<>vOtherAgc; 1; 4)="DIST")
			$sProcName:="District "+Substring:C12(<>vOtherAgc; 5; 1)
		: (<>vOtherAgc="MDC")
			$sProcName:="DCR"
		Else 
			$sProcName:=<>vOtherAgc
	End case 
	
	$Lpid:=LSpawnProcess("P_OtherAgc"; <>LStackSize; $sProcName; True:C214; False:C215)
End if 