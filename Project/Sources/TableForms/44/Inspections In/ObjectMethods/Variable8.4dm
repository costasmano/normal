//SC vTmLeader on layout [BMS Inspections];"Inspections In".
//Copyright © 1997, Thomas D. Nee, All Rights Reserved.

//Display variable for Team Leader.

C_TEXT:C284(vTmLeader)  // Command Replaced was o_C_STRING length was 44
C_LONGINT:C283($k)  //Command Replaced was o_C_INTEGER

//TRACE

If (Form event code:C388=On Load:K2:1)
	$k:=Find in array:C230(aPeople_ID; [BMS Inspections:44]TeamLeader:6)
	If ($k>0)
		vTmLeader:=aPeople{$k}
	Else 
		vTmLeader:="Select Team Leader"
	End if 
End if 