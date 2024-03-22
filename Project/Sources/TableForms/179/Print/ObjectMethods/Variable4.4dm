//SC vTmMembers on layout [Cond Units];"Cond Units Prt".
//Copyright © 1997, Thomas D. Nee, All Rights Reserved.

//Display variable for the Team Members.

C_TEXT:C284(vTmMembers)  // Command Replaced was o_C_STRING length was 80
C_LONGINT:C283($i; $j; $k)  //Command Replaced was o_C_INTEGER

ARRAY INTEGER:C220(aInspTeamID; 0)
//RELATE MANY([BMS Inspections])
SELECTION TO ARRAY:C260([BMS Field Trip:56]Person ID:2; aInspTeamID)
$j:=Size of array:C274(aInspTeamID)
$i:=1
vTmMembers:=""
While ($i<=$j) & (Length:C16(vTmMembers)<50)
	If ($i>1)
		vTmMembers:=vTmMembers+", "
	End if 
	$k:=Find in array:C230(aPeople_ID; aInspTeamID{$i})
	If ($k>0)
		vTmMembers:=vTmMembers+aPeople{$k}
	Else 
		vTmMembers:=vTmMembers+"Invalid Person ID"
	End if 
	$i:=$i+1
End while 

If ($i<=$j)
	vTmMembers:=vTmMembers+", et al."
End if 