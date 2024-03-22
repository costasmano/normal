//%attributes = {"invisible":true}
// ----------------------------------------------------
// m_ListConsultantNames
// User name (OS): cjmiller
// Date and time: 02/22/07, 11:38:31
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	P_ListConsultantNames
	Mods_2006_CJMv2
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 
C_LONGINT:C283($Lpid)
$Lpid:=LSpawnProcess("P_ListConsultantNames"; <>LStackSize; "Conslt Names"; True:C214; False:C215)

//End m_ListConsultantNames