//%attributes = {"invisible":true}
// ----------------------------------------------------
// ut_PRJRetrieveConstructionAmt
// User name (OS): charlesmiller
// Date and time: 01/14/11, 11:42:53
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2011_01  //r001 CJ Miller`01/14/11, 11:42:55      `
End if 

C_LONGINT:C283($Lpid)

$Lpid:=LSpawnProcess("ut_PRJCntrlRetrieveOfAmounts"; <>LStackSize; "Retrieve CP Amounts"; False:C215; False:C215; "CP")

//End ut_PRJRetrieveConstructionAmt