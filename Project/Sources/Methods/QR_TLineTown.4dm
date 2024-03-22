//%attributes = {"shared":true}
// Method: QR_TLineTown
// Description
// Build TownName with townline equations
// Parameters
// $0 : RetVal_txt  
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 11/20/15, 16:17:11
	// ----------------------------------------------------
	// Modified by: Costas Manousakis-(Designer)-(11/20/15 16:14:21)
	Mods_2015_11
	//  `change param $0 to text
	C_TEXT:C284(QR_TLineTown; $0)
End if 

C_TEXT:C284($0)
RELATE MANY:C262([Bridge MHD NBIS:1])
ORDER BY:C49([TownLineInfo:73]; [TownLineInfo:73]BDEPT:2; >)
SELECTION TO ARRAY:C260([TownLineInfo:73]BDEPT:2; aBDEPT_)
$0:=[Bridge MHD NBIS:1]Town Name:175
C_LONGINT:C283($i)  //Command Replaced was o_C_INTEGER
For ($i; 1; Size of array:C274(aBDEPT_))
	If (Length:C16(Replace string:C233(aBDEPT_{$i}; " "; ""))>0)
		$0:=$0+"="+Get_Town_Name(aBDEPT_{$i})
	End if 
End for 