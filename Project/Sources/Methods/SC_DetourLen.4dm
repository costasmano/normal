//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/10/06, 15:56:47
	// ----------------------------------------------------
	// Method: SC_DetourLen
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CM03
End if 
C_REAL:C285($0; $DetourLen; $MaxDetLen)
$DetourLen:=[Bridge MHD NBIS:1]Item19:91
If (SC_InterState_Arterial)
	$MaxDetLen:=SC_InterStateMaxDet_r
Else 
	$MaxDetLen:=SC_NonInterStateMaxDet_r
End if 
If (Position:C15([Bridge MHD NBIS:1]Item26:120; ".09.19.")>0)
	$MaxDetLen:=SC_LocalRdMaxDet_r
End if 
If ($DetourLen>$MaxDetLen)
	$DetourLen:=$MaxDetLen
End if 
If ($DetourLen<=0)
	$DetourLen:=2
End if 
If ([Bridge MHD NBIS:1]Item41:141="K")
	//If bridge is closed and there is not acrow panel on it there are no fatalities
	$DetourLen:=0
End if 

SC_WriteSingleDataCol(String:C10($DetourLen))
$0:=$DetourLen
