//SC vTmLeader on layout [Cond Units];"Cond Units Prt".
//Copyright © 1997, Thomas D. Nee, All Rights Reserved.

//Display variable for the Team Leader.

C_TEXT:C284(vTmLeader)  // Command Replaced was o_C_STRING length was 44
C_LONGINT:C283($k)  //Command Replaced was o_C_INTEGER

$k:=Find in array:C230(aPeople_ID; [BMS Inspections:44]TeamLeader:6)
If ($k>0)
	vTmLeader:=aPeople{$k}
Else 
	vTmLeader:=""
End if 