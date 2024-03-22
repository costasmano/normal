//SC vBIE on layout [Cond Units];"Cond Units Prt".
//Copyright © 1997, Thomas D. Nee, All Rights Reserved.

//Display variable for the District Bridge Inspection Engineer.

C_TEXT:C284(vBIE)  // Command Replaced was o_C_STRING length was 44
C_LONGINT:C283($k)  //Command Replaced was o_C_INTEGER

$k:=Find in array:C230(aPeople_ID; [BMS Inspections:44]DBrInspEngr:5)
If ($k>0)
	vBIE:=aPeople{$k}
Else 
	vBIE:=""
End if 